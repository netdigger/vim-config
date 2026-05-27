#!/usr/bin/env bash
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VIM_HOME="$HOME/.vim"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
info()  { echo -e "${GREEN}[OK]${NC}  $1"; }
warn()  { echo -e "${YELLOW}[..]${NC}  $1"; }
step()  { echo -e "\n${YELLOW}==>${NC} ${GREEN}$1${NC}"; }

# ── Help ──
usage() {
    echo ""
    echo "  Usage: install.sh [pkg|vim|tmux]"
    echo ""
    echo "    (none)  Install everything"
    echo "    pkg     System packages + tools only"
    echo "    vim     Vim configuration only"
    echo "    tmux    tmux configuration only"
    echo ""
    exit 0
}

# ── install_packages ──
install_packages() {
    step "System packages"
    PACKAGES=(
        universal-ctags fonts-powerline pipx
        clang-format clang clangd cppcheck ripgrep
        build-essential cmake python3-dev
        golang-go
    )
    for pkg in "${PACKAGES[@]}"; do
        if dpkg -s "$pkg" &>/dev/null; then
            info "$pkg (already installed)"
        else
            sudo apt install -y "$pkg" 2>/dev/null || warn "Failed: $pkg"
        fi
    done

    if ctags --version 2>&1 | grep -q 'Universal'; then
        info "ctags: already universal-ctags"
    else
        sudo update-alternatives --set ctags /usr/bin/ctags-universal 2>/dev/null || true
        info "ctags switched to universal-ctags"
    fi

    step "FZF"
    if [ -x "$HOME/.fzf/bin/fzf" ]; then
        info "fzf already installed ($($HOME/.fzf/bin/fzf --version 2>&1))"
    else
        [ ! -d "$HOME/.fzf" ] && git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
        "$HOME/.fzf/install" --no-update-rc --all
        info "fzf installed"
    fi

    step "gopls (Go LSP)"
    if command -v gopls &>/dev/null; then
        info "gopls already installed ($(gopls version 2>&1))"
    else
        # /usr/local/go/bin: official tarball install (Ubuntu 22.04 users often
        # need this since the apt golang-go is 1.18). $HOME/go/bin: gopls itself.
        export PATH="/usr/local/go/bin:$PATH:$HOME/go/bin"
        if command -v go &>/dev/null; then
            # gopls@latest requires Go >=1.21; Ubuntu 22.04 ships Go 1.18.
            # Pin to the newest gopls compatible with the installed Go.
            local go_ver go_major go_minor gopls_ref="latest"
            go_ver=$(go version | awk '{print $3}' | sed 's/^go//')
            go_major=${go_ver%%.*}
            go_minor=$(echo "$go_ver" | cut -d. -f2)
            if [ "$go_major" -lt 1 ] || { [ "$go_major" -eq 1 ] && [ "$go_minor" -lt 21 ]; }; then
                gopls_ref="v0.13.2"
                warn "Go $go_ver < 1.21 — pinning gopls@$gopls_ref (last compatible release)"
            fi
            go install "golang.org/x/tools/gopls@$gopls_ref" 2>&1 || warn "gopls install failed"
            info "gopls installed ($gopls_ref)"
        else
            warn "Go not found — skipping gopls"
        fi
    fi

    step "yapf"
    export PATH="$HOME/.local/bin:$PATH"
    if command -v yapf &>/dev/null; then
        info "yapf already installed ($(yapf --version 2>&1))"
    else
        pipx ensurepath &>/dev/null || true
        pipx install yapf 2>/dev/null || warn "yapf install failed"
    fi

    step "CMake tools"
    export PATH="$HOME/.local/bin:$PATH"
    for tool in cmake-language-server cmakelint cmake-format; do
        if command -v "$tool" &>/dev/null; then
            info "$tool already installed"
        else
            pipx install "$tool" 2>/dev/null || warn "$tool install failed"
        fi
    done
}

# ── configure_vim ──
configure_vim() {
    step "vim-plug"
    if [ -f "$VIM_HOME/autoload/plug.vim" ]; then
        info "vim-plug already installed"
    else
        curl -fLo "$VIM_HOME/autoload/plug.vim" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        info "vim-plug installed"
    fi

    step "Deploy Vim config"
    [ -L "$HOME/.vimrc" ] && rm "$HOME/.vimrc"
    cp "$SCRIPT_DIR/vim/vimrc" "$HOME/.vimrc"

    rm -rf "$VIM_HOME/config"
    cp -r "$SCRIPT_DIR/vim/config" "$VIM_HOME/config"
    info "vim/config/ → $VIM_HOME/config"

    rm -rf "$VIM_HOME/ftplugin"
    cp -r "$SCRIPT_DIR/vim/ftplugin" "$VIM_HOME/ftplugin"
    info "vim/ftplugin/ → $VIM_HOME/ftplugin"

    rm -rf "$VIM_HOME/ftdetect"
    cp -r "$SCRIPT_DIR/vim/ftdetect" "$VIM_HOME/ftdetect"
    info "vim/ftdetect/ → $VIM_HOME/ftdetect"

    mkdir -p "$VIM_HOME/cache" "$HOME/.cache/tags"

    step "Vim plugins"
    local plugin_dir="$VIM_HOME/plugged"
    local snapshot_file="$(mktemp)"

    # Snapshot current plugin revisions
    if [ -d "$plugin_dir" ]; then
        for d in "$plugin_dir"/*/; do
            if git -C "$d" rev-parse HEAD >/dev/null 2>&1; then
                printf '%s %s\n' "$(basename "$d")" "$(git -C "$d" rev-parse HEAD)" >> "$snapshot_file"
            fi
        done
    fi

    # Fix stale ALE remote after repo moved from w0rp/ale → dense-analysis/ale
    local ale_dir="$plugin_dir/ale"
    if [ -d "$ale_dir" ] && git -C "$ale_dir" remote get-url origin 2>/dev/null | grep -q 'w0rp/ale'; then
        warn "ALE remote points to old w0rp/ale — removing to re-clone from dense-analysis/ale"
        rm -rf "$ale_dir"
    fi

    vim +PlugUpgrade +PlugUpdate +qall 2>/dev/null || warn "Run :PlugUpdate in Vim manually"
    info "Plugins installed/updated"

    # Smoke test: can vim start without errors?
    if ! vim -c quit 2>&1; then
        if [ -s "$snapshot_file" ]; then
            warn "Vim startup failed — rolling back to previous plugin revisions"
            while IFS=' ' read -r name commit; do
                local d="$plugin_dir/$name"
                if [ -d "$d" ] && git -C "$d" rev-parse HEAD >/dev/null 2>&1; then
                    git -C "$d" checkout "$commit" 2>/dev/null || true
                fi
            done < "$snapshot_file"
            warn "All plugins rolled back. Some plugins may require a newer Vim — check with: vim --version"
        else
            warn "Vim startup failed with fresh plugins. Your Vim version may be too old — check with: vim --version"
        fi
    fi

    rm -f "$snapshot_file"

    step "YouCompleteMe"
    YCM_CORE="$VIM_HOME/plugged/YouCompleteMe/third_party/ycmd/ycm_core.cpython-*.so"
    if compgen -G "$YCM_CORE" &>/dev/null; then
        info "YCM already compiled"
    elif [ -d "$VIM_HOME/plugged/YouCompleteMe" ]; then
        cd "$VIM_HOME/plugged/YouCompleteMe"
        local ycm_args=(--clang-completer)
        # --ts-completer needs Node >=18; Ubuntu 22.04 ships Node 12.
        if command -v node &>/dev/null; then
            local node_major
            node_major=$(node --version | sed 's/^v\([0-9]*\).*/\1/')
            if [ "$node_major" -ge 18 ]; then
                ycm_args+=(--ts-completer)
            else
                warn "Node $(node --version) < 18 — skipping --ts-completer (install Node 18+ for JS/TS completion)"
            fi
        else
            warn "Node not found — skipping --ts-completer"
        fi
        # NOTE: --go-completer is intentionally omitted. The pinned (Vim-8.2
        # compatible) YCM bundles an old golang.org/x/tools that won't build
        # on Go >=1.26, and we already install a standalone gopls above —
        # which ALE/Vim can use for Go LSP without involving YCM's bundle.
        python3 install.py "${ycm_args[@]}" 2>&1 || \
            warn "YCM compilation failed — try manually"
        info "YCM compiled"
    else
        warn "YCM not found — run :PlugInstall first"
    fi

    step "LeaderF C extension"
    LF_SO="$VIM_HOME/plugged/LeaderF/autoload/leaderf/python/fuzzyMatchC.cpython-*.so"
    if compgen -G "$LF_SO" &>/dev/null; then
        info "LeaderF C extension already installed"
    elif [ -f "$VIM_HOME/plugged/LeaderF/install.sh" ]; then
        cd "$VIM_HOME/plugged/LeaderF"
        bash install.sh 2>&1 || warn "LeaderF C extension failed"
        info "LeaderF C extension installed"
    fi

    step "vim-prettier"
    if [ -d "$VIM_HOME/plugged/vim-prettier/node_modules" ]; then
        info "prettier dependencies already installed"
    elif [ -d "$VIM_HOME/plugged/vim-prettier" ]; then
        cd "$VIM_HOME/plugged/vim-prettier"
        # prettier needs Node >=14; warn on Ubuntu 22.04's default Node 12.
        if command -v node &>/dev/null; then
            local node_major
            node_major=$(node --version | sed 's/^v\([0-9]*\).*/\1/')
            if [ "$node_major" -lt 14 ]; then
                warn "Node $(node --version) < 14 — prettier install will likely fail (install Node 14+)"
            fi
        fi
        if command -v yarn &>/dev/null; then
            yarn install 2>&1 || warn "yarn install failed"
        elif command -v npm &>/dev/null; then
            npm install --legacy-peer-deps 2>&1 || warn "npm install failed"
        else
            warn "yarn/npm not found"
        fi
        info "prettier dependencies installed"
    fi
}

# ── configure_tmux ──
configure_tmux() {
    # tmux-powerline
    if [ ! -d "$HOME/.tmux/powerline" ]; then
        git clone --depth 1 https://github.com/erikw/tmux-powerline.git "$HOME/.tmux/powerline" 2>/dev/null || \
            warn "tmux-powerline clone failed"
    fi

    step "Deploy tmux config"
    mkdir -p "$HOME/.tmux"
    cp "$SCRIPT_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
    cp "$SCRIPT_DIR/tmux/powerline-theme.sh" "$HOME/.tmux/powerline/themes/dark.sh"
    info "tmux/tmux.conf → ~/.tmux.conf"
    info "tmux/powerline-theme.sh → ~/.tmux/powerline/themes/dark.sh"
    info "Reload with: tmux source-file ~/.tmux.conf  (or C-j C-r)"
}

# ── Main ──
echo ""
echo "  dev-env installer"
echo "  ================="

case "${1:-all}" in
    all)
        install_packages
        configure_vim
        configure_tmux
        ;;
    pkg)
        install_packages
        ;;
    vim)
        configure_vim
        ;;
    tmux)
        configure_tmux
        ;;
    -h|--help|help)
        usage
        ;;
    *)
        echo ""
        echo "  Unknown: $1"
        usage
        ;;
esac

echo ""
echo "  ┌──────────────────────────────────────┐"
echo "  │        Installation complete!        │"
echo "  └──────────────────────────────────────┘"
echo ""

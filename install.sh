#!/usr/bin/env bash
set -eu

# ── Colors ──
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info()  { echo -e "${GREEN}[OK]${NC}  $1"; }
warn()  { echo -e "${YELLOW}[..]${NC}  $1"; }
err()   { echo -e "${RED}[!!]${NC}  $1"; }
step()  { echo -e "\n${YELLOW}==>${NC} ${GREEN}$1${NC}"; }

die() {
    err "$1"
    exit 1
}

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
VIM_HOME="$HOME/.vim"

echo ""
echo "  vim-config installer"
echo "  ===================="

# ── 1. System packages ──
step "System packages"
PACKAGES=(
    universal-ctags
    fonts-powerline
    pipx
    clang-format
    clang
    clangd
    cppcheck
    ripgrep
    build-essential
    cmake
    python3-dev
    golang-go
)
info "Installing apt packages..."
for pkg in "${PACKAGES[@]}"; do
    if dpkg -s "$pkg" &>/dev/null; then
        info "$pkg (already installed)"
    else
        sudo apt install -y "$pkg" 2>/dev/null || warn "Failed: $pkg"
    fi
done

# Switch ctags to universal
if ctags --version 2>&1 | grep -q 'Universal'; then
    info "ctags: already universal-ctags"
else
    info "Switching ctags to universal-ctags..."
    sudo update-alternatives --set ctags /usr/bin/ctags-universal 2>/dev/null || true
fi

# ── 2. vim-plug ──
step "vim-plug"
if [ -f "$VIM_HOME/autoload/plug.vim" ]; then
    info "vim-plug already installed"
else
    info "Downloading vim-plug..."
    curl -fLo "$VIM_HOME/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    info "vim-plug installed"
fi

# ── 3. Deploy config files ──
step "Deploy configuration"
info "Installing vimrc → ~/.vimrc"
if [ -L "$HOME/.vimrc" ]; then
    rm "$HOME/.vimrc"
fi
cp "$SCRIPT_DIR/vimrc" "$HOME/.vimrc"

info "Installing config/ → $VIM_HOME/config"
rm -rf "$VIM_HOME/config"
cp -r "$SCRIPT_DIR/config" "$VIM_HOME/config"

info "Installing ftplugin/ → $VIM_HOME/ftplugin"
rm -rf "$VIM_HOME/ftplugin"
cp -r "$SCRIPT_DIR/ftplugin" "$VIM_HOME/ftplugin"

info "Installing ftdetect/ → $VIM_HOME/ftdetect"
rm -rf "$VIM_HOME/ftdetect"
cp -r "$SCRIPT_DIR/ftdetect" "$VIM_HOME/ftdetect"

# ── 4. Cache directories ──
mkdir -p "$VIM_HOME/cache" "$HOME/.cache/tags"

# ── 5. FZF ──
step "FZF (fuzzy finder)"
if [ -x "$HOME/.fzf/bin/fzf" ]; then
    info "fzf already installed ($($HOME/.fzf/bin/fzf --version 2>&1))"
else
    if [ ! -d "$HOME/.fzf" ]; then
        git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    fi
    "$HOME/.fzf/install" --no-update-rc --all
    info "fzf installed"
fi

# ── 6. gopls (Go language server) ──
step "gopls (Go LSP)"
if command -v gopls &>/dev/null; then
    info "gopls already installed ($(gopls version 2>&1))"
else
    export PATH="$PATH:$HOME/go/bin"
    if command -v go &>/dev/null; then
        info "Installing gopls..."
        go install golang.org/x/tools/gopls@latest 2>&1 || warn "gopls install failed"
    else
        warn "Go not found — skipping gopls"
    fi
fi

# ── 7. yapf (Python formatter) ──
step "yapf"
if command -v yapf &>/dev/null; then
    info "yapf already installed ($(yapf --version 2>&1))"
else
    pipx ensurepath &>/dev/null || true
    export PATH="$HOME/.local/bin:$PATH"
    pipx install yapf 2>/dev/null || warn "yapf install failed; try: pipx install yapf"
fi

# ── 7. Vim plugins ──
step "Vim plugins (:PlugInstall)"
if [ -d "$VIM_HOME/plugged/ale" ]; then
    info "Plugins already installed (found ale)"
else
    info "Installing plugins (this may take a moment)..."
    vim +PlugInstall +qall 2>/dev/null || {
        warn "Automatic plugin install failed."
        warn "Open Vim and run: :PlugInstall"
    }
fi

# ── 8. YouCompleteMe ──
step "YouCompleteMe"
YCM_CORE="$VIM_HOME/plugged/YouCompleteMe/third_party/ycmd/ycm_core.cpython-*.so"
if compgen -G "$YCM_CORE" &>/dev/null; then
    info "YCM already compiled"
else
    if [ -d "$VIM_HOME/plugged/YouCompleteMe" ]; then
        info "Compiling YouCompleteMe (C/C++, JS/TS, Python, Go)..."
        cd "$VIM_HOME/plugged/YouCompleteMe"
        python3 install.py --clang-completer --ts-completer --go-completer 2>&1 || {
            warn "YCM compilation failed."
            warn "Try manually: cd ~/.vim/plugged/YouCompleteMe && python3 install.py --clang-completer --ts-completer --go-completer"
        }
    else
        warn "YCM plugin not found. Run :PlugInstall in Vim first."
    fi
fi

# ── 9. LeaderF C extension ──
step "LeaderF C extension"
LF_SO="$VIM_HOME/plugged/LeaderF/autoload/leaderf/python/fuzzyMatchC.cpython-*.so"
if compgen -G "$LF_SO" &>/dev/null; then
    info "LeaderF C extension already installed"
else
    if [ -f "$VIM_HOME/plugged/LeaderF/install.sh" ]; then
        info "Building LeaderF C extension..."
        cd "$VIM_HOME/plugged/LeaderF"
        bash install.sh 2>&1 || warn "LeaderF C extension failed"
    fi
fi

# ── 10. vim-prettier deps ──
step "vim-prettier"
if [ -d "$VIM_HOME/plugged/vim-prettier/node_modules" ]; then
    info "prettier dependencies already installed"
else
    if [ -d "$VIM_HOME/plugged/vim-prettier" ]; then
        info "Installing prettier dependencies..."
        cd "$VIM_HOME/plugged/vim-prettier"
        if command -v yarn &>/dev/null; then
            yarn install 2>&1 || warn "yarn install failed"
        elif command -v npm &>/dev/null; then
            npm install 2>&1 || warn "npm install failed"
        else
            warn "yarn/npm not found. Install Node.js and run: cd ~/.vim/plugged/vim-prettier && yarn install"
        fi
    fi
fi

# ── Done ──
echo ""
echo "  ┌──────────────────────────────────────┐"
echo "  │        Installation complete!        │"
echo "  └──────────────────────────────────────┘"
echo ""
echo "  Language support:"
echo "    C/C++          clangd + cppcheck + YCM"
echo "    Python         jedi (YCM) + yapf"
echo "    JavaScript/TS  tsserver (YCM) + prettier"
echo "    Go             gopls (YCM) + goimports"
echo "    Octave/Matlab  vim-octave"
echo ""
echo "  PATH updates:"
echo "    \$HOME/go/bin  (gopls, go tools) — added to ~/.bashrc"
echo ""

# tmux config

Prefix: <kbd>Ctrl-j</kbd> (double-tap to pass through)

Status bar (tmux-powerline) at bottom: session, git branch, hostname, date, time.

## Install

Run from the repo root:

```bash
./install.sh tmux    # tmux config only
./install.sh         # or install everything (packages + vim + tmux)
```

Then reload with `C-j C-r`.

This deploys `tmux.conf` to `~/.tmux.conf`, the powerline theme to `~/.tmux/powerline/themes/dark.sh`, and auto-clones [tmux-powerline](https://github.com/erikw/tmux-powerline) if needed.

## Keybindings

| Key | Action |
|-----|--------|
| `C-j \|` | Split pane vertically (left/right) |
| `C-j -` | Split pane horizontally (up/down) |
| `C-j h/j/k/l` | Switch pane left/down/up/right |
| `C-j z` | Toggle pane zoom (maximize/restore) |
| `C-j Enter` | Popup terminal (80%) |
| `C-j e` | Synchronize input to all panes (on) |
| `C-j E` | Synchronize input to all panes (off) |
| `C-j C-r` | Reload tmux config |
| `C-j Q` | Quit tmux (prompts for confirmation) |
| `C-j [` | Enter copy mode (vi keys) |

### Copy mode

| Key | Action |
|-----|--------|
| `v` / `s` | Begin selection |
| `y` / `c` | Yank/copy selection and exit |

## Settings

| Setting | Value |
|---------|-------|
| Terminal | `tmux-256color` (with true color override) |
| Base index | 1 (windows start at 1) |
| History | 100,000 lines |
| Escape time | 10ms |
| Mouse | on |
| Status interval | 5s |
| Status position | bottom |

## Powerline theme

`powerline-theme.sh` is a dark theme for tmux-powerline. It auto-detects patched fonts (Nerd Font / Powerline) and uses the appropriate separators.

Status bar segments:

| Side | Segments |
|------|----------|
| Left | Session name, Git branch |
| Right | Hostname, Date, Time |

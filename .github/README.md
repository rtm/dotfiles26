# dotfiles26

Personal dotfiles, managed using the **bare-repo strategy**: a single bare git repository at `~/.dotfiles` whose work tree is `$HOME`. Tracked files (e.g. `~/.bashrc`, `~/.emacs.d/`) live in their normal home-directory locations rather than inside a separate `dotfiles/` checkout.

Supersedes the older [`dotfiles`](https://github.com/rtm/dotfiles) repo, which used [`rcm`](https://github.com/thoughtbot/rcm) and didn't handle Windows well.

## The `dot` alias

```bash
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

Use `dot` exactly like `git`, scoped to this repo: `dot status`, `dot add ~/.bashrc`, `dot commit -m "..."`, `dot push`. The alias is defined in the tracked `.bashrc`, so once a fresh machine is bootstrapped, it's available in every new shell.

On Windows, the alias works in Git Bash (which sources `.bashrc`). For PowerShell, define an equivalent function in `$PROFILE`:

```powershell
function dot { git --git-dir="$HOME\.dotfiles" --work-tree="$HOME" @args }
```

## Bootstrap on a new machine

```bash
# 1. Clone bare into ~/.dotfiles
git clone --bare https://github.com/rtm/dotfiles26.git $HOME/.dotfiles

# 2. Define the alias for this shell (will be permanent once .bashrc is checked out)
alias dot='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

# 3. Quiet untracked files (otherwise `dot status` lists all of $HOME)
dot config status.showUntrackedFiles no

# 4. Check out tracked files into $HOME
dot checkout main
```

If step 4 fails because of pre-existing files in `$HOME`, back them up and retry:

```bash
mkdir -p ~/.dotfiles-backup
dot checkout main 2>&1 | awk '/^\s+\./{print $1}' | xargs -I{} mv {} ~/.dotfiles-backup/{}
dot checkout main
```

## OS dispatch

Most files are OS-agnostic and apply identically on WSL/Linux and Windows (Git Bash). For files that genuinely must differ, the convention is to suffix per-OS variants and dispatch from the canonical file. For example, `.bashrc` contains:

```bash
case "$(uname -s)" in
  Linux*)
    if grep -qi microsoft /proc/version 2>/dev/null; then
      [ -f ~/.bashrc-wsl ] && . ~/.bashrc-wsl
    else
      [ -f ~/.bashrc-linux ] && . ~/.bashrc-linux
    fi ;;
  CYGWIN*|MINGW*|MSYS*) [ -f ~/.bashrc-windows ] && . ~/.bashrc-windows ;;
  Darwin*)              [ -f ~/.bashrc-macos ]   && . ~/.bashrc-macos   ;;
esac
```

All variants are tracked; only the relevant one is sourced on a given machine. Variants that aren't applicable (e.g. `.bashrc-windows` on WSL) sit unused.

For files whose filename is fixed and content must vary by machine (`.gitconfig`, `.ssh/config`), use an unconditional include of an untracked per-machine file:

```ini
# in tracked ~/.gitconfig
[include]
    path = ~/.gitconfig-local
```

The local file is a per-machine symlink to whichever tracked OS variant applies.

## Work trees

| Machine    | Work tree            | Notes                                                |
| ---------- | -------------------- | ---------------------------------------------------- |
| WSL/Linux  | `/home/rtm/`         |                                                      |
| Windows    | `C:\Users\User\`     | Shared by native Windows tools and Git Bash          |

Both check out the same `main` branch. On Windows, the same `~/.emacs.d` is read by both native Emacs and Git Bash Emacs (same physical path).

## `dot add .` is dangerous

The work tree is your entire home directory. `dot add .` or `dot add -A` would stage thousands of untracked files. Always add by explicit path: `dot add ~/.bashrc`.

## Line endings

A `.gitattributes` at the repo root pins `* text=auto eol=lf` so Git Bash on Windows checks out shell scripts with LF endings, regardless of `core.autocrlf`.

#!/usr/bin/env bash
#
# video-memory.sh - the skill's door to Ask Hormozi (2,039 MoreMozi videos,
# searchable offline). Wraps https://github.com/poseljacob/ask-hormozi via the
# learnaiwithhugo fork, which carries two installer fixes.
#
#   video-memory.sh status            installed | not-installed first-run | not-installed offered
#   video-memory.sh mark-offered      remember that the one-time offer was made
#   video-memory.sh install           one-off: clone the corpus, install QMD if needed, index
#   video-memory.sh search "<q>" [n]  search the videos, markdown out (default 6 results)
#
# Nothing here phones home at question time. After install, every search runs
# against files on this machine.

set -euo pipefail

REPO_URL="https://github.com/learnaiwithhugo/ask-hormozi.git"
INSTALL_DIR="${HORMOZI_VIDEO_MEMORY_DIR:-$HOME/.local/share/hormozi-plugin/ask-hormozi}"
MARKER_DIR="$HOME/.config/hormozi-plugin"
MARKER="$MARKER_DIR/video-memory-offered"

# ask-hormozi's own setup.sh symlinks the CLI into ~/.local/bin, which is not
# always on PATH inside an agent's shell. Look there explicitly.
find_cli() {
  if command -v ask-hormozi >/dev/null 2>&1; then
    command -v ask-hormozi
  elif [[ -x "$HOME/.local/bin/ask-hormozi" ]]; then
    echo "$HOME/.local/bin/ask-hormozi"
  else
    return 1
  fi
}

cmd_status() {
  local cli
  if cli="$(find_cli)" && "$cli" doctor >/dev/null 2>&1; then
    echo "installed"
  elif [[ -f "$MARKER" ]]; then
    echo "not-installed offered"
  else
    echo "not-installed first-run"
  fi
}

cmd_mark_offered() {
  mkdir -p "$MARKER_DIR"
  touch "$MARKER"
  echo "ok"
}

cmd_install() {
  for tool in git python3; do
    if ! command -v "$tool" >/dev/null 2>&1; then
      echo "error: $tool is required. Install it and run the install again." >&2
      exit 1
    fi
  done
  if ! command -v qmd >/dev/null 2>&1 && ! command -v npm >/dev/null 2>&1; then
    echo "error: the search engine (QMD) needs Node.js 22+ and npm. Install Node from https://nodejs.org, then run the install again." >&2
    exit 1
  fi

  mkdir -p "$(dirname "$INSTALL_DIR")"
  if [[ -d "$INSTALL_DIR/.git" ]]; then
    echo "Corpus already cloned at $INSTALL_DIR, pulling latest."
    git -C "$INSTALL_DIR" pull -q --ff-only || true
  else
    echo "Cloning the transcript corpus (about 90 MB) into $INSTALL_DIR ..."
    git clone -q --depth 1 "$REPO_URL" "$INSTALL_DIR"
  fi

  echo "Running ask-hormozi setup (Python environment, QMD, index) ..."
  # --skip-skill: this plugin is the only door. A second, auto-triggering
  # ask-hormozi skill would compete with /hormozi:ask.
  (cd "$INSTALL_DIR" && ./setup.sh --skip-skill)

  local cli
  cli="$(find_cli)" || { echo "error: setup finished but ask-hormozi was not found." >&2; exit 1; }
  "$cli" doctor >/dev/null
  # Prove a search works before claiming success. If this crashes, the
  # install is not done, whatever setup.sh printed.
  "$cli" search "offer" --limit 1 >/dev/null
  mkdir -p "$MARKER_DIR" && touch "$MARKER"
  echo "installed"
}

cmd_search() {
  local query="${1:-}"
  local limit="${2:-6}"
  if [[ -z "$query" ]]; then
    echo "usage: video-memory.sh search \"<question>\" [limit]" >&2
    exit 2
  fi
  local cli
  cli="$(find_cli)" || { echo "not-installed"; exit 3; }
  "$cli" search "$query" --limit "$limit"
}

case "${1:-}" in
  status)       cmd_status ;;
  mark-offered) cmd_mark_offered ;;
  install)      cmd_install ;;
  search)       shift; cmd_search "$@" ;;
  *)
    sed -n '2,13p' "$0" | sed 's/^# \{0,1\}//'
    exit 2
    ;;
esac

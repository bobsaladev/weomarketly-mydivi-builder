#!/usr/bin/env bash
# Install marketly-divi-component Cursor skill on Bob's Mac.
# Usage: install-to-mac.sh [SOURCE_DIR] [MARKETLY_REPO_ROOT]
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="${1:-$(dirname "$SCRIPT_DIR")}"
PERSONAL_DEST="${HOME}/.cursor/skills/marketly-divi-component"

if [[ ! -f "${SOURCE_DIR}/SKILL.md" ]]; then
  echo "ERROR: SOURCE_DIR missing SKILL.md: ${SOURCE_DIR}" >&2
  exit 1
fi

mkdir -p "${PERSONAL_DEST}"
rsync -a --delete \
  --exclude 'scripts/' \
  "${SOURCE_DIR}/" "${PERSONAL_DEST}/"
echo "Installed personal skill: ${PERSONAL_DEST}"

MARKETLY_ROOT="${2:-}"
if [[ -z "${MARKETLY_ROOT}" ]]; then
  for candidate in \
    "${HOME}/Desktop/WEOMARKETLY" \
    "${HOME}/Desktop/Organizado/Proyectos/WEOMARKETLY/MARKETLY" \
    "${HOME}/Desktop/PROJECTS/WEOMARKETLY/MARKETLY" \
    "${HOME}/Projects/WEOMARKETLY/MARKETLY"; do
    if [[ -d "${candidate}/MODULES" ]] || [[ -d "${candidate}/.git" ]] || [[ -d "${candidate}" ]]; then
      MARKETLY_ROOT="${candidate}"
      break
    fi
  done
fi

if [[ -n "${MARKETLY_ROOT}" && -d "${MARKETLY_ROOT}" ]]; then
  REPO_DEST="${MARKETLY_ROOT}/.cursor/skills/marketly-divi-component"
  mkdir -p "${REPO_DEST}"
  rsync -a --delete \
    --exclude 'scripts/' \
    "${SOURCE_DIR}/" "${REPO_DEST}/"
  echo "Installed repo skill: ${REPO_DEST}"
else
  echo "WARN: MARKETLY repo not found; personal install only." >&2
fi
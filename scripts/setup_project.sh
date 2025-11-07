#!/usr/bin/env bash
set -e

# Ensure pipx is available
if ! command -v pipx >/dev/null 2>&1; then
    python3 -m pip install --user --quiet pipx
    python3 -m pipx ensurepath
fi

# Ensure Commitizen (cz) is available
if ! command -v cz >/dev/null 2>&1; then
    pipx install --quiet commitizen
fi

# Ensure pre-commit is installed and hooks are set up idempotently
if command -v pre-commit >/dev/null 2>&1; then
    # Check if pre-commit hook is already installed
    if ! grep -q "This hook was installed by pre-commit" .git/hooks/pre-commit 2>/dev/null; then
        pre-commit install --overwrite >/dev/null
    fi

    # Check if commit-msg hook is already installed
    if ! grep -q "This hook was installed by pre-commit" .git/hooks/commit-msg 2>/dev/null; then
        pre-commit install --hook-type commit-msg --overwrite >/dev/null
    fi
fi

# Set Git configurations safely and idempotently
if ! git config --global --get push.autoSetupRemote >/dev/null 2>&1; then
    git config --global push.autoSetupRemote true
fi

repo_root="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [ -n "$repo_root" ]; then
    if ! git config --global --get-all safe.directory | grep -Fxq "$repo_root"; then
        git config --global --add safe.directory "$repo_root"
    fi
fi

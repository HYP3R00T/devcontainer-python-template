# Developer Setup

This page documents setup paths that match the repository as it exists today.

## Prerequisites

- [Git](https://git-scm.com/)
- [Mise](https://mise.jdx.dev/)
- [uv](https://docs.astral.sh/uv/)

## Setup

1. Fork the repository.
2. Create a branch for your work.
3. Run `mise install`.
4. Run `uv sync` to install project dependencies.
5. Activate the virtual environment.

    === "Linux/MacOS"

        ``` sh
        source ./.venv/bin/activate
        ```

    === "Windows"

        ``` sh
        .venv/Scripts/Activate.ps1
        ```

## Pre-commit Hooks

Install hooks after dependencies are set up:

```bash
prek install --hook-type pre-commit --overwrite
prek install --hook-type commit-msg --overwrite
```

This enables automatic checks before each commit for:

- File format validation (JSON, YAML, TOML)
- Code formatting and linting (Python with Ruff)
- Commit message format (Conventional Commits)
- Dependency synchronization (UV lockfiles)

???+ tip "Warm up hooks"
    Run `prek run --all-files` immediately after installing the hooks. That preloads each environment and prevents surprises during your next commit.

## Daily Commands

Use these commands from the repository root:

```bash
uv run ruff check
uv run ruff format --check
uv run ty check
uv run pytest --cov --cov-report=term-missing --cov-fail-under=80
uv run zensical build --clean
```

In this template, `scripts/enter_project.sh` can also install `cz` and hooks automatically when `mise` shell hooks run.

## Related

- [Authoring Documentation](../contributing/authoring-documentation.md)
- [Naming Conventions](../contributing/naming-conventions.md)
- [Documentation Principles](../contributing/documentation-principles/index.md)

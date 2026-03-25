# AGENTS.md

Instructions for coding agents working in this repository.

## Project overview

- Repository: `HYP3R00T/devcontainer-python-template`
- Stack: Python (>= 3.13 locally), `uv` for dependency management, `ruff` for lint/format, `ty` for type checking, `pytest` for tests, `zensical` for docs.
- Current state: this is a minimal template repository. Keep changes small, clear, and easy to reuse.

## Environment setup

- Preferred environment manager is `mise` (see `mise.toml`).
- Dev container runs `scripts/setup.sh` on create.
- First-time local setup:
   	- `mise install`
   	- `uv sync`
   	- `prek install --hook-type pre-commit --overwrite`
   	- `prek install --hook-type commit-msg --overwrite`

## Where to look first

- Python/tooling config: `pyproject.toml`, `ruff.toml`, `ty.toml`, `mise.toml`
- Docs config/content: `zensical.toml`, `docs/index.md`
- Automation scripts: `scripts/setup.sh`, `scripts/enter_project.sh`
- CI definitions: `.github/workflows/ci.yml`, `.github/workflows/docs.yml`

## Commands agents should run

- Install/update dependencies:
   	- `uv sync`
- Lint:
   	- `uv run ruff check`
- Format check:
   	- `uv run ruff format --check`
- Format (when needed):
   	- `uv run ruff format`
- Type check:
   	- `uv run ty check`
- Tests:
   	- `uv run pytest --cov --cov-report=term-missing --cov-fail-under=80`
- Docs build:
   	- `uv run zensical build --clean`
- Docs preview:
   	- `uv run zensical serve`

Notes:

- CI enforces coverage threshold at `80%` in `.github/workflows/ci.yml`.
- `mise.toml` local `test` task also uses `--cov-fail-under=80`, matching CI.

## Code style and quality expectations

- Use `ruff` as the source of truth for formatting/linting.
- Keep line length practical; `E501` is ignored, but avoid unnecessary long lines.
- Prefer explicit, typed Python where practical; run `ty check` on changed code.
- Avoid introducing new tools unless necessary and justified.
- Keep template files generic; avoid project-specific hardcoding unless requested.

## Testing expectations

- Add or update tests for behavior changes.
- Run the full lint/type/test sequence before finishing substantial code changes.
- If tests are missing for a new module, create focused tests rather than broad integration scaffolding.

## Documentation expectations

- If behavior/config changes, update docs in `docs/` and verify with `uv run zensical build --clean`.
- Keep examples minimal and executable where possible.

## Commit and PR guidance

- This repo installs a `commit-msg` hook with Commitizen via `prek`; use conventional commit messages.
- Prefer `cz commit` if available.
- Before opening PRs, ensure:
   	- Lint passes
   	- Format check passes
   	- Type checks pass
   	- Tests pass with coverage >= 80%
- Keep PRs focused; include a short validation summary listing exact commands run.

## Security and secrets

- Never commit secrets or credentials.
- Use `.env` only for local development values (already gitignored).
- Do not print or copy token values into logs, docs, or commit messages.

## Agent behavior in this repo

- Prefer minimal diffs that preserve existing structure.
- Do not refactor unrelated files during targeted fixes.
- If a command fails due to missing tools, use `mise install` and `uv sync` before alternative workarounds.
- When changing CI-related behavior, keep `.github/workflows/ci.yml` and local guidance in sync.

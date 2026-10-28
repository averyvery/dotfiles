**My shell is fish, always. Never assume bash or zsh. Every command you write for me to run must be fish-compatible.**

# Global Preferences

These apply in every project. An explicit request in a session overrides them.

## Shell
- My login shell is fish (`/opt/homebrew/bin/fish`), not bash or zsh. Don't wonder or guess which shell it is; it's fish.
- If you need to confirm, run `echo $SHELL` or `status fish-path`; don't assume otherwise.
- Don't use bash-only syntax in commands I'm asked to run. That includes `export FOO=bar`, `VAR=x cmd`, `$(...)` for command substitution, `&&` chains that depend on bash semantics, heredocs, and `<<<`.
- Use fish equivalents: `set -x FOO bar`, `cmd; and other`, `(cmd)` for substitution, `begin; ...; end`, and `echo "..." | cmd` instead of here-strings.
- When a snippet needs to run in bash, wrap it as `bash -c '...'` so it's explicit.

## Scripts
- "Our script" or "the script we made" usually means something under `~/Code/scripts/`. Look there first.
- Save new utility scripts in `~/Code/scripts/` unless I say otherwise.

## Temporary assets
- Store temporary assets (source images, screenshots, videos) in `~/Code/assets/[project name]/`, not in `~/Downloads/`.
- Put each piece of work in its own subfolder, e.g. `~/Code/assets/viget-craft-astro/appomni/`.
- Screenshots and any HTML or other files made to view them (comparison pages, contact sheets) go in the same work subfolder. Don't leave them in the repo or `~/Downloads/` unless I ask.

## Pull requests
- When referencing an issue in a PR body, always write `References #11`. Never write `Closes #11`, `Fixes #11`, or `Resolves #11`, since those auto-close the issue on merge.

## Responsive CSS
- Use width-only media queries (`min-width` / `max-width`). Don't use vertical ones (`min-height`, `max-height`, `orientation`) in CSS or Tailwind variants. Size to viewport height with units like `svh` instead.

## Planning and design docs
- For most work that changes code, use the `superpowers:brainstorming` approach: write a spec, then a plan, then implement.
- Specs, plans, design docs, and notes from this flow are local only. Write them to disk in the project's repo root and leave them untracked. Never stage, commit, or push them, and don't ask whether to check them in.
- If I ask for a doc to be committed (for example, a review list in `docs/plans/`), that is a deliberate request and this rule doesn't apply to it.

## Quick file hosting
- To publish a local file at `https://dougismycopilot.com/files/<name>`, use `~/Code/websites/dougismycopilot/upload.sh`. Details are in that folder's `CLAUDE.md`.
- Uploads are public and overwrite existing names. Confirm before uploading anything private.

## Screenshots
For screenshots of the Viget app, use the existing tool before writing any browser code: `~/code/scripts/viget-craft-astro/screenshots/shots.mjs`. Point it at a dev server with `--base=<origin>` (or `SHOTS_BASE_URL`); it defaults to `http://localhost:4321`.

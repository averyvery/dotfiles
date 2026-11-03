**My shell is fish, always. Every command you write for me to run must be fish-compatible.**

# Global Preferences

These apply in every project. An explicit request in a session overrides them.

## Shell
- My login shell is fish (`/opt/homebrew/bin/fish`). Don't assume bash or zsh.
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
- For new features and multi-file changes, use the `superpowers:brainstorming` approach: write a spec, then a plan, then implement. Skip it for small, single-file fixes.
- When brainstorming, open each doc you write (spec, plan, design notes) in Zed for me right after writing it: `zed <path>`.
- Specs, plans, design docs, and notes from this flow are local only. Write them to the project's repo root, leave them untracked, and never stage, commit, or push them.
- An explicit request to commit a doc (e.g. a review list in `docs/plans/`) overrides this.

## Quick file hosting
- To publish a local file at `https://dougismycopilot.com/files/<name>`, use `~/Code/websites/dougismycopilot/upload.sh`. Details are in that folder's `CLAUDE.md`.
- Uploads are public and overwrite existing names. Confirm before uploading anything not meant to be public.

## Screenshots
- For screenshots of Viget Craft/Astro projects, use the existing tool before writing any browser code: `~/Code/scripts/viget-craft-astro/screenshots/shots.mjs`. Point it at a dev server with `--base=<origin>` (or `SHOTS_BASE_URL`); it defaults to `http://localhost:4321`.

## Browser (Pi Bridge)
- Pi Bridge gives Pi access to my own Chrome through the `pi-browser-bridge__browser_*` MCP tools. Use them to see or drive pages in my signed-in browser, such as `http://localhost:5174/...`.
- Before using them, check the connection with `pi-browser-bridge__browser_get_status`. If it isn't connected, run `/reload` in Pi or `mcp({ connect: "pi-browser-bridge__browser" })`.
- Pick the connected profile with `profile_id`. There can be more than one, so check `browser_list_profiles` first.
- Screenshots only work on the active tab. Activate the tab first with `browser_tab_action` (`action: "activate"`). Tell me before switching tabs, since it changes what I'm looking at.
- If a local page shows "connection refused", the dev server isn't running. Ask me to start it. Don't start it yourself unless I ask.

## QR codes for links
- Every time I give the user a URL, or open a link for them, show a QR code for it in the reply, right after the link. Use the `qr-code` skill (`uv run ~/Code/scripts/qr-code.py "<URL>"`), and include the URL as text too. This covers apps, previews, output, and dashboards, on the home network or over the internet.
- Print QR codes in the terminal only, as text art, in a code block. Never generate, save, or open a PNG or other image file for a QR code.

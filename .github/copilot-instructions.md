# Copilot Instructions (Submodule: sck-core-docker)

## Plan → Approval → Execute (Mandatory)
Before altering Dockerfiles, compose files, or build scripts, provide a plan and wait for approval.

- Tech: Docker images/build contexts.
- Precedence: Local first; then root `../../.github/...`.
- Conventions: Keep Dockerfiles minimal, pinned, and reproducible. Prefer multi-stage builds and small base images.
- UI/Auth rules generally do not apply here unless building UI assets; if so, reference `../sck-core-ui/docs/ui-style-guide.md`.

## Contradiction Detection
- Check proposals against reproducibility and security best practices.
- If conflict, warn + options + example.
- Example: "Using latest tags conflicts with pinning guidance; pin exact base image digests."

## Standalone clone note
If cloned standalone, see:
- Root Copilot guidance: https://github.com/eitssg/simple-cloud-kit/blob/develop/.github/copilot-instructions.md
 

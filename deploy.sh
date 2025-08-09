#!/usr/bin/env bash
# deploy.sh  —  local build + always-push helper
# Usage:  ./deploy.sh  [optional commit message]

set -e          # stop on first error
BRANCH="main"   # change if your default branch is different

echo "🔧 Building site locally…"
hugo --minify   # add --cleanDestinationDir if you like

echo "✅ Local build succeeded."

# Stage everything (in case you edited files)
git add -A

# Use the user-supplied commit message if provided, else a timestamp
MSG="${1:-"Update / trigger rebuild • $(date -u +'%Y-%m-%dT%H:%M:%SZ')"}"

if git diff-index --quiet HEAD; then
  echo "ℹ️  No file changes detected — making an empty commit."
  git commit --allow-empty -m "$MSG"
else
  echo "📦 Committing actual changes."
  git commit -m "$MSG"
fi

echo "🚀 Pushing to $BRANCH…"
git push origin "$BRANCH"
echo "🎉 Done. GitHub Actions will rebuild in a minute."

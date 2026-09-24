#!/usr/bin/env bash
set -euo pipefail

# Rebuild the Hydra grammar from the local repository and refresh its queries.
#
# The grammar is a path source in languages.toml, so there is no revision to
# bump: regenerating the parser and rebuilding is the whole loop. The local
# checkout is the one pushed to github.com/antoniusnaumann/tree-sitter-hydra.

helix_config_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
grammar_repo="${HYDRA_GRAMMAR_REPO:-/Users/anaumann/Development/tree-sitter-hydra}"
query_source="$grammar_repo/queries"
query_target="$helix_config_dir/runtime/queries/hydra"

if [ ! -f "$grammar_repo/grammar.js" ]; then
    echo "Tree-sitter Hydra repository not found: $grammar_repo" >&2
    exit 1
fi

if command -v tree-sitter >/dev/null 2>&1; then
    (cd "$grammar_repo" && tree-sitter generate)
else
    echo "tree-sitter CLI not found; building whatever src/parser.c holds" >&2
fi

mkdir -p "$query_target"
find "$query_target" -maxdepth 1 -type f -name '*.scm' -delete
cp "$query_source"/*.scm "$query_target"/

echo "Copied queries to $query_target"

cd "$helix_config_dir"
hx --grammar build

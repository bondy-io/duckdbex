#!/bin/sh
# Build the DuckDB NIF for a rebar3 build.
#
# elixir_make normally drives the root Makefile with MIX_APP_PATH pointing at
# the mix build dir. Under rebar3 there is no elixir_make, so this script
# supplies the same variables and points MIX_APP_PATH at the project root:
# the Makefile writes priv/ into the source tree and rebar3 copies it into
# _build/default/lib/duckdbex/priv, exactly like any app artifact.
set -eu

cd "$(dirname "$0")/.."

ERTS_INCLUDE_DIR="$(erl -noshell -eval 'io:format("~ts/erts-~ts/include/", [code:root_dir(), erlang:system_info(version)]).' -s init stop)"

exec make MIX_APP_PATH="$PWD" ERTS_INCLUDE_DIR="$ERTS_INCLUDE_DIR" "$@"

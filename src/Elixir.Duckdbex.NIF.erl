%% @private
%% Pure-Erlang NIF stubs for the DuckDB NIF (priv/duckdb_nif.so).
%%
%% The module name is not a typo: the NIF registers itself as
%% 'Elixir.Duckdbex.NIF' (see ERL_NIF_INIT in c_src/nif.cpp), and the NIF
%% binds to whatever module loads it. Keeping the upstream module name means
%% this fork does not need to modify any upstream file. The Erlang compiler
%% requires the file name to equal the module name, hence the dotted file
%% name; the beam is Elixir.Duckdbex.NIF.beam, exactly what the Elixir side
%% produces from lib/duckdbex/nif.ex.
-module('Elixir.Duckdbex.NIF').

-on_load(init/0).

-export([
    create_config/0,
    set_config_option/3,
    get_config_options/0,
    release/1,
    open/2,
    connection/1,
    query/2,
    query/3,
    prepare_statement/2,
    execute_statement/1,
    execute_statement/2,
    get_named_parameters/1,
    begin_transaction/1,
    commit/1,
    rollback/1,
    set_auto_commit/2,
    is_auto_commit/1,
    has_active_transaction/1,
    columns/1,
    fetch_chunk/1,
    fetch_all/1,
    appender/2,
    appender/3,
    appender_add_row/2,
    appender_add_rows/2,
    appender_flush/1,
    appender_close/1,
    source_id/0,
    library_version/0,
    storage_format_version/0,
    library_version/1,
    platform/0,
    number_of_threads/1,
    extension_is_loaded/2
]).

init() ->
    Nif = case code:priv_dir(duckdbex) of
        {error, bad_name} -> filename:join("priv", "duckdb_nif");
        Dir -> filename:join(Dir, "duckdb_nif")
    end,
    ok = erlang:load_nif(Nif, 0).

create_config() -> erlang:nif_error(nif_library_not_loaded).
set_config_option(_Config, _Name, _Value) -> erlang:nif_error(nif_library_not_loaded).
get_config_options() -> erlang:nif_error(nif_library_not_loaded).
release(_Resource) -> erlang:nif_error(nif_library_not_loaded).
open(_Path, _Config) -> erlang:nif_error(nif_library_not_loaded).
connection(_Db) -> erlang:nif_error(nif_library_not_loaded).
query(_Conn, _Sql) -> erlang:nif_error(nif_library_not_loaded).
query(_Conn, _Sql, _Args) -> erlang:nif_error(nif_library_not_loaded).
prepare_statement(_Conn, _Sql) -> erlang:nif_error(nif_library_not_loaded).
execute_statement(_Stmt) -> erlang:nif_error(nif_library_not_loaded).
execute_statement(_Stmt, _Args) -> erlang:nif_error(nif_library_not_loaded).
get_named_parameters(_Stmt) -> erlang:nif_error(nif_library_not_loaded).
begin_transaction(_Conn) -> erlang:nif_error(nif_library_not_loaded).
commit(_Conn) -> erlang:nif_error(nif_library_not_loaded).
rollback(_Conn) -> erlang:nif_error(nif_library_not_loaded).
set_auto_commit(_Conn, _AutoCommit) -> erlang:nif_error(nif_library_not_loaded).
is_auto_commit(_Conn) -> erlang:nif_error(nif_library_not_loaded).
has_active_transaction(_Conn) -> erlang:nif_error(nif_library_not_loaded).
columns(_Result) -> erlang:nif_error(nif_library_not_loaded).
fetch_chunk(_Result) -> erlang:nif_error(nif_library_not_loaded).
fetch_all(_Result) -> erlang:nif_error(nif_library_not_loaded).
appender(_Conn, _Table) -> erlang:nif_error(nif_library_not_loaded).
appender(_Conn, _Schema, _Table) -> erlang:nif_error(nif_library_not_loaded).
appender_add_row(_Appender, _Row) -> erlang:nif_error(nif_library_not_loaded).
appender_add_rows(_Appender, _Rows) -> erlang:nif_error(nif_library_not_loaded).
appender_flush(_Appender) -> erlang:nif_error(nif_library_not_loaded).
appender_close(_Appender) -> erlang:nif_error(nif_library_not_loaded).
source_id() -> erlang:nif_error(nif_library_not_loaded).
library_version() -> erlang:nif_error(nif_library_not_loaded).
storage_format_version() -> erlang:nif_error(nif_library_not_loaded).
library_version(_StorageFormatVersion) -> erlang:nif_error(nif_library_not_loaded).
platform() -> erlang:nif_error(nif_library_not_loaded).
number_of_threads(_Db) -> erlang:nif_error(nif_library_not_loaded).
extension_is_loaded(_Db, _Name) -> erlang:nif_error(nif_library_not_loaded).

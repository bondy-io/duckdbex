%% DuckDB API for Erlang.
%%
%% Thin wrapper over the duckdbex_nif NIF. Pure Erlang: the package builds
%% with rebar3 and runs without Elixir. Elixir consumers get the same API
%% through the Duckdbex facade module (lib/duckdbex.ex).
-module(duckdbex).

-export([
    create_config/0,
    set_config_option/3,
    get_config_options/0,
    release/1,

    open/0,
    open/1,
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

    library_version/0,
    library_version/1,
    storage_format_version/0,
    source_id/0,
    platform/0,
    number_of_threads/1,
    extension_is_loaded/2,

    integer_to_hugeint/1,
    hugeint_to_integer/1
]).

%% Config

create_config() ->
    duckdbex_nif:create_config().

set_config_option(Config, Name, Value)
    when is_reference(Config) andalso (is_binary(Name) orelse is_atom(Name)) ->
    duckdbex_nif:set_config_option(Config, Name, Value).

get_config_options() ->
    duckdbex_nif:get_config_options().

release(Resource) when is_reference(Resource) ->
    duckdbex_nif:release(Resource).

%% Database and connections

open() ->
    duckdbex_nif:open(<<":memory:">>, nil).

open(Path) when is_binary(Path) ->
    duckdbex_nif:open(Path, nil);
open(Config) when is_reference(Config) ->
    duckdbex_nif:open(<<":memory:">>, Config).

open(Path, Config) when is_binary(Path), is_reference(Config) orelse Config =:= nil ->
    duckdbex_nif:open(Path, Config).

connection(Db) when is_reference(Db) ->
    duckdbex_nif:connection(Db).

%% Queries

query(Conn, Sql) when is_reference(Conn), is_binary(Sql) ->
    duckdbex_nif:query(Conn, Sql).

query(Conn, Sql, Args)
    when is_reference(Conn), is_binary(Sql), is_list(Args) orelse is_map(Args) ->
    duckdbex_nif:query(Conn, Sql, Args).

prepare_statement(Conn, Sql) when is_reference(Conn), is_binary(Sql) ->
    duckdbex_nif:prepare_statement(Conn, Sql).

execute_statement(Stmt) when is_reference(Stmt) ->
    duckdbex_nif:execute_statement(Stmt).

execute_statement(Stmt, Args)
    when is_reference(Stmt), is_list(Args) orelse is_map(Args) ->
    duckdbex_nif:execute_statement(Stmt, Args).

get_named_parameters(Stmt) when is_reference(Stmt) ->
    duckdbex_nif:get_named_parameters(Stmt).

%% Transactions

begin_transaction(Conn) when is_reference(Conn) ->
    duckdbex_nif:begin_transaction(Conn).

commit(Conn) when is_reference(Conn) ->
    duckdbex_nif:commit(Conn).

rollback(Conn) when is_reference(Conn) ->
    duckdbex_nif:rollback(Conn).

set_auto_commit(Conn, AutoCommit) when is_reference(Conn), is_boolean(AutoCommit) ->
    duckdbex_nif:set_auto_commit(Conn, AutoCommit).

is_auto_commit(Conn) when is_reference(Conn) ->
    duckdbex_nif:is_auto_commit(Conn).

has_active_transaction(Conn) when is_reference(Conn) ->
    duckdbex_nif:has_active_transaction(Conn).

%% Results

columns(Result) when is_reference(Result) ->
    duckdbex_nif:columns(Result).

fetch_chunk(Result) when is_reference(Result) ->
    duckdbex_nif:fetch_chunk(Result).

fetch_all(Result) when is_reference(Result) ->
    duckdbex_nif:fetch_all(Result).

%% Appender

appender(Conn, Table) when is_reference(Conn), is_binary(Table) ->
    duckdbex_nif:appender(Conn, Table).

appender(Conn, Schema, Table)
    when is_reference(Conn), is_binary(Schema), is_binary(Table) ->
    duckdbex_nif:appender(Conn, Schema, Table).

appender_add_row(Appender, Row) when is_reference(Appender), is_list(Row) ->
    duckdbex_nif:appender_add_row(Appender, Row).

appender_add_rows(Appender, Rows) when is_reference(Appender), is_list(Rows) ->
    duckdbex_nif:appender_add_rows(Appender, Rows).

appender_flush(Appender) when is_reference(Appender) ->
    duckdbex_nif:appender_flush(Appender).

appender_close(Appender) when is_reference(Appender) ->
    duckdbex_nif:appender_close(Appender).

%% Introspection

library_version() ->
    duckdbex_nif:library_version().

library_version(StorageFormatVersion) when is_integer(StorageFormatVersion) ->
    duckdbex_nif:library_version(StorageFormatVersion).

storage_format_version() ->
    duckdbex_nif:storage_format_version().

source_id() ->
    duckdbex_nif:source_id().

platform() ->
    duckdbex_nif:platform().

number_of_threads(Db) ->
    duckdbex_nif:number_of_threads(Db).

extension_is_loaded(Db, ExtensionName) ->
    duckdbex_nif:extension_is_loaded(Db, ExtensionName).

%% Hugeint helpers

integer_to_hugeint(Int) when is_integer(Int) ->
    {Int bsr 64, Int band 16#FFFFFFFFFFFFFFFF}.

hugeint_to_integer({Upper, Lower})
    when is_integer(Upper), is_integer(Lower), Lower >= 0 ->
    (Upper bsl 64) bor Lower.

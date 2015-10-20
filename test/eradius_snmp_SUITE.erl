-module(eradius_snmp_SUITE).
-compile(export_all).

-include_lib("common_test/include/ct.hrl").
-include_lib("eunit/include/eunit.hrl").

%%%===================================================================
%%% Common Test callbacks
%%%===================================================================

all() ->
    [snmpa_info].

init_per_suite(Config) ->
    DbDir = string:strip(os:cmd("mktemp -d -t eradius_dnmp_tests.XXX"), right, $\n),
    application:set_env(snmp, agent, [{config, [{dir, "../../priv/sample/snmp/agent/conf/"}]},
                                      {db_dir, DbDir},
                                      {mibs, ["../../priv/mibs/ERADIUS-MIB"]}]),
    application:ensure_all_started(eradius_snmp),
    Config.

end_per_suite(_Config) ->
    application:stop(eradius_snmp),
    ok.

%%%===================================================================
%%% Test cases
%%%===================================================================

snmpa_info(_Config) ->
    Info = snmpa:info(),
    ?assertEqual([v1, v2, v3], proplists:get_value(vsns, Info)),
    MIBServer = proplists:get_value(mib_server, Info, []),
    ct:pal("~p~n", [proplists:get_value(loaded_mibs, MIBServer)]),
    ?assertEqual({'ERADIUS-MIB', true, "../../priv/mibs/ERADIUS-MIB.bin"}, 
                 lists:keyfind('ERADIUS-MIB', 1, proplists:get_value(loaded_mibs, MIBServer))),
    ok.

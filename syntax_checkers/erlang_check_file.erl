#!/usr/bin/env escript
-export([main/1]).

main([FileName]) ->
    BaseDir = filename:join(filename:dirname(FileName), ".."),
    DepsDir = case file:consult(filename:join(BaseDir, "rebar.config")) of
                  {ok, Terms} ->
                      proplists:get_value(deps_dir, Terms, "deps");
                  {error, _} ->
                      "deps"
              end,
    compile:file(FileName,
                 [warn_obsolete_guard,
                  warn_unused_import,
                  warn_shadow_vars,
                  warn_export_vars,
                  strong_validation,
                  report,
                  {i, filename:join(BaseDir, "include")},
                  {i, filename:join(BaseDir, DepsDir)}]).

-module(erlang_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).



start(_Type, _Args) ->
	Dispatch = cowboy_router:compile([
		{'_', [
			{"/", hello_handler, []},
			{"/test", test_handler, []}
		]}
	]),
	{ok, _} = cowboy:start_clear(my_http_listener, 
		[{port, 53112}],
		#{env => #{dispatch => Dispatch}}),
	erlang_sup:start_link().

stop(_State) ->
	ok.

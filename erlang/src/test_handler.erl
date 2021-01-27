-module(test_handler).
-behavior(cowboy_handler).

-export([
	init/2,
	allowed_methods/2,
	content_types_provided/2,
	content_types_accepted/2,
	hello_to_json/2,
	test_get/2,
	test_post/2,
	test_put/2,
	router/2
	]).


init(Req, Opts) ->
	% io:format("Opts: ~p~n",[Req]),
	io:format("init Method: ~p~n",[cowboy_req:method(Req)]),
	{cowboy_rest, Req, Opts}.

allowed_methods(Req, State) ->
	{[
		<<"GET">>,
		<<"POST">>,
		<<"PUT">>
	], Req, State}.

content_types_provided(Req, State) ->
	{[
		{<<"application/json">>, hello_to_json}
	], Req, State}.

content_types_accepted(Req, State) ->
	io:format("Method: ~p~n",[cowboy_req:method(Req)]),
	{[{<<"application/json">>, router}], Req, State}.

router(Req, State) ->
	case cowboy_req:method(Req) of
		<<"POST">> ->
			{<<"{\"status\": \"POST\"}">>, Req, State};
		<<"PUT">> ->
			{<<"{\"status\": \"PUT\"}">>, Req, State};
			% Accepted = {[{<<"application/json">>, test_put}], Req, State};		
		<<"GET">> ->
			{<<"{\"status\": \"GET\"}">>, Req, State}
			% Accepted = {[{<<"application/json">>, test_get}], Req, State}
    end.

hello_to_json(Req, State) ->
	Body = <<"{\"rest\": \"Hello World!\"}">>,
	{Body, Req, State}.

test_get(Req, State) ->
	<<"{\"rest\": \"Hello POST!\"}">>.

test_post(Req, State) ->
	<<"{\"rest\": \"Hello POST!\"}">>.

test_put(Req, State) ->
	<<"{\"rest\": \"Hello PUT!\"}">>.


{application, 'erlang', [
	{description, "New project"},
	{vsn, "0.1.0"},
	{modules, ['erlang_app','erlang_sup','hello_handler','test_handler']},
	{registered, [erlang_sup]},
	{applications, [kernel,stdlib,cowboy,mysql]},
	{mod, {erlang_app, []}},
	{env, []}
]}.
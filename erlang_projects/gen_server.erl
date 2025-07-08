-module(server).
-author("Afghan Goat").
-behaviour(gen_server).

%% API
-export([start_link/0, beh/1, stop/0]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2,
	code_change/3]).

%% API Client Call
start_link() ->
	gen_server:start_link({global, ?MODULE}, ?MODULE, [], []).

stop() ->
	gen_server:cast({global,?MODULE}, stop).

%Custom behaviour by gen server
beh(n) ->
	%gen_server:call({global,?MODULE},{smth,n}).
	io:fwrite("Custom placeholder behaviour was called on gen_server~n").

init([]) ->
	process_flag(trap_exit, true),
	io:format("~p (~p) is initializing... ~n", [{global, ?MODULE}, self()]),
	{ok, []}.

handle_call(stop, _From, State) ->
	{stop, normal, ok, State}; %Pattern matching

handle_call(_Request, _From, State) ->
	{reply,error, State}.

handle_cast(stop, State) ->
	{stop, normal, State};

handle_cast(_Request, State) ->
	{noreply, State}.

handle_info(_Info, State) ->
	{noreply, State}.

terminate(_Reason, _State) ->
	io:format("terminating ~p~n", [{global, ?MODULE}]),
	ok.

code_change(_OldVsn, State, _Extra) ->
	{ok, State}.
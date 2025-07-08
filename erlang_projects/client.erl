% base client program
%UNFINISHED

-module(client).
-author("Afghan Goat").
-export([start/0,writea/0,spawn_all/1,sender/1,receiver/0]).

%main
start() ->
    Pid= spawn(fun() -> receiver() end),
    sender(Pid).

sender(Pid) ->
    Pid ! {self(), a_message}. %!Send
    

receiver() ->
    receive
        {From, Message} ->
            io:format("Received message from ~p: ~p~n",[From,Message]),
            receiver();
        _Other ->
            io:format("Unknown message received.~n"),
            receiver()
    after
        5000 ->
            io:fwrite("No message received after 5 seconds!~n")
    end.

writea() ->
    io:fwrite("Lorem!~n"),
    io:fwrite("Ipsum!~n"),
    io:fwrite("Dolor sit amet!3~n").

spawn_all(n) ->
    [spawn(fun start/0) || _ <- lists:seq(1,n)].
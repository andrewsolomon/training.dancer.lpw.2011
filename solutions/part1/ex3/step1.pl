#!/bin/env perl
use Dancer;
use DateTime;

set logger => 'console';
set log => 'debug';
set show_errors => 1;

get '/', sub {
    return "<h1>Hello World!</h1>";
};

get '/hello' => sub {
    return "<h1>Hello Things!</h1>";
};

get '/time' => sub {
    my $now = DateTime->now(time_zone => 'Europe/Riga');

    return "<p>Hello World, the time is now " . $now->ymd .' '. $now->hms. "</p>";
};

Dancer->dance;

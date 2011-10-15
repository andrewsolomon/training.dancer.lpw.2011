#!/bin/env perl
use Dancer;
use DateTime;

set port => $ENV{'DANCER_PORT'};
set logger => 'console';
set log => 'debug';
set show_errors => 1;

set engines => {
    template_toolkit => 
    {
        start_tag => '[%',
        stop_tag  => '%]'
    }
};
set template  => 'template_toolkit';

get '/', sub {
    return "<h1>Hello World!</h1>";
};

get '/hello' => sub {
    return "<h1>Hello Things!</h1>";
};

get '/time' => sub {
    my $now = DateTime->now(time_zone => 'Europe/Riga');

    return template 'date_time' => { time => $now->hms, date => $now->ymd };
};

Dancer->dance;

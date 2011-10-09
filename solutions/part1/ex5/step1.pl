#!/bin/env perl
use Dancer;

set logger      => 'console';
set log         => 'debug';
set show_errors => 1;

get '/'         => sub {
    return "<h1>Hello World!</h1>";
};

get '/hello/:adjective'    => sub {
    return "<h1>Turn it all around ".params->{adjective}." people!</h1>";
};

Dancer->dance;

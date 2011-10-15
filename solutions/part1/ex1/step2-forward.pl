#!/bin/env perl
use Dancer;

set port => $ENV{'DANCER_PORT'};
set logger      => 'console';
set log         => 'debug';
set show_errors => 1;

get '/'  => sub {
    return "<h1>Hello World!</h1>";
};

Dancer->dance;

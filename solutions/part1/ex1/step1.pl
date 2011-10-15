#!/bin/env perl
use Dancer;

set port => $ENV{'DANCE_PORT'};
set logger      => 'console';
set log         => 'debug';
set show_errors => 1;

get '/' => sub {
    return "Hello World!";
};

Dancer->dance;

#!/bin/env perl
use Dancer;

set logger      => 'console';
set log         => 'debug';
set show_errors => 1;

get '/' => sub {
    return "Hello World!";
};

Dancer->dance;

#!/usr/bin/perl
use Dancer;

set('logger', 'console');
set('log', 'debug');
set('show_errors',1);


my $hwsub = sub {
    return "Hello World!";
};

get('/', $hwsub);

Dancer->dance;

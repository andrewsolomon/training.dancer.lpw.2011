#!/bin/env perl
use Dancer;
use DateTime;

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

get '/' => sub {
    return template 'hello-adj-index';
};

get '/hello-adj' => sub {
    my $adjectives = params->{adjective};

    my @adj_list = split (/,/, $adjectives);
    template 'hello-multiple-adj' => { adjective_list => \@adj_list };
};



Dancer->dance;

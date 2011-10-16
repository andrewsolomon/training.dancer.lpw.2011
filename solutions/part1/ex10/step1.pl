#!/usr/bin/perl
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
    template 'hello-multiple-adj' => { adjective_list =>  params->{adjective} };
};



Dancer->dance;

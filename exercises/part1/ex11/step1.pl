#!/usr/bin/perl
use Dancer;
use Data::Dump qw/pp/;

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
    my $ra_shopping_list = params->{item};
    return template 'write-it-on-my-forehead' => { 
      shopping_list => $ra_shopping_list ,
      req_headers => pp(request->headers),
    };
};



Dancer->dance;

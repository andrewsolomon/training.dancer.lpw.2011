#!/usr/bin/perl
use Dancer;
use Data::Dump qw/pp/;

set logger => 'console';
set log => 'debug';
set show_errors => 1;
set session => 'Simple';
set layout  => 'main';


set engines => {
    template_toolkit => 
    {
        start_tag => '[%',
        stop_tag  => '%]'
    }
};
set template  => 'template_toolkit';

get '/' => sub {
    debug ('Storing: '.pp(params->{item}));
    my $one_item = params->{item};
    my @items;
    if (defined( session('shopping_list') )) {
      @items = @{session('shopping_list') };
    }
    push @items, $one_item if $one_item;
    session shopping_list => \@items;


    return template 'remember' => { 
      list => \@items , 
      req_headers => pp(request->headers),
    };
     
};



Dancer->dance;

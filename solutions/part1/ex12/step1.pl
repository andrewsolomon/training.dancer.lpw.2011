#!/usr/bin/perl
use Dancer;

set logger => 'console';
set log => 'debug';
set show_errors => 1;


Dancer->dance;

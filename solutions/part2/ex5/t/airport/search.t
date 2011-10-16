#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

use Test::More qw/no_plan/;

BEGIN {
  use_ok('Airport::Data');
  use_ok('Airport::Search');
}

my $ra_airports = Airport::Data::parse_airports('t/data/airports1.csv');
my $n_all = scalar(@$ra_airports);
my @tests = (

  {
    string     => 'Air'   ,
    is_word    =>  0  ,
    num_expected  => $n_all ,
  },


  {
    string     => 'Air'   ,
    is_word    =>  1  ,
    num_expected  => 0 ,
  },

  {
    string     => 'Airport'   ,
    is_word    =>  1  ,
    num_expected  => 5  ,
  },

  {
    string     => 'Sydney'   ,
    is_word    =>  1  ,
    num_expected  => 1 ,
  },

  {
    string     => 'Sydney'   ,
    is_word    =>  0  ,
    num_expected  => 1 ,
  },

);

foreach my $rh_test (@tests) {
  my $ra_search_res = Airport::Search::get_name_matching_airports(
    airports => $ra_airports,
    matching_string => $rh_test->{string},
    word  => $rh_test->{is_word},
  );
  is (ref($ra_search_res), 'ARRAY', 'get_matching_airports returns an arrayref');
  is (scalar(@$ra_search_res), $rh_test->{num_expected}, 
      'no names contain word Air');
  foreach (@$ra_search_res) {
    is(ref($_), 'HASH', 'array element is a hashref');
  }
}


my $maxdist = 403;
my @latlong_tests = (
  {
    x => 0, 
    y => 0, 
    d => $maxdist,
    num_expected => $n_all,
  },
  {
    x => 0, 
    y => 0, 
    d => 0,
    num_expected => 0,
  },
  {
    x => 151.177, 
    y => -33.9, 
    d => 1,
    num_expected => 1,
  },

);

foreach my $rh_test (@latlong_tests) {
  my $ra_search_res = Airport::Search::get_latlong_matching_airports(
    airports => $ra_airports,
    lat => $rh_test->{y},
    long => $rh_test->{x},
    max => $rh_test->{d},
  );
  is (ref($ra_search_res), 'ARRAY', 'get_latlong_matching_airports returns an arrayref');
  is (scalar(@$ra_search_res), $rh_test->{num_expected}, 
      'Correct number of airports found');
  foreach (@$ra_search_res) {
    is(ref($_), 'HASH', 'array element is a hashref');
  }
}

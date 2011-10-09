#!/usr/bin/perl

use strict;
use warnings;
use 5.010;
use Data::Types qw/is_float/;
use Data::Dump qw/pp/;

use Test::More qw/no_plan/;

BEGIN {
  use_ok('Airport::Data');
}

ok(1, 'non zero is good ');
#ok(0, 'zero is bad');
my @keys_to_check = qw/id name latitude_deg longitude_deg iata_code/;

my $ra_airports = Airport::Data::parse_airports('t/data/airports1.csv');

is(ref($ra_airports), 'ARRAY', 'parse_airports returns an array ref');
is(scalar(@$ra_airports), 5, 'returns 5 airports');
foreach my $rh_ap (@$ra_airports) {
  is(ref($rh_ap), 'HASH', 'each airport is hashref');
  foreach my $key (@keys_to_check ) {
    ok ($rh_ap->{$key}, "Airport key $key has value ".$rh_ap->{$key});
    if ($key =~ /_deg$/) {
      ok(is_float($rh_ap->{$key}), "$key is a floatingpoint number");
    }
  }
}


my $r_latlong = Airport::Data::parse_search_string("10:-10.3");
ok($r_latlong->{latitude} && $r_latlong->{longitude} , 'matches latlong');
my $r_string = Airport::Data::parse_search_string("3is my place");
ok($r_string->{matching}, 'matches string');




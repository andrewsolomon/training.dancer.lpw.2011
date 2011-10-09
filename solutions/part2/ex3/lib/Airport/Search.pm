package Airport::Search;

use strict;
use warnings;
use Text::CSV;
use 5.010;
use List::Util qw/min/;
use Data::Dump qw/pp/;

=head2 get_name_matching_airports 

  airports - an arrayref of hashrefs as produced by Airports::Data
  matching string - a string to be found in name
  word    - a boolean. If 1, only match against entire words 

=cut


sub get_name_matching_airports {
  my $rh_args = {
    airports        => undef,
    matching_string => undef,
    word            => undef,
    @_
  };


  my @matches;

  foreach my $airport (@{$rh_args->{airports}}) {
    my $match = $rh_args->{matching_string};
    if (($rh_args->{word} && ($airport->{name} =~ m/\b$match\b/i))
      || ((!$rh_args->{word}) && ($airport->{name} =~ m/$match/i)) 
      || ($rh_args->{word} && ($airport->{municipality} =~ m/\b$match\b/i))
      || ((!$rh_args->{word}) && ($airport->{municipality} =~ m/$match/i)) ) {
      push (@matches, $airport);
    }

  }
  return \@matches;
}



=head2 get_latlong_matching_airports 

  airports - an arrayref of hashrefs as produced by Airports::Data
  lat - <floating point>, # latitude search
  long  <floating point>, # longitude search
  max <floating point>, # the distance within which an airport is a match.

=cut


sub get_latlong_matching_airports {
  my $rh_args = {
    airports        => undef,
    lat             => undef,
    long            => undef,
    max             => undef,
    @_
  };


  my @matches;

  foreach my $airport (@{$rh_args->{airports}}) {
    if (_distance(
        y1  => $airport->{latitude_deg},
        y2  => $rh_args->{lat},
        x1 => $airport->{longitude_deg},
        x2 => $rh_args->{long}) <= $rh_args->{max}) {

      push (@matches, $airport);
      
    }
    

  }
  return \@matches;
}

sub _distance {
  my $rh_args = {
    x1 => undef, 
    y1 => undef, 
    x2 => undef, 
    y2 => undef, 
    @_
  };

  my $xdiff = abs($rh_args->{x1} - $rh_args->{x2});

  my $ydiff = abs($rh_args->{y1} - $rh_args->{y2});

  my $dist = sqrt(
    $ydiff**2 + 
    min($xdiff, abs(360 - $xdiff))**2
  );

#say "Xdiff = $xdiff, Ydiff = $ydiff and Dist = $dist";
  
  return $dist;

}

1;


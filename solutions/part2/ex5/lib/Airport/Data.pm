package Airport::Data;

use strict;
use warnings;
use Text::CSV;
use 5.010;
use Data::Types qw/is_float/;


sub parse_airports {
  my $infile = shift;

  my $csv = Text::CSV->new( { binary => 1, eol => $/ });
  my $in_fh;
  open ($in_fh, "<:encoding(utf8)", $infile) or die $!;

  my $ra_colnames = $csv->getline( $in_fh ) ;
  $csv->column_names(@$ra_colnames);

  my @airports;

  while (my $rh_line =  $csv->getline_hr($in_fh) ) {
    push @airports, $rh_line;
  }

  close ($in_fh);

  return \@airports;

}

sub parse_search_string {
  my $input  = shift;

  $input =~ s/:/ /g;
  $input =~ s/,/ /g;

  my ($a, $b ) = split(/ /,$input);

  if (is_float($a) and is_float($b)) {
    return { latitude => $a, longitude => $b };
  }
  else {
    return {matching => $input};
  }

}


1;

package Airport::Controller;
use Airport::Data;
use Airport::Search;
use Dancer;

debug 'Reading airports_csv';
my $ra_airports = Airport::Data::parse_airports(setting('airports_csv'));


get '/' => sub {
  template 'index';
};

get '/results' => sub {
  my $searchstring = params->{searchstring};
  my $rh_search_params = Airport::Data::parse_search_string($searchstring);


  my $ra_searchresults ;
  if (defined($rh_search_params->{latitude}))  {
    $ra_searchresults = Airport::Search::get_latlong_matching_airports(
      airports  => $ra_airports,
      lat       => $rh_search_params->{latitude},
      long      => $rh_search_params->{longitude},
      max       => 1,
    );
  }
  else {
    $ra_searchresults = Airport::Search::get_name_matching_airports(
      airports  => $ra_airports,
      matching_string      => $rh_search_params->{matching},
      word      => 1,
    );

  }

  template 'index' => {
    search_type => defined($rh_search_params->{latitude}) ?
      'location' : 'name',
    searchstring => $searchstring,
    num_airports_found => scalar(@$ra_searchresults),
    total_number_airports => scalar(@$ra_airports),
    searchresults => $ra_searchresults,

  };
};

1;



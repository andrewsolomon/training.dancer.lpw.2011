package Airport::Controller;
use Dancer;


get '/' => sub {
  template 'index';
};

get '/results' => sub {
  my $searchstring = params->{searchstring};
  template 'index' => {
    searchstring => $searchstring,
    searchresults => [
      { name => 'Kentucky Fried Airport', iso_country => 'Kentucky' },
      { name => 'McAirport', iso_country => 'United State of Texas' },
    ],

  };
};

1;



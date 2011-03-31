use strict;
use Facebook::Graph;
use Net::Twitter::Lite;

register( 'Twitter' => sub {
    my $c = shift;
    my $config = $c->get('config');
    die 'please set consumer_key' unless $config->{Twitter}->{consumer_key};
    die 'please set consumer_secret' unless $config->{Twitter}->{consumer_secret};
    return Net::Twitter::Lite->new(%{$config->{Twitter}});
}, { persistent => 1 });

register( 'Facebook' => sub {
    my $c = shift;
    my $config = $c->get('config');
    die 'please set app_id' unless $config->{Facebook}->{app_id};
    die 'please set secret' unless $config->{Facebook}->{secret};
    return Facebook::Graph->new(%{$config->{Facebook}});
}, { persistent => 1 });

1;
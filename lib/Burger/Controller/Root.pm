package Burger::Controller::Root;
use strict;
use warnings;
use parent 'Pickles::Controller';

use Encode;
use JSON;

sub index {
    my( $self, $c ) = @_;
    
    my $json = JSON->new->pretty->utf8;
    
    $c->stash->{to_json} = sub {
        decode_utf8($json->encode(shift))
    };
    
    $c->stash->{tw_account} = $c->session->get('tw_account');
    $c->stash->{fb_account} = $c->session->get('fb_account');
    $c->stash->{dropbox_account} = $c->session->get('dropbox_account');
    $c->stash->{openid_account} = $c->session->get('openid_account');
}

sub logout {
    my( $self, $c ) = @_;
    
    $c->session->expire;
    $c->redirect('/');
}

1;

__END__


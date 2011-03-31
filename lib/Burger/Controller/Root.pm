package Burger::Controller::Root;
use strict;
use warnings;
use parent 'Pickles::Controller';

sub index {
    my( $self, $c ) = @_;
    
    $c->stash->{tw_account} = $c->session->get('tw_account');
    $c->stash->{fb_account} = $c->session->get('fb_account');
}

sub login {
    my( $self, $c ) = @_;
    
    
}

1;

__END__


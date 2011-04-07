package Burger::Controller::Root;
use strict;
use warnings;
use parent 'Pickles::Controller';

sub index {
    my( $self, $c ) = @_;
    
    $c->stash->{tw_account} = $c->session->get('tw_account');
    $c->stash->{fb_account} = $c->session->get('fb_account');
    $c->stash->{dropbox_account} = $c->session->get('dropbox_account');
}

sub logout {
    my( $self, $c ) = @_;
    
    $c->session->expire;
    $c->redirect('/');
}

1;

__END__


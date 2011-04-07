package Burger::Controller::Login::Dropbox;
use strict;
use warnings;
use parent 'Pickles::Controller';

sub oauth {
    my( $self, $c ) = @_;
    
    my $box = $c->get('Dropbox');
    my $url = $box->login;
    die $box->error if $box->error;
    
    $c->session->set('dropbox_request', {
        request_token  => $box->request_token,
        request_secret => $box->request_secret
    });
    
    $url=~s|^https?://api|https://www|;
    
    $c->redirect($url);
}

sub callback {
    my( $self, $c ) = @_;
    
    my $dropbox_request = $c->session->remove('dropbox_request');

    my $box = $c->get('Dropbox');
    $box->request_token($dropbox_request->{request_token});
    $box->request_secret($dropbox_request->{request_secret});
    $box->auth;
    die $box->error if $box->error;
    
    my $account_info = $box->account_info;
    $c->session->set('dropbox_account', {
        account_info => $account_info,
        access_token => $box->access_token,
        access_secret => $box->access_secret
    });
    
    $c->redirect('/');
}

1;

__END__


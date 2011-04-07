package Burger::Controller::Login::Twitter;
use strict;
use warnings;
use parent 'Pickles::Controller';

sub oauth {
    my( $self, $c ) = @_;
    
    my $nt = $c->get('Twitter');
    my $url = $nt->get_authentication_url(callback => $c->config->{Twitter}->{callback});
    
    $c->session->set('tw_request', {
        request_token        => $nt->request_token,
        request_token_secret => $nt->request_token_secret
    });
    
    $c->redirect($url);
}

sub callback {
    my( $self, $c ) = @_;
    
    my $tw_request = $c->session->remove('tw_request');

    my $nt = $c->get('Twitter');
    $nt->request_token($tw_request->{request_token});
    $nt->request_token_secret($tw_request->{request_token_secret});
    
    my $verifier = $c->req->param('oauth_verifier');

    my($access_token, $access_token_secret, $user_id, $screen_name) =
        $nt->request_access_token(verifier => $verifier);
    
    $c->session->set('tw_account', {
        user_id => $user_id,
        screen_name => $screen_name,
        access_token => $access_token,
        access_token_secret => $access_token_secret
    });
    
    $c->redirect('/');
}

1;

__END__


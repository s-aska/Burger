package Burger::Controller::Login::Facebook;
use strict;
use warnings;
use parent 'Pickles::Controller';

sub oauth {
    my( $self, $c ) = @_;
    
    my $fb = $c->get('Facebook');
    my $url = $fb->authorize->extend_permissions('publish_stream')->uri_as_string;
    
    warn $url;
    
    $c->redirect($url);
}

sub callback {
    my( $self, $c ) = @_;
    
    my $code = $c->req->param('code');
    my $fb = $c->get('Facebook');
    $fb->request_access_token($code);
    my $access_token = $fb->access_token;
    my $user = $fb->fetch('me');
    use Data::Dumper;
    warn Dumper($user);
    $c->session->set('fb_account', {
        user => $user,
        access_token => $access_token
    });
    
    $c->redirect('/');
}

1;

__END__


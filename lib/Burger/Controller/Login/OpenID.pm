package Burger::Controller::Login::OpenID;
use strict;
use warnings;
use parent 'Pickles::Controller';

use Net::OpenID::Consumer::Lite;

sub auth {
    my( $self, $c ) = @_;
    
    my $check_url;
    if (my $op = $c->req->param('op')) {
        my $config = $c->config;
        my $error;
        $error = 'please set return_to' unless $config->{OpenID}->{return_to};
        $error = 'please set realm' unless $config->{OpenID}->{realm};
        if ($error) {
            $c->res->body("$error");
            $c->finished(1);
            $c->abort;
        }
        if ($op eq 'google') {
            my $google_url = URI->new('https://www.google.com/accounts/o8/ud');
            my %query = (
                'openid.ns'         => 'http://specs.openid.net/auth/2.0',
                'openid.claimed_id' => 'http://specs.openid.net/auth/2.0/identifier_select',
                'openid.identity'   => 'http://specs.openid.net/auth/2.0/identifier_select',
                'openid.return_to'  => $config->{OpenID}->{return_to},
                'openid.realm'      => $config->{OpenID}->{realm},
                'openid.mode'       => 'checkid_setup'
            );
            my @required = $c->req->param('openid.ax.required');
            if (@required) {
                my $axschema = {
                    country   => 'http://axschema.org/contact/country/home',
                    email     => 'http://axschema.org/contact/email',
                    firstname => 'http://axschema.org/namePerson/first',
                    language  => 'http://axschema.org/pref/language',
                    lastname  => 'http://axschema.org/namePerson/last'
                };
                for my $type (@required) {
                    $query{'openid.ax.type.'.$type} = $axschema->{$type};
                }
                $query{'openid.ax.required'} = join(',', @required);
                $query{'openid.ns.ax'} = 'http://openid.net/srv/ax/1.0';
                $query{'openid.ax.mode'} = 'fetch_request';
            }
            $google_url->query_form(%query);
            $check_url = $google_url->as_string;
            warn $check_url;
        } elsif ($op eq 'hatena') {
            my $hatena_id = $c->req->param('hatena_id');
            my $hatena_url = URI->new('https://www.hatena.ne.jp/openid/server');
            $hatena_url->query_form(
                'openid.identity'   => "http://www.hatena.ne.jp/$hatena_id/",
                'openid.return_to'  => $config->{OpenID}->{return_to},
                'openid.realm'      => $config->{OpenID}->{realm},
                'openid.mode'       => 'checkid_immediate'
            );
            $check_url = $hatena_url->as_string;
        }
        else {
            $c->res->body("unknown op $op");
            $c->finished(1);
            $c->abort;
        }
    }
    elsif (my $server_url = $c->req->param('openid.identifier')) {
        my $return_to = $c->config->{OpenID}->{return_to};
        $check_url = Net::OpenID::Consumer::Lite->check_url(
            $server_url,
            $return_to
        );
    }
    
    $c->redirect($check_url);
}

sub callback {
    my( $self, $c ) = @_;
    
    my $request = $c->req->parameters->mixed;
    
    if ($request->{'openid.identity'}=~m|^http://www.hatena.ne.jp/|) {
        $request->{'openid.op_endpoint'}
            = 'https://www.hatena.ne.jp/openid/server';
    }
    
    Net::OpenID::Consumer::Lite->handle_server_response(
        $request => (
            not_openid => sub {
                die "Not an OpenID message";
            },
            setup_required => sub {
                my $setup_url = shift;
                warn "setup_url: $setup_url";
                $c->redirect($setup_url);
            },
            cancelled => sub {
                $c->res->body('cancel.');
                $c->finished(1);
                $c->abort;
            },
            verified => sub {
                my $vident = shift;
                $c->session->set('openid_account', {
                    vident => $vident
                });
                $c->redirect('/');
            },
            error => sub {
                my $err = shift;
                $c->res->body('error: ' . $err);
                $c->finished(1);
                $c->abort;
            }
        )
    );
}

1;

__END__


use HTTP::Session;
use HTTP::Session::Store::File;
use HTTP::Session::State::Cookie;

my $session_dir = __path_to('sessions');

mkdir $session_dir if !-d $session_dir;

return +{
    'Plugin::Session' => {
        store => HTTP::Session::Store::File->new(
            dir => $session_dir,
        ),
        state => HTTP::Session::State::Cookie->new()
    },
    Twitter => {
        consumer_key => '',
        consumer_secret => '',
        callback => 'http://localhost:5000/login/twitter/callback',
        oauth_urls => {
            request_token_url  => "https://api.twitter.com/oauth/request_token",
            authorization_url  => "https://api.twitter.com/oauth/authorize",
            authentication_url => "https://api.twitter.com/oauth/authenticate",
            access_token_url   => "https://api.twitter.com/oauth/access_token",
            xauth_url          => "https://api.twitter.com/oauth/access_token"
        }
    },
    Facebook => {
        postback => 'http://localhost:5000/login/facebook/callback',
        app_id => '',
        secret => ''
    },
    Dropbox => {
        key => '',
        secret => '',
        callback_url => 'http://localhost:5000/login/dropbox/callback'
    },
    OpenID => {
        return_to => 'http://localhost:5000/login/openid/callback',
        realm => 'http://localhost:5000/'
    }
};


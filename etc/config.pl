use HTTP::Session;
use HTTP::Session::Store::File;
use HTTP::Session::State::Cookie;

return +{
    'Plugin::Session' => {
        store => HTTP::Session::Store::File->new(
            dir => '/tmp/sessions',
        ),
        state => HTTP::Session::State::Cookie->new()
    },
    Twitter => {
        consumer_key => '',
        consumer_secret => '',
        callback => 'http://localhost:5000/login/twitter/callback',
        oauth_urls => {
            request_token_url => "https://api.twitter.com/oauth/request_token",
            authorization_url => "https://api.twitter.com/oauth/authorize",
            access_token_url  => "https://api.twitter.com/oauth/access_token",
            xauth_url         => "https://api.twitter.com/oauth/access_token"
        }
    },
    Facebook => {
        postback => 'http://localhost:5000/login/facebook/callback',
        app_id => '',
        secret => ''
    }
};


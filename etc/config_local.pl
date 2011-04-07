return +{
    Twitter => {
        consumer_key => 'd6hRIZT0OUNuU5Uklqiw',
        consumer_secret => 'MP84rcMlshtfrc8W1ywPGq4fWfnGM8PWM8VRKacug',
        callback => 'http://localhost:8000/login/twitter/callback',
        oauth_urls => {
            request_token_url  => "https://api.twitter.com/oauth/request_token",
            authorization_url  => "https://api.twitter.com/oauth/authorize",
            authentication_url => "https://api.twitter.com/oauth/authenticate",
            access_token_url   => "https://api.twitter.com/oauth/access_token",
            xauth_url          => "https://api.twitter.com/oauth/access_token"
        }
    },
    Facebook => {
        postback => 'http://localhost:8000/login/facebook/callback',
        app_id => '200200250012308',
        secret => 'd89bb7116fdc1a737ead2ce79df70423'
    },
    Dropbox => {
        key => '1s9bfctl76jpceg',
        secret => 'fr3ti28li2qn6mt',
        callback_url => 'http://localhost:8000/login/dropbox/callback'
    }
};
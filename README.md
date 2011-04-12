# Burger

Pickles's Sample Application.

( Picklesを美味しく頂く為ののサンプルアプリケーションです。 )

## Screen

<img src="http://dl.dropbox.com/u/11475683/screen/burger003.png">

## Features

- Social/OAuth Login
  - Twitter
  - Facebook
  - Dropbox
  - Google (OpenID)
  - Other OpenID

### Setup Twitter

1. Create App https://developer.twitter.com/apps/new  
    Choose Browser Application.  
    Input Callback URL (http://example.com/login/twitter/callback)
2. Get Consumer Key and Consumer Secret
3. edit config.pl

        Twitter => {
            consumer_key => 'Your App Consumer Key',
            consumer_secret => 'Your App Consumer Secret',
            callback => 'http://localhost:5000/login/twitter/callback',
            oauth_urls => {
                request_token_url => "https://api.twitter.com/oauth/request_token",
                authorization_url => "https://api.twitter.com/oauth/authorize",
                access_token_url  => "https://api.twitter.com/oauth/access_token",
                xauth_url         => "https://api.twitter.com/oauth/access_token"
            }
        },

**Caution**

- ブラウザアプリケーションを指定しないと利用できない
- Callback URL を指定しないと勝手にクライアントアプリケーションとして登録されてしまう
- Callback URL にlocalhostは指定できないが、リクエスト時に上書きできるので適当なのを入れる

### Setup Facebook

1. Create App <http://www.facebook.com/developers/createapp.php>
2. Get app\_id and Secret
3. Register Web Site URL (eg. http://localhost:5000/)
4. edit config.pl

        Facebook => {
            postback => 'http://localhost:5000/login/facebook/callback',
            app_id => 'Your app_id',
            secret => 'Your secret'
        }

**Caution**

- Site URL を登録したドメイン配下しかpostbackに指定できない

### Setup Dropbox

1. Create App <https://www.dropbox.com/developers>
2. Get API Key and API Secret
3. edit config.pl

        Dropbox => {
            key => 'Your API Key',
            secret => 'Your API Secret',
            callback_url => 'http://localhost:8000/login/dropbox/callback'
        }

## Run

    plackup Burger.psgi

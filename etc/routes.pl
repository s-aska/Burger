router {
    connect '/' => { controller => 'Root', action => 'index' };
    connect '/:action' => { controller => 'Root' };
    connect '/login/twitter/:action' => { controller => 'Login::Twitter' };
    connect '/login/facebook/:action' => { controller => 'Login::Facebook' };
    connect '/login/dropbox/:action' => { controller => 'Login::Dropbox' };
    connect '/login/openid/:action' => { controller => 'Login::OpenID' };
};

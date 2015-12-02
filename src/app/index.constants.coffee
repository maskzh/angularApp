angular.module('jkbs')
  # .constant 'malarkey', malarkey
  # .constant 'moment', moment
  .constant 'AUTH_EVENTS',
    loginSuccess: 'auth-login-success'
    loginFailed: 'auth-login-failed'
    logoutSuccess: 'auth-logout-success'
    sessionTimeout: 'auth-session-timeout'
    notAuthenticated: 'auth-not-authenticated'
    notAuthorized: 'auth-not-authorized'
  .constant 'USER_ROLES',
    all: '*'
    public: 'public'
    shop: 'shop'
    institution: 'institution'
    guest: 'guest'

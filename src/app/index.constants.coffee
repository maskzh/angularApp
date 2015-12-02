angular.module('jkbs')

  # .constant 'malarkey', malarkey
  .constant 'moment', moment    # moment 库

  .constant 'AUTH_EVENTS',
    loginSuccess: 'auth-login-success'
    loginFailed: 'auth-login-failed'
    logoutSuccess: 'auth-logout-success'
    notAuthenticated: 'auth-not-authenticated'
    notAuthorized: 'auth-not-authorized'
    sessionTimeout: 'auth-session-timeout'
  .constant 'USER_ROLES',
    all: '*'
    public: 'public'
    shop: 'shop'
    institution: 'institution'
    guest: 'guest'

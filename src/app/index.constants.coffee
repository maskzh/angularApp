# 所有全局常量配置
angular.module 'jkbs'
  .constant 'moment', moment    # moment 库

  # URL
  .constant 'URL',
    img: 'http://img.jkbsimg.com/'
    root: 'https://api.jkbsapp.com'

  # 全局事件
  .constant 'EVENTS',
    loginSuccess: 'auth-login-success'
    loginFailed: 'auth-login-failed'
    logoutSuccess: 'auth-logout-success'
    notAuthenticated: 'auth-not-authenticated'
    notAuthorized: 'auth-not-authorized'
    sessionTimeout: 'auth-session-timeout'
    jumpSuccess: 'jump-success'

  # 用户角色
  .constant 'USER_ROLES',
    all: '*'
    public: 'public'
    shop: 'shop'
    institution: 'institution'
    guest: 'guest'

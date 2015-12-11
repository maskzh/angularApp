angular.module 'jkbs'
  .run ($rootScope, EVENTS, Auth, $log) ->
    'ngInject'

    # 绑定 stateChangeStart 事件
    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->

      # 先自动登录，Auth 模块会处理 User 服务里的数据
      Auth.autoLogin()

      # 判断是否为 login 页面，如果是 login 页面则不校验登录状态
      if toState.name is 'login'
        return

      # 校验登录状态
      if !Auth.isAuthenticated()
        event.preventDefault()
        $rootScope.$broadcast EVENTS.notAuthenticated
        return

      # 校验通过广播跳转成功
      # TODO BUG 刷新页面时 directive 还未初始化，所以无法收到广播
      $rootScope.$broadcast EVENTS.jumpSuccess

      return

    $log.debug 'runBlock end'

angular.module 'jkbs'
  .run ($rootScope, EVENTS, Auth, $log) ->
    'ngInject'
    $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
      Auth.autoLogin()
      if toState.name is 'login'
        return

      if !Auth.isAuthenticated()
        event.preventDefault()
        $rootScope.$broadcast EVENTS.notAuthenticated
        return

      $rootScope.$broadcast EVENTS.jumpSuccess

      return

    $log.debug 'runBlock end'

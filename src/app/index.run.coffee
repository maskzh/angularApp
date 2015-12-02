angular.module 'jkbs'
  .run ($rootScope, AUTH_EVENTS, Auth, $log) ->
    'ngInject'
    $rootScope.$on '$stateChangeStart', (event, next) ->
      authorizedRoles = next.data.authorizedRoles
      if !Auth.isAuthorized(authorizedRoles)
        event.preventDefault()
        if Auth.isAuthenticated()
          $rootScope.$broadcast AUTH_EVENTS.notAuthorized
        else
          $rootScope.$broadcast AUTH_EVENTS.notAuthenticated

    $log.debug 'runBlock end'

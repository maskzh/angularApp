angular.module 'jkbs'
  .controller 'LoginController', ($rootScope, AUTH_EVENTS, Auth) ->
    'ngInject'
    vm = this
    vm.credentials =
      username: '',
      password: ''

    vm.login = (credentials) ->
      Auth.login(credentials).then (user) ->
        $rootScope.$broadcast(AUTH_EVENTS.loginSuccess)
        $scope.setCurrentUser(user)
      , () ->
        $rootScope.$broadcast(AUTH_EVENTS.loginFailed)

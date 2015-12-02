angular.module 'jkbs'
  .controller 'LoginController', ($rootScope, AUTH_EVENTS, Auth, Sha1) ->
    'ngInject'
    vm = this
    vm.credentials =
      username: '',
      password: ''

    vm.login = (credentials) ->
      credentials.password = Sha1.hash(credentials.password)
      console.log credentials
      Auth.login(credentials).then (user) ->
        $rootScope.$broadcast(AUTH_EVENTS.loginSuccess)
        $scope.setCurrentUser(user)
      , () ->
        $rootScope.$broadcast(AUTH_EVENTS.loginFailed)

    return

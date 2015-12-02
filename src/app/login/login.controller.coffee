angular.module 'jkbs'
  .controller 'LoginController', ($rootScope, $scope, EVENTS, Auth, Sha1) ->
    'ngInject'
    vm = this
    vm.credentials =
      mobile: '',
      password: ''

    vm.login = (credentials) ->
      credentials.password = Sha1.hash(credentials.password)
      Auth.login(credentials).then (user) ->
        $scope.setCurrentUser(user)
        $rootScope.$broadcast(EVENTS.loginSuccess)
      , () ->
        $rootScope.$broadcast(EVENTS.loginFailed)

    return

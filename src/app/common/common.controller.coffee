angular.module 'jkbs'
  .controller 'commonController', ($scope, Auth, EVENTS, User, $state, toastr) ->
    'ngInject'

    $scope.currentUser = null
    # $scope.userRoles = USER_ROLES
    # $scope.isAuthorized = Auth.isAuthorized
    $scope.setCurrentUser = (user) ->
      $scope.currentUser = user

    $scope.$on EVENTS.loginSuccess, (event) ->
      $state.go 'base.home'

    $scope.$on EVENTS.loginFailed, (event) ->
      alert '暂时无法登录'

    $scope.$on EVENTS.logoutSuccess, (event) ->
      User.destroy()
      $state.go 'login'

    $scope.$on EVENTS.notAuthenticated, (event) ->
      $state.go 'login'

    toastr.info '欢迎登录健康帮手！'

    return

    # $scope.$on EVENTS.notAuthorized, (event) ->
    #   console.log EVENTS.notAuthorized
    #
    # $scope.$on EVENTS.sessionTimeout, (event) ->
    #   console.log EVENTS.sessionTimeout

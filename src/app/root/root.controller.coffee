# angular 根节点 APP
# 由该控制器接受 stateChange 分发到具体页面
angular.module 'jkbs'
  .controller 'rootController', ($scope, Auth, EVENTS, User, $state) ->
    'ngInject'

    $scope.currentUser = null
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

    return

    # $scope.$on EVENTS.notAuthorized, (event) ->
    #   console.log EVENTS.notAuthorized
    #
    # $scope.$on EVENTS.sessionTimeout, (event) ->
    #   console.log EVENTS.sessionTimeout

angular.module 'jkbs'
  .controller 'BaseController', (USER_ROLES, Auth, toastr) ->
    'ngInject'
    vm = this
    vm.showToastr = (info) ->
      toastr.info 'info'
      return

    vm.currentUser = null
    vm.userRoles = USER_ROLES
    vm.isAuthorized = Auth.isAuthorized
    vm.setCurrentUser = (user) ->
      vm.currentUser = user
    return

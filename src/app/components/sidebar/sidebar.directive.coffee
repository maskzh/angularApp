angular.module 'jkbs'
  .directive 'jSidebar', ->
    SidebarController = ($scope, menu, $location, EVENTS) ->
      'ngInject'
      vm = this
      vm.menu = menu.getMenu()
      vm.currentUrl = '#' + $location.path()
      $scope.$on EVENTS.jumpSuccess, (event) ->
        vm.currentUrl = '#' + $location.path()
      return

    directive =
      restrict: 'E'
      templateUrl: 'app/components/sidebar/sidebar.html'
      controller: SidebarController
      controllerAs: 'vm'
      bindToController: true

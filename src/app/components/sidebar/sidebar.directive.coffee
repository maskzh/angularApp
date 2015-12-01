angular.module 'jkbs'
  .directive 'ygSidebar', ->

    SidebarController = (menu) ->
      'ngInject'
      vm = this
      vm.menu = menu.getMenu()
      vm.isCollapsed = []
      for num in vm.menu
        vm.isCollapsed.push(true)

      vm.toggle = (index) ->
        result = !vm.isCollapsed[index]
        for value,key in vm.isCollapsed
          vm.isCollapsed[key] = true
        vm.isCollapsed[index] = result
      return

    directive =
      restrict: 'E'
      templateUrl: 'app/components/sidebar/sidebar.html'
      controller: SidebarController
      controllerAs: 'vm'
      bindToController: true

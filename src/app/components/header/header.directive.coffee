angular.module 'jkbs'
  .directive 'ygHeader', ->

    HeaderController = (moment) ->
      'ngInject'
      vm = this
      # "vm.creation" is avaible by directive option "bindToController: true"
      vm.relativeDate = moment(vm.creationDate).fromNow()
      vm.isCollapsed = false
      return

    directive =
      restrict: 'E'
      templateUrl: 'app/components/header/header.html'
      scope: creationDate: '='
      controller: HeaderController
      controllerAs: 'vm'
      bindToController: true

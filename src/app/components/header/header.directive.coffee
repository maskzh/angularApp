angular.module 'jkbs'
  .directive 'ygHeader', ->

    HeaderController = () ->
      'ngInject'
      vm = this
      return

    directive =
      restrict: 'E'
      templateUrl: 'app/components/header/header.html'
      scope: creationDate: '='
      controller: HeaderController
      controllerAs: 'vm'
      bindToController: true

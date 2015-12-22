angular.module 'jkbs'
  .directive 'fe', ->
    FeController = (Util, $scope, $state, $sce, $timeout, toastr) ->
      'ngInject'
      return

    linkFunc = (scope, el, attr, vm)->
      vm.id = attr.id
      vm.label = attr.label

    directive =
      restrict: 'E'
      transclude: true,
      templateUrl: 'app/components/form/fe.html'
      link: linkFunc
      controller: FeController
      controllerAs: 'vm'

angular.module 'jkbs'
  .directive 'jHeader', ->

    HeaderController = (User, $http, $rootScope, EVENTS) ->
      'ngInject'
      vm = this
      vm.user = User.user

      vm.logout = () ->
        $http
          .post '/auth/logout'
          .then () ->
            $rootScope.$broadcast(EVENTS.logoutSuccess)

      return

    directive =
      restrict: 'E'
      templateUrl: 'app/components/header/header.html'
      scope: creationDate: '='
      controller: HeaderController
      controllerAs: 'vm'
      bindToController: true

angular.module 'jkbs'
  .config ($stateProvider, $urlRouterProvider) ->
    'ngInject'
    $stateProvider
      .state 'base',
        templateUrl: 'app/base/base.html'
        controller: 'BaseController'
        controllerAs: 'base'

      .state 'base.demo',
        url: '/'
        templateUrl: 'app/demo/demo.html'
        controller: 'DemoController'
        controllerAs: 'demo'

    $urlRouterProvider.otherwise '/'

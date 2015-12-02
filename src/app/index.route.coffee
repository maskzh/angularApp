angular.module 'jkbs'
  .config ($stateProvider, $urlRouterProvider, USER_ROLES) ->
    'ngInject'
    $stateProvider
      .state 'login',
        templateUrl: 'app/login/login.html'
        controller: 'LoginController'
        controllerAs: 'login'

      .state 'base',
        templateUrl: 'app/base/base.html'
        controller: 'BaseController'
        controllerAs: 'base'

      # 首页
      .state 'base.home',
        url: '/'
        templateUrl: 'app/home/index.html'
        controller: 'HomeController'
        controllerAs: 'home'
        data:
          authorizedRoles: [USER_ROLES.shop, USER_ROLES.institution]

      # 微店
      .state 'base.shop',
        url: '/shop'
        templateUrl: 'app/shop/index.html'
        controller: 'ShopController'
        controllerAs: 'shop'

      # 订单
      .state 'base.order',
        url: '/order'
        templateUrl: 'app/order/index.html'
        controller: 'OrderController'
        controllerAs: 'order'

      # 医生
      .state 'base.doctor',
        url: '/doctor'
        templateUrl: 'app/doctor/index.html'
        controller: 'DoctorController'
        controllerAs: 'doctor'

      # 疾病
      .state 'base.disease',
        url: '/disease'
        templateUrl: 'app/disease/index.html'
        controller: 'DiseaseController'
        controllerAs: 'disease'

      # 药品
      .state 'base.medicine',
        url: '/medicine'
        templateUrl: 'app/medicine/index.html'
        controller: 'MedicineController'
        controllerAs: 'medicine'

      # 圈子
      .state 'base.circle',
        url: '/circle'
        templateUrl: 'app/circle/index.html'
        controller: 'CircleController'
        controllerAs: 'circle'

      # 资讯
      .state 'base.news',
        url: '/news'
        templateUrl: 'app/news/index.html'
        controller: 'NewsController'
        controllerAs: 'newsme'

      # 用户
      .state 'base.user',
        url: '/user'
        templateUrl: 'app/user/index.html'
        controller: 'UserController'
        controllerAs: 'user'

      # # 提成
      # .state 'base.home',
      #   url: '/'
      #   templateUrl: 'app/home/index.html'
      #   controller: 'HomeController'
      #   controllerAs: 'home'

      # 代理商
      .state 'base.agent',
        url: '/agent'
        templateUrl: 'app/agent/index.html'
        controller: 'AgentController'
        controllerAs: 'agent'

    $urlRouterProvider.otherwise '/'

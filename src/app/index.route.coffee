angular.module 'jkbs'
  .config ($stateProvider, $urlRouterProvider, USER_ROLES) ->
    'ngInject'
    $stateProvider
      .state 'login',
        url: '/login'
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

      # 微店
      .state 'base.shop',
        url: '/shop/:type'
        templateUrl: 'app/shop/index.html'
        controller: 'ShopController'
        controllerAs: 'shop'

      # 订单
      .state 'base.order',
        url: '/order/index'
        templateUrl: 'app/order/index.html'
        controller: 'OrderController'
        controllerAs: 'order'

      # 医生
      .state 'base.doctor',
        url: '/doctor/index'
        templateUrl: 'app/doctor/index.html'
        controller: 'DoctorController'
        controllerAs: 'vm'
      .state 'base.doctors_order',
        url: '/doctor/order'
        templateUrl: 'app/doctor/order.html'
        controller: 'DoctorOrderController'
        controllerAs: 'vm'
      .state 'base.doctor_order',
        url: '/doctor/order/:id'
        templateUrl: 'app/doctor/order.html'
        controller: 'DoctorOrderController'
        controllerAs: 'vm'

      # 疾病
      .state 'base.disease',
        url: '/disease/index'
        templateUrl: 'app/disease/index.html'
        controller: 'DiseaseController'
        controllerAs: 'disease'
      .state 'base.disease_cat',
        url: '/disease/cat'
        templateUrl: 'app/disease/cat.html'
        controller: 'DiseaseCatController'
        controllerAs: 'disease'

      # 药品
      .state 'base.medicine',
        url: '/medicine/index'
        templateUrl: 'app/medicine/index.html'
        controller: 'MedicineController'
        controllerAs: 'medicine'
      .state 'base.medicine_cat',
        url: '/medicine/cat'
        templateUrl: 'app/medicine/cat.html'
        controller: 'MedicineCatController'
        controllerAs: 'medicine'

      # 圈子
      .state 'base.circle',
        url: '/circle/index'
        templateUrl: 'app/circle/index.html'
        controller: 'CircleController'
        controllerAs: 'circle'
      .state 'base.circle_post',
        url: '/circle/post'
        templateUrl: 'app/circle/post.html'
        controller: 'PostController'
        controllerAs: 'circle'

      # 资讯
      .state 'base.news',
        url: '/news/index'
        templateUrl: 'app/news/index.html'
        controller: 'NewsController'
        controllerAs: 'news'
      .state 'base.news_cat',
        url: '/news/cat'
        templateUrl: 'app/news/cat.html'
        controller: 'NewsCatController'
        controllerAs: 'news'

      # 用户
      .state 'base.user',
        url: '/user/index'
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
        url: '/agent/index'
        templateUrl: 'app/agent/index.html'
        controller: 'AgentController'
        controllerAs: 'agent'

    $urlRouterProvider.otherwise '/'

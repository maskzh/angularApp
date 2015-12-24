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
        url: '/shop'
        templateUrl: 'app/shop/index.html'
        controller: 'ShopController'
        controllerAs: 'vm'
      .state 'base.shop_new',
        url: '/shop/new'
        templateUrl: 'app/shop/new.html'
        controller: 'ShopNewController'
        controllerAs: 'vm'
      .state 'base.shop_edit',
        url: '/shop/:id/edit'
        templateUrl: 'app/shop/new.html'
        controller: 'ShopNewController'
        controllerAs: 'vm'

      # 订单
      .state 'base.order',
        url: '/order'
        templateUrl: 'app/order/index.html'
        controller: 'OrderController'
        controllerAs: 'vm'
      .state 'base.order_show',
        url: '/order/:id'
        templateUrl: 'app/order/show.html'
        controller: 'OrderShowController'
        controllerAs: 'vm'

      # 医生
      .state 'base.doctor',
        url: '/doctor'
        templateUrl: 'app/doctor/index.html'
        controller: 'DoctorController'
        controllerAs: 'vm'
      .state 'base.doctors_order', # 所有医生订单
        url: '/doctor/order'
        templateUrl: 'app/doctor/order.html'
        controller: 'DoctorOrderController'
        controllerAs: 'vm'
      .state 'base.doctor_order', # 具体医生订单
        url: '/doctor/order/:id'
        templateUrl: 'app/doctor/order.html'
        controller: 'DoctorOrderController'
        controllerAs: 'vm'
      .state 'base.doctor_new', # 添加医生
        url: '/doctor/new'
        templateUrl: 'app/doctor/new.html'
        controller: 'DoctorNewController'
        controllerAs: 'vm'
      .state 'base.doctor_edit', # 编辑医生
        url: '/doctor/:id/edit'
        templateUrl: 'app/doctor/new.html'
        controller: 'DoctorNewController'
        controllerAs: 'vm'

      # 疾病
      .state 'base.disease',
        url: '/disease'
        templateUrl: 'app/disease/index.html'
        controller: 'DiseaseController'
        controllerAs: 'vm'
      .state 'base.disease_new', # 添加疾病
        url: '/disease/new'
        templateUrl: 'app/disease/new.html'
        controller: 'DiseaseNewController'
        controllerAs: 'vm'
      .state 'base.disease_edit', # 修改疾病
        url: '/disease/:id/edit'
        templateUrl: 'app/disease/new.html'
        controller: 'DiseaseNewController'
        controllerAs: 'vm'
      .state 'base.disease_cat',
        url: '/disease-title'
        templateUrl: 'app/disease/cat.html'
        controller: 'DiseaseCatController'
        controllerAs: 'vm'
      .state 'base.disease_cat_new', # 添加疾病分类
        url: '/disease-title/new'
        templateUrl: 'app/disease/new-cat.html'
        controller: 'DiseaseNewCatController'
        controllerAs: 'vm'
      .state 'base.disease_cat_edit', # 修改疾病分类
        url: '/disease-title/:id/edit'
        templateUrl: 'app/disease/new-cat.html'
        controller: 'DiseaseNewCatController'
        controllerAs: 'vm'

      # 药品
      .state 'base.medicine',
        url: '/medicine'
        templateUrl: 'app/medicine/index.html'
        controller: 'MedicineController'
        controllerAs: 'vm'
      .state 'base.medicine_new', # 添加药品
        url: '/medicine/new'
        templateUrl: 'app/medicine/new.html'
        controller: 'MedicineNewController'
        controllerAs: 'vm'
      .state 'base.medicine_edit', # 修改药品
        url: '/medicine/:id/edit'
        templateUrl: 'app/medicine/new.html'
        controller: 'MedicineNewController'
        controllerAs: 'vm'
      .state 'base.medicine_cat',
        url: '/medicine-category'
        templateUrl: 'app/medicine/cat.html'
        controller: 'MedicineCatController'
        controllerAs: 'vm'
      .state 'base.medicine_cat_new', # 添加药品分类
        url: '/medicine-category/new'
        templateUrl: 'app/medicine/new-cat.html'
        controller: 'MedicineNewCatController'
        controllerAs: 'vm'
      .state 'base.medicine_cat_edit', # 修改药品分类
        url: '/medicine-category/:id/edit'
        templateUrl: 'app/medicine/new-cat.html'
        controller: 'MedicineNewCatController'
        controllerAs: 'vm'

      # 资讯
      .state 'base.news',
        url: '/news'
        templateUrl: 'app/news/index.html'
        controller: 'NewsController'
        controllerAs: 'news'
      .state 'base.news_new', # 添加资讯
        url: '/news/new'
        templateUrl: 'app/news/new.html'
        controller: 'NewsNewController'
        controllerAs: 'vm'
      .state 'base.news_edit', # 修改资讯
        url: '/news/:id/edit'
        templateUrl: 'app/news/new.html'
        controller: 'NewsNewController'
        controllerAs: 'vm'
      .state 'base.news_cat',
        url: '/news-category'
        templateUrl: 'app/news/cat.html'
        controller: 'NewsCatController'
        controllerAs: 'vm'
      .state 'base.news_cat_new', # 添加资讯分类
        url: '/news-category/new'
        templateUrl: 'app/news/new-cat.html'
        controller: 'NewsNewCatController'
        controllerAs: 'vm'
      .state 'base.new_cat_edit', # 修改资讯分类
        url: '/news-category/:id/edit'
        templateUrl: 'app/news/new-cat.html'
        controller: 'NewsNewCatController'
        controllerAs: 'vm'

      # 用户
      .state 'base.user',
        url: '/user'
        templateUrl: 'app/user/index.html'
        controller: 'UserController'
        controllerAs: 'vm'
      .state 'base.user_new',
        url: '/user/new'
        templateUrl: 'app/user/new.html'
        controller: 'UserNewController'
        controllerAs: 'vm'
      .state 'base.user_edit',
        url: '/user/:id/edit'
        templateUrl: 'app/user/new.html'
        controller: 'UserNewController'
        controllerAs: 'vm'

      # 活动
      .state 'base.activity',
        url: '/activity'
        templateUrl: 'app/activity/index.html'
        controller: 'ActivityController'
        controllerAs: 'vm'
      .state 'base.activity_new',
        url: '/activity/new'
        templateUrl: 'app/activity/new.html'
        controller: 'ActivityNewController'
        controllerAs: 'vm'
      .state 'base.activity_edit',
        url: '/activity/:id/edit'
        templateUrl: 'app/activity/new.html'
        controller: 'ActivityNewController'
        controllerAs: 'vm'

      # # 提成
      # .state 'base.home',
      #   url: '/'
      #   templateUrl: 'app/home/index.html'
      #   controller: 'HomeController'
      #   controllerAs: 'home'

      # # 圈子
      # .state 'base.circle',
      #   url: '/circle'
      #   templateUrl: 'app/circle/index.html'
      #   controller: 'CircleController'
      #   controllerAs: 'circle'
      # .state 'base.circle_post',
      #   url: '/circle/post'
      #   templateUrl: 'app/circle/post.html'
      #   controller: 'PostController'
      #   controllerAs: 'circle'

      # 代理商
      # .state 'base.agent',
      #   url: '/agent'
      #   templateUrl: 'app/agent/index.html'
      #   controller: 'AgentController'
      #   controllerAs: 'agent'

    $urlRouterProvider.otherwise '/'

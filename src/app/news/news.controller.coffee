angular.module 'jkbs'
  # 资讯列表
  .controller 'NewsController', (Util, $scope, $stateParams) ->
    'ngInject'
    # 分类目录进来是有ID的
    if $stateParams.id
      listUrl = "news-list?type=10&category_id=#{$stateParams.id}"
    else
      listUrl = "news-list?type=10"

    $scope.title = '资讯管理'
    $scope.grid =
      api:
        base: '/news'
        list: listUrl
      table: [
        { text:"ID", field: "id"},
        { text:"标题", field: "title"},
        {
          text:"封面",
          field: "pic",
          render: (field, full) ->
            imgUrl = Util.img field
            "<a class='J_image' href=#{imgUrl}><img width=30 src=#{imgUrl}></a>"
        },
        {
          text:"创建时间",
          field: "created_at",
          render: (field, full) ->
            Util.timeFormat field
        },
        {
          text:"状态",
          field: "status",
          render: (field, full) ->
            Util.renderBl field
        },
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            Util.genBtns([
              {type: 'default', title: '编辑', href: "news/#{full.id}/edit", icon: 'edit'}
            ], full.id)
        }
      ]
    return

  # 资讯分类列表
  .controller 'NewsCatController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.title = '资讯分类管理'
    $scope.grid =
      api:
        base: '/news-category'
        list: 'index'
      table: [
        { text:"ID", field: "id"},
        { text:"名称", field: "title"},
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            Util.genBtns([
              {type: 'default', title: '资讯', href: "news-category/#{full.id}/news", icon: 'navicon'},
              {type: 'default', title: '编辑', href: "news-category/#{full.id}/edit", icon: 'edit'}
            ], full.id)
        }
      ]
    return

  # 新建和修改资讯分类
  .controller 'NewsNewCatController', (Util, $stateParams, toastr) ->
    'ngInject'
    vm = this

    # 初始化表单数据
    vm.formData = {}
    vm.formData.status = 0
    vm.formData.order_id = 0

    # 初始化表单方法
    resMethods = Util.res('/news-category')
    vm.save = () ->
      resMethods.save vm.formData, id
        .then (res) ->
          toastr.success '已成功提交'

    # init
    id = if $stateParams.id? then $stateParams.id else false
    if id
      vm.title = "修改资讯分类"
      resMethods.get id
        .then (res) ->
          vm.formData = res.data
    else
      vm.title = "添加资讯分类"
      vm.state = true
    return

  # 新建和修改资讯
  .controller 'NewsNewController', (Util, $stateParams, toastr, Uploader, NewsService) ->
    'ngInject'
    vm = this

    # 初始化表单数据
    vm.formData = {}
    vm.formData.status = 1
    vm.formData.type = 10
    NewsService.getNewsCat().then (data)->
      vm.typeList = data

    # 初始化表单方法
    resMethods = Util.res('/news')
    vm.upload = Uploader.upload
    vm.save = () ->
      resMethods.save vm.formData, id
        .then (res) ->
          toastr.success '已成功提交'

    # init
    id = if $stateParams.id? then $stateParams.id else false
    if id
      vm.title = "修改资讯"
      resMethods.get id
        .then (res) ->
          vm.formData = res.data
    else
      vm.title = "添加资讯"
      vm.state = true
    return

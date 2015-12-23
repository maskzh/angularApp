angular.module 'jkbs'
  .controller 'NewsController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.grid =
      api:
        base: '/news'
        list: ''
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
          text:"最后修改",
          field: "updated_at",
          render: (field, full) ->
            Util.timeFormat field
        },
        {
          text:"推送时间",
          field: "send_at",
          render: (field, full) ->
            Util.timeFormat field
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

  .controller 'NewsCatController', (Util, $scope) ->
    'ngInject'
    # 表格
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
              {type: 'default', title: '编辑', href: "news-category/#{full.id}/edit", icon: 'edit'}
            ], full.id)
        }
      ]
    return

  .controller 'NewsNewCatController', (Util, $stateParams, toastr) ->
    'ngInject'
    vm = this
    vm.formData = {}
    vm.formData.status = 0

    id = if $stateParams.id? then $stateParams.id else false
    resMethods = Util.res('/news-category')
    vm.save = () ->
      resMethods.save vm.formData, id
        .then (res) ->
          toastr.success '已成功提交'

    # init
    if id
      resMethods.get id
        .then (res) ->
          vm.formData = res.data
    else
      vm.state = true
    return

  .controller 'NewsNewController', (Util, $stateParams, toastr, Uploader) ->
    'ngInject'
    vm = this
    vm.formData = {}
    vm.formData.status = 1
    Util.get '/news-category/index'
    .then (res) ->
      vm.typeList = res.data.items

    id = if $stateParams.id? then $stateParams.id else false
    resMethods = Util.res('/news')
    vm.save = () ->
      resMethods.save vm.formData, id
        .then (res) ->
          toastr.success '已成功提交'
    vm.upload = Uploader.upload

    # init
    if id
      resMethods.get id
        .then (res) ->
          vm.formData = res.data
    else
      vm.state = true
    return

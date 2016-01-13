angular.module 'jkbs'
  # 疾病列表
  .controller 'DiseaseController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.title = "疾病管理"
    $scope.grid =
      api:
        base: '/disease'
      table: [
        { text:"ID", field: "id"},
        { text:"名称", field: "title"},
        {
          text:"描述",
          field: "link",
          render: (field, full) ->
            return field if !!field
            return full.description
        },
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            Util.genBtns([
              {type: 'default', title: '编辑', href: "disease/#{full.id}/edit", icon: 'edit'}
            ], full.id)
        }
      ]
    return

  # 疾病标题列表
  .controller 'DiseaseCatController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.title = "疾病标题管理"
    $scope.grid =
      api:
        base: '/disease-title'
      addHref: 'base.disease_new'
      table: [
        { text:"ID", field: "id"},
        {
          text:"图片",
          field: "pic",
          render: (field, full) ->
            imgUrl = Util.img field
            "<a class='J_image' href=#{imgUrl}><img width=30 src=#{imgUrl} alt=#{full.title}></a>"
        },
        { text:"类别", field: "type" },
        { text:"标题", field: "title" },
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            Util.genBtns([
              {type: 'default', title: '编辑', href: "disease-title/#{full.id}/edit", icon: 'edit'}
            ], full.id)
        }
      ]
    return

  # 新增和修改疾病标题
  .controller 'DiseaseNewCatController', (Util, $stateParams, toastr, Uploader) ->
    'ngInject'
    vm = this

    # 初始化表单数据
    vm.formData = {}

    # 初始化表单方法
    resMethods = Util.res('/disease-title')
    vm.upload = Uploader.upload
    vm.save = () ->
      resMethods.save vm.formData, id
        .then (res) ->
          toastr.success '已成功提交'

    # init
    id = if $stateParams.id? then $stateParams.id else false
    if id
      vm.title = "修改疾病标题"
      resMethods.get id
        .then (res) ->
          vm.formData = res.data
    else
      vm.title = "添加疾病标题"
      vm.state = true
    return

  # 新增和修改疾病
  .controller 'DiseaseNewController', (Util, $stateParams, toastr, $modal) ->
    'ngInject'
    vm = this

    # 初始化表单数据
    vm.formData = {}

    # 初始化表单方法
    resMethods = Util.res('/disease')
    vm.save = () ->
      resMethods.save vm.formData, id
        .then (res) ->
          toastr.success '已成功提交'

    vm.loadLink = (keyword) ->
      Util.get '/disease-title/title-list', {keyword: keyword}

    vm.loadTherapies = (type, keyword) ->
      Util.get '/disease-title/may-be-therapies', {type: type, keyword: keyword}
      .then (res) ->
        return

    # init
    id = if $stateParams.id? then $stateParams.id else false
    if id
      vm.title = "修改疾病"
      resMethods.get id
        .then (res) ->
          vm.formData = res.data
    else
      vm.title = "增加疾病"
      vm.state = true

    # 添加疾病关联
    vm.link = []
    vm.doctor = []
    vm.medicine = []
    vm.physiotherapy = []
    vm.fruit = []
    vm.grid =
      link:
        api:
          base: '/disease-title'
        operation: 'search choose'
        table: [
          { text:"ID", field: "id"},
          {
            text:"图片",
            field: "pic",
            render: (field, full) ->
              imgUrl = Util.img field
              "<a class='J_image' href=#{imgUrl}><img width=30 src=#{imgUrl} alt=#{full.title}></a>"
          },
          { text:"类别", field: "type" },
          { text:"标题", field: "title" }
        ]
      therapies: (type) ->
        {
          api:
            base: "/disease-title/may-be-therapies?type=#{type}"
          operation: 'search choose'
          table: [
            { text:"ID", field: "id"},
            {
              text:"图片",
              field: "pic",
              render: (field, full) ->
                imgUrl = Util.img field
                "<a class='J_image' href=#{imgUrl}><img width=30 src=#{imgUrl} alt=#{full.title}></a>"
            },
            { text:"标题", field: "title" }
          ]
        }

    vm.openModal = (grid, type) ->
      modalInstance = $modal.open
        templateUrl: 'modal.html'
        controller: 'DiseaseModalController'
        size: 'lg'
        resolve:
          parentCtrl: ->
            vm
          grid: ->
            grid
          type: ->
            type

    return

  .controller 'DiseaseModalController', ($scope, Util, $modalInstance, parentCtrl, grid, type) ->
    data = if type? then parentCtrl[type] else parentCtrl[grid]
    gridConfig = if type? then parentCtrl.grid[grid](type) else parentCtrl.grid[grid]
    $scope.title = '选择'
    $scope.grid = angular.extend {}, gridConfig, {
      callback: (scope, el, attr, vm) ->
        vm.choose = ->
          for itemA in vm.selectedItems
            flag = true
            for itemB in data
              flag = false if itemA.id is itemB.id
            data.push itemA if flag

          if type?
            ids = []
            for item in data
              ids.push item.id
            ids = ids.join(',')
          else
            ids = []
            for item in data
              ids.push item.title
            ids = ids.join(' ')
          if type? then parentCtrl.formData["#{type}_id"] = ids else parentCtrl.formData[grid] = ids
          return
    }
    $scope.cancel = ->
      $modalInstance.dismiss 'cancel'

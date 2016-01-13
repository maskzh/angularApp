angular.module 'jkbs'
  # 疾病列表
  .controller 'DiseaseController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.title = "疾病管理"
    $scope.grid =
      api:
        base: '/disease'
      operation: 'delete search'
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

    # 添加疾病关联
    vm.doctor = []
    vm.medicine = []
    vm.physiotherapy = []
    vm.food = []
    vm.fruit = []
    updateFormData = (type) ->
      ids = []
      for item in vm[type]
        ids.push item.id
      ids = ids.join(',')
      vm.formData["#{type}_id"] = ids
    vm.removeLabel = (type, label, $event) ->
      $event.stopPropagation()
      for item,i in vm[type]
        if item.id is label.id
          vm[type].splice i, 1
      updateFormData(type)
    vm.grid = (type) ->
      _vm = vm
      if type is 'doctor'
        table =
          [
            { text:"ID", field: "id"},
            { text:"姓名", field: "user_name"},
            {
              text:"头像",
              field: "user_pic",
              render: (field, full) ->
                imgUrl = Util.img field
                "<a class='J_image' href='#{imgUrl}'><img width=30 src='#{imgUrl}' alt='#{full.name}'></a>"
            },
            { text:"类型", field: "type"},
            { text:"职称", field: "title"},
            {
              text:"医院/科室",
              field: null,
              render: (field, full) ->
                return "#{full.hospital}/#{full.department}"
            },
            { text:"咨询费用", field: "consultation_fee"},
            { text:"评价", field: "star"}
          ]
      else
        table =
          [
            { text:"ID", field: "id"},
            {
              text:"图片",
              field: "pic",
              render: (field, full) ->
                imgUrl = Util.img field
                "<a class='J_image' href='#{imgUrl}'><img width=30 src='#{imgUrl}'></a>"
            },
            { text:"药品名称", field: "title"},
            {
              text:"规格",
              field: "spec",
              render: (field, full) ->
                field + " #{full.unit}"
            },
            { text:"生产厂商", field: "company"},
            { text:"注册号", field: "register_number"},
            { text:"类型", field: "type"},
            { text:"二维码", field: 'barcode' }
          ]
      {
        api:
          base: "/disease-title/may-be-therapies?type=#{type}&name=#{vm.formData.title}"
        operation: 'choose'
        table: table
        callback: (scope, el, attr, vm) ->
          vm.choose = ->
            for itemA in vm.selectedItems
              flag = true
              for itemB in _vm[type]
                flag = false if itemA.id is itemB.id
              _vm[type].push itemA if flag
            updateFormData(type)
            return
      }

    vm.openModal = (type) ->
      modalInstance = $modal.open
        templateUrl: 'modal.html'
        controller: 'DiseaseModalController'
        size: 'lg'
        resolve:
          grid: ->
            vm.grid(type)

    # init
    id = if $stateParams.id? then $stateParams.id else false
    if id
      vm.title = "修改疾病"
      resMethods.get id
        .then (res) ->
          vm.formData = res.data
          for type in ['doctor', 'medicine', 'institution', 'food', 'fruit']
            do (type) ->
              Util.get '/disease/disease-treat', {type: type, id: id}
              .then (res) ->
                vm[type] = res.data.items || []
    else
      vm.title = "增加疾病"
      vm.state = true
    return

  .controller 'DiseaseModalController', ($scope, Util, $modalInstance, grid) ->
    $scope.title = '选择'
    $scope.grid = grid
    $scope.cancel = ->
      $modalInstance.dismiss 'cancel'

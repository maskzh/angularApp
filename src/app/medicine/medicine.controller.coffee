angular.module 'jkbs'
  .controller 'MedicineController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.title = '药品管理'
    $scope.grid =
      api:
        base: '/medicine'
        list: ''
      addHref: ''
      table: [
        { text:"ID", field: "id"},
        {
          text:"图片",
          field: "pic",
          render: (field, full) ->
            imgUrl = Util.img field
            "<a class='J_image' href=#{imgUrl}><img width=30 src=#{imgUrl}></a>"
        },
        {
          text:"规格",
          field: "spec",
          render: (field, full) ->
            field + " #{full.unit}"
        },
        { text:"生产厂商", field: "company"},
        { text:"注册号", field: "register_number"},
        { text:"类型", field: "type"},
        {
          text:"二维码",
          field: 'barcode',
          render: (field, full) ->
            imgUrl = Util.img field
            "<a class='J_image' href='#{imgUrl}'><img width=30 src='#{imgUrl}'></a>"
        },
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            Util.genBtns([
              {type: 'default', title: '编辑', href: "medicine/#{full.id}/edit", icon: 'edit'}
            ], full.id)
        }
      ]
    return

  .controller 'MedicineCatController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.title = '药品分类'
    $scope.grid =
      api:
        base: '/medicine-category'
        list: 'get-category'
      table: [
        { text:"ID", field: "id"},
        {
          text:"图标",
          field: "pic",
          render: (field, full) ->
            imgUrl = Util.img field
            "<a class='J_image' href=#{imgUrl}><img width=30 src=#{imgUrl} alt=#{full.name}></a>"
        },
        { text:"名称", field: "title"},
        { text:"描述", field: "description"},
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            Util.genBtns([
              {type: 'default', title: '编辑', href: "medicine-category/#{full.id}/edit", icon: 'edit'}
            ], full.id)
        }
      ]
    return

  .controller 'MedicineNewCatController', (Util, $stateParams, toastr) ->
    'ngInject'
    vm = this
    vm.formData = {}
    vm.formData.order_id = 0
    id = if $stateParams.id? then $stateParams.id else false
    resMethods = Util.res('/medicine-category')

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

  .controller 'MedicineNewController', (Util, $stateParams, toastr) ->
    'ngInject'
    vm = this
    vm.formData = {}
    id = if $stateParams.id? then $stateParams.id else false
    resMethods = Util.res('/medicine')

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

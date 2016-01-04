angular.module 'jkbs'
  .controller 'MedicineController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.title = '药品管理'
    $scope.grid =
      api:
        base: '/medicine'
        list: ''
      table: [
        { text:"ID", field: "id"},
        {
          text:"图片",
          field: "pic",
          render: (field, full) ->
            imgUrl = Util.img field
            "<a class='J_image' href=#{imgUrl}><img width=30 src=#{imgUrl}></a>"
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
        { text:"二维码", field: 'barcode' },
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
    vm = this
    $scope.title = '药品分类'
    Util.get '/medicine-category/get-category', {type: 'all'}
    .then (res) ->
      vm.cats = res.data.items

    $('.tree').on 'click', '[data-delete]', (e) ->
      Util.delete "/medicine-category/#{$(this).data('delete')}"
      .then (res) ->
        toastr.success '删除成功'
        $(this).parents('li').remove()
    return

  .controller 'MedicineNewCatController', (Util, $stateParams, toastr, Uploader, medicineService) ->
    'ngInject'
    vm = this
    vm.formData = {}
    vm.formData.order_id = 0
    vm.typeList = []
    Util.get '/medicine-category/get-category', {type: 'all'}
    .then (res) ->
      for item1 in res.data.items
        vm.typeList.push {id: item1.id, title: "① #{item1.title}"}
        for item2 in item1.child_list
          vm.typeList.push {id: item2.id, title: "----② #{item2.title}"}
      return

    id = if $stateParams.id? then $stateParams.id else false
    resMethods = Util.res('/medicine-category')

    vm.save = () ->
      resMethods.save vm.formData, id
        .then (res) ->
          toastr.success '已成功提交'
    vm.upload = Uploader.upload

    # init
    if id
      vm.title = "修改药品分类"
      resMethods.get id
        .then (res) ->
          vm.formData = res.data
    else
      vm.title = "添加药品分类"
      vm.state = true
    return

  .controller 'MedicineNewController', (Util, $stateParams, toastr, Uploader, medicineService) ->
    'ngInject'
    vm = this
    vm.formData = {}
    vm.formData.buy_online = 0
    vm.formData.contain_ephedrine = 0
    vm.formData.status = 0
    vm.typeList = []
    Util.get '/medicine-category/get-category', {type: 'all'}
    .then (res) ->
      for item1 in res.data.items
        vm.typeList.push {id: item1.id, title: "-----------①  #{item1.title}(不可选)------------"}
        for item2 in item1.child_list
          for item3 in item2.child_list
            vm.typeList.push angular.extend item3, {level1: item1.title, level2: '② ' + item2.title}
    id = if $stateParams.id? then $stateParams.id else false
    resMethods = Util.res('/medicine')

    vm.save = () ->
      resMethods.save vm.formData, id
        .then (res) ->
          toastr.success '已成功提交'
    vm.upload = Uploader.upload

    # init
    if id
      vm.title = "修改药品"
      resMethods.get id
        .then (res) ->
          vm.formData = res.data
    else
      vm.title = "添加药品"
      vm.state = true
    return

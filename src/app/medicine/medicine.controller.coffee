angular.module 'jkbs'
  # 药品列表
  .controller 'MedicineController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.title = '药品管理'
    $scope.grid =
      api:
        base: '/medicine'
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
              {type: 'default', text: '编辑', href: "#/medicine/#{full.id}/edit", icon: 'edit'}
            ], full.id)
        }
      ]
    return

  # 药品分类
  .controller 'MedicineCatController', (Util, MedicineService) ->
    'ngInject'
    # 表格
    vm = this
    vm.title = '药品分类'
    MedicineService.getMedicineCat().then (data) ->
      vm.cats = data

    # 绑定树节点删除事件
    $('.tree').on 'click', '[data-delete]', (e) ->
      Util.delete "/medicine-category/#{$(this).data('delete')}"
      .then (res) ->
        toastr.success '删除成功'
        $(this).parents('li').remove()

    return

  # 新增药品分类
  .controller 'MedicineNewCatController', (Util, $stateParams, toastr, Uploader, MedicineService) ->
    'ngInject'
    vm = this

    # 初始化表单数据
    vm.formData = {}
    vm.formData.order_id = 0
    MedicineService.getMedicineCat().then (data) ->
      vm.typeList = []
      for item1 in data
        vm.typeList.push {id: item1.id, title: "① #{item1.title}"}
        if item1.child_list
          for item2 in item1.child_list
            vm.typeList.push {id: item2.id, title: "----② #{item2.title}"}
      return

    # 初始化表单方法
    resMethods = Util.res('/medicine-category')
    vm.upload = Uploader.upload
    vm.save = () ->
      resMethods.save vm.formData, id
        .then (res) ->
          toastr.success '已成功提交'

    # init
    id = if $stateParams.id? then $stateParams.id else false
    if id
      vm.title = "修改药品分类"
      resMethods.get id
        .then (res) ->
          vm.formData = res.data
    else
      vm.title = "添加药品分类"
      vm.state = true
    return

  # 新增药品
  .controller 'MedicineNewController', ($scope, Util, $stateParams, toastr, Uploader, MedicineService) ->
    'ngInject'
    vm = this

    # 初始化表单数据
    vm.formData = {}
    vm.formData.buy_online = 0
    vm.formData.contain_ephedrine = 0
    vm.formData.status = 0
    MedicineService.getMedicineCat().then (data) ->
      vm.typeList = []
      for item1 in data
        vm.typeList.push {id: item1.id, title: "-----------①  #{item1.title}(不可选)------------"}
        if item1.child_list?
          for item2 in item1.child_list
            if item2.child_list?
              for item3 in item2.child_list
                vm.typeList.push angular.extend item3, {level1: item1.title, level2: '② ' + item2.title}
      return

    # 初始化表单方法
    resMethods = Util.res('/medicine')
    vm.upload = Uploader.upload
    vm.save = () ->
      $scope.$emit 'contentChange'
      resMethods.save vm.formData, id
        .then (res) ->
          toastr.success '已成功提交'
    # 编辑器
    $scope.ueditorReady = (editor) ->
      $scope.$on 'contentChange', () ->
        editor.fireEvent 'contentChange'

    # init
    id = if $stateParams.id? then $stateParams.id else false
    if id
      vm.title = "修改药品"
      resMethods.get id
        .then (res) ->
          vm.formData = res.data
    else
      vm.title = "添加药品"
      vm.state = true
    return

  # 默认药品管理
  .controller 'MedicineDefaultController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.title = '默认药品管理'
    $scope.grid =
      api:
        base: '/to-lead-medicine'
        list: 'get-list'
      disabled: 'add search'
      table: [
        { text:"ID", field: "id"},
        {
          text:"图片",
          field: "medicine_pic",
          render: (field, full) ->
            imgUrl = Util.img field
            "<a class='J_image' href=#{imgUrl}><img width=30 src=#{imgUrl}></a>"
        },
        { text:"药品名称", field: "medicine_title"}
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            Util.genBtns([], full.id)
        }
      ]
    return

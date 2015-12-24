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
    Util.get '/medicine-category/get-category'
    .then (res) ->
      vm.cats = res.data.items
      for i in vm.cats
        do (i)->
          Util.get "/medicine-category/get-category?parent=#{i.id}"
          .then (res) ->
            i.child_list = res.data.items

    $('.tree').on 'click', '[data-delete]', (e) ->
      Util.delete "/medicine-category/#{$(this).data('delete')}"
      .then (res) ->
        toastr.success '删除成功'
        $(this).parents('li').remove()



    # $scope.grid =
    #   api:
    #     base: '/medicine-category'
    #     list: 'get-category'
    #   table: [
    #     { text:"ID", field: "id"},
    #     {
    #       text:"图标",
    #       field: "pic",
    #       render: (field, full) ->
    #         imgUrl = Util.img field
    #         "<a class='J_image' href=#{imgUrl}><img width=30 src=#{imgUrl} alt=#{full.name}></a>"
    #     },
    #     { text:"名称", field: "title"},
    #     { text:"描述", field: "description"},
    #     {
    #       text:"操作",
    #       field: "",
    #       render: (field, full) ->
    #         Util.genBtns([
    #           {type: 'default', title: '编辑', href: "medicine-category/#{full.id}/edit", icon: 'edit'}
    #         ], full.id)
    #     }
    #   ]
    return

  .controller 'MedicineNewCatController', (Util, $stateParams, toastr, Uploader, medicineService) ->
    'ngInject'
    vm = this
    vm.formData = {}
    vm.formData.order_id = 0
    vm.typeList = medicineService.catType()
    id = if $stateParams.id? then $stateParams.id else false
    resMethods = Util.res('/medicine-category')

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

  .controller 'MedicineNewController', (Util, $stateParams, toastr, Uploader, medicineService) ->
    'ngInject'
    vm = this
    vm.formData = {}
    vm.formData.buy_online = 0
    vm.formData.contain_ephedrine = 0
    vm.formData.status = 0
    # Util.get '/medicine-category/get-category'
    # .then (res) ->
    #   vm.typeList = res.data.items
    vm.typeList = medicineService.type()
    id = if $stateParams.id? then $stateParams.id else false
    resMethods = Util.res('/medicine')

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

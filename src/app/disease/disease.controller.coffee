angular.module 'jkbs'
  .controller 'DiseaseController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.grid =
      api:
        base: '/disease'
        list: ''
      addHref: ''
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

  .controller 'DiseaseCatController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.grid =
      api:
        base: '/disease-title'
        list: 'title-list'
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

  .controller 'DiseaseNewCatController', (Util, $stateParams, toastr, Uploader) ->
    'ngInject'
    vm = this
    vm.formData = {}
    id = if $stateParams.id? then $stateParams.id else false
    resMethods = Util.res('/disease-title')

    vm.save = () ->
      resMethods.save vm.formData, id
        .then (res) ->
          toastr.success '已成功提交'
    vm.upload = Uploader.upload

    # init
    if id
      vm.title = "修改疾病标题"
      resMethods.get id
        .then (res) ->
          vm.formData = res.data
    else
      vm.title = "添加疾病标题"
      vm.state = true
    return

  .controller 'DiseaseNewController', (Util, $stateParams, toastr) ->
    'ngInject'
    vm = this
    vm.formData = {}
    id = if $stateParams.id? then $stateParams.id else false
    resMethods = Util.res('/disease')

    vm.save = () ->
      resMethods.save vm.formData, id
        .then (res) ->
          toastr.success '已成功提交'

    # init
    if id
      vm.title = "修改疾病"
      resMethods.get id
        .then (res) ->
          vm.formData = res.data
    else
      vm.title = "增加疾病"
      vm.state = true
    return

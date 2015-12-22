angular.module 'jkbs'
  .controller 'UserController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.title = '用户管理'
    $scope.grid =
      api:
        base: '/user'
        list: ''
      table: [
        { text:"ID", field: "id"},
        {
          text:"头像",
          field: "pic",
          render: (field, full) ->
            imgUrl = Util.img field
            "<a class='J_image' href=#{imgUrl}><img width=30 src=#{imgUrl} alt=#{full.name}></a>"
        },
        { text:"姓名", field: "name"},
        { text:"手机号", field: "mobile"},
        { text:"用户组", field: "group_id"},
        { text:"管理员组", field: "admin_group_id"},
        {
          text: "注册时间",
          field: 'created_at',
          render: (field, full) ->
             (Util.timeFormat field) + "<br>#{full.client}"
        },
        { text:"状态", field: "status"},
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            Util.genBtns([
              {type: 'default', title: '编辑', href: "user/#{full.id}/edit", icon: 'edit'}
            ], full.id)
        }
      ]
    return

  .controller 'UserNewController', (Util, $stateParams, toastr, Uploader, Sha1) ->
    'ngInject'
    vm = this
    vm.formData = {}
    vm.formData.status = 0
    vm.admin_group_list = [
      {id: 0,label: "无管理权限"}
      {id: 1,label: "日常管理"}
      {id: 2,label: "总管理"}
    ]
    id = if $stateParams.id? then $stateParams.id else false
    resMethods = Util.res('/user')

    vm.save = () ->
      if vm.formData.password
        vm.formData.password = Sha1.hash vm.formData.password
      resMethods.save vm.formData, id
        .then (res) ->
          toastr.success '已成功提交'
    vm.upload = Uploader.upload

    # init
    if id
      resMethods.get id
        .then (res) ->
          vm.formData = res.data
          vm.formData.password = ''
    else
      vm.state = true
    return

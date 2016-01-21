angular.module 'jkbs'
  # 用户列表
  .controller 'UserController', (Util, $scope, UserService) ->
    'ngInject'
    # 表格
    $scope.title = '用户管理'
    $scope.grid =
      api:
        base: '/user'
        list: 'get-list'
        search: 'get-list'
      tabs: [
        {text:'全部', query: {identity:''}},
        {text:'老板', query: {identity:'boss'}},
        {text:'天使', query:{identity:'angel'}},
        {text:'医生', query:{identity:'doctor'}},
        {text:'客服', query:{identity:'service'}}
      ]
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
        {
          text:"用户角色",
          field: "",
          render: (field, full) ->
            html = ''
            for item in UserService.renderRole full
              html += "<span class='label label-#{item.type}'>#{item.value}</span> "
            html
        },
        # { text:"用户组", field: "group_id"},
        # { text:"管理员组", field: "admin_group_id"},
        # {
        #   text: "注册时间",
        #   field: 'created_at',
        #   render: (field, full) ->
        #      (Util.timeFormat field) + "<br>#{full.client}"
        # },
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
              {type: 'default', text: '编辑', href: "#/user/#{full.id}/edit", icon: 'edit'}
            ], full.id)
        }
      ]
    return

  # 新增或修改用户
  .controller 'UserNewController', (Util, $stateParams, toastr, Uploader, Sha1, UserService) ->
    'ngInject'
    vm = this

    # 表单初始值
    vm.formData = {}
    vm.formData.status = 1
    vm.formData.admin_group_id = 0
    vm.admin_group_list = UserService.getAdminGroupList()

    # 表单方法
    resMethods = Util.res('/user')
    vm.upload = Uploader.upload
    vm.save = () ->
      vm.formData.password = Sha1.hash vm.password
      resMethods.save vm.formData, id
        .then (res) ->
          toastr.success '已成功提交'

    # init
    id = if $stateParams.id? then $stateParams.id else false
    if id
      vm.title = "修改用户"
      resMethods.get id
        .then (res) ->
          vm.formData = res.data
          vm.formData.password = ''
    else
      vm.title = "添加用户"
      vm.state = true
    return

  # 修改账户密码
  .controller 'UserIController', (Util, toastr, Uploader, Sha1) ->
    'ngInject'
    vm = this
    vm.title = '修改账户密码'
    vm.formData = {}
    vm.confirm = ->
      if vm.confirmPassword isnt vm.password_new
        toastr.error '请确认两次新密码是否一致'
        return false
      return true
    vm.save = ->
      return if !vm.confirm()
      vm.formData.password = Sha1.hash vm.password
      vm.formData.password_new = Sha1.hash vm.password_new
      Util.post '/user/update-password', vm.formData
      .then (res) ->
        toastr.success '密码修改成功, 下次登录有效'
    return

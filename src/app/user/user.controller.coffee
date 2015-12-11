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
        { text:"姓名", field: "name"},
        { text:"手机号", field: "mobile"},
        {
          text:"头像",
          field: "pic",
          render: (field, full) ->
            imgUrl = Util.img field
            "<a class='J_image' href=#{imgUrl}><img width=30 src=#{imgUrl} alt=#{full.name}></a>"
        },
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
              {type: 'default', title: '编辑', href: "user/#{full.id}", icon: 'edit'}
            ], full.id)
        }
      ]
    return

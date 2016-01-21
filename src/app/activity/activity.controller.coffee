angular.module 'jkbs'
  # 活动列表
  .controller 'ActivityController', (Util, $scope) ->
    'ngInject'
    $scope.title = "活动二维码"
    $scope.grid =
      api:
        base: '/e-activity'
        routing: 'activity'
      table: [
        { text:"ID", field: "id"},
        { text:"活动标题", field: "title"},
        {
          text:"二维码",
          field: "",
          render: (field, full) ->
            "<a class='J_image' " +
            "href='/front/qr/create-qr?data=http://www.jkbs365.com/wx2.html?id=#{full.id}'>"+
            "<img width=60 src='/front/qr/index?data=http://www.jkbs365.com/wx2.html?id=#{full.id}'></a>"
        },
        {
          text:"添加时间",
          field: "created_at",
          render: (field, full) ->
            Util.timeFormat field
        },
        {
          text:"统计信息",
          field: "",
          render: (field, full) ->
            "二维码扫码次数：#{full.count&&full.count.opennum || 0}<br>"+
            "ios下载：#{full.count&&full.count.iosdownnum || 0}<br>" +
            "android下载：#{full.count&&full.count.andownnum || 0}<br>"
        },
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            Util.genBtns([
              {type: 'default', text: '编辑', href: "#/activity/#{full.id}/edit", icon: 'edit'}
            ], full.id)
        }
      ]
    return

  # 添加活动二维码
  .controller 'ActivityNewController', (Util, $stateParams, toastr) ->
    'ngInject'
    vm = this

    # 初始化表单数据
    vm.formData = {}

    # 初始化表单方法
    resMethods = Util.res('/e-activity')
    vm.save = () ->
      resMethods.save vm.formData, id
        .then (res) ->
          toastr.success '已成功提交'

    # init
    id = if $stateParams.id? then $stateParams.id else false
    if id
      vm.title = "修改活动"
      resMethods.get id
        .then (res) ->
          vm.formData = res.data
    else
      vm.title = "添加活动"
      vm.state = true
    return

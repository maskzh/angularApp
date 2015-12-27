angular.module 'jkbs'
  .controller 'ActivityController', (Util, $scope) ->
    'ngInject'
    vm = this
    # 表格
    $scope.title = "活动二维码"
    $scope.grid =
      api:
        base: '/e-activity'
        list: ''
        search: ''
        addHref: 'activity'
      table: [
        { text:"ID", field: "id"},
        { text:"活动标题", field: "title"},
        {
          text:"二维码",
          field: "",
          render: (field, full) ->
            "<a class='J_image' " +
            "href='/front/qr/index?data=http://www.jkbs365.com/wx2.html?id=#{full.id}'>"+
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
            "二维码扫码次数：#{full.count&&full.count.opennum}<br>"+
            "ios下载：#{full.count&&full.count.iosdownnum}<br>" +
            "android下载：#{full.count&&full.count.andownnum}<br>"
        },
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            Util.genBtns([
              {type: 'default', title: '编辑', href: "activity/#{full.id}/edit", icon: 'edit'}
            ], full.id)
        }
      ]
    return
  .controller 'ActivityNewController', (Util, $scope, $stateParams, toastr) ->
    'ngInject'
    vm = this
    $scope.title = "添加活动"
    vm.formData = {}
    id = if $stateParams.id? then $stateParams.id else false
    resMethods = Util.res('/e-activity')

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

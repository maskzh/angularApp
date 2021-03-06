angular.module 'jkbs'
  # 医生列表
  .controller 'DoctorController', (Util, $scope, toastr) ->
    'ngInject'
    # 表格
    $scope.title = '医生管理'
    $scope.grid =
      api:
        base: '/doctor'
        list: "recommend-list"
        search: 'search-list'
      tabs: [
        {
          text: '全部',
          query: {type: 'all'}
          active: true
        }
        {
          text: '推荐',
          query: {type: ''}
        },
      ]
      table: [
        { text:"ID", field: "id"},
        { text:"姓名", field: "user_name"},
        {
          text:"头像",
          field: "user_pic",
          render: (field, full) ->
            imgUrl = Util.img field
            "<a class='J_image' href=#{imgUrl}><img width=30 src=#{imgUrl} alt=#{full.name}></a>"
        },
        { text:"类型", field: "type"},
        { text:"职称", field: "title"},
        {
          text:"医院/科室",
          field: null,
          render: (field, full) ->
            return "#{full.hospital}/#{full.department}"
        },
        { text:"咨询费用", field: "consultation_fee"},
        { text:"评价", field: "star"},
        {
          text:"推荐",
          field: "recommend",
          render: (field, full) ->
            "<span class='label label-primary'>#{if field is 1 then '已推荐' else ''}</span> " +
            "<span class='label label-warning'>#{if full.status is 0 then '未审核' else ''}</span> "
        },
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            btns = [
              {type: 'default', text: '订单', href: "#/doctor/order/#{full.id}?name=#{full.user_name}", icon: 'navicon'}
              {type: 'default', text: '编辑', href: "#/doctor/#{full.id}/edit", icon: 'edit'}
            ]
            if full.recommend is 0
              btns.push
                type: 'success'
                text: '推荐'
                selector: 'recommend'
                icon: 'thumbs-up'
            else
              btns.push
                type: 'warning'
                text: '取消推荐'
                selector: 'recommend'
                icon: 'thumbs-down'
            Util.genBtns btns, full.id
        }
      ]
      events: [
        {
          type: 'click'
          selector: '.recommend'
          handle: (evt, self, scope, el, attr, vm) ->
            Util.post '/doctor/recommend', {ids:[$(self).data('id')]}
            .then (res) ->
              toastr.success res.data.message || '推荐成功'
              vm.pageChanged()
        }
      ]

    return

  # 医生咨询订单
  .controller 'DoctorOrderController', (Util, $scope, $stateParams, $location) ->
    'ngInject'
    # 表格
    $scope.title = ($location.search().name or '') + '医生咨询订单'
    if $stateParams.id?
      listUrl = "get-list?doctor_id=#{$stateParams.id}"
    else
      listUrl = "get-list"
    $scope.grid =
      api:
        base: '/order-doctor'
        list: listUrl
      available: 'delete search checkbox pagination'
      table: [
        { text:"订单ID", field: "id"},
        {
          text:"用户信息",
          field: "",
          render: (field, full) ->
            if full.user?
              "<div class='row'>"+
              "<div class='col-xs-3'><img class='J_image' src='#{Util.img full.user.pic}' width=30></div>" +
              "<div class='col-xs-9'>"+
              "<div>用户ID：#{full.user_id}</div>" +
              "<div>#{full.user.name}</div>" +
              "<div>#{full.user.mobile}</div>"+
              "</div></div>"
        },
        {
          text:"下单时间",
          field: "created_at",
          render: (field, full) ->
            Util.timeFormat field
        },
        { text:"咨询价格", field: "amount"},
        {
          text:"订单状态",
          field: "status",
          render: (field, full) ->
            return '已下单' if field is 10
            return '已完成' if field is 100
        },
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            Util.genBtns [], full.id
        }
      ]
    return

  # 医生新增和编辑
  .controller 'DoctorNewController', (Util, $stateParams, toastr, DoctorService, Uploader) ->
    'ngInject'
    vm = this

    # 初始化表单数据
    vm.formData = {}
    vm.formData.onsale = 0
    vm.formData.status = 0
    vm.typeList = DoctorService.type()
    DoctorService.getDepartment().then (data) ->
      vm.departmentList = data

    # 初始化表单方法
    resMethods = Util.res('/doctor')
    vm.upload = Uploader.upload
    vm.save = () ->
      resMethods.save vm.formData, vm.id
        .then (res) ->
          toastr.success '已成功提交'

    # init
    vm.id = if $stateParams.id? then $stateParams.id else false
    if vm.id
      vm.title = "修改医生"
      resMethods.get vm.id
        .then (res) ->
          vm.formData = res.data
    else
      vm.title = "添加医生"
      vm.state = true
    return

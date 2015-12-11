angular.module 'jkbs'
  # 医生列表
  .controller 'DoctorController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.title = '医生管理'
    $scope.grid =
      api:
        list: '/doctor/recommend-list'
        delete: '/doctor'
        search: '/doctor/search-list'
      addHref: 'base.doctor_new'
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
          text:"操作",
          field: "",
          render: (field, full) ->
            Util.genBtns([
              {type: 'default', title: '订单', href: "doctor/order/#{full.id}?name=#{full.user_name}", icon: 'navicon'}
              {type: 'default', title: '编辑', href: "doctor/#{full.id}/edit", icon: 'edit'}
            ], full.id)
        }
      ]
    return

  # 医生咨询订单
  .controller 'DoctorOrderController', (Util, $scope, $stateParams, $location) ->
    'ngInject'
    # 表格
    $scope.title = ($location.search().name or '') + '医生咨询订单'
    listUrl = '/order-doctor/get-list'
    listUrl = listUrl + "?doctor_id=#{$stateParams.id}" if $stateParams.id?
    $scope.grid =
      api:
        list: listUrl
        delete: '/order-doctor'
      table: [
        { text:"订单ID", field: "id"},
        {
          text:"用户头像",
          field: "pic",
          render: (field, full) ->
            imgUrl = Util.img field
            "<a class='J_image' href=#{imgUrl} alt='img'><img width=30 src=#{imgUrl} alt=#{full.name}></a>"
        },
        {
          text:"用户信息",
          field: "",
          render: (field, full) ->
            "#{full.user_id}<br>"+
            "#{full.name}<br>"+
            "#{full.mobile}"
        },
        {
          text:"下单时间",
          field: "created_at",
          render: (field, full) ->
            Util.timeFormate field
        },
        {
          text:"最后修改",
          field: "updated_at",
          render: (field, full) ->
            Util.timeFormate field
        },
        { text:"咨询价格", field: "amount"},
        { text:"订单状态", field: "status_text"},
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            Util.genBtns([], full.id)
        }
      ]
    return

  # 医生新增和编辑
  .controller 'DoctorNewController', (Util, $stateParams, toastr) ->
    'ngInject'
    vm = this
    vm.formData = {}
    vm.id = if $stateParams.id? then $stateParams.id else false
    resMethods = Util.res('/doctor')

    vm.save = () ->
      resMethods.save vm.formData, vm.id

    # init
    if vm.id
      resMethods.get vm.id
        .then (res) ->
          vm.formData = res.data

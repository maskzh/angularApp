angular.module 'jkbs'
  .controller 'DoctorController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.title = '医生管理'
    $scope.grid =
      listUrl: '/doctor/recommend-list'
      addUrl: ''
      deleteUrl: '/doctor'
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
            "<div class='btn-group table-btns'>"+
            "<a class='btn btn-sm btn-default hint hint--top' title='订单' href='#/doctor/order/#{full.id}?name=#{full.user_name}'>"+
            "<i class='fa fa-navicon'></i></a>"+
            "<a class='btn btn-sm btn-default hint hint--top' title='编辑' href='#/doctor/#{full.id}'><i class='fa fa-edit'></i></a>"+
            "<a class='btn btn-sm btn-danger hint hint--top J_delete' title='删除' alt='#{full.id}'><i class='fa fa-close'></i></a>"+
            "</div>"
        }
      ]
    return

  .controller 'DoctorOrderController', (Util, $scope, $stateParams, $location) ->
    'ngInject'
    # 表格
    $scope.title = ($location.search().name or '') + '医生咨询订单'
    listUrl = '/order-doctor/get-list'
    listUrl = listUrl + "?doctor_id=#{$stateParams.id}" if $stateParams.id?
    $scope.grid =
      listUrl: listUrl
      addUrl: ''
      deleteUrl: '/order-doctor'
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
            "<div class='btn-group table-btns'>"+
            "<a class='btn btn-sm btn-default hint hint--top' title='订单' href='#/doctor/order/#{full.id}?name=#{full.user_name}'>"+
            "<i class='fa fa-navicon'></i></a>"+
            "<a class='btn btn-sm btn-default hint hint--top' title='编辑' href='#/doctor/#{full.id}'><i class='fa fa-edit'></i></a>"+
            "<a class='btn btn-sm btn-danger hint hint--top J_delete' title='删除' alt='#{full.id}'><i class='fa fa-close'></i></a>"+
            "</div>"
        }
      ]
    return

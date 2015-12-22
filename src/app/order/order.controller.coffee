angular.module 'jkbs'
  .controller 'OrderController', (Util, $scope, orderService) ->
    'ngInject'
    # 表格
    $scope.title = '订单管理'
    $scope.grid =
      api:
        base: '/order'
        list: 'order-list'
      operation: 'delete search'
      tabs: [
        {title:'全部', query: {whether_done:0}},
        {title:'未完成', query:{whether_done:2}},
        {title:'已完成', query:{whether_done:1}}
      ]
      tabs2: [
        {title: '全部', query: {type: 10}},
        {title: '药店', query: {type: 10}},
        {title: '机构', query: {type: 20}}
      ]
      table: [
        { text:"ID", field: "id"},
        {
          text:"用户信息",
          field: "",
          render: (field, full) ->
            "#{full.name}<br>"+
            "#{full.tel}<br>"+
            "#{full.address}"
        },
        {
          text:"支付方式",
          field: 'pay',
          render: (field, full) ->
            orderService.pay field
        },
        {
          text:"发货方式",
          field: 'delivery',
          render: (field, full) ->
            orderService.delivery field
        },
        {
          text:"下单时间",
          field: "created_at",
          render: (field, full) ->
            return Util.timeFormat field
        },
        { text:"总价", field: "price"},
        {
          text:"状态",
          field: "status",
          render: (field, full) ->
            orderService.status field
        },
        {
          text:"操作",
          field:"",
          render: (field, full) ->
            Util.genBtns([
              {type: 'default', title: '查看', href: "order/#{full.id}", icon: 'eye'}
            ], full.id)
        }
      ]
    return

  .controller 'OrderShowController', (Util, $scope, $stateParams, orderService, toastr) ->
    'ngInject'
    # 表格
    vm = this
    $scope.title = '订单详情'
    id = $stateParams.id
    handleData = (data) ->
      data.delivery = orderService.delivery data.delivery
      data.pay = orderService.pay data.pay
      data
    Util.get "/order/order-info?order_id=#{id}"
      .then (res) ->
        $scope.data = handleData res.data
    return

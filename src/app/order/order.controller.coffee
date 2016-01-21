angular.module 'jkbs'
  # 订单列表
  .controller 'OrderController', (Util, $scope, OrderService) ->
    'ngInject'
    # 表格
    $scope.title = '订单管理'
    $scope.grid =
      api:
        base: '/order'
        list: 'all-list'
        search: 'all-list'
      disabled: 'add'
      tabs: [
        [
          {text:'全部', query: {whether_done:0}},
          {text:'未完成', query:{whether_done:2}},
          {text:'已完成', query:{whether_done:1}}
        ],
        [
          {text: '全部', query: {type: ''}},
          {text: '药店', query: {type: 10}},
          {text: '机构', query: {type: 20}}
        ]
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
            OrderService.pay field
        },
        {
          text:"发货方式",
          field: 'delivery',
          render: (field, full) ->
            OrderService.delivery field
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
            OrderService.status field
        },
        {
          text:"操作",
          field:"",
          render: (field, full) ->
            Util.genBtns [
              {type: 'default', text: '查看', href: "#/order/#{full.id}", icon: 'eye'}
            ], full.id
        }
      ]
    return

  # 订单详情
  .controller 'OrderShowController', (Util, $scope, $stateParams, OrderService, toastr) ->
    'ngInject'
    # 表格
    vm = this
    vm.title = '订单详情'

    id = $stateParams.id
    handleData = (data) ->
      data.delivery = OrderService.delivery data.delivery
      data.pay = OrderService.pay data.pay
      data
    Util.get "/order/order-info?order_id=#{id}"
      .then (res) ->
        $scope.data = handleData res.data
    return

angular.module 'jkbs'
  .controller 'OrderController', (Util, $scope, User) ->
    'ngInject'
    # 表格
    $scope.title = '订单管理'
    $scope.grid =
      listUrl: '/order/order-list/?user_id=' + User.user.id
      addUrl: ''
      deleteUrl: '/order'
      table: [
        { text:"ID", field: "id"},
        { text:"姓名", field: "name"},
        { text:"电话", field: "tel"},
        { text:"地址", field: "address"},
        {
          text:"支付方式",
          field: 'pay',
          render: (field, full) ->
            return '在线支付' if field is '10'
            return '当面支付' if field is '20'
        },
        {
          text:"发货方式",
          field: 'delivery',
          render: (field, full) ->
            return '普通快递' if field is '10'
            return '上门自取' if field is '20'
            return '送货上门' if field is '30'
        },
        {
          text:"下单时间",
          field: "created_at",
          render: (field, full) ->
            return Util.timeFormat field
        },
        {
          text:"发货时间",
          field: "ship_dateline",
          render: (field, full) ->
            return Util.timeFormat field
        },
        { text:"订单价格", field: "price"},
        { text:"状态", field: "status"},
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            "<div class='btn-group table-btns'>"+
            "<a class='btn btn-sm btn-default hint hint--top' title='编辑' href='#/order/#{full.id}'><i class='fa fa-edit'></i></a>"+
            "<a class='btn btn-sm btn-danger hint hint--top J_delete' title='删除' alt='#{full.id}'><i class='fa fa-close'></i></a>"+
            "</div>"
        }
      ]
    return

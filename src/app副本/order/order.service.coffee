angular.module 'jkbs'
  .service 'orderService', () ->
    'ngInject'
    @type = (val) ->
      type =
        '10': '药品'
        '20': '机构套餐'
      type[val]

    @pay = (val) ->
      pay =
        '10': '在线支付'
        '20': '当面支付'
      pay[val]

    @delivery = (val) ->
      delivery =
        '10': '普通快递'
        '20': '上门自取'
        '30': '送货上门'
      delivery[val]

    @status = (val) ->
      status =
        '0': '已删除'
        '1': '已取消'
        '2': '已拒收'
        '10': '已下单'
        '20': '已接单'
        '30': '确认收货'
        '40': '已完成'
        '110': '已退货'
      status[val]

    return

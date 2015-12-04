angular.module 'jkbs'
  .controller 'ShopController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.listUrl = '/doctor/recommend-list'
    $scope.addUrl = ''
    $scope.deleteUrl = '/doctor'
    $scope.maps = [
      { text:"ID", field: "id"},
      { text:"姓名", field: "user_name"},
      {
        text:"头像",
        field: "user_pic",
        render: (field, full) ->
          imgUrl = Util.img field
          "<img width=30 src=#{imgUrl} alt=#{full.user_name}>"
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
          "<div class='btn-group'>"+
          "<a class='btn btn-sm btn-default' href='#/doctor/order/#{full.id}'>订单</a>"+
          "<a class='btn btn-sm btn-default' href='#/doctor/#{full.id}'>编辑</a>"+
          "<a class='btn btn-sm btn-danger' alt='#{full.id}'>删除</a>"+
          "</div>"
      }
    ]
    return

  .controller 'InstitutionController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.listUrl = '/doctor/recommend-list'
    $scope.addUrl = ''
    $scope.deleteUrl = '/doctor'
    $scope.maps = [
      { text:"ID", field: "id"},
      { text:"姓名", field: "user_name"},
      {
        text:"头像",
        field: "user_pic",
        render: (field, full) ->
          imgUrl = Util.img field
          "<img width=30 src=#{imgUrl} alt=#{full.user_name}>"
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
          "<div class='btn-group'>"+
          "<a class='btn btn-sm btn-default' href='#/doctor/order/#{full.id}'>订单</a>"+
          "<a class='btn btn-sm btn-default' href='#/doctor/#{full.id}'>编辑</a>"+
          "<a class='btn btn-sm btn-danger' alt='#{full.id}'>删除</a>"+
          "</div>"
      }
    ]
    return

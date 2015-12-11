angular.module 'jkbs'
  .controller 'ShopController', (Util, $scope, $stateParams) ->
    'ngInject'
    # 表格
    type = $stateParams.type
    $scope.title = if $stateParams.type is '10' then '药店管理' else '机构管理'

    $scope.grid =
      api:
        base: '/shop'
        list: "shop-list?type=#{type}"
      table: [
        { text:"ID", field: "id"},
        {
          text:"Logo",
          field: "pic",
          render: (field, full) ->
            imgUrl = Util.img field
            "<a class='J_image' href=#{imgUrl}><img width=30 src=#{imgUrl}></a>"
        },
        { text:"店名", field: "title"},
        { text:"公司名", field: "company"},
        {
          text:"联系",
          field: '',
          render: (field, full) ->
            "管理员：#{full.user_id}<br>"+
            "联系人：#{full.contact}<br>"+
            "联系电话：#{full.tel}<br>"
        },
        { text: '地址', field: 'address' },
        # { text:"营业时间", field: "open_time"},
        # { text:"主营内容", field: "sale_content"},
        { text:"评价", field: "star"},
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            Util.genBtns([
              {type: 'default', title: '编辑', href: "shop/#{full.id}", icon: 'edit'}
            ], full.id)
        }
      ]
    return

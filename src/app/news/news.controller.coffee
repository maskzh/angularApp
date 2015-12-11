angular.module 'jkbs'
  .controller 'NewsController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.grid =
      api:
        base: '/news'
        list: ''
      table: [
        { text:"ID", field: "id"},
        { text:"标题", field: "title"},
        {
          text:"封面",
          field: "pic",
          render: (field, full) ->
            imgUrl = Util.img field
            "<a class='J_image' href=#{imgUrl}><img width=120 src=#{imgUrl}></a>"
        },
        {
          text:"创建时间",
          field: "created_at",
          render: (field, full) ->
            Util.timeFormat field
        },
        {
          text:"最后修改",
          field: "updated_at",
          render: (field, full) ->
            Util.timeFormat field
        },
        {
          text:"推送时间",
          field: "send_at",
          render: (field, full) ->
            Util.timeFormat field
        },
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            "<div class='btn-group table-btns'>"+
            "<a class='btn btn-sm btn-default hint hint--top' title='编辑' href='#/news/#{full.id}'><i class='fa fa-edit'></i></a>"+
            "<a class='btn btn-sm btn-danger hint hint--top J_delete' title='删除' alt='#{full.id}'><i class='fa fa-close'></i></a>"+
            "</div>"
        }
      ]
    return

  .controller 'NewsCatController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.grid =
      api:
        base: '/news/news_category'
        list: 'index'
      table: [
        { text:"ID", field: "id"},
        { text:"名称", field: "title"},
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            "<div class='btn-group table-btns'>"+
            "<a class='btn btn-sm btn-default hint hint--top' title='编辑' href='#/news/news_category/#{full.id}'><i class='fa fa-edit'></i></a>"+
            "<a class='btn btn-sm btn-danger hint hint--top J_delete' title='删除' alt='#{full.id}'><i class='fa fa-close'></i></a>"+
            "</div>"
        }
      ]
    return

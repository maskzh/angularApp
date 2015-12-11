angular.module 'jkbs'
  .controller 'DiseaseController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.grid =
      api:
        base: '/disease'
        list: ''
      addHref: ''
      table: [
        { text:"ID", field: "id"},
        { text:"名称", field: "title"},
        {
          text:"描述",
          field: "link",
          render: (field, full) ->
            return field if !!field
            return full.description
        },
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            Util.genBtns([
              {type: 'default', title: '编辑', href: "disease/#{full.id}", icon: 'edit'}
            ], full.id)
        }
      ]
    return

  .controller 'DiseaseCatController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.grid =
      api:
        base: '/disease-title'
        list: 'title-list'
      addHref: 'base.disease_new'
      table: [
        { text:"ID", field: "id"},
        {
          text:"图片",
          field: "pic",
          render: (field, full) ->
            imgUrl = Util.img field
            "<a class='J_image' href=#{imgUrl}><img width=30 src=#{imgUrl} alt=#{full.title}></a>"
        },
        { text:"类别", field: "type" },
        { text:"标题", field: "title" },
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            "<div class='btn-group'>"+
            "<a class='btn btn-sm btn-default hint hint--top' title='编辑' href='#/disease-title/#{full.id}'><i class='fa fa-edit'></i></a>"+
            "<a class='btn btn-sm btn-danger hint hint--top J_delete' title='删除' alt='#{full.id}'><i class='fa fa-close'></i></a>"+
            "</div>"
        }
      ]
    return

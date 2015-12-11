angular.module 'jkbs'
  .controller 'MedicineController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.title = '药品管理'
    $scope.grid =
      listUrl: '/medicine'
      addUrl: ''
      deleteUrl: '/medicine'
      table: [
        { text:"ID", field: "id"},
        {
          text:"图片",
          field: "pic",
          render: (field, full) ->
            imgUrl = Util.img field
            "<a class='J_image' href=#{imgUrl}><img width=30 src=#{imgUrl}></a>"
        },
        {
          text:"规格",
          field: "spec",
          render: (field, full) ->
            field + " #{full.unit}"
        },
        { text:"生产厂商", field: "company"},
        { text:"注册号", field: "register_number"},
        { text:"类型", field: "type"},
        {
          text:"二维码",
          field: 'barcode',
          render: (field, full) ->
            imgUrl = Util.img field
            "<a class='J_image' href='#{imgUrl}'><img width=30 src='#{imgUrl}'></a>"
        },
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            Util.genBtns([
              {type: 'default', title: '编辑', href: "medicine/#{full.id}", icon: 'edit'}
            ], full.id)
        }
      ]
    return

  .controller 'MedicineCatController', (Util, $scope) ->
    'ngInject'
    # 表格
    $scope.title = '药品分类'
    $scope.grid =
      listUrl: '/medicine-category/get-category'
      addUrl: ''
      deleteUrl: '/medicine-category'
      table: [
        { text:"ID", field: "id"},
        {
          text:"图标",
          field: "pic",
          render: (field, full) ->
            imgUrl = Util.img field
            "<a class='J_image' href=#{imgUrl}><img width=30 src=#{imgUrl} alt=#{full.name}></a>"
        },
        { text:"名称", field: "title"},
        { text:"描述", field: "description"},
        {
          text:"操作",
          field: "",
          render: (field, full) ->
            "<div class='btn-group table-btns'>"+
            "<a class='btn btn-sm btn-default hint hint--top' title='编辑' href='#/medicine-category//#{full.id}'><i class='fa fa-edit'></i></a>"+
            "<a class='btn btn-sm btn-danger hint hint--top J_delete' title='删除' alt='#{full.id}'><i class='fa fa-close'></i></a>"+
            "</div>"
        }
      ]
    return

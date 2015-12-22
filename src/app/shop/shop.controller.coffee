angular.module 'jkbs'
  .controller 'ShopController', (Util, $scope, $stateParams) ->
    'ngInject'
    # 表格
    $scope.title = '微店管理'

    $scope.grid =
      api:
        base: '/shop'
        list: "shop-list"
      tabs: [
        {title:'药店', query: {type:10}},
        {title:'机构', query:{type:20}},
      ]
      table: [
        { text:"ID", field: "id"},
        {
          text:"Logo",
          field: "pic",
          render: (field, full) ->
            imgUrl = Util.img field
            "<a class='J_image' href='#{imgUrl}'><img width=30 src='#{imgUrl}'></a>"
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
              {type: 'default', title: '编辑', href: "shop/#{full.id}/edit", icon: 'edit'}
            ], full.id)
        }
      ]
    return

  .controller 'ShopNewController', (Util, $stateParams, toastr, Uploader) ->
    'ngInject'
    vm = this
    # init methods
    resMethods = Util.res('/shop')
    vm.save = () ->
      resMethods.save vm.formData, id
        .then (res) ->
          toastr.success '已成功提交'

    vm.upload = Uploader.upload

    # init data
    vm.formData = {}
    vm.formData.is_boss_customer_service = 0 #管理员帐号是否作为客服出现
    vm.formData.service_insurance = 0 #医保支持
    vm.formData.service_chinese_medicine = 0 #中药有售
    vm.formData.service_chinese_medicine_agent = 0 #中药代煎
    vm.formData.chain = 0 #是否连锁
    vm.formData.status = 1 #是否可用
    vm.formData.template_id = 0 #默认模板

    # init 省市区域
    vm.getLocaleList = (name, parent, child)->
      if vm[parent] and vm[parent].length
        for item in vm[parent]
          if item.name is name
            id = item.id or ''
      Util.get '/area/get-list', {parent: id}
      .then (res) ->
        vm[child] = res.data.items

    vm.setLonAndLat = (str)->
      xyz = str.split ','
      if xyz.length > 1
        vm.formData.lon = xyz[0]
        vm.formData.lat = xyz[1]

    # init
    id = if $stateParams.id? then $stateParams.id else false
    if id
      resMethods.get id
        .then (res) ->
          vm.formData = res.data
    else
      # true 为新增，不存在 为编辑
      vm.state = true

    vm.getLocaleList(null, null, 'province_list')
    return

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
        # { text:"公司名", field: "company"},
        {
          text:"联系",
          field: '',
          render: (field, full) ->
            "联系人：#{full.contact}<br>"+
            "联系电话：#{full.tel}<br>"+
            "地址：#{full.address}"
        },
        {
          text: '更多',
          field: '',
          render: (field, full) ->
            "收藏次数：#{full.favor_num}<br>"+
            "访问次数：#{full.view_num}<br>"+
            "评价：#{full.star}"
        },
        # { text:"营业时间", field: "open_time"},
        # { text:"主营内容", field: "sale_content"},
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

  .controller 'ShopNewController', (Util, $stateParams, toastr, Uploader, $timeout) ->
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

    # 省市区域
    vm.getPrivinceList = ()->
      Util.get '/area/get-list'
      .then (res) ->
        vm.province_list = res.data.items

    vm.getCityList = ()->
      Util.get '/area/get-list',{name: vm.formData.province}
      .then (res) ->
        vm.city_list = res.data.items

    vm.getCountryList = ()->
      Util.get '/area/get-list',{name: vm.formData.city}
      .then (res) ->
        vm.country_list = res.data.items

    # 粘贴自动补全经纬度
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
          vm.getCityList()
          vm.getCountryList()
    else
      # true 为新增，不存在 为编辑
      vm.state = true
    vm.getPrivinceList()

    return

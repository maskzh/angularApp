angular.module 'jkbs'
  .directive 'grid', ->
    GridController = (Util, $state, $sce, toastr) ->
      'ngInject'
      vm = this

      # 数据和分页
      vm.list = []
      vm.currentPage = 1
      vm.totalItems = 0

      # 状态字段
      vm.isNoData = false
      vm.isLoading = true

      # 其它字段
      vm.ths = [] # 表头的标题们
      vm.ids = [] # 被选中的条目的 id
      vm.bindGetList = null # 根据参数生成的获取数据列表方法

      # 根据提供的 表格maps 处理数据
      handleList = (items, maps) ->
        result = []
        for item in items
          # 循环 items
          tmp = []
          tmp.id = item.id
          for map in maps
            # 根据 maps 处理每个 item
            key = map.field
            value = if key? then item[key] else ''
            # 如果有 render 方法
            render = map.render
            if render?
              value = render(value, item)
            # 将每个字段的处理结果推入 tmp
            tmp.push value
          # 将每个 item 的处理结果推入 result
          result.push tmp
        # 最后返回 result
        result

      # 发起请求获取数据，并处理生成传递到模板中的字段
      vm.getList = (url, data) ->
        # reset
        vm.ids = []
        vm.isLoading = true

        data = angular.extend {page: 1, 'per-page': 10}, data
        Util.get url, data
          .then (res)->
            if res.data.items.length is 0
              vm.noData = true
              vm.isLoading = false
              return

            # 赋值
            vm.list = handleList res.data.items, vm.maps
            vm.currentPage = res.data._meta.currentPage
            vm.totalItems = res.data._meta.totalCount
            vm.noData = false
            vm.isLoading = false
            return
        return

      # 获取标头标题们
      vm.getThs = (maps) ->
        result = []
        for map in maps
          result.push map.text
        result

      # 页码修改，重新请求
      vm.pageChanged = ()->
        vm.bindGetList {page: vm.currentPage}

      # 删除某一个条目
      vm.deleteItem = (url, id) ->
        if confirm '确定删除？'
          Util.delete "#{url}/#{id}", {id: id}
            .then (res) ->
              toastr.info '删除成功'
              vm.pageChanged()

      # 删除多个条目
      vm.deleteItems = (url, ids) ->
        if confirm '确定删除？'
          Util.delete url, {ids: ids}
            .then (res) ->
              toastr.info '删除成功'
              vm.pageChanged()

      # 根据字段搜索并加载数据
      vm.search = (query) ->
        vm.bindGetList {query: query}

      # 增加条目
      vm.add = () ->
        $state.go vm.addUrl

      # 删除多个
      vm.delete = () ->
        vm.deleteItems vm.deleteUrl, vm.ids.join(',')

      return

    linkFunc = (scope, el, attr, vm) ->
      vm.listUrl = attr.listUrl
      vm.addUrl = attr.addUrl
      vm.deleteUrl = attr.deleteUrl
      vm.maps = scope.maps

      # init
      vm.ths = vm.getThs(vm.maps)
      vm.bindGetList = vm.getList.bind(vm, vm.listUrl)
      vm.bindGetList()

      el.on 'click', 'thead input', (e) ->
        checked = $(this).prop 'checked'
        $cboxs = el.find 'tbody input'
        if checked
          $cboxs
            .prop 'checked', true
            .each (item) ->
              vm.ids.push $(item).val()
        else
          $cboxs
            .prop 'checked', false
            .each (item) ->
              vm.ids = []

      el.on 'click', 'tbody input', (e) ->
        checked = $(this).prop 'checked'
        if checked
          vm.ids.push $(this).val()
        else
          for id, i in vm.ids
            if $(this).val() is id
              vm.ids.splice i, 1

      el.on 'click', 'a[alt]', (e) ->
        vm.deleteItem vm.deleteUrl, $(this).attr 'alt'

      scope.$on '$destroy', ->
        el.off()
        return

      return

    directive =
      restrict: 'E'
      scope: true
      templateUrl: 'app/components/grid/grid.html'
      link: linkFunc
      controller: GridController
      controllerAs: 'vm'
      # bindToController: true
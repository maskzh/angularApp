angular.module 'jkbs'
  .service 'Util', (User, $http, $q, URL, toastr) ->
    'ngInject'
    token = User.token
    vm = this

    # ajax
    @ajax = (type, url, data, config) ->
      delay = $q.defer()
      $http[type] url, data, config
        .success (res) ->
          if res.result
            delay.resolve res
          else
            toastr.warning (res and res.message) or '请求发生错误'
            delay.reject res
        .error (res, status, headers, config) ->
          toastr.error (res and res.message) or '请求发生错误'
          delay.reject res, status, headers, config
      delay.promise

    # ajax get
    @get = (url, data, config) ->
      data = angular.extend {'access-token': token}, data
      config = angular.extend {params: data}, config
      @ajax 'get', url, config

    # ajax post
    @post = (url, data, config) ->
      data = angular.extend {'access-token': token}, data
      @ajax 'post', url, data, config

    # ajax put
    @put = (url, data, config) ->
      data = angular.extend {'access-token': token}, data
      @ajax 'put', url, data, config

    # ajax delete
    @delete = (url, data, config) ->
      data = angular.extend {'access-token': token}, data
      config = angular.extend {params: data}, config
      @ajax 'delete', url, config

    # 给图片地址加上绝对路径
    @img = (url) ->
      return URL.img + url if url
      'assets/common/default.gif'


    # 给 grid 生成操作按钮
    @genBtns = (btns, id, hideDelete) ->
      html = '<div class="btn-group table-btns">'
      for btn in btns
        html += "<a class='btn btn-tiny hint hint--top btn-#{btn.type} #{btn.selector || ''}'" +
                " title='#{btn.text}'" +
                " href='#{btn.href || 'javascript:;'}'" +
                " data-id='#{id}'>" +
                "<i class='fa fa-#{btn.icon}'></i>" +
                "</a>"
      unless hideDelete
        html += "<a class='btn btn-tiny btn-danger hint hint--top J_delete' title='删除' data-id='#{id}'><i class='fa fa-trash'></i></a>"
      html += '</div>'

    # 给 grid 生成 布尔 状态
    @renderBl = (bl) ->
      if bl is 1 or bl is '1'
        return '<i class="fa fa-check" alt="open"></i>'
      else
        return '<i class="fa fa-close" alt="close"></i>'


    # 时间转换工具
    @timeFormat = (timestamp, fmt) ->
      date = new Date parseInt(timestamp)*1000
      fmt = fmt || 'yyyy-MM-dd hh:mm'

      o =
        "M+": date.getMonth() + 1 #月份
        "d+": date.getDate() #日
        "h+": if date.getHours() % 12 is 0 then 12 else date.getHours() % 12 #小时
        "H+": date.getHours() #小时
        "m+": date.getMinutes() #分
        "s+": date.getSeconds() #秒
        "q+": Math.floor((date.getMonth() + 3) / 3) #季度
        "S": date.getMilliseconds() #毫秒

      week =
          cn:
            "0": "/u65e5"
            "1": "/u4e00"
            "2": "/u4e8c"
            "3": "/u4e09"
            "4": "/u56db"
            "5": "/u4e94"
            "6": "/u516d"

      if /(y+)/.test(fmt)
        fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length))

      if /(E+)/.test(fmt)
        if RegExp.$1.length > 1
          if RegExp.$1.length > 2
            r = "/u661f/u671f"
          else
            r = "/u5468"
        else
          r = ""
        fmt = fmt.replace RegExp.$1, r + week[date.getDay() + ""]

      for k of o
        if new RegExp("(" + k + ")").test(fmt)
          x = if RegExp.$1.length is 1 then o[k] else ("00" + o[k]).substr(("" + o[k]).length)
          fmt = fmt.replace(RegExp.$1, x)

      fmt

     # 表单修改新增逻辑封装
    @res = (url) ->
      return {
        get: (id) ->
          vm.get "#{url}/#{id}"
        save: (data, id) ->
          return vm.put "#{url}/#{id}", data if id
          vm.post url, data
        delete: (id) ->
          vm.delete "#{url}/#{id}"
      }

    return

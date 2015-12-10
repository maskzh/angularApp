angular.module 'jkbs'
  .service 'Util', (User, $http, $q, URL) ->
    'ngInject'
    token = User.token

    @ajax = (type, url, data, config) ->
      delay = $q.defer()
      $http[type] url, data, config
        .success (res) ->
          if res.result
            delay.resolve res
          else
            delay.reject res.message
        .error (res, status, headers, config) ->
          delay.reject res.message
      delay.promise

    @get = (url, data, config) ->
      data = angular.extend {'access-token': token}, data
      config = angular.extend {params: data}, config
      @ajax 'get', url, config

    @post = (url, data, config) ->
      @ajax 'post', url, data, config

    @put = (url, data, config) ->
      @ajax 'put', url, data, config

    @delete = (url, data, config) ->
      data = angular.extend {'access-token': token}, data
      config = angular.extend {params: data}, config
      @ajax 'delete', url, config

    @img = (url) ->
      URL.img + url

    @genBtns = (btns, id) ->
      html = '<div class="btn-group table-btns">'
      for btn in btns
        html += "<a class='btn btn-sm hint hint--top btn-#{btn.type}'" +
                " title='#{btn.title}'" +
                " href='#/#{btn.href}'>" +
                "<i class='fa fa-#{btn.icon}'></i>" +
                "</a>"
      if id?
        html += "<a class='btn btn-sm btn-danger hint hint--top J_delete' title='删除' alt='#{id}'><i class='fa fa-close'></i></a>"
      html += '</div>'

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


    return

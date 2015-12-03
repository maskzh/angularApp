angular.module 'jkbs'
  .service 'Util', (User, $http, $q) ->
    'ngInject'

    token = User.token

    URL_PREFIX = 'https://api.jkbsapp.com'
    IMG_PREFIX = 'http://img.jkbsimg.com/'

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
      IMG_PREFIX + url

    return

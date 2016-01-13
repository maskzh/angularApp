angular.module 'jkbs'
  .service 'NewsService', (Util) ->
    'ngInject'
    # 获取资讯分类
    @getNewsCat = ->
      Util.get '/news-category/index'
      .then (res) ->
        return res.data.items

    return

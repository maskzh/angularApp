# 所有模块初始化配置
angular.module 'jkbs'
  .config ($logProvider, localStorageServiceProvider, toastrConfig) ->
    'ngInject'
    # 配置日志
    $logProvider.debugEnabled true

    # 配置 localStorage
    localStorageServiceProvider
      .setPrefix 'jkbs'
      .setStorageType 'localStorage'
      .setStorageCookie 45, '/admin'
      # .setStorageCookieDomain ''
      .setNotify true, true

    # 配置 toastr
    toastrConfig.allowHtml = true
    toastrConfig.closeButton = true
    toastrConfig.tapToDismiss = true
    toastrConfig.timeOut = 1000
    toastrConfig.positionClass = 'toast-top-right'
    toastrConfig.preventDuplicates = false
    # toastrConfig.progressBar = true

    return

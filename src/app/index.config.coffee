angular.module 'jkbs'
  .config ($logProvider, localStorageServiceProvider, toastrConfig) ->
    'ngInject'
    # Enable log
    $logProvider.debugEnabled true

    localStorageServiceProvider
      .setPrefix 'jkbs'
      .setStorageType 'localStorage'
      .setStorageCookie 45, '/admin'
      # .setStorageCookieDomain ''
      .setNotify true, true

    # Set options third-party lib
    toastrConfig.allowHtml = true
    toastrConfig.closeButton = true
    toastrConfig.tapToDismiss = true
    toastrConfig.timeOut = 1000
    toastrConfig.positionClass = 'toast-top-right'
    toastrConfig.preventDuplicates = false
    # toastrConfig.progressBar = true

    return

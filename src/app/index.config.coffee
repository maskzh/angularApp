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
    toastrConfig.timeOut = 3000
    toastrConfig.positionClass = 'toast-top-right'
    toastrConfig.preventDuplicates = true
    toastrConfig.progressBar = true

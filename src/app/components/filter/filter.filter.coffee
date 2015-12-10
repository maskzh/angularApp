angular.module 'jkbs'
  .filter 'img', (URL) ->
    'ngInject'
    (url) ->
      URL.img + url

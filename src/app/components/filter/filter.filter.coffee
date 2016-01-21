angular.module 'jkbs'
  .filter 'img', (URL) ->
    'ngInject'
    (url) ->
      URL.img + url
  .filter 'to_trusted', ($sce) ->
    (text) ->
      $sce.trustAsHtml text

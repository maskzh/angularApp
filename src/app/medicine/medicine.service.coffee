angular.module 'jkbs'
  .service 'MedicineService', (Util) ->
    'ngInject'

    @getMedicineCat = ->
      Util.get '/medicine-category/get-category', {type: 'all'}
      .then (res) ->
        res.data.items

    return

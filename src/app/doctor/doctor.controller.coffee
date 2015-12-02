angular.module 'jkbs'
  .controller 'DoctorController', (Util) ->
    'ngInject'
    vm = this


    vm.getList = (page) ->
      Util.get '/doctor/recommend-list/', {page: page, 'per-page': 10}
        .then (res)->
          if res.result
            vm.list = res.data.items
            vm.currentPage = res.data._meta.currentPage
            vm.totalItems = res.data._meta.totalCount

    vm.pageChanged = ()->
      vm.getList vm.currentPage

    # init
    vm.getList 1

    return

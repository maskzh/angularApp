angular.module 'jkbs'
  .controller 'HomeController', ($timeout, webDevTec, toastr, $modal) ->
    'ngInject'
    vm = this
    activate = ->
      $timeout (->
        vm.classAnimation = 'rubberBand'
        return
      ), 4000
      return

    vm.showToastr = ->
      toastr.info 'Fork <a href="https://github.com/Swiip/generator-gulp-angular" target="_blank"><b>generator-gulp-angular</b></a>'
      vm.classAnimation = ''
      return

    vm.closeAlert = (index)->
      vm.alerts.splice(index, 1)

    vm.pageChanged = ()->
      vm.list = pagination({
        url: '/api/list',
        data: {
          page: vm.bigCurrentPage
        }
      })

    vm.currentPage = 5
    vm.totalItems = 75

    vm.open = () ->
      modalInstance = $modal.open({
        templateUrl: 'myModalContent.html',
        controller: 'HomeModalInstanceCtrl'
      })
      modalInstance.result.then ()->
        console.log '2222'

    vm.alerts = [
      {
        msg: "点击查看我们新的隐私策略",
        type: 'info'
      },
      {
        msg: "点击查看我们新的隐私策略",
        type: 'info'
      }
    ]

    vm.tabs = [
      {
        title: '1'
        content: '11'
      },
      {
        title: '2'
        content: '22'
      }
    ]
    vm.classAnimation = ''
    activate()
    return

  .controller 'HomeModalInstanceCtrl', ()->
    console.log '1111'

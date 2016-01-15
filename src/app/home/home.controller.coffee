angular.module 'jkbs'
  .controller 'HomeController', ->
    'ngInject'
    vm = this

    vm.alerts = [
      {
        msg: "药店删除暂不可用，多项删除暂不可用，正在修改...",
        type: 'danger'
      },
      {
        msg: "BUG 问题，请及时与我们反馈。",
        type: 'info'
      }
    ]

    vm.logs = [
      '2016.01.14 编辑器已更新为原来版本，可点击编辑器右上角的电脑状图标进入全屏编辑视图'
    ]

    vm.closeAlert = (index)->
      vm.alerts.splice(index, 1)

    return

angular.module 'jkbs'
  .service 'UserService', () ->
    'ngInject'
    # 用户角色
    role =
      shop: '药店老板#primary'
      institution: '机构老板#primary'
      doctor: '医生#success'
      angel: '健康天使#danger'
      shop_customer_service: '药店客服#info'
      institution_customer_service: '机构客服#info'

    # 用户权限组
    adminGroupList = [
      {id: 0, label: "无管理权限"}
      {id: 1, label: "日常管理"}
      {id: 2, label: "总管理"}
    ]

    @getAdminGroupList = ->
      adminGroupList

    @renderRole = (full) ->
      roleArr = []
      for key of role
        if full[key]? and (full[key] is '1' or full[key] is 1)
          roleArr.push role[key]
      return roleArr.map (item)->
        tmp = item.split '#'
        return {
          value: tmp[0],
          type: tmp[1]
        }

    return

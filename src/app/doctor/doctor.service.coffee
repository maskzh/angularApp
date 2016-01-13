angular.module 'jkbs'
  .service 'DoctorService', (Util) ->
    'ngInject'
    @type = ->
      ['医生','美丽咨询师','经络医生','健康管理师','公共营养师','理疗师','按摩师']

    @getDepartment = ->
      Util.get '/hospital-department/get-list?type=all'
      .then (res) ->
        tmp = []
        for item1 in res.data.items
          tmp.push {id: item1.id, title: "① #{item1.title}"}
          if item1.child_list?
            for item2 in item1.child_list
              tmp.push {id: item1.id, title: "-- ②  #{item2.title}"}
              if item2.child_list?
                for item3 in item2.child_list
                  tmp.push {id: item1.id, title: "---- ③  #{item3.title}"}
        tmp
    return

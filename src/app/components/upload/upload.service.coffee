angular.module 'jkbs'
  .service 'Uploader', (Upload, User, toastr) ->
    'ngInject'

    @upload = (file, formData, key)->
      Upload.upload
        url: '/upload/upload-image'
        data:
          upfile: file
          'access-token': User.get().token
      .then (res) ->
        d = res.data
        if d.result
          formData[key] = d.data.cloud_key
        else
          toastr.error res.data.message
      , (res) ->
        toastr.error res.data.message
      , (e) ->
        progressPercentage = parseInt 100.0 * e.loaded / e.total
        console.log 'progress: ' + progressPercentage + '% ' + e.config.data.upfile.name

    return

angular.module 'jkbs'
  .factory 'Auth', ($http, Session) ->
    'ngInject'

    login = (credentials) ->
      $http
        .post '/auth/admin-login', credentials
        .then (res) ->
          if res.data.result is true
            Session.create res.data.data.id, res.data.data.admin_group_id
            res.data.data
          else
            alert '登录发生错误'
            false

    isAuthenticated = ->
      !!Session.userId;

    isAuthorized = (authorizedRoles) ->
      authorizedRoles = [authorizedRoles] if !angular.isArray(authorizedRoles)
      isAuthenticated() && authorizedRoles.indexOf(Session.userRole) isnot -1

    service =
      login: login
      isAuthenticated: isAuthenticated
      isAuthorized: isAuthorized

  .service 'Session', ->
    this.create = (userId, userRole) ->
      # this.id = sessionId
      this.userId = userId
      this.userRole = userRole

    this.destroy = () ->
      # this.id = null
      this.userId = null
      this.userRole = null
    this

angular.module 'jkbs'
  .factory 'Auth', ($http, Session) ->
    'ngInject'

    login = (credentials) ->
      $http
        .post '/login', credentials
        .then (res) ->
          Session.create res.data.id, res.data.user.id, res.data.user.role
          res.data.user

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
    this.create = (sessionId, userId, userRole) ->
      this.id = sessionId
      this.userId = userId
      this.userRole = userRole

    this.destroy = () ->
      this.id = null
      this.userId = null
      this.userRole = null
    this

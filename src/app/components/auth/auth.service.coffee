angular.module 'jkbs'
  .factory 'Auth', ($http, User) ->
    'ngInject'

    @getToken = (userId) ->
      $http
        .get '/auth/access-token'
        .then (res) ->
          User.token = res.data

    @login = (credentials) ->
      $http
        .post '/auth/admin-login', credentials
        .then (res) ->
          if res.data.result is true
            User.set res.data.data, res.data.message
            res.data.data
          else
            alert '登录发生错误'
            false

    @autoLogin = () ->
      userInfo = User.getFromLocal()
      if userInfo.token
        User.set(userInfo.user, userInfo.token)
        return true
      return false

    @isAuthenticated = ->
      !!User.user && !!User.user.id
      # true

    this

    # isAuthorized = (authorizedRoles) ->
    #   authorizedRoles = [authorizedRoles] if !angular.isArray(authorizedRoles)
    #   isAuthenticated() && authorizedRoles.indexOf(Session.userRole) isnot -1


  .service 'User', (localStorageService) ->
    @saveToLocal = (user, token) ->
      localStorageService.set 'user', user
      localStorageService.set 'token', token

    @getFromLocal = (user, token) ->
      user: localStorageService.get 'user'
      token: localStorageService.get 'token'

    @get = () ->
      user: @user
      token: @token

    @set = (user, token) ->
      # @id = sessionId
      @user = user
      @token = token
      @saveToLocal user, token

    @destroy = () ->
      localStorageService.remove 'user'
      localStorageService.remove 'token'
      # @id = null
      @user = null
      @token = null

    return

angular.module 'glasses'
  .service 'menu', () ->
    'ngInject'
    data = [
      {
        value: "微店管理",
        href: "/#/",
        icon: "home"
        subs: [
          {
            value: "微店管理",
            href: "/#/"
          },
          {
            value: "微店管理",
            href: "/#/"
          },
          {
            value: "微店管理",
            href: "/#/"
          }
        ]
      },
      {
        value: "微店管理",
        href: "/#/",
        icon: "home"
        subs: [
          {
            value: "微店管理",
            href: "/#/"
          },
          {
            value: "微店管理",
            href: "/#/"
          },
          {
            value: "微店管理",
            href: "/#/"
          }
        ]
      }
    ]

    getMenu = ->
      data

    @getMenu = getMenu
    return

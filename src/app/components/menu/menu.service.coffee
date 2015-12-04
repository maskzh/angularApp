angular.module 'jkbs'
  .service 'menu', () ->
    'ngInject'
    data = [
      {
        title: '微店|demo',
        menus: ['#/shop/10|药店管理', '#/shop/20|机构管理']
      },
      {
        title: '订单|demo',
        menus: ['#/order/index|订单管理', '#/order/report|报表']
      },
      {
        title: '医生|demo',
        menus: ['#/doctor/index|医生管理', '#/doctor/order|咨询订单']
      },
      {
        title: '疾病|demo',
        menus: ['#/disease/index|疾病管理', '#/disease/cat|疾病分类']
      },
      {
        title: '药品|demo',
        menus: ['#/medicine/index|药品管理', '#/medicine/cat|药品分类']
      },
      {
        title: '圈子|demo',
        menus: ['#/circle/index|圈子管理', '#/circle/post|帖子管理']
      },
      {
        title: '资讯|demo',
        menus: ['#/news/index|资讯管理', '#/news/cat|资讯分类']
      },
      {
        title: '用户|demo',
        menus: ['#/user/index|用户管理']
      },
      {
        title: '代理商|demo',
        menus: ['#/agent/index|代理商管理']
      },
    ]

    getMenu = ->
      navs = []
      for index,item of data
        menus = []
        titleArr = item.title.split('|')
        for n,i of item.menus
          menu = i.split('|')
          menus.push
            href: menu[0].toLowerCase().trim()
            text: menu[1].toLowerCase().trim()

        navs.push
          text: titleArr[0].toLowerCase().trim()
          icon: titleArr[1].toLowerCase().trim()
          menus: menus
      navs


    @getMenu = getMenu
    return

angular.module 'jkbs'
  .service 'menu', () ->
    'ngInject'
    data = [
      {
        title: '微店|demo',
        menus: ['#/shop|微店管理']
      },
      {
        title: '订单|demo',
        menus: ['#/order|订单管理'] #, '#/|报表'
      },
      {
        title: '医生|demo',
        menus: ['#/doctor|医生管理', '#/doctor/order|咨询订单']
      },
      {
        title: '疾病|demo',
        menus: ['#/disease|疾病管理', '#/disease-title|疾病分类']
      },
      {
        title: '药品|demo',
        menus: ['#/medicine|药品管理', '#/medicine-category|药品分类']
      },
      {
        title: '资讯|demo',
        menus: ['#/news|资讯管理', '#/news-category|资讯分类']
      },
      {
        title: '用户|demo',
        menus: ['#/user|用户管理']
      },
      # {
      #   title: '代理商|demo',
      #   menus: ['#/agent|代理商管理']
      # },
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

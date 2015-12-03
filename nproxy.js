module.exports = [

  // 1. replace single file with local one
  {
    pattern: /https?:\/\/api\.jkbsapp\.com\/admin\/styles\/app-(.*)\.css/,      // Match url you wanna replace
    responder:  "/Users/zyc/Salt light/jkbs2_admin/.tmp/serve/app/index.css"
  },

  {
    pattern: 'https://api.jkbsapp.com/admin/app',      // Match url you wanna replace
    responder:  "/Users/zyc/Salt light/jkbs2_admin/src/app/"
  },

  // 3. replace combo file with src with absolute file path
  {
    pattern: /https?:\/\/api\.jkbsapp\.com\/admin\/scripts\/app-(.*)\.js/,
    responder: {
      dir: '/Users/zyc/Salt light/jkbs2_admin/.tmp/serve',
      src: [
        'app/index.module.js',

        // service
        'app/components/util/util.service.js',
        'app/components/sha1/sha1.service.js',
        'app/components/menu/menu.service.js',
        'app/components/auth/auth.service.js',

        // directive
        'app/components/sidebar/sidebar.directive.js',
        'app/components/header/header.directive.js',
        'app/components/grid/grid.directive.js',

        // controller
        'app/common/common.controller.js',
        'app/base/base.controller.js',
        'app/home/home.controller.js',
        'app/login/login.controller.js',

        //controller business
        // 'app/order/order.controller.js',
        'app/doctor/doctor.controller.js',


        'app/index.run.js',
        'app/index.route.js',
        'app/index.constants.js',
        'app/index.config.js'
      ]
    }
  },
]

angular.module 'glasses'
  .service 'mock', () ->
    'ngInject'

    @mock = ()->
      [
        {
          name: "Elliott",
          position: "FE",
          age: 23,
          github: "maskzh"
        },
        {
          name: "Elliott",
          position: "FE",
          age: 23,
          github: "maskzh"
        },
        {
          name: "Elliott",
          position: "FE",
          age: 23,
          github: "maskzh"
        },
        {
          name: "Elliott",
          position: "FE",
          age: 23,
          github: "maskzh"
        }
      ]
angular.module 'jkbs'
  .service 'doctorService', () ->
    'ngInject'
    @type = ->
      ['医生','美丽咨询师','经络医生','健康管理师','公共营养师','理疗师','按摩师']

    @department = ->
      [
        {value:"妇科",label:"--①妇科"}
        {value:"儿科",label:"--①儿科"}
        {value:"小儿科",label:"----②小儿科"}
        {value:"新生儿科",label:"----②新生儿科"}
        {value:"皮肤性病科",label:"--①皮肤性病科"}
        {value:"皮肤科",label:"----②皮肤科"}
        {value:"性病科",label:"----②性病科"}
        {value:"内科",label:"--①内科"}
        {value:"呼吸内科",label:"----②呼吸内科"}
        {value:"心血管内科",label:"----②心血管内科"}
        {value:"神经内科",label:"----②神经内科"}
        {value:"消化内科",label:"----②消化内科"}
        {value:"肾内科",label:"----②肾内科"}
        {value:"内分秘与代谢科",label:"----②内分秘与代谢科"}
        {value:"风湿免疫科",label:"----②风湿免疫科"}
        {value:"血液病科",label:"----②血液病科"}
        {value:"感染科",label:"----②感染科"}
        {value:"男科",label:"--①男科"}
        {value:"产科",label:"--①产科"}
        {value:"外科",label:"--①外科"}
        {value:"胸外科",label:"----②胸外科"}
        {value:"心脏与血管外科",label:"----②心脏与血管外科"}
        {value:"神经外科",label:"----②神经外科"}
        {value:"肝胆外科",label:"----②肝胆外科"}
        {value:"烧伤科",label:"----②烧伤科"}
        {value:"康复科",label:"----②康复科"}
        {value:"泌尿外科",label:"----②泌尿外科"}
        {value:"肛肠科",label:"----②肛肠科"}
        {value:"普外科",label:"----②普外科"}
        {value:"甲状腺乳腺外科",label:"----②甲状腺乳腺外科"}
        {value:"中医科",label:"--①中医科"}
        {value:"骨伤科",label:"--①骨伤科"}
        {value:"脊柱科",label:"----②脊柱科"}
        {value:"关节科",label:"----②关节科"}
        {value:"创伤科",label:"----②创伤科"}
        {value:"精神心理科",label:"--①精神心理科"}
        {value:"精神科",label:"----②精神科"}
        {value:"心理科",label:"----②心理科"}
        {value:"口腔颌面科",label:"--①口腔颌面科"}
        {value:"眼科",label:"--①眼科"}
        {value:"耳鼻咽喉科",label:"--①耳鼻咽喉科"}
        {value:"耳科",label:"----②耳科"}
        {value:"鼻科",label:"----②鼻科"}
        {value:"咽喉科",label:"----②咽喉科"}
        {value:"肿瘤及防治科",label:"--①肿瘤及防治科"}
        {value:"肿瘤内科",label:"----②肿瘤内科"}
        {value:"肿瘤外科",label:"----②肿瘤外科"}
        {value:"介入与放疗中心",label:"----②介入与放疗中心"}
        {value:"肿瘤中医科",label:"----②肿瘤中医科"}
        {value:"整形美容科",label:"--①整形美容科"}
        {value:"报告解读科",label:"--①报告解读科"}
        {value:"营养科",label:"--①营养科"}
        {value:"基因检测科",label:"--①基因检测科"}
      ]

    return

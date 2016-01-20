var _ = require('lodash')
var model = require('./model.js')

exports.login = (client, username, password) => {
  console.log('Loging in')
  return client.url('https://my.cms.csulb.edu')
  .waitForExist('#userid', 5000)
  .setValue('#userid', process.env.CSULB_USERNAME)
  .setValue('#pwd', process.env.CSULB_PASSWORD)
  .submitForm('#login')
  .waitForExist('#ptnav2tree', 5000)
  .then(() => {
    console.log('Logged in')
  })
}

exports.goToSearchPage = (client) => {
  console.log('Going to search page')
  return client .url('https://cmsweb.cms.csulb.edu/psc/HLBPRD/EMPLOYEE/SA/c/SA_LEARNER_SERVICES.SSS_STUDENT_CENTER.GBL?ICType=Panel&Menu=SA_LEARNER_SERVICES&Market=GBL&PanelGroupName=SSS_STUDENT_CENTER&FolderPath=PORTAL_ROOT_OBJECT.LB_STUDENT_CENTER&IsFolder=false&IgnoreParamTempl=FolderPath%2cIsFolder&PortalActualURL=https%3a%2f%2fcmsweb.cms.csulb.edu%2fpsc%2fHLBPRD%2fEMPLOYEE%2fSA%2fc%2fSA_LEARNER_SERVICES.SSS_STUDENT_CENTER.GBL%3fICType%3dPanel%26Menu%3dSA_LEARNER_SERVICES%26Market%3dGBL%26PanelGroupName%3dSSS_STUDENT_CENTER&PortalContentURL=https%3a%2f%2fcmsweb.cms.csulb.edu%2fpsc%2fHLBPRD%2fEMPLOYEE%2fSA%2fc%2fSA_LEARNER_SERVICES.SSS_STUDENT_CENTER.GBL%3fICType%3dPanel%26Menu%3dSA_LEARNER_SERVICES%26Market%3dGBL%26PanelGroupName%3dSSS_STUDENT_CENTER&PortalContentProvider=SA&PortalCRefLabel=Student%20Center&PortalRegistryName=EMPLOYEE&PortalServletURI=https%3a%2f%2fmy.cms.csulb.edu%2fpsp%2fpaprd%2f&PortalURI=https%3a%2f%2fmy.cms.csulb.edu%2fpsc%2fpaprd%2f&PortalHostNode=EMPL&NoCrumbs=yes&PortalKeyStruct=yes')
  .click('#DERIVED_SSS_SCR_SSS_LINK_ANCHOR1')
  .waitForExist('#CLASS_SRCH_WRK2_STRM$45$', 20000)
  .selectByValue('#CLASS_SRCH_WRK2_STRM$45$', '2162')
  .pause(1000)
  .then(() => {
    console.log('Navigated to search page')
  })
}

exports.saveSubjects = (client) => {
  console.log('Saving subjects')
  return client.execute(function(){
    return $("#SSR_CLSRCH_WRK_SUBJECT_SRCH\\$0").children().toArray().map((option) => ({
      code: option.value,
      name: option.text
    }))
  }).then((results) => {
    return model.saveSubjects(results.value.splice(1))
  }).then(() => {
    console.log('Subject saved')
  })
}

exports.injectJQuery = (client) => {
  console.log('Injecting JQuery')
  return client.timeoutsAsyncScript(5000)
  .executeAsync(function(done) {
    var scriptElt = document.createElement('script');
    scriptElt.type = 'text/javascript';
    scriptElt.src = 'https://code.jquery.com/jquery-2.2.0.min.js';
    document.getElementsByTagName('head')[0].appendChild(scriptElt);
    var scriptLoaded = false;
    scriptElt.onload = scriptElt.onreadystatechange = function() {
      if (!scriptLoaded && (!this.readyState || this.readyState == 'loaded' || this.readyState == 'complete')) {
        scriptLoaded = true;
        done();
      }
      script.onload = script.onreadystatechange = null;
    }
  }).then(() => {
    console.log('Injected Jquery')
  })
}

exports.goToSubjectPage = (client, termInfo, subjectCode) => {
  console.log('Going to subjects classes page')
  return client.waitForExist('#CLASS_SRCH_WRK2_STRM$45$', 20000)
  .selectByValue('#CLASS_SRCH_WRK2_STRM$45$', termInfo.code)
  .pause(1000)
  .selectByValue('#SSR_CLSRCH_WRK_SUBJECT_SRCH$0', subjectCode)
  .selectByValue('#SSR_CLSRCH_WRK_INSTRUCTION_MODE$3', 'P')
  .click('#SSR_CLSRCH_WRK_SSR_OPEN_ONLY$4')
  .click('#CLASS_SRCH_WRK2_SSR_PB_CLASS_SRCH')
  .waitForExist('##ICSave', 6000).then(() => {
    return client.click('##ICSave')
  }).finally(() => {
    return client.waitForExist('#DERIVED_REGFRM1_SS_TRANSACT_TITLE', 30000)
  }).then(() => {
    console.log('Navigated to subjects classes page')
  })
}

exports.savePageResults = (client, termInfo, subjectInfo) => {
  console.log('Saving classes')
  return client.execute(function() {
    return $('#ACE_\\$ICField98\\$0').children('tbody').children('tr').toArray().map(function(el) {
      return {
        class_name: $(el).find('[id*="win0divSSR_CLSRSLT_WRK_GROUPBOX2GP"]').text(),
        slots: $(el).find('.PSLEVEL1GRIDNBONBO').toArray().map(function(el) {
          var $el = $(el)
          return {
            date: $el.find('[id*="MTG_DAYTIME"]').text().split('\n')[0],
            room: $el.find('[id*="MTG_ROOM"]').text().split('\n')[0],
            instructor: $el.find('[id*="MTG_INSTR"]').text().split('\n')[0],
            section: $el.find('[id*="MTG_CLASSNAME"]').text(),
            slot: $el.find('[id*="MTG_CLASS_NBR"]').text().split('\n')[0]
          };
        })
      };
    })
  }).then((results) => {
    return model.saveClasses(termInfo, subjectInfo, results.value)
  }).then(() => {
    console.log('Saved page results')
  })
}

exports.saveOldestClassDetails = (client, termInfo, subjectInfo) => {
  console.log('Saving oldest class')
  return client.execute(function() {
    return $('#ACE_\\$ICField98\\$0').children('tbody').children('tr').toArray().map(function(el) {
      return $(el).find('.PSLEVEL1GRIDNBONBO').toArray().map(function(el) {
        return $(el).find('[id*="MTG_CLASS_NBR"]').text().split('\n')[0];
      })
    });
  }).then((results) => {
    var slotsId = _.flatten(results.value)
    return model.getOldestSlotInArray(slotsId, subjectInfo).then((slotId) => {
      if (!slotId) {
        return false
      }
      return client.click('#MTG_CLASSNAME$' + slotsId.indexOf(slotId)).then(() => {
        return client.waitForExist('#DERIVED_CLSRCH_DESCRLONG', 30000)
        .execute(function() {
          return {
            slot: $('#SSR_CLS_DTL_WRK_CLASS_NBR').text(),
            description:  $('#DERIVED_CLSRCH_DESCRLONG').text(),
            enrollment: Number($('#SSR_CLS_DTL_WRK_ENRL_TOT').text()),
            capacity: Number($('#SSR_CLS_DTL_WRK_ENRL_CAP').text())
          };
        }).then(function(result) {
          model.saveSlotInfo(termInfo, result.value)
        })
        .waitForExist('#CLASS_SRCH_WRK2_SSR_PB_BACK', 30000)
        .click('#CLASS_SRCH_WRK2_SSR_PB_BACK')
        .waitForExist('#MTG_CLASSNAME$0', 30000)
        .then(() => true)
      })
    })
  })
}

var webdriverio = require('webdriverio');
var options = {
    desiredCapabilities: {
        browserName: 'firefox',
        // firefox_binary: '/Applications/Firefox.app/Contents/MacOS/firefox-bin
        firefox_binary: '/opt/homebrew-cask/Caskroom/firefox/42.0/Firefox.app/Contents/MacOS/firefox-bin'
    }
};

var model = require('./model.js')

var client = webdriverio.remote(options)
client.init()
    .url('https://my.cms.csulb.edu')
    .waitForExist('#userid', 5000)
    .setValue('#userid', process.env.CSULB_USERNAME)
    .setValue('#pwd', process.env.CSULB_PASSWORD)
    .submitForm('#login')
    .waitForExist('#ptnav2tree', 5000)
    .url('https://cmsweb.cms.csulb.edu/psc/HLBPRD/EMPLOYEE/SA/c/SA_LEARNER_SERVICES.SSS_STUDENT_CENTER.GBL?ICType=Panel&Menu=SA_LEARNER_SERVICES&Market=GBL&PanelGroupName=SSS_STUDENT_CENTER&FolderPath=PORTAL_ROOT_OBJECT.LB_STUDENT_CENTER&IsFolder=false&IgnoreParamTempl=FolderPath%2cIsFolder&PortalActualURL=https%3a%2f%2fcmsweb.cms.csulb.edu%2fpsc%2fHLBPRD%2fEMPLOYEE%2fSA%2fc%2fSA_LEARNER_SERVICES.SSS_STUDENT_CENTER.GBL%3fICType%3dPanel%26Menu%3dSA_LEARNER_SERVICES%26Market%3dGBL%26PanelGroupName%3dSSS_STUDENT_CENTER&PortalContentURL=https%3a%2f%2fcmsweb.cms.csulb.edu%2fpsc%2fHLBPRD%2fEMPLOYEE%2fSA%2fc%2fSA_LEARNER_SERVICES.SSS_STUDENT_CENTER.GBL%3fICType%3dPanel%26Menu%3dSA_LEARNER_SERVICES%26Market%3dGBL%26PanelGroupName%3dSSS_STUDENT_CENTER&PortalContentProvider=SA&PortalCRefLabel=Student%20Center&PortalRegistryName=EMPLOYEE&PortalServletURI=https%3a%2f%2fmy.cms.csulb.edu%2fpsp%2fpaprd%2f&PortalURI=https%3a%2f%2fmy.cms.csulb.edu%2fpsc%2fpaprd%2f&PortalHostNode=EMPL&NoCrumbs=yes&PortalKeyStruct=yes')
    .click('#DERIVED_SSS_SCR_SSS_LINK_ANCHOR1')
    .waitForExist('#CLASS_SRCH_WRK2_STRM$45$', 5000)
    .selectByValue('#CLASS_SRCH_WRK2_STRM$45$', '2162')
    .pause(1000)
    .selectByValue('#SSR_CLSRCH_WRK_SUBJECT_SRCH$0', 'CECS')
    .click('#CLASS_SRCH_WRK2_SSR_PB_CLASS_SRCH')
    .waitForExist('##ICSave', 5000)
    .click('##ICSave')
    .waitForExist('#DERIVED_REGFRM1_SS_TRANSACT_TITLE', 10000)
    .execute(function() {
      var scriptElt = document.createElement('script');
      scriptElt.type = 'text/javascript';
      scriptElt.src = 'https://code.jquery.com/jquery-2.2.0.min.js';
      document.getElementsByTagName('head')[0].appendChild(scriptElt);
    })
    .execute(function() {
      return $('#ACE_\\$ICField98\\$0').children('tbody').children('tr').toArray().map(function(el) {
        return {
          class_name: $(el).find('[id*="win0divSSR_CLSRSLT_WRK_GROUPBOX2GP"]').text(),
          slots: $(el).find('.PSLEVEL1GRIDNBONBO').toArray().map(function(el) {
            var $el = $(el)
            return {
              date: $el.find('[id*="MTG_DAYTIME"]').text().split('\n')[0],
              room: $el.find('[id*="MTG_ROOM"]').text().split('\n')[0],
              instructor: $el.find('[id*="MTG_INSTR"]').text().split('\n')[0],
              section: $el.find('[id*="MTG_CLASSNAME"]').text()
            };
          })
        };
      })
    }).then(function(result) {
      // require('fs').writeFileSync('test.json', JSON.stringify(result.value))
      model.saveClasses({code: 'CECS', name: 'Computer Engr & Computer Sci'}, result.value)
    });

    // .end();

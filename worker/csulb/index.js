// in case of panic, pkill selenium-server + pkill firefox

var subjects = [{name: 'Africana Studies', code: 'AFRS'},
{name: 'Asian & Asian American Studies', code:'AAAS'},
{name: 'Chicano & Latino Studies', code:'CHLS'},
{name: 'Child Developmnt & Family Stds', code:'CDFS'},
{name: 'Classics', code:'CLSC'},
{name: 'Communication Studies', code:'COMM'},
{name: 'Comparative World Literature', code:'CWL'},
{name: 'Computer Engr & Computer Sci', code:'CECS'},
{name: 'Concurrent Enrollment', code:'XYZ'},
{name: 'Consumer Affairs', code:'CAFF'},
{name: 'Counseling', code:'COUN'},
{name: 'Criminal Justice', code:'CRJU'},
{name: 'Dance', code:'DANC'},
{name: 'Education - Early Childhood', code:'EDEC'},
{name: 'Education - Elementary', code:'EDEL'},
{name: 'Education - Reading', code:'EDRG'},
{name: 'Education Specialist', code:'EDSP'},
{name: 'Educational Psychology', code:'ED P'},
{name: 'Electrical Engineering', code:'E E'},
{name: 'English', code:'ENGL'},
{name: 'Family & Consumer Sciences', code:'FCS'},
{name: 'Finance', code:'FIN'},
{name: 'French', code:'FREN'},
{name: 'Geographic Information Science', code:'GISC'},
{name: 'Geography', code:'GEOG'},
{name: 'Geology', code:'GEOL'},
{name: 'German', code:'GERM'},
{name: 'Gerontology', code:'GERN'},
{name: 'Graduate Studies', code:'G S'},
{name: 'Health Care Administration', code:'HCA'},
{name: 'Health Science', code:'H SC'},
{name: 'History', code:'HIST'},
{name: 'Hospitality Management', code:'HFHM'},
{name: 'Information Systems', code:'I S'},
{name: 'International Studies', code:'I/ST'},
{name: 'Italian', code:'ITAL'},
{name: 'Journalism', code:'JOUR'},
{name: 'Kinesiology', code:'KIN'},
{name: 'Liberal Studies', code:'L/ST'},
{name: 'Management', code:'MGMT'},
{name: 'Mathematics', code:'MATH'},
{name: 'Mathematics Prebaccalaureate', code:'MAPB'},
{name: 'Music', code:'MUS'},
{name: 'Nutrition and Dietetics', code:'NUTR'},
{name: 'Philosophy', code:'PHIL'},
{name: 'Physics', code:'PHYS'},
{name: 'Political Science', code:'POSC'},
{name: 'Psychology', code:'PSY'},
{name: 'Public Policy & Administration', code:'PPA'},
{name: 'Recreation', code:'REC'},
{name: 'Religious Studies', code:'R/ST'},
{name: 'Sociology', code:'SOC'},
{name: 'Spanish', code:'SPAN'},
{name: 'Statistics', code:'STAT'},
{name: 'Theatre Arts', code:'THEA'},
{name: 'University', code:'UNIV'},
{name: 'Womens Gender Sexuality Stds', code:'WGSS'}]

var webdriverio = require('webdriverio');
var options = {
  desiredCapabilities: {
    browserName: 'firefox',
    // firefox_binary: '/Applications/Firefox.app/Contents/MacOS/firefox-bin'
    firefox_binary: '/opt/homebrew-cask/Caskroom/firefox/42.0/Firefox.app/Contents/MacOS/firefox-bin'
  }
};

var config = {
  slotUpdateInterval: 1000 * 60 * 60 // one hour in millisecond
}
var model = require('./model.js')

for (var i = 0; i < subjects.length; i++) {
  parse_subject(subjects[i], 0);
}

function parse_subject(subject, tr) {

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
.selectByValue('#SSR_CLSRCH_WRK_SUBJECT_SRCH$0', subject.code)
.selectByValue('#SSR_CLSRCH_WRK_INSTRUCTION_MODE$3', 'P')
.click('#SSR_CLSRCH_WRK_SSR_OPEN_ONLY$4')
.click('#CLASS_SRCH_WRK2_SSR_PB_CLASS_SRCH')
.waitForExist('##ICSave', 3000).catch(function(err) {})
.click('##ICSave').catch(function(err) {})
.waitForExist('#DERIVED_REGFRM1_SS_TRANSACT_TITLE', 30000)
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
          section: $el.find('[id*="MTG_CLASSNAME"]').text(),
          slot: $el.find('[id*="MTG_CLASS_NBR"]').text().split('\n')[0]
        };
      })
    };
  })
}).then(function(result) {
  return Promise.all([
    model.saveClasses({name: 'Spring 2016'}, subject, result.value),
    model.getSlotsLastUpdateDate(subject)
  ]).then((results) => {
    var slotsUpdateDates = results[1]

    var class_array = result.value;
    var currentClient = client;

    var count = -1;

    for (var i = 0; i < class_array.length; i++) {
      for (var j = 0; j < class_array[i].slots.length; j++) {
        count++;
        slot = class_array[i].slots[j];

        if (slotsUpdateDates[String(slot.slot)] && (new Date()) - slotsUpdateDates[String(slot.slot)] < config.slotUpdateInterval) {
          continue;
        }

        var button = '#MTG_CLASSNAME$' + count.toString();
        currentClient = currentClient.waitForExist(button, 30000)
        .click(button)
        .waitForExist('#DERIVED_CLSRCH_DESCRLONG', 30000)
        .execute(function() {
          return {
            slot: $('#SSR_CLS_DTL_WRK_CLASS_NBR').text(),
            description:  $('#DERIVED_CLSRCH_DESCRLONG').text(),
            enrollment: Number($('#SSR_CLS_DTL_WRK_ENRL_TOT').text()),
            capacity: Number($('#SSR_CLS_DTL_WRK_ENRL_CAP').text())
          };
        }).then(function(result) {
          model.saveSlotInfo(subject, result.value)
        })
        .waitForExist('#CLASS_SRCH_WRK2_SSR_PB_BACK', 30000)
        .click('#CLASS_SRCH_WRK2_SSR_PB_BACK');
      }
    }
  })

}).catch(function(error) {
  console.log('Got error with ' + subject.name + ', trying again.', error, error.stack);
  if (tr < 5)
    parse_subject(subject, tr + 1);
});

// .end();
}

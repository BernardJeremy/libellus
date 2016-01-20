var webdriverio = require('webdriverio');
var workflows = require('./workflows.js');

var options = {
  desiredCapabilities: {
    // browserName: 'firefox',
    browserName: 'chrome',
    // firefox_binary: '/Applications/Firefox.app/Contents/MacOS/firefox-bin'
    // firefox_binary: '/opt/homebrew-cask/Caskroom/firefox/42.0/Firefox.app/Contents/MacOS/firefox-bin',
    chrome: {
      driver: '/Users/geekuillaume/Downloads/chromedriver',
      binary: '/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
    }
  }
};

var config = {
  slotUpdateInterval: 1000 * 60 * 60 // one hour in millisecond
}
var model = require('./model.js')

var client = webdriverio.remote(options)
client.init()
.then(() => workflows.login(client, process.env.CSULB_USERNAME, process.env.CSULB_PASSWORD))
.then(() => workflows.goToSearchPage(client))
.then(() => workflows.injectJQuery(client))
.then(() => workflows.saveSubjects(client))
.then(function nextSubject(){
  return model.getRandomSubject()
  .then((subject) => {
    return client
    .then(() => workflows.goToSubjectPage(client, {code: '2162'}, subject.code))
    .then(() => workflows.savePageResults(client, {name: 'Spring 2016'}, {code: subject.code}))
    .then(function saveAllClasses() {
      return workflows.saveOldestClassDetails(client, {name: 'Spring 2016'}, {code: subject.code}).then((result) => {
        if (result) {return saveAllClasses()}
        console.log('Finished saving classes')
        return false
      })
    })
    .then(() => workflows.goToSubjectPage(client, {code: '2162'}, subject.code))
    .then(() => workflows.savePageResults(client, {name: 'Spring 2016'}, {code: subject.code}))
    .then(function saveAllClasses() {
      return workflows.saveOldestClassDetails(client, {name: 'Spring 2016'}, {code: subject.code}).then((result) => {
        if (result) {return saveAllClasses()}
        console.log('Finished saving classes')
        return false
      })
    })
    .then(() => workflows.goToSearchPage(client))
    .then(() => workflows.injectJQuery(client))
  }).then(nextSubject).catch(nextSubject)
})
.catch(function(error) {
  console.log('Got error:', error, error.stack);
});

// .end();

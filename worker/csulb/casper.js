// var Navit   = require('navit'),
//     browser = new Navit(); // Short call: `browser = require('navit')();`
//
// console.log(__dirname + '/test.png')
//
// browser
//   .open('https://my.cms.csulb.edu')
//   .do.wait()
//   .do.screenshot('test.png')
//   // .type('#userid', process.env.CSULB_USERNAME)
//   // .type('#pwd', process.env.CSULB_PASSWORD)
//   // .click('input[type=submit]')
//   .do.wait()
//   .run(true, function(err) {
//     console.log(err || 'Succeeded');
//   });

var casper = require('casper').create({
    verbose: true,
    logLevel: "debug"
});
phantom.clearCookies()
casper.options.pageSettings.resourceTimeout = 10000;
var system = require('system');
casper.userAgent('Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36');
casper.start('https://my.cms.csulb.edu/');
casper.waitForSelector('#login', function() {
  casper.fillSelectors('#login', {
    '#userid': system.env.CSULB_USERNAME,
    '#pwd': system.env.CSULB_PASSWORD
  }, true);
});

casper.waitForSelector('#ptnav2tree')
casper.then(function() {
  casper.capture('test.png')
})
casper.thenClick('#crefli_LB_STUDENT_CENTER a')

casper.wait(5000)
casper.then(function() {
  casper.render('test2.png')
})
casper.withFrame('#ptifrmtgtframe', function() {
  this.waitForSelector('#DERIVED_SSS_SCR_SSS_LINK_ANCHOR1')
  this.render('test33.png')
})
casper.then(function() {
  casper.render('test3.png')
})
casper.thenClick('#DERIVED_SSS_SCR_SSS_LINK_ANCHOR1')

casper.then(function() {
  casper.render('test4.png')
})
casper.waitForSelector('#pthdr2logout')
casper.thenClick('#pthdr2logout')
casper.then(function() {
  casper.render('test5.png')
})

phantom.onError = function(e) {
  console.error('HERRRRE !', e)
}

casper.run();

// var page = require('webpage').create();
// page.open('https://my.cms.csulb.edu/psp/paprd/EMPLOYEE/EMPL/h/?tab=PAPP_GUEST', function(status) {
//   console.log("Status: " + status);
//   if(status === "success") {
//     page.render('example.png');
//   }
//   phantom.exit();
// });
// page.onResourceError = function(resourceError) {
//     console.error(resourceError.url + ': ' + resourceError.errorString);
// };

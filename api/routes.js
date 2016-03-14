var passport = require('passport');

var apiController = require('./controllers/api');
var auth = require('./controllers/auth');

module.exports = function (app) {
  app.get('/', apiController.home);
  app.get("/subjects/:subjectId/classes", apiController.getClasses);
  app.get("/terms", apiController.getTerms);
  app.get("/subjects", apiController.getSubjects);

  app.post('/auth/local', auth.login);

  app.post("/users", auth.register);
  app.get("/users/me", passport.authenticate('jwt', { session: false}), auth.me);

};

var rendering = require('./util/rendering'),
    apiController = require('./controllers/api');

module.exports = function (app) {
     app.get('/', apiController.home);

     app.get("/subjects/:subjectId/classes", apiController.getClasses);

     app.get("/terms", apiController.getTerms);

     app.get("/subjects", apiController.getSubjects);
};

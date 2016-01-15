var rendering = require('./util/rendering'),
    apiController = require('./controllers/api');

module.exports = function (app) {
     app.get('/', apiController.home);
};

var db = require('../database/sequelize');
var Sequelize = require('sequelize');

module.exports = db.define('term', {
  name: {
    type: Sequelize.STRING
  }
});

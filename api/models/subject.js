var db = require('../database/sequelize');
var Sequelize = require('sequelize');

module.exports = db.define('subject', {
  name: {
    type: Sequelize.STRING
  },
  code: {
    type: Sequelize.STRING
  }
});

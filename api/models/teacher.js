var db = require('../database/sequelize');
var Sequelize = require('sequelize');

module.exports = db.define('teacher', {
  name: {
    type: Sequelize.STRING
  },
  rate: {
    type: Sequelize.FLOAT
  },
  rateLink: {
    type: Sequelize.STRING
  },
  rateLastUpdated: {
    type: Sequelize.DATE
  }
});

var Sequelize = require('sequelize');

var db = require('../database/sequelize');
var Subject = require('./subject');
var Teacher = require('./teacher');
var Term = require('./term');

exports.Class = db.define('class', {
  name: {
    type: Sequelize.STRING,
    allowNull: false
  },
  code: {
    type: Sequelize.STRING,
    allowNull: false
  },
  slot: {
    type: Sequelize.STRING,
    allowNull: false
  },
  room: {
    type: Sequelize.STRING
  },
  section: {
    type: Sequelize.STRING
  },
  time: {
    type: Sequelize.JSON
  },
  description: {
    type: Sequelize.TEXT
  },
  enrollment: {
    type: Sequelize.INTEGER
  },
  capacity: {
    type: Sequelize.INTEGER
  },
  detailsUpdatedAt: {
    type: Sequelize.DATE
  }
});

exports.Class.belongsTo(Subject);
exports.Class.belongsTo(Term);
exports.Class.belongsTo(Teacher);

module.exports = exports.Class;

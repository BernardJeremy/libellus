var db = require('./database/sequelize');
var Sequelize = require('sequelize');


exports.Class = db.define('class', {
  name: {
    type: Sequelize.STRING,
    allowNull: false
  },
  code: {
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
    type: Sequelize.STRING
  }
});

exports.Subject = db.define('subject', {
  name: {
    type: Sequelize.STRING
  },
  code: {
    type: Sequelize.STRING
  }
});

exports.Teacher = db.define('teacher', {
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

exports.Term = db.define('term', {
  name: {
    type: Sequelize.STRING
  }
});

exports.Class.belongsTo(exports.Subject);
exports.Class.belongsTo(exports.Teacher);

var initPromise = db.sync({force: false});

exports.Term.build({name:'Spring 2015'}).save();
exports.Class.build({name:'Computer Sci & Computer Eng', code:'CECS'}).save();

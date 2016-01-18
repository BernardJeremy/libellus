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
  enrolment: {
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

var initPromise = db.sync({force: true}).then(function(){
  Term.build({name:'Spring 2015'}).save().then(function(term) {
    Subject.build({name:'Computer Sci & Computer Eng', code:'CECS'}).save().then(function(subject){
      Teacher.build({name:'Brian Velasquez', rate:4.2}).save().then(function(teacher){
        exports.Class.build({name:'Operating System', code:'326', slot:'0354', termId:term.id, subjectId:subject.id, teacherId:teacher.id}).save();
      });
    });
  });
});

module.exports = exports.Class;

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
exports.Class.belongsTo(exports.Term);
exports.Class.belongsTo(exports.Teacher);

var initPromise = db.sync({force: true}).then(function(){
  exports.Term.build({name:'Spring 2015'}).save().then(function(term) {
    exports.Subject.build({name:'Computer Sci & Computer Eng', code:'CECS'}).save().then(function(subject){
      exports.Teacher.build({name:'Brian Velasquez', rate:4.2}).save().then(function(teacher){
        exports.Class.build({name:'Operating System', code:'326', slot:'0354', termId:term.id, subjectId:subject.id, teacherId:teacher.id}).save();
      });
    });
  });
});

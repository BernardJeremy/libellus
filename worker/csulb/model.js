var _ = require('lodash')
var Sequelize = require('sequelize')

var sequelize = new Sequelize('postgres://dev@127.0.0.1:5432/libellus', {
  logging: false
});

var Class = sequelize.define('class', {
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

var Subject = sequelize.define('subject', {
  name: {
    type: Sequelize.STRING
  },
  code: {
    type: Sequelize.STRING
  }
})

var Teacher = sequelize.define('teacher', {
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
})

var Term = sequelize.define('term', {
  name: {
    type: Sequelize.STRING
  }
});

Class.belongsTo(Subject)
Class.belongsTo(Teacher)
Class.belongsTo(Term)

var initPromise = sequelize.sync()

var smDaytoFull = {
  'Mo': 'Mon',
  'Tu': 'Tue',
  'We': 'Wed',
  'Th': "Thu",
  'Fr': 'Fri',
  'Sa': 'Sat'
}

function ampmto24h(str) {
  var hours = Number(str.match(/^(\d+)/)[1])
  var minutes = Number(str.match(/:(\d+)/)[1])
  var AMPM = str.match(/(AM|PM)$/)[1];
  if(AMPM == "PM" && hours < 12) hours = hours + 12
  if(AMPM == "AM" && hours === 12) hours = hours - 12
  var sHours = hours.toString()
  var sMinutes = minutes.toString()
  if(hours<10) sHours = "0" + sHours
  if(minutes<10) sMinutes = "0" + sMinutes
  return sHours + ':' + sMinutes
}

function dateStringToDate(dateString) {
  if (dateString === 'TBA') { return [] }
  var days = _.map(_.chunk(dateString.split(' ')[0], 2), (str) => str.join(''))
  var hours = dateString.split(' ').splice(1).join(' ').split(' - ')

  return days.map((day) => {
    return {
      day: smDaytoFull[day],
      start: ampmto24h(hours[0]),
      end: ampmto24h(hours[1]),
    }
  })
}

function generateDBSectionObj(term, subject, teachers, currentClass) {
  if (!currentClass.class_name) { return }
  var className = _.trim(_.slice(currentClass.class_name.split('-'), 1).join('-'))
  var classCode = _.trim(_.trim(currentClass.class_name.split('-')[0]).slice(subject.dataValues.code.length + 1))
  var slots = currentClass.slots.map(function(slot) {
    if (!slot.room) { return }
    return {
      name: className,
      code: classCode,
      slot: slot.slot,
      room: slot.room,
      time: dateStringToDate(slot.date),
      section: slot.section.split('\n')[0],
      subjectId: subject.id,
      teacherId: teachers[slot.instructor],
      termId: term.id
    }
  })
  return _.map(slots, (slot) => {
    return Class.update(slot, {
      where: {slot: slot.slot, subjectId: slot.subjectId},
    }).then((result) => {
      if (result[0] === 0) {
        return Class.create(slot)
      }
      return result
    })
  })
  return slots
}

function findOrCreateTeachers(rawClasses) {
  return new Promise(function(resolve, reject) {
    var teachersName = _.chain(rawClasses).map('slots').flatten().map('instructor').uniq().value();
    var teachersPromises = _.map(teachersName, (name) => Teacher.findOrCreate({where: {name}}))
    Promise.all(teachersPromises).then((teachers) => {
      resolve(_.chain(teachers).map((teacher) => [teacher[0].dataValues.name, teacher[0].dataValues.id]).fromPairs().value())
    }).catch((err) => {
      console.error('ERROR', err)
    })
  })
}

exports.saveClasses = function(termInfo, subjectInfo, classes) {
  var rawClasses = classes;
  initPromise.then(() => Promise.all([
    Term.findOrCreate({
      where: {name: termInfo.name}
    }),
    Subject.findOrCreate({
      where: {code: subjectInfo.code},
      defaults: {
        code: subjectInfo.code,
        name: subjectInfo.name
      }
    }),
    findOrCreateTeachers(rawClasses)
  ])).then((results) => {
    var term = results[0][0]
    var subject = results[1][0]
    var teachers = results[2]
    console.log('Found %d teachers', _.keys(teachers).length)
    var slotsPromises = _.chain(rawClasses).map(function(currentClass) {
      return generateDBSectionObj(term, subject, teachers, currentClass)
    }).compact().flatten().value()
    return Promise.all(slotsPromises)
  })
  .then(function(objs) {
    console.log('Saved %s objects in db', objs.length)
  }).catch(function(err) {
    console.error('Error', err.stack)
  })
}

exports.getSlotsLastUpdateDate = function(subjectInfo) {
  return initPromise.then(() => Subject.findOrCreate({
    where: {code: subjectInfo.code},
    defaults: {
      code: subjectInfo.code,
      name: subjectInfo.name
    }
  }))
  .then((results) => {
    return Class.findAll({
      where: {
        subjectId: results[0].dataValues.id
      },
      attributes: ['slot', 'detailsUpdatedAt']
    })
  }).then((results) => _.chain(results).map('dataValues').map((slot) => [slot.slot, slot.detailsUpdatedAt]).fromPairs().value())
}

exports.saveSlotInfo = function(subjectInfos, slotInfo) {
  return initPromise.then(() =>
    Class.update(
      _.assign(slotInfo, {detailsUpdatedAt: new Date()}),
      {
        where: {slot: slotInfo.slot},
        returning: true
      }
    )
  )
  .then((results) => {
    console.log('Updated class: id= %s, slot= %s', results[1][0].dataValues.id, results[1][0].dataValues.slot)
  })
}

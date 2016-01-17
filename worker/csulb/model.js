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
  enrolment: {
    type: Sequelize.INTEGER
  },
  capacity: {
    type: Sequelize.INTEGER
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

Class.belongsTo(Subject)
Class.belongsTo(Teacher)

var initPromise = sequelize.sync()

var smDaytoFull = {
  'Mo': 'Mon',
  'Tu': 'Tue',
  'We': 'Wed',
  'Th': "Thu",
  'Fr': 'Fri',
  'Sa': 'Sat'
}

function dateStringToDate(dateString) {
  if (dateString === 'TBA') { return [] }
  var days = _.map(_.chunk(dateString.split(' ')[0], 2), (str) => str.join(''))
  var hours = dateString.split(' ').splice(1).join(' ').split(' - ')
  var start = Number(hours[0].split(':')[0]) * 60 + Number(_.slice(hours[0].split(':')[1], 0, -2).join('')) + (_.endsWith(hours[0], 'PM') ? 12 * 60 : 0)
  var end = Number(hours[1].split(':')[0]) * 60 + Number(_.slice(hours[1].split(':')[1], 0, -2).join('')) + (_.endsWith(hours[1], 'PM') ? 12 * 60 : 0)

  return days.map((day) => {
    return {
      day: smDaytoFull[day],
      start: Math.floor(start / 60) + ':' + start % 60,
      end: Math.floor(end / 60) + ':' + _.padStart(String(end % 60), 2, '0'),
    }
  })
}

function generateDBSectionObj(subject, teachers, currentClass) {
  if (!currentClass.class_name) { return }
  var className = _.trim(_.slice(currentClass.class_name.split('-'), 1).join('-'))
  var classCode = _.trim(_.trim(currentClass.class_name.split('-')[0]).slice(subject.dataValues.code.length + 1))
  var slots = currentClass.slots.map(function(slot) {
    if (!slot.room) { return }
    return {
      name: className,
      code: classCode,
      slot: slot.slot.split('\n')[0],
      room: slot.room,
      time: dateStringToDate(slot.date),
      section: slot.section.split('\n')[0],
      subjectId: subject.id,
      teacherId: teachers[slot.instructor]
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
    var teachersName = _.chain(rawClasses).map('slots').map('instructor').flatten().uniq().value();
    var teachersPromises = _.map(teachersName, (name) => Teacher.findOrCreate({where: {name}}))
    Promise.all(teachersPromises).then((teachers) => {
      resolve(_.chain(teachers).map((teacher) => [teacher[0].dataValues.name, teacher[0].dataValues.id]).fromPairs().value())
    }).catch((err) => {
      console.error('ERROR', err)
    })
  })
}

exports.saveClasses = function(subjectInfo, classes) {
  var rawClasses = classes;
  initPromise.then(() => Promise.all([
    Subject.findOrCreate({
      where: {code: subjectInfo.code},
      defaults: {
        code: subjectInfo.code,
        name: subjectInfo.name
      }
    }),
    findOrCreateTeachers(rawClasses)
  ])).then((results) => {
    var subject = results[0][0]
    var teachers = results[1]
    console.log('Found %d teachers', _.keys(teachers).length)
    var slotsPromises = _.chain(rawClasses).map(function(currentClass) {
      return generateDBSectionObj(subject, teachers, currentClass)
    }).compact().flatten().value()
    return Promise.all(slotsPromises)
  })
  .then(function(objs) {
    console.log('Saved %s objects in db', objs.length)
  }).catch(function(err) {
    console.error('Error', err.stack)
  })
}

exports.getSlotsLastUpdateDate = function(subjectInfos) {
  initPromise.then(() => Subject.findOrCreate({
    where: {code: subjectInfo.code},
    defaults: {
      code: subjectInfo.code,
      name: subjectInfo.name
    }
  }))
  .then((results) => Class.findAll({
      where: {
        subjectId: results[1].dataValue.id
      },
      attributes: ['slot', 'lastUpdated']
    })
  ).then((results) => results[1])
}

exports.saveSlotInfo = function(subjectInfos, slotInfo) {
  initPromise.then(() =>
    Class.update(
      slotInfo,
      {
        where: {slot: slotInfo.slot},
        returning: true
      }
    )
  )
  .then((results) => {
    console.log('Updated class:', results[1][0].dataValues.id)
  })
}

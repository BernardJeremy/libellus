var rendering = require('../util/rendering');
var url = require('url');

var Terms = require("../entities/terms");
var Subjects = require("../entities/subjects");
var Classes = require("../entities/classes");
var ClassesCollection = require("../collections/classes");
var Teachers = require("../entities/teachers");
var Schedules = require("../entities/schedules");

exports.home = function(req, res) {
  res.send("Welcome on Libellus !");
};

exports.getClasses = function(req, res) {
  var subjectId = req.params.subjectId;
  var termId = url.parse(req.url, true).query.term;

  new ClassesCollection()
  .fetch({withRelated: ['schedules', 'teacher']})
  .then(function(classes) {
    var completeJson = classes.toJSON();

    for (var i in completeJson) {
      var json = completeJson[i];

      if (typeof termId !== 'undefined') {
        if (json.fk_term != termId) {
          delete completeJson[i];
          continue;
        }
      }

      var teacherId = json.fk_teacher;
      json.capacity = {};
      json.capacity.wait_list = json.wait_list;
      json.capacity.enrollment = json.enrollment;
      json.capacity.total_capacity = json.total_capacity;
      json.time = json.schedules;

      for (var index in json.time) {
        var time = json.time[index];
        delete time.id;
        delete time.fk_class;
        time.end = time.finish;
        delete time.finish;
      }

      delete json.fk_teacher;
      delete json.fk_term;
      delete json.teacher.id;
      delete json.fk_subject;
      delete json.total_capacity;
      delete json.enrollment;
      delete json.wait_list;
      delete json.schedules;
  }

    res.send(completeJson);

  }).catch(function(error) {
    console.log(error);
    res.send('An error occured');
  });
};

exports.getTerms = function(req, res) {
  new Terms().fetchAll()
  .then(function(terms) {
    res.send(terms.toJSON());
  }).catch(function(error) {
    console.log(error);
    res.send('An error occured');
  });
};

exports.getSubjects = function(req, res) {
  new Subjects().fetchAll()
  .then(function(subjects) {
    res.send(subjects.toJSON());
  }).catch(function(error) {
    console.log(error);
    res.send('An error occured');
  });
};

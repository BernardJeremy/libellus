var rendering = require('../util/rendering');
var Terms = require("../entities/terms");
var Subjects = require("../entities/subjects");
var Classes = require("../entities/classes");
var Teachers = require("../entities/teachers");

exports.home = function(req, res) {
  res.send({
    'data': {
      'test': {
        'testsub': {
          'str': 'testsub hello world'
        },
        'testsub2': 42
      },
      'test2': 'hello world'
    }
  });
};

exports.getClasses = function(req, res) {
  var subjectId = req.params.subjectId;
  new Classes().where("fk_subject", subjectId).fetch()
  .then(function(classes) {
    var json = classes.toJSON();

    var teacherId = json.fk_teacher;
    var time = json.time.split('-');
    json.capacity = {};
    json.capacity.wait_list = json.wait_list;
    json.capacity.enrollment = json.enrollment;
    json.capacity.total_capacity = json.total_capacity;
    json.time = {};
    json.time.day = json.days;
    json.time.start = time[0];
    json.time.end = time[1];

    delete json.fk_teacher;
    delete json.fk_subject;
    delete json.total_capacity;
    delete json.enrollment;
    delete json.wait_list;
    delete json.days;


    new Teachers().where("id", teacherId).fetch().then(function(teachers){
      json.teacher = teachers.toJSON();
      res.send(json);
    }).catch(function(error) {
      console.log(error);
      res.send('An error occured');
    });

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

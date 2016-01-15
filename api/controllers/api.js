var rendering = require('../util/rendering');
var Terms = require("../entities/terms");
var Subjects = require("../entities/subjects");
var Classes = require("../entities/classes");

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
  new Classes().fetchAll()
  .then(function(classes) {
    res.send(classes.toJSON());
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

var rendering = require('../util/rendering');
var url = require('url');

var Model = require("../model.js");

exports.home = function(req, res) {
  res.send("Welcome on Libellus !");
};

exports.getClasses = function(req, res) {
  var subjectId = req.params.subjectId;
  var termId = url.parse(req.url, true).query.term;
  var whereTerm = {subjectId: subjectId};


  if (typeof termId !== 'undefined') {
    whereTerm = {
          subjectId: subjectId,
          termId: termId
        };
  }

  Model.Class
  .findAll({
    include: [{ all: true }],
    where: whereTerm
  })
  .then(function(classes){
    res.send(classes);
  }).catch(function(error) {
    console.log(error);
    res.send('An error occured');
  });
};

exports.getTerms = function(req, res) {
  Model.Term.findAll()
  .then(function(terms) {
    res.send(terms);
  }).catch(function(error) {
    console.log(error);
    res.send('An error occured');
  });
};

exports.getSubjects = function(req, res) {
  Model.Subject.findAll()
  .then(function(subjects) {
    res.send(subjects);
  }).catch(function(error) {
    console.log(error);
    res.send('An error occured');
  });
};

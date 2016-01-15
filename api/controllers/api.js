var rendering = require('../util/rendering');
var Terms = require("../entities/terms");

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
  res.send([{
      "id" : "0",
      "name" : "Operating System",
      "code" : "326",
      "description" : "xxxxxxxxxxxxxxxxx",
      "room" : "VEC-250",
      "teacher" :{
                  "name" : "Brian Velasquez",
                  "rate" : "5",
                  "rate_link" : "http://www.ratemyprofessors.com/ShowRatings.jsp?tid=446598"
                },
      "capacity" : {
                  "total_capacity" : "20",
                  "enrollment" : "12",
                  "wait_list" : "0"
                },
      "time" : [
          {
            "day" : "Mon",
            "start" : "10:30",
            "end" : "13:30"
          },
          {
            "day" : "Wed",
            "start" : "10:30",
            "end" : "13:30"
          }
        ]
      }
    ]
  );
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
  res.send([{
              id: "0",
              name : "Computer Science & Computer Engineering",
              code : "CECS"

            }, {
              id: "1",
              name : "Economic",
              code : "ECON"

            }, {
              id: "2",
              name : "American Language Institute",
              code : "ALI"

            },]
          );
};

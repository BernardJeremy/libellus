var rendering = require('../util/rendering');


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
  res.send([{
              id: "0",
              name: "Spring 2016"
            }, {
              id: "1",
              name: "Winter 2016"
            }]
          );
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

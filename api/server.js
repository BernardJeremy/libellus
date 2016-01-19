var express = require('express');
var cors = require('cors');

var app = express();

app.use(cors());

require('./routes')(app);

app.listen(process.env.PORT || 8080, function (){
  console.log('Listening on port %d', process.env.PORT || 8080);
});

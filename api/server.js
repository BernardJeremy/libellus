var express = require('express');
var cors = require('cors');

var app = express();

app.use(cors());

require('./routes')(app);

app.listen(8080, function (){
  console.log('Listening on port 8080');
});

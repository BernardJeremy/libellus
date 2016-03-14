var express = require('express');
var cors = require('cors');
var bodyParser = require('body-parser')
var app = express();

app.use(bodyParser.json());
app.use(cors());

require('./routes')(app);

app.listen(process.env.PORT || 8080, function (){
  console.log('Listening on port %d', process.env.PORT || 8080);
});

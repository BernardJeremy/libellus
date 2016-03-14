var passport = require('passport');
var _ = require('lodash');

var JwtStrategy = require('passport-jwt').Strategy;
var ExtractJwt = require('passport-jwt').ExtractJwt;
var jwt = require('jsonwebtoken');

var config = require('../config');
var User = require('../models/user');

var opts = {
  jwtFromRequest: ExtractJwt.fromAuthHeader(),
  secretOrKey: config.jwtSecret
}
passport.use(new JwtStrategy(opts, function(jwt_payload, done) {
  User.findOne({id: jwt_payload.id}).then(function(user) {
    if (user) {
      done(null, user.dataValues);
    } else {
      done(null, false);
    }
  }).catch(function(err) {
    if (err) {
      return done(err, false);
    }
  });
}));

exports.register = function(req, res) {
  var user = User.build(req.body, { fields: [ 'username', 'email', 'password' ] })
  user.save().then((user) => {
    var token = jwt.sign({id: user.dataValues.id}, config.jwtSecret);
    return res.send({authToken: token, user: _.omit(user, 'hashedPassword')});
  }).catch((err) => {
    res.status(400).send(err);
  })
}

exports.login = function(req, res) {
  User.findOne({email: req.body.email}).then((user) => {
    if (!user) {
      return res.status(401).send({error: 'NO_USER', message: 'No user registered with this email'});
    }
    if (!user.checkPassword(req.body.password)) {
      return res.status(401).send({error: 'WRONG_PASSWORD', message: 'Wrong password'});
    }

    var token = jwt.sign({id: user.dataValues.id}, config.jwtSecret);
    return res.send({authToken: token});
  }).catch((err) => {
    res.status(500).send({error: 'SERVER_ERROR', message: 'An error occured with the server'});
    throw err;
  })
}

exports.me = function(req, res) {
  res.send(_.omit(req.user, 'hashedPassword'));
}

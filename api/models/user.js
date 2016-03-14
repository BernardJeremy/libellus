var Sequelize = require('sequelize');

var db = require('../database/sequelize');
var bcrypt = require('bcrypt');

var User = db.define('user', {
  username: {
    type: Sequelize.STRING,
    allowNull: false,
    unique: true
  },
  email: {
    type: Sequelize.STRING,
    allowNull: false,
    unique: true,
    validate: {
      isEmail: true
    }
  },
  hashedPassword: {
    type: Sequelize.STRING,
    allowNull: false
  }
}, {
  setterMethods: {
    password: function(password) {
      var salt = bcrypt.genSaltSync(10);
      var hash = bcrypt.hashSync(password, salt);

      console.log('coucou', password, hash);

      this.setDataValue('hashedPassword', hash);
    }
  },
  instanceMethods: {
    checkPassword: function(password) {
      console.log('check', bcrypt.compareSync(password, this.hashedPassword));
      return bcrypt.compareSync(password, this.hashedPassword);
    }
  }
});

User.sync();

module.exports = User;

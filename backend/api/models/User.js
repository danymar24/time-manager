/**
 * User.js
 *
 * @description :: A model definition.  Represents a database table/collection/etc.
 * @docs        :: https://sailsjs.com/docs/concepts/models-and-orm/models
 */

const bcrypt = require('bcrypt-nodejs');

module.exports = {

  attributes: {

    'firstname': {
      type: 'string',
      required: true
    },

    'lastname': {
      type: 'string'
    },

    'email': {
      type: 'string',
      unique: true,
      required: true
    },

    'encriptedPassword': {
      type: 'string'
    },

    //  ╔═╗╦═╗╦╔╦╗╦╔╦╗╦╦  ╦╔═╗╔═╗
    //  ╠═╝╠╦╝║║║║║ ║ ║╚╗╔╝║╣ ╚═╗
    //  ╩  ╩╚═╩╩ ╩╩ ╩ ╩ ╚╝ ╚═╝╚═╝


    //  ╔═╗╔╦╗╔╗ ╔═╗╔╦╗╔═╗
    //  ║╣ ║║║╠╩╗║╣  ║║╚═╗
    //  ╚═╝╩ ╩╚═╝╚═╝═╩╝╚═╝


    //  ╔═╗╔═╗╔═╗╔═╗╔═╗╦╔═╗╔╦╗╦╔═╗╔╗╔╔═╗
    //  ╠═╣╚═╗╚═╗║ ║║  ║╠═╣ ║ ║║ ║║║║╚═╗
    //  ╩ ╩╚═╝╚═╝╚═╝╚═╝╩╩ ╩ ╩ ╩╚═╝╝╚╝╚═╝

  },

  beforeCreate(values, cb) {
    if (!values.password || !values.confirmation || values.password != values.confirmation) {
      return cb({ err: ['Password does not match confirmation'] });
    }

    const salt = bcrypt.genSaltSync(10);
    bcrypt.hash(values.password, salt, null, function (err, hash) {
      if (err) return cb(err);
      values.encryptedPassword = hash;

      delete values.password;
      delete values.confirmation;

      cb();
    });
  },

  toJSON() {
    var obj = this.toObject();
    delete obj.encriptedPassword;
    return obj;
  }

};


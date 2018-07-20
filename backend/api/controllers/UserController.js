/**
 * UserController
 *
 * @description :: Server-side actions for handling incoming requests.
 * @help        :: See https://sailsjs.com/docs/concepts/actions
 */

const bcrypt = require('bcrypt-nodejs');
const QRCode = require('qrcode');

module.exports = {
  
    'signup': function(req, res) {
        User.create(req.body).exec(function(err, user) {
            if (err) {
                return res.serverError(err);
            }

            return res.json(user);
        });
    },
    
    'login': function(req, res) {
        if (!req.body.email || !req.body.password)  {
            return res.badRequest({
                err: "Email or password cannot be empty"
            });
        }

        User.findOne({
            email: req.body.email
        }).exec(function(err, user) {
            if (err) {
                return res.serverError(err);
            }
            if (!user) {
                return res.notFound({err: 'Could not find email,' + req.body.email});
            }

            bcrypt.compare(req.body.password, user.encryptedPassword, function(err, result) {
                if (result) {
                    delete user.encryptedPassword;
                    return res.json({
                        user,
                        token: jwToken.sign(user)
                    });
                } else {
                    return res.forbidden({ err: 'Email and password combination do not match'});
                }
            });
        });
    },

    'check': function(req, res) {
        return res.json();
    },

    'getqr': function(req, res) {
        const date = new Date();
        let code = {
            validTrough: new Date(date.getTime() + 60 * 60000),
            email: req.body.email
        }
        QRCode.toDataURL(JSON.stringify(code), function (err, url) {
            return res.json({
                url
            });
        });
    },

    'verifyqr': function(req, res) {
        const date = new Date();
        const validTrough = new Date(req.body.validTrough)

        if (validTrough.getTime() > date.getTime()) {
            console.log(req.body.email);
            User.findOne({
                email: req.body.email
            }).exec(function(err, user) {
                if (err) {
                    res.badRequest({ err: 'The given code is not valid'});
                }
                console.log(user);
                res.json(user);
            });
        } else {
            console.log('invalid date');

            res.badRequest({ err: 'The given code is not valid' });
        }
    }

};


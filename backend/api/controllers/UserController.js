/**
 * UserController
 *
 * @description :: Server-side actions for handling incoming requests.
 * @help        :: See https://sailsjs.com/docs/concepts/actions
 */

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
                    return res.json(user);
                } else {
                    return res.forbidden({ err: 'Email and password combination do not match'});
                }
            });
        });
    }

};


###
isAdmin
###
 
module.exports = (req, res, next) ->

  # User is allowed, proceed to the next policy, 
  # or if this is the last policy, the controller
  if (req.session.user?.isAdmin)
    return next()

  # User is not allowed
  # (default res.forbidden() behavior can be overridden in `config/403.js`)
  return res.forbidden('You must be an admin to access this page')


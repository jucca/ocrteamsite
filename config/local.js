module.exports = {

  // @see ./session.js
  // @see ./connections.js

  email: {
    // this can be configured to use any email
    // transporter, but I've found the gmail one
    // to be the simplest for development
    transportOptions: {
      service: 'Gmail',
      auth: {
        user: '',
        pass: ''
      },
      maxConnections: 20,
      maxMessages: Infinity
    }
  },

  // @see ../api/services/Uploader.coffee
  uploads: {
    folder: "" + __dirname + "/../uploads",
    url: 'http://localhost'
  }
};

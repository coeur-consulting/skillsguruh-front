process.env.VUE_APP_VERSION = require("./package.json").version;
module.exports = {
  lintOnSave: process.env.NODE_ENV !== "production",
  pwa: {
    workboxOptions: {
      skipWaiting: true,
      clientsClaim: true,
    },
  },
};

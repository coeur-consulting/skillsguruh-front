process.env.VUE_APP_VERSION = require("./package.json").version;
module.exports = {
  lintOnSave: process.env.NODE_ENV !== "production",
  pwa: {
    workboxPluginMode: "InjectManifest",
    workboxOptions: {
      swSrc: "src/service-worker.js",
      exclude: [/\.map$/, /manifest\.json$/],
    },
    themeColor: "#1da025",
  },
};

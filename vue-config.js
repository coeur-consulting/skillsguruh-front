module.exports = {
  lintOnSave: process.env.NODE_ENV !== "production",
  pwa: {
    workboxOptions: {
      skipWaiting: true,
      clientsClaim: true,
    },
  },
};

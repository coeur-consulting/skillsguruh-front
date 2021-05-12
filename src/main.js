import Vue from "vue";
import App from "./App.vue";
import "./registerServiceWorker";
import router from "./router";
import store from "./store";
import VueToast from "vue-toast-notification";
import { BootstrapVue, IconsPlugin } from "bootstrap-vue";
import VueCarousel from "vue-carousel";
import VueChatScroll from "vue-chat-scroll";
import vueEventCalendar from "vue-event-calendar";
import VueApexCharts from "vue-apexcharts";
import axios from "axios";
import VueAxios from "vue-axios";
import VueAnimateOnScroll from "vue-animate-onscroll";

import "vue-toast-notification/dist/theme-sugar.css";
import "animate.css";
import "vue-event-calendar/dist/style.css";
import "./assets/scss/style.scss";

Vue.use(require("vue-moment"));
Vue.use(BootstrapVue);
Vue.use(IconsPlugin);
Vue.use(VueCarousel);
Vue.use(vueEventCalendar, { locale: "en" });
Vue.use(VueChatScroll);
Vue.use(VueApexCharts);
Vue.use(VueAxios, axios);
Vue.use(VueAnimateOnScroll);
Vue.use(VueToast, {
  position: "top-right",
});

Vue.component("apexchart", VueApexCharts);

Vue.config.productionTip = false;

router.beforeEach((to, from, next) => {
  if (to.matched.some((record) => record.meta.typeOrg)) {
    // this route requires auth, check if logged in
    // if not, redirect to login page.
    var org = JSON.parse(localStorage.getItem("authOrg"));
    if (!org) {
      next({
        path: "/login",
        query: { redirect: to.fullPath },
      });
    } else {
      next();
    }
  } else {
    next(); // make sure to always call next()!
  }
});

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");

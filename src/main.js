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
import VCalendar from "v-calendar";
import VueClipboard from "vue-clipboard2";
import VueSocialSharing from "vue-social-sharing";

import "vue-toast-notification/dist/theme-sugar.css";
import "animate.css";
import "vue-event-calendar/dist/style.css";
import "./assets/scss/style.scss";

Vue.use(VueSocialSharing);
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
Vue.use(VCalendar, {
  componentPrefix: "vc",
});
Vue.use(VueClipboard);
Vue.component("apexchart", VueApexCharts);

Vue.config.productionTip = false;

router.beforeEach((to, from, next) => {
  if (to.matched.some((record) => record.meta.typeOrg)) {
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
    next();
  }

  if (to.matched.some((record) => record.meta.typeAdmin)) {
    var admin = JSON.parse(localStorage.getItem("authAdmin"));
    if (!admin) {
      next({
        path: "/login",
        query: { redirect: to.fullPath },
      });
    } else {
      next();
    }
  } else {
    next();
  }
  if (to.matched.some((record) => record.meta.typeFacilitator)) {
    var facilitator = JSON.parse(localStorage.getItem("authFacilitator"));
    if (!facilitator) {
      next({
        path: "/login",
        query: { redirect: to.fullPath },
      });
    } else {
      next();
    }
  } else {
    next();
  }
  if (to.matched.some((record) => record.meta.typeLearner)) {
    var learner = JSON.parse(localStorage.getItem("authLearner"));
    if (!learner) {
      next({
        path: "/login",
        query: { redirect: to.fullPath },
      });
    } else {
      next();
    }
  } else {
    next();
  }
});

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");

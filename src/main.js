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
import VueCountdownTimer from "vuejs-countdown-timer";
import VueSocialauth from "vue-social-auth";
import VueWebSpeech from "vue-web-speech";
import Cloudinary from "cloudinary-vue";
import VueCompositionAPI from "@vue/composition-api";
import InfiniteLoading from "vue-infinite-loading";

import "vue-toast-notification/dist/theme-sugar.css";
import "animate.css";
import "vue-event-calendar/dist/style.css";
import "vue-search-select/dist/VueSearchSelect.css";
import "./assets/scss/style.scss";
import "./cloudinary.js";

Vue.use(VueCompositionAPI);
Vue.use(Cloudinary, {
  configuration: {
    cloudName: "skillsguruh",
  },
});
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
Vue.use(VueCountdownTimer);
Vue.use(VueWebSpeech);
Vue.use(VueToast, {
  position: "top-right",
});
Vue.use(VCalendar, {
  componentPrefix: "vc",
});
Vue.use(VueClipboard);
Vue.component("apexchart", VueApexCharts);
Vue.use(VueSocialauth, {
  providers: {
    google: {
      clientId:
        "738236291995-2nqjms56jvo6pc8it4p9c9cd4kmv8btn.apps.googleusercontent.com",
      redirectUri: "http://localhost:8080/auth/google/callback", // Your client app URL
    },
  },
});
Vue.filter("currencyFormat", function(numb) {
  var num = Number(numb);
  if (num) {
    return "₦ " + num.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
  } else {
    return "₦ 0.00";
  }
});
Vue.use(require("vue-pusher"), {
  api_key: "e1c39173a3f0a174688d",
  options: {
    cluster: "eu",
    encrypted: true,
  },
});
Vue.use(InfiniteLoading, {
  slots: {
    noMore: "No more message", // you can pass a string value
  },
});

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
  if (to.matched.some((record) => record.meta.typeMember)) {
    var member = JSON.parse(localStorage.getItem("authMember"));
    if (!member) {
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

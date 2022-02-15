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
import InfiniteLoading from "vue-infinite-loading";
import {
  FontAwesomeIcon,
  FontAwesomeLayers,
  FontAwesomeLayersText,
} from "@fortawesome/vue-fontawesome";

import "vue-toast-notification/dist/theme-sugar.css";
import "animate.css";
import "vue-event-calendar/dist/style.css";
import "vue-search-select/dist/VueSearchSelect.css";

import "./cloudinary.js";
import VueDictaphone from "vue-dictaphone";
import Antd from "ant-design-vue";
import "./assets/scss/style.scss";
//Import Froala Editor
import 'froala-editor/js/plugins.pkgd.min.js';
//Import third party plugins
import 'froala-editor/js/third_party/embedly.min';
import 'froala-editor/js/third_party/font_awesome.min';
import 'froala-editor/js/third_party/spell_checker.min';
import 'froala-editor/js/third_party/image_tui.min';
// Import Froala Editor css files.
import 'froala-editor/css/froala_editor.pkgd.min.css';
import VueFroala from "vue-froala-wysiwyg";
Vue.use(VueFroala);


Vue.use(Antd);
export const bus = new Vue();

Vue.component("font-awesome-icon", FontAwesomeIcon);
Vue.component("font-awesome-layers", FontAwesomeLayers);
Vue.component("font-awesome-layers-text", FontAwesomeLayersText);
Vue.use(Cloudinary, {
  configuration: {
    cloudName: "skillsguruh",
  },
});
Vue.use(VueDictaphone);
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
    return "₦" + num.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
  } else {
    return "₦0.00";
  }
});
function tags(text){
   var reg = /(?:^|\W)@(\w+)(?!\w)/g,
     match;

   var str = text
     .split(/\s+/)
     .map((item) => {
       if ((match = reg.exec(item))) {
         reg.exec(item);
         item = `  <a  href="/me/profile/${match[1].toLowerCase()}" id="${match[1]}">@${match[1]}</a> `;
         return item;
       }
       return item;
     })
     .join(" ");
   return str;
}
Vue.filter('tagsfilter', function(text){
   return tags(text);
})
Vue.use(require("vue-pusher"), {
  api_key: "35db7038d78ae4a57201",
  options: {
    cluster: "mt1",
    encrypted: true,
  },
});
Vue.use(InfiniteLoading, {
  slots: {
    noMore: "No more data", // you can pass a string value
  },
});
Vue.mixin({
  methods: {
    toText: function(HTML) {
      if (!HTML) return;
      var input = HTML;

      return input
        .replace(/<(style|script|iframe)[^>]*?>[\s\S]+?<\/\1\s*>/gi, "")
        .replace(/<[^>]+?>/g, "")
        .replace(/\s+/g, " ")
        .replace(/ /g, " ")
        .replace(/>/g, " ");
    },
    showInfo: function(key, value) {
      return key ? value : "**********";
    },
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

  // if (to.matched.some((record) => record.meta.showtribe)) {
  //   var user = JSON.parse(localStorage.getItem("authMember"));
  //   var tribe = localStorage.getItem("tribe");

  //   if (tribe && user) {
  //     Vue.axios
  //       .get(`${process.env.VUE_APP_API_PATH}/check/tribe/${tribe}`, {
  //         headers: {
  //           Authorization: `Bearer ${user.access_token}`,
  //         },
  //       })
  //       .then((res) => {
  //         if (res.status == 200 && res.data.message == "found") {
  //           next();
  //         } else {
  //           Vue.$toast.error("Unauthorised access");
  //           next("/me/tribes");
  //         }
  //       });
  //   } else {
  //     Vue.$toast.error("Unauthorised access");
  //     next("/me/tribes");
  //   }
  // } else {
  //   next();
  // }
});

new Vue({
  router,
  store,
  render: (h) => h(App),
  methods: {
    handletags(text){
      return tags(text)
    }
  },
}).$mount("#app");

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

import "vue-toast-notification/dist/theme-sugar.css";
import "animate.css";
import "vue-event-calendar/dist/style.css";
import "./assets/scss/style.scss";

Vue.use(BootstrapVue);
Vue.use(IconsPlugin);
Vue.use(VueCarousel);
Vue.use(vueEventCalendar, { locale: "en" });
Vue.use(VueChatScroll);
Vue.use(VueApexCharts);
Vue.use(VueAxios, axios);

Vue.use(VueToast, {
  position: "top-right",
});

Vue.component("apexchart", VueApexCharts);

Vue.config.productionTip = false;

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount("#app");

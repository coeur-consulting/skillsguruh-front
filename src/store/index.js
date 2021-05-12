import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    organization: localStorage.getItem("organization") || null,
    admin: localStorage.getItem("admin") || null,
    facilitator: localStorage.getItem("facilitator") || null,
    learner: localStorage.getItem("api") || null,
    url: "http://localhost:8000/api",
    // url:''
  },
  mutations: {},
  actions: {},
  modules: {},
  getters: {
    organization: (state) => state.organization,
    admin: (state) => state.admin,
    facilitator: (state) => state.facilitator,
    learner: (state) => state.learner,
    url: (state) => state.url,
  },
});

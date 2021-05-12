import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    organization: JSON.parse(localStorage.getItem("authOrg")) || {},
    admin: JSON.parse(localStorage.getItem("authAdmin")) || {},
    facilitator: JSON.parse(localStorage.getItem("authFacilitator")) || {},
    learner: JSON.parse(localStorage.getItem("authUser")) | {},
    url: "http://localhost:8000/v1",
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

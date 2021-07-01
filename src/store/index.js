import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    notifications: [],
    organization: JSON.parse(localStorage.getItem("authOrg")) || {},
    admin: JSON.parse(localStorage.getItem("authAdmin")) || {},
    facilitator: JSON.parse(localStorage.getItem("authFacilitator")) || {},
    learner: JSON.parse(localStorage.getItem("authLearner")) || {},
    // url: "http://localhost:8000/v1",
    url: "https://skillsguruh-api.herokuapp.com/v1",
    inboxes: [],
  },
  mutations: {
    SET_NOTIFICATION(state, notifications) {
      state.notifications = notifications;
    },
    SET_INBOX(state, inboxes) {
      state.inboxes = inboxes;
    },
    ADD_MESSAGE(state, data) {
      state.inboxes.push(data.message);
    },
  },
  actions: {
    getInbox({ commit, state }, user) {
      if (user == "organization") {
        Vue.axios
          .get(`${state.url}/inboxes`, {
            headers: {
              Authorization: `Bearer ${state.organization.access_token}`,
            },
          })
          .then((response) => {
            commit("SET_INBOX", response.data);
          });
      }
      if (user == "admin") {
        Vue.axios
          .get(`${state.url}/inboxes`, {
            headers: {
              Authorization: `Bearer ${state.admin.access_token}`,
            },
          })
          .then((response) => {
            commit("SET_INBOX", response.data);
          });
      }
      if (user == "facilitator") {
        Vue.axios
          .get(`${state.url}/inboxes`, {
            headers: {
              Authorization: `Bearer ${state.facilitator.access_token}`,
            },
          })
          .then((response) => {
            commit("SET_INBOX", response.data);
          });
      }
      if (user == "learner") {
        Vue.axios
          .get(`${state.url}/inboxes`, {
            headers: {
              Authorization: `Bearer ${state.learner.access_token}`,
            },
          })
          .then((response) => {
            commit("SET_INBOX", response.data);
          });
      }
    },
    getNotifications({ commit, state }, user) {
      if (user == "organization") {
        Vue.axios
          .get(`${state.url}/get-notifications`, {
            headers: {
              Authorization: `Bearer ${state.organization.access_token}`,
            },
          })
          .then((response) => {
            commit("SET_NOTIFICATION", response.data);
          });
      }
      if (user == "admin") {
        Vue.axios
          .get(`${state.url}/get-notifications`, {
            headers: {
              Authorization: `Bearer ${state.admin.access_token}`,
            },
          })
          .then((response) => {
            commit("SET_NOTIFICATION", response.data);
          });
      }
      if (user == "facilitator") {
        Vue.axios
          .get(`${state.url}/get-notifications`, {
            headers: {
              Authorization: `Bearer ${state.facilitator.access_token}`,
            },
          })
          .then((response) => {
            commit("SET_NOTIFICATION", response.data);
          });
      }
      if (user == "learner") {
        Vue.axios
          .get(`${state.url}/get-notifications`, {
            headers: {
              Authorization: `Bearer ${state.learner.access_token}`,
            },
          })
          .then((response) => {
            commit("SET_NOTIFICATION", response.data);
          });
      }
    },
    markNotifications({ commit, state }, user) {
      Vue.axios
        .get(`${state.url}/mark-notifications`, {
          headers: {
            Authorization: `Bearer ${user.access_token}`,
          },
        })
        .then((response) => {
          commit("SET_NOTIFICATION", response.data);
        });
    },
    postNotifications({ commit, state }, data, user) {
      Vue.axios
        .post(`${state.url}/unread-notifications`, data, {
          headers: {
            Authorization: `Bearer ${user.access_token}`,
          },
        })
        .then((response) => {
          commit("SET_NOTIFICATION", response.data);
        });
    },
    markNotification({ commit, state }, data) {
      Vue.axios
        .get(`${state.url}/mark-notification/${data.id}`, {
          headers: {
            Authorization: `Bearer ${data.user.access_token}`,
          },
        })
        .then((response) => {
          commit("SET_NOTIFICATION", response.data);
        });
    },
  },
  modules: {},
  getters: {
    organization: (state) => state.organization,
    admin: (state) => state.admin,
    facilitator: (state) => state.facilitator,
    learner: (state) => state.learner,
    url: (state) => state.url,
    notifications: (state) => state.notifications,
    inboxes: (state) => state.inboxes,
  },
});

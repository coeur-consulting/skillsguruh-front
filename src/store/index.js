import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    notifications: [],
    voices: [],
    organization: JSON.parse(localStorage.getItem("authOrg")) || {},
    admin: JSON.parse(localStorage.getItem("authAdmin")) || {},
    facilitator: JSON.parse(localStorage.getItem("authFacilitator")) || {},
    member: JSON.parse(localStorage.getItem("authMember")) || {},
    // url: "http://localhost:8000/v1",
    url: "https://nzukoor-server.herokuapp.com/v1",
    inboxes: [],
  },
  mutations: {
    SET_NOTIFICATION(state, notifications) {
      state.notifications = notifications;
    },
    ADD_NOTIFICATION(state, notification) {
      state.notifications.push(notification);
    },
    SET_INBOX(state, inboxes) {
      state.inboxes = inboxes;
    },
    ADD_MESSAGE(state, data) {
      state.inboxes.push(data.message);
    },
    SET_SPEECH(state, voices) {
      state.voices = voices;
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
      if (user == "member") {
        Vue.axios
          .get(`${state.url}/inboxes`, {
            headers: {
              Authorization: `Bearer ${state.member.access_token}`,
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
      if (user == "member") {
        Vue.axios
          .get(`${state.url}/get-notifications`, {
            headers: {
              Authorization: `Bearer ${state.member.access_token}`,
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
    member: (state) => state.member,
    url: (state) => state.url,
    notifications: (state) => state.notifications,
    inboxes: (state) => state.inboxes,
    voices: (state) => state.voices,
  },
});

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
    url: process.env.VUE_APP_API_PATH,
    inboxes: [],
    isOpen: false,
    isMinimise: false,
    chatter: {
      id: "",
      name: "",
      type: "",
      profile: "",
    },
    course: {},
    tribe: localStorage.getItem("tribe"),
    tribe_info: {},
    tribes: [],
  },
  mutations: {
    SET_TRIBE(state, tribe) {
      state.tribe = tribe;
    },
    SET_TRIBES(state, tribes) {
      state.tribes = tribes;
    },
    SET_TRIBE_INFO(state, tribe) {
      state.tribe_info = tribe;
    },
    SET_COURSE(state, course) {
      state.course = course;
    },
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
    OPEN_CHAT(state, chat) {
      state.isOpen = chat;
    },
    MIN_CHAT(state, chat) {
      state.isMinimise = chat;
    },
    GET_CHATTER(state, chatter) {
      state.chatter = chatter;
    },
  },
  actions: {
    async REPORT_CONTENT({ state }, detail) {
      return Vue.axios
        .post(`${state.url}/reports`, detail, {
          headers: {
            Authorization: `Bearer ${state.member.access_token}`,
          },
        })
        .catch((err) => {
          console.log(err);
        });
    },
    SEARCH_TRIBES({ state }, query) {
      let params = {
        query,
      };
      Vue.axios
        .get(`${state.url}/search`, { params })
        .then((res) => {
          if (res.data === "ok") console.log("request sent successfully");
        })
        .catch((err) => {
          console.log(err);
        });
    },
    GET_TRIBES({ state, commit }) {
      Vue.axios
        .get(`${state.url}/all/tribes`)
        .then((res) => {
          {
            commit("SET_TRIBES", res.data);
          }
        })
        .catch((err) => {
          console.log(err);
        });
    },
    async highlightText({ state }, text) {
      var part = text.substring(text.indexOf("@") + 1, text.lastIndexOf(""));
      console.log(part);
      var trimmpart = part
        .replace(/<(style|script|iframe)[^>]*?>[\s\S]+?<\/\1\s*>/gi, "")
        .replace(/<[^>]+?>/g, "")
        .replace(/\s+/g, " ")
        .replace(/ /g, " ")
        .replace(/>/g, " ");
      if (part.length) {
        var result = await Vue.axios
          .get(`${state.url}/get/userprofile/${trimmpart}`, {
            headers: {
              Authorization: `Bearer ${state.member.access_token}`,
            },
          })
          .then((res) => {
            if (res.status == 200 && res.data.message == "found") {
              return text.replace(
                `@${part}`,
                `<a  href='/member/profile/${res.data.data.username}'><span class='highlight'>@${trimmpart}</span></a>`
              );
            } else {
              return text;
            }
          });

        return result;
      }
      return text;
    },
    async checkTribe({ state }, detail) {
      return Vue.axios.get(`${state.url}/check/tribe/${detail.tribe_id}`, {
        headers: {
          Authorization: `Bearer ${detail.user.access_token}`,
        },
      });
    },
    async joinTribe({ state }, detail) {
      return Vue.axios.get(`${state.url}/join/tribe/${detail.tribe_id}`, {
        headers: {
          Authorization: `Bearer ${detail.user.access_token}`,
        },
      });
    },
    async leaveTribe({ state }, detail) {
      return Vue.axios.get(`${state.url}/leave/tribe/${detail.tribe_id}`, {
        headers: {
          Authorization: `Bearer ${detail.user.access_token}`,
        },
      });
    },
    newConnection({ state }, user) {
      Vue.axios.post(`${state.url}/new/connection`, user, {
        headers: {
          Authorization: `Bearer ${user.token}`,
        },
      });
    },
    getChatter({ commit }, data) {
      commit("GET_CHATTER", data);
      commit("OPEN_CHAT", true);
      commit("MIN_CHAT", false);
    },
    toggleChat({ commit }, data) {
      commit("OPEN_CHAT", data);
    },
    minChat({ commit }, data) {
      commit("MIN_CHAT", data);
    },
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

          if (data.url) {
            window.location.href = data.url;
          }
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
    chatter: (state) => state.chatter,
    isOpen: (state) => state.isOpen,
    isMinimise: (state) => state.isMinimise,
    course: (state) => state.course,
    tribe: (state) => state.tribe,
    tribes: (state) => state.tribes,
    tribe_info: (state) => state.tribe_info,
  },
});

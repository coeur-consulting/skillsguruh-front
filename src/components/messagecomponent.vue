<template>
  <div class="messages shadow-sm rounded-8 bg-white pb-3 overflow-hidden">
    <div class="d-flex p-3 py-2 align-items-center bg-dark-green text-white">
      <h6 class="flex-1 text-left mb-0">Messages</h6>
      <b-icon
        icon="chevron-down"
        class="cursor-pointer"
        @click="toggleMessage = !toggleMessage"
      ></b-icon>
    </div>
    <div class="m-message border-top" v-if="toggleMessage">
      <div class="px-3 py-2 mb-2">
        <div class="px-3 py-2 d-flex align-items-center search">
          <b-icon icon="search"></b-icon>
          <b-form-input
            autocomplete="off"
            autocorrect="off"
            size="sm"
            class="flex-1 border-0 no-focus search-bg"
            type="search"
            placeholder="Search name"
          ></b-form-input>
          <b-icon icon="sliders"></b-icon>
        </div>
      </div>

      <div v-if="showMessage">
        <div class="message_box py-3" v-if="chatter.length">
          <div v-for="(message, index) in chatter" :key="index">
            <div class="message px-3 py-3 d-flex border-bottom">
              <b-avatar size="2rem" :src="message.profile"></b-avatar>

              <div
                class="message_text flex-1 px-2"
                @click="
                  getmessage(
                    message.id,
                    message.name,
                    message.type,
                    message.profile
                  )
                "
              >
                <span class="message_name">{{ message.name }}</span>
                <br />
                <div
                  class="last_message"
                  v-if="user == 'member'"
                  :class="
                    !lastMessage(message).status &&
                    lastMessage(message).receiver_id ==
                      $store.getters.member.id &&
                    lastMessage(message).receiver == 'member'
                      ? 'font-weight-bold'
                      : ''
                  "
                >
                  <span v-if="lastMessage(message).message" class="text-muted">
                    {{ lastMessage(message).message }}</span
                  >
                  <span v-else class="text-muted fs11"
                    ><i>Sent attachment</i></span
                  >
                </div>
                <div
                  class="last_message"
                  v-if="user == 'facilitator'"
                  :class="
                    !lastMessage(message).status &&
                    lastMessage(message).receiver_id ==
                      $store.getters.facilitator.id &&
                    lastMessage(message).receiver == 'facilitator'
                      ? 'font-weight-bold'
                      : ''
                  "
                >
                  {{ lastMessage(message).message }}
                </div>
                <div
                  class="last_message"
                  v-if="user == 'admin'"
                  :class="
                    !lastMessage(message).status &&
                    lastMessage(message).receiver_id ==
                      $store.getters.admin.id &&
                    lastMessage(message).receiver == 'admin'
                      ? 'font-weight-bold'
                      : ''
                  "
                >
                  {{ lastMessage(message).message }}
                </div>
              </div>

              <div>
                <span class="message_time">
                  {{ lastMessage(message).time | moment("LT") }}</span
                >
              </div>
            </div>
          </div>
        </div>
        <div
          v-else
          class="
            message_box
            d-flex
            justify-content-center
            align-content-center
            p-5
          "
        >
          <div class="text-muted">No Message Available</div>
        </div>
      </div>

      <div v-else class="p-3 message_box">
        <div class="d-flex w-100 mb-3">
          <div class="mr-2">
            <b-skeleton type="avatar"></b-skeleton>
          </div>
          <div class="w-100">
            <b-skeleton animation="wave" width="85%"></b-skeleton>
            <b-skeleton animation="wave" width="35%"></b-skeleton>
          </div>
        </div>
        <div class="d-flex w-100 mb-3">
          <div class="mr-2">
            <b-skeleton type="avatar"></b-skeleton>
          </div>
          <div class="w-100">
            <b-skeleton animation="wave" width="85%"></b-skeleton>
            <b-skeleton animation="wave" width="35%"></b-skeleton>
          </div>
        </div>
        <div class="d-flex w-100 mb-3">
          <div class="mr-2">
            <b-skeleton type="avatar"></b-skeleton>
          </div>
          <div class="w-100">
            <b-skeleton animation="wave" width="85%"></b-skeleton>
            <b-skeleton animation="wave" width="35%"></b-skeleton>
          </div>
        </div>
        <div class="d-flex w-100 mb-3">
          <div class="mr-2">
            <b-skeleton type="avatar"></b-skeleton>
          </div>
          <div class="w-100">
            <b-skeleton animation="wave" width="85%"></b-skeleton>
            <b-skeleton animation="wave" width="35%"></b-skeleton>
          </div>
        </div>
        <div class="d-flex w-100 mb-3">
          <div class="mr-2">
            <b-skeleton type="avatar"></b-skeleton>
          </div>
          <div class="w-100">
            <b-skeleton animation="wave" width="85%"></b-skeleton>
            <b-skeleton animation="wave" width="35%"></b-skeleton>
          </div>
        </div>
        <div class="d-flex w-100 mb-3">
          <div class="mr-2">
            <b-skeleton type="avatar"></b-skeleton>
          </div>
          <div class="w-100">
            <b-skeleton animation="wave" width="85%"></b-skeleton>
            <b-skeleton animation="wave" width="35%"></b-skeleton>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  props: ["user"],
  data() {
    return {
      showMessage: true,
      toggleMessage: true,

      chatters: [],
      open: false,
      showAll: false,
      mini_info: {
        id: "",
        name: "",
        type: "",
        profile: "",
      },
      current: {
        id: "",
        type: "",
      },
    };
  },

  computed: {
    unreadmesages() {
      if (this.$props.user == "admin") {
        return this.inboxes.filter(
          (item) =>
            !item.status && item.admin_id !== this.$store.getters.admin.id
        );
      }
      if (this.$props.user == "facilitator") {
        return this.inboxes.filter(
          (item) =>
            !item.status &&
            item.facilitator_id !== this.$store.getters.facilitator.id
        );
      }
      if (this.$props.user == "member") {
        return this.inboxes.filter(
          (item) =>
            !item.status && item.user_id !== this.$store.getters.member.id
        );
      }
      return [];
    },
    useraccess() {
      var token = null;
      if (this.$props.user == "admin") {
        return this.$store.getters.admin;
      }
      if (this.$props.user == "facilitator") {
        return this.$store.getters.facilitator;
      }
      if (this.$props.user == "member") {
        return this.$store.getters.member;
      }
      return token;
    },
    inboxes() {
      return this.$store.getters.inboxes;
    },
    sortmessages() {
      return this.inboxes.map((item) => {
        var info = {};

        if (this.$props.user == "member") {
          if (item.user_id && item.user_id == this.useraccess.id) {
            info.admin = item.admin_info;
            info.user = item.member_info;
            info.facilitator = item.facilitator_info;
            info.message = item.message;
            info.time = item.created_at;
            info.status = item.status;
            info.id = item.id;
            info.member_id = item.member_id;
            info.receiver_id = item.receiver_id;
            info.receiver = item.receiver;
            return info;
          }
          if (
            item.receiver == "user" &&
            item.receiver_id == this.useraccess.id
          ) {
            info.admin = item.admin;
            info.user = item.user;
            info.facilitator = item.facilitator;
            info.message = item.message;
            info.time = item.created_at;
            info.status = item.status;
            info.id = item.id;
            info.receiver_id = item.receiver_id;
            info.receiver = item.receiver;
            return info;
          }
        }
        if (this.$props.user == "facilitator") {
          if (
            item.facilitator_id &&
            item.facilitator_id == this.useraccess.id
          ) {
            info.admin = item.admin_info;
            info.user = item.member_info;
            info.facilitator = item.facilitator_info;
            info.message = item.message;
            info.time = item.created_at;
            info.status = item.status;
            info.id = item.id;
            info.facilitator_id = item.facilitator_id;
            info.receiver_id = item.receiver_id;
            info.receiver = item.receiver;
            return info;
          }
          if (
            item.receiver == "facilitator" &&
            item.receiver_id == this.useraccess.id
          ) {
            info.admin = item.admin;
            info.user = item.user;
            info.facilitator = item.facilitator;
            info.message = item.message;
            info.time = item.created_at;
            info.status = item.status;
            info.id = item.id;
            info.receiver_id = item.receiver_id;
            info.receiver = item.receiver;
            return info;
          }
        }
        if (this.$props.user == "admin") {
          if (item.admin_id && item.admin_id == this.useraccess.id) {
            info.admin = item.admin_info;
            info.user = item.member_info;
            info.facilitator = item.facilitator_info;
            info.message = item.message;
            info.time = item.created_at;
            info.status = item.status;
            info.id = item.id;
            info.admin_id = item.admin_id;
            info.receiver_id = item.receiver_id;
            info.receiver = item.receiver;
            return info;
          }
          if (
            item.receiver == "admin" &&
            item.receiver_id == this.useraccess.id
          ) {
            info.admin = item.admin;
            info.user = item.user;
            info.facilitator = item.facilitator;
            info.message = item.message;
            info.time = item.created_at;
            info.status = item.status;
            info.id = item.id;
            info.receiver_id = item.receiver_id;
            info.receiver = item.receiver;
            return info;
          }
        }
      });
    },
    chatter() {
      var allnames = this.sortmessages.map((item) => {
        var checkers = {};
        if (this.$props.user == "admin") {
          if (item.user) {
            checkers.id = item.user.id;
            checkers.type = "user";
            checkers.name = item.user.username;
            checkers.message = item.message;
            checkers.time = item.time;
            checkers.profile = item.user.profile;

            return checkers;
          }
          if (item.admin && item.admin.id != this.useraccess.id) {
            checkers.id = item.admin.id;
            checkers.type = "admin";
            checkers.name = item.admin.name;
            checkers.message = item.message;
            checkers.time = item.time;
            checkers.profile = item.admin.profile;

            return checkers;
          }
          if (item.facilitator) {
            checkers.id = item.facilitator.id;
            checkers.type = "facilitator";
            checkers.name = item.facilitator.username;
            checkers.message = item.message;
            checkers.time = item.time;
            checkers.profile = item.facilitator.profile;

            return checkers;
          }
        }

        if (this.$props.user == "member") {
          if (item.user && item.user.id != this.useraccess.id) {
            checkers.id = item.user.id;
            checkers.type = "user";
            checkers.name = item.user.username;
            checkers.message = item.message;
            checkers.time = item.time;
            checkers.profile = item.user.profile;

            return checkers;
          }
          if (item.admin) {
            checkers.id = item.admin.id;
            checkers.type = "admin";
            checkers.name = item.admin.name;
            checkers.message = item.message;
            checkers.time = item.time;
            checkers.profile = item.admin.profile;

            return checkers;
          }
          if (item.facilitator) {
            checkers.id = item.facilitator.id;
            checkers.type = "facilitator";
            checkers.name = item.facilitator.username;
            checkers.message = item.message;
            checkers.time = item.time;
            checkers.profile = item.facilitator.profile;

            return checkers;
          }
        }
        if (this.$props.user == "facilitator") {
          if (item.user) {
            checkers.id = item.user.id;
            checkers.type = "user";
            checkers.name = item.user.username;
            checkers.message = item.message;
            checkers.time = item.time;
            checkers.profile = item.user.profile;

            return checkers;
          }
          if (item.admin) {
            checkers.id = item.admin.id;
            checkers.type = "admin";
            checkers.name = item.admin.name;
            checkers.message = item.message;
            checkers.time = item.time;
            checkers.profile = item.admin.profile;

            return checkers;
          }
          if (item.facilitator && item.facilitator.id != this.useraccess.id) {
            checkers.id = item.facilitator.id;
            checkers.type = "facilitator";
            checkers.name = item.facilitator.username;
            checkers.message = item.message;
            checkers.time = item.time;
            checkers.profile = item.facilitator.profile;

            return checkers;
          }
        }
      });

      return [
        ...new Set(
          allnames
            .filter((item) => item)
            .map((item) => {
              return JSON.stringify({
                name: item.name,
                id: item.id,
                type: item.type,
                profile: item.profile,
              });
            })
        ),
      ].map((item) => JSON.parse(item));
    },
  },

  methods: {
    lastMessage(info) {
      var mess = this.sortmessages.filter((item) => {
        if (info.type == "user" && item.user && item.user.id == info.id) {
          return item;
        }
        if (info.type == "admin" && item.admin && item.admin.id == info.id) {
          return item;
        }
        if (
          info.type == "facilitator" &&
          item.facilitator &&
          item.facilitator.id == info.id
        ) {
          return item;
        }
      });

      return mess.pop();
    },
    togglechat() {
      this.mini_info = {
        id: "",
        name: "",
        type: "",
        profile: "",
      };
      this.open = false;
      this.showAll = false;
    },
    getmessage(id, name, type, profile) {
      this.mini_info.id = id;
      this.mini_info.name = name;
      this.mini_info.type = type;
      this.mini_info.profile = profile;
      this.$store.dispatch("getChatter", this.mini_info);
    },
  },
};
</script>
<style scoped lang="scss">
.rounded-8 {
  border-radius: 8px;
}

.messages {
  position: fixed;
  bottom: 0;
  width: 320px;
  right: 4%;
}
.search {
  background: #fbfbfb;
  border-radius: 8px;
}
.search-bg {
  background: #fbfbfb;
}
.message_box {
  height: 68.5vh;
  overflow: scroll;
}
.message_text {
  line-height: 1.4;
  text-align: left;
  color: rgba($color: #000000, $alpha: 0.44);
}
.message_name {
  font-size: 13px;

  color: rgba($color: #000000, $alpha: 0.64);
}
.last_message {
  font-size: 12px;
  color: rgba($color: #000000, $alpha: 0.54);
  display: -webkit-box;
  line-clamp: 1;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
}
.message_time {
  font-size: 11px;
  color: rgba($color: #000000, $alpha: 0.44);
}
.message.active,
.message:hover {
  background: #f7f8fa;
  cursor: pointer;
}
</style>

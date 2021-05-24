<template>
  <div class="messages shadow-sm rounded-8 bg-white pb-3 pt-1">
    <div class="d-flex p-3 py-2 align-items-center">
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

      <div class="message_box py-3" v-if="chatters.length">
        <div v-for="(message, index) in chatters" :key="index">
          <div class="message px-3 py-3 d-flex border-bottom">
            <b-avatar size="2.2rem" :src="message.profile"></b-avatar>

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
              <div class="last_message">
                {{ message.message }}
              </div>
            </div>

            <div>
              <span class="message_time">
                {{ message.time | moment("LT") }}</span
              >
            </div>
          </div>
        </div>
      </div>
      <div
        v-else
        class="message_box d-flex justify-content-center align-content-center p-5"
      >
        <div class="text-muted">No Message Available</div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  props: ["user"],
  data() {
    return {
      toggleMessage: true,
      inboxes: [],
      chatters: [],
      current: {
        id: "",
        type: "",
      },
    };
  },
  mounted() {
    this.getinbox();
  },
  computed: {
    useraccess() {
      var token = null;
      if (this.$props.user == "admin") {
        return this.$store.getters.admin;
      }
      if (this.$props.user == "facilitator") {
        return this.$store.getters.facilitator;
      }
      if (this.$props.user == "learner") {
        return this.$store.getters.learner;
      }
      return token;
    },
  },

  methods: {
    getmessage(id, name, type, profile) {
      this.current.id = id;
      this.current.type = type;
      this.$emit("getmessage", id, name, type, profile);
    },
    getinbox() {
      this.$http
        .get(`${this.$store.getters.url}/inboxes`, {
          headers: {
            Authorization: `Bearer ${this.useraccess.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.sortmessages(res.data.reverse());
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    async sortmessages(arr) {
      this.inboxes = await arr.map((item) => {
        var info = {};
        if (this.$props.user == "admin") {
          if (item.admin_id && item.admin_id == this.useraccess.id) {
            info.admin = item.admin_info || null;
            info.user = item.learner_info || null;
            info.facilitator = item.facilitator_info || null;
            info.message = item.message || null;
            info.time = item.created_at || null;
          }
          if (
            item.receiver == "admin" &&
            item.receiver_id == this.useraccess.id
          ) {
            info.admin = item.admin || null;
            info.user = item.user || null;
            info.facilitator = item.facilitator || null;
            info.message = item.message || null;
            info.time = item.created_at || null;
          }
        }
        if (this.$props.user == "facilitator") {
          if (
            item.facilitator_id &&
            item.facilitator_id == this.useraccess.id
          ) {
            info.admin = item.admin_info || null;
            info.user = item.learner_info || null;
            info.facilitator = item.facilitator_info || null;
            info.message = item.message || null;
            info.time = item.created_at || null;
          }
          if (
            item.receiver == "facilitator" &&
            item.receiver_id == this.useraccess.id
          ) {
            info.admin = item.admin || null;
            info.user = item.user || null;
            info.facilitator = item.facilitator || null;
            info.message = item.message || null;
            info.time = item.created_at || null;
          }
        }
        if (this.$props.user == "learner") {
          if (item.admin_id && item.admin_id == this.useraccess.id) {
            info.admin = item.admin_info || null;
            info.user = item.learner_info || null;
            info.facilitator = item.facilitator_info || null;
            info.message = item.message || null;
            info.time = item.created_at || null;
          }
          if (
            item.receiver == "learner" &&
            item.receiver_id == this.useraccess.id
          ) {
            info.admin = item.admin || null;
            info.user = item.user || null;
            info.facilitator = item.facilitator || null;
            info.message = item.message || null;
            info.time = item.created_at || null;
          }
        }

        return info;
      });
      this.getChatters(this.inboxes);
    },
    getChatters(arr) {
      var check = {};

      arr.reverse().forEach((item) => {
        var checkers = {};
        if (item.admin) {
          checkers.id = item.admin.id;
          checkers.type = "admin";
          checkers.name = item.admin.name;
          checkers.message = item.message;
          checkers.time = item.time;
          checkers.profile = item.admin.profile;
          check = this.chatters.find((val) => {
            if (val.type == "admin" && val.id == item.admin.id) {
              return val;
            }
          });
        }
        if (item.facilitator) {
          checkers.id = item.facilitator.id;
          checkers.type = "facilitator";
          checkers.name = item.facilitator.name;
          checkers.profile = item.facilitator.profile;
          checkers.message = item.message;
          checkers.time = item.time;
          check = this.chatters.find((val) => {
            if (val.type == "facilitator" && val.id == item.facilitator.id) {
              return val;
            }
          });
        }
        if (item.user) {
          checkers.id = item.user.id;
          checkers.type = "user";
          checkers.name = item.user.name;
          checkers.message = item.message;
          checkers.profile = item.user.profile;
          checkers.time = item.time;
          check = this.chatters.find((val) => {
            if (val.type == "user" && val.id == item.user.id) {
              return val;
            }
          });
        }

        if (!check) {
          this.chatters.push(checkers);
        }
      });
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
}
.message_name {
  font-size: 13px;
  font-weight: bold;
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

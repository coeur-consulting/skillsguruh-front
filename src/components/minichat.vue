<template>
  <div class="reply_box bg-white shadow border" v-if="showAll">
    <div
      class="d-flex px-2 py-2 align-items-center border-bottom bg-lighter-green"
    >
      <div class="d-flex flex-1 align-items-center">
        <b-avatar size="2rem" :src="mini_info.profile" class="mr-2"></b-avatar>
        <span
          v-if="mini_info.type == 'user'"
          class="chat_name"
          @click="$router.push(`/learner/profile/u/${mini_info.id}`)"
          >{{ mini_info.name }}</span
        >
        <span
          v-else-if="mini_info.type == 'facilitator'"
          class="chat_name"
          @click="$router.push(`/learner/profile/u/${mini_info.id}`)"
          >{{ mini_info.name }}</span
        >
        <span v-else class="chat_name">{{ mini_info.name }}</span>
      </div>
      <div class="d-flex align-items-center">
        <b-icon
          class="mr-3 cursor-pointer"
          icon="arrows-angle-expand"
          @click="open = !open"
        ></b-icon>
        <b-icon
          font-scale="1.5"
          class="cursor-pointer"
          icon="x"
          @click="closeChat"
        ></b-icon>
      </div>
    </div>
    <div v-if="open">
      <div class="reply py-3 text-left" v-chat-scroll>
        <div v-for="(item, index) in messages" :key="index">
          <div
            v-if="item.admin_id"
            class="mb-1"
            :class="
              item.admin_id == $store.getters.admin.id
                ? 'right_text'
                : 'left_text'
            "
          >
            <div
              class="
                d-flex
                flex-1
                align-items-center
                justify-content-between
                mb-1
              "
            >
              <span
                class="chatting_name font-weight-bold mr-3"
                v-if="item.admin"
                >{{ item.admin.name }}</span
              >

              <span
                class="chatting_name font-weight-bold mr-3"
                v-if="item.user"
                >{{ item.user.name }}</span
              >

              <span
                class="chatting_name font-weight-bold mr-3"
                v-if="item.facilitator"
                >{{ item.facilitator.name }}</span
              >
              <span class="text-muted fs11">
                {{ item.created_at | moment("LT") }}</span
              >
            </div>
            <span>{{ item.message }}</span>
          </div>
          <div
            v-if="item.user_id"
            class="mb-1"
            :class="
              item.user_id == $store.getters.learner.id
                ? 'right_text'
                : 'left_text'
            "
          >
            <div
              class="
                d-flex
                flex-1
                align-items-center
                justify-content-between
                mb-1
              "
            >
              <span
                class="chatting_name font-weight-bold mr-3"
                v-if="item.admin"
                >{{ item.admin.name }}</span
              >

              <span
                class="chatting_name font-weight-bold mr-3"
                v-if="item.user"
                >{{ item.user.name }}</span
              >

              <span
                class="chatting_name font-weight-bold mr-3"
                v-if="item.facilitator"
                >{{ item.facilitator.name }}</span
              >
              <span class="text-muted fs11">
                {{ item.created_at | moment("LT") }}</span
              >
            </div>
            <span>{{ item.message }}</span>
          </div>
          <div
            v-if="item.facilitator_id"
            class="mb-1"
            :class="
              item.facilitator_id == $store.getters.facilitator.id
                ? 'right_text'
                : 'left_text'
            "
          >
            <div
              class="
                d-flex
                flex-1
                align-items-center
                justify-content-between
                mb-1
              "
            >
              <span
                class="chatting_name font-weight-bold mr-3"
                v-if="item.admin"
                >{{ item.admin.name }}</span
              >

              <span
                class="chatting_name font-weight-bold mr-3"
                v-if="item.user"
                >{{ item.user.name }}</span
              >

              <span
                class="chatting_name font-weight-bold mr-3"
                v-if="item.facilitator"
                >{{ item.facilitator.name }}</span
              >
              <span class="text-muted fs11">
                {{ item.created_at | moment("LT") }}</span
              >
            </div>
            <span>{{ item.message }}</span>
          </div>
        </div>
      </div>
      <div class="text-left px-1 pb-1 border-top">
        <b-input-group class="mt-1">
          <template #append>
            <b-input-group-text class="border-0 bg-transparent">
              <b-icon
                @click="addinbox"
                font-scale="1"
                icon="cursor-fill"
                class="text-dark-green cursor-pointer"
              ></b-icon>
            </b-input-group-text>
          </template>
          <template #prepend>
            <b-input-group-text
              class="border-0 bg-transparent d-none d-md-block"
              ><span class=""
                ><b-icon
                  icon="emoji-smile-fill"
                  class="text-dark-green cursor-pointer"
                  font-scale="1"
                ></b-icon></span
            ></b-input-group-text>
          </template>
          <b-form-input
            @keyup.enter="addinbox"
            v-model="inbox.message"
            size="sm"
            autocomplete="off"
            autocorrect="off"
            placeholder="Type here .."
            class="border-0 no-focus fs13"
          ></b-form-input>
        </b-input-group>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  props: ["mini_info", "user", "open", "showAll"],
  data() {
    return {
      inbox: {
        mesage: "",
        attachment: "",
        receiver: "",
        receiver_id: "",
      },
    };
  },

  mounted() {
    // this.getinbox();
  },

  watch: {
    $route: "closeChat",
  },
  computed: {
    inboxes() {
      return this.$store.getters.inboxes;
    },
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
    messages() {
      return this.inboxes.filter((item) => {
        if (
          (item.admin_id == this.$props.mini_info.id &&
            this.$props.mini_info.type == "admin") ||
          (item.user_id == this.$props.mini_info.id &&
            this.$props.mini_info.type == "user") ||
          (item.facilitator_id == this.$props.mini_info.id &&
            this.$props.mini_info.type == "facilitator") ||
          (item.receiver == this.$props.mini_info.type &&
            item.receiver_id == this.$props.mini_info.id)
        ) {
          return item;
        }
      });
    },
  },
  methods: {
    closeChat() {
      this.$emit("togglechat");
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
            this.inboxes = res.data.reverse();
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    async sortmessages(arr) {
      var inboxes = await arr.map((item) => {
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
          if (item.user_id && item.user_id == this.useraccess.id) {
            info.admin = item.admin_info || null;
            info.user = item.learner_info || null;
            info.facilitator = item.facilitator_info || null;
            info.message = item.message || null;
            info.time = item.created_at || null;
          }
          if (
            item.receiver == "user" &&
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
      this.getChatters(inboxes);
    },
    addinbox() {
      this.inbox.receiver_id = this.$props.mini_info.id;
      this.inbox.receiver = this.$props.mini_info.type;
      this.$http
        .post(`${this.$store.getters.url}/inboxes`, this.inbox, {
          headers: {
            Authorization: `Bearer ${this.useraccess.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.$toast.success("Message sent ");

            // this.inboxes.push(res.data);

            this.inbox = {
              attachment: "",
              message: "",
              receiver: "",
              receiver_id: "",
            };
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    dropinbox(id, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/inboxes/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success("Message deleted");
                this.inboxes.splice(index, 1);
              }
            })
            .catch((err) => {
              this.$toast.error(err.response.data.message);
            });
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

.reply_box {
  position: fixed;
  bottom: 0;
  width: 330px;
  left: 50%;
  border-radius: 10px 10px 0 0;
  z-index: 999;
  overflow: hidden;
  margin-left: -165px;
}
.reply {
  height: 360px;
  overflow: scroll;
}
.left_text {
  font-size: 12px;
  padding: 10px;
  background-color: #fbfbfb;
  border-radius: 0 10px 10px 0;
  border-left: 3px solid var(--lighter-green);
  width: 90%;
  margin-right: auto;
}
.right_text {
  font-size: 12px;
  padding: 10px;
  border-radius: 10px 0 0 10px;
  width: 90%;
  margin-left: auto;
  background-color: #f7f8fa;
  border-right: 3px solid var(--red);
}
.chat_name {
  font-size: 13px;
  font-weight: bold;
}
.chatting_name {
  font-size: 12px;
}
@media (max-width: 600px) {
  .reply_box {
    position: fixed;
    bottom: 0;
    width: 95vw;
    left: 0;
    right: 0;
    border-radius: 10px 10px 0 0;
    z-index: 999;
    overflow: hidden;
    margin: 0 auto;
  }
  .reply {
    height: 70vh;
  }
}
</style>

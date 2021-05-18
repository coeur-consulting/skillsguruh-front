<template>
  <div>
    <div class="reply_box bg-white shadow border" v-if="showall">
      <div
        class="d-flex px-2 py-2 align-items-center border-bottom bg-dark-green text-white"
      >
        <div class="d-flex flex-1 align-items-center">
          <b-avatar
            size="2rem"
            :src="mini_info.profile"
            class="mr-2 text-white"
          ></b-avatar>
          <span class="chat_name text-white">{{ mini_info.name }}</span>
        </div>
        <div class="d-flex align-items-center">
          <b-icon
            class="mr-3 cursor-pointer text-white"
            icon="arrows-angle-expand"
            @click="open = !open"
          ></b-icon>
          <b-icon
            font-scale="1.5"
            class="cursor-pointer text-white"
            icon="x"
            @click="showall = false"
          ></b-icon>
        </div>
      </div>
      <div v-if="open">
        <div class="reply py-3 text-left" v-chat-scroll>
          <div v-for="(item, index) in messages" :key="index">
            <div
              class="mb-1"
              :class="
                item.admin_id == $store.getters.admin.id
                  ? 'left_text'
                  : 'right_text'
              "
            >
              <div
                class="d-flex flex-1 align-items-center justify-content-between mb-1"
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
              <b-input-group-text class="border-0 bg-transparent"
                ><span class=""
                  ><b-icon
                    icon="emoji-smile-fill"
                    class="text-dark-green cursor-pointer"
                    font-scale="1"
                  ></b-icon></span
              ></b-input-group-text>
            </template>
            <b-form-input
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
  </div>
</template>
<script>
export default {
  props: ["mini_info"],
  data() {
    return {
      showall: false,
      open: false,
      inboxes: [],
      inbox: {
        message: "",
        attachment: "",
        receiver: "",
        receiver_id: "",
      },
    };
  },
  mounted() {
    this.getinbox();
  },
  watch: {
    mini_info: {
      deep: true,
      handler: "togglechat",
    },
  },
  computed: {
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
    togglechat() {
      this.showall = true;
      this.open = true;
    },
    getinbox() {
      this.$http
        .get(`${this.$store.getters.url}/inboxes`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.inboxes = res.data.data.reverse();
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    async sortmessages(arr) {
      this.inboxes = await arr.map((item) => {
        var info = {};
        if (item.admin_id && item.admin_id == this.$store.getters.admin.id) {
          if (item.admin_info) {
            info.type = "admin";
            info.id = item.admin_info.id;
          }
          if (item.facilitator_info) {
            info.type = "facilitator";
            info.id = item.facilitator_info.id;
          }
          if (item.user_info) {
            info.type = "user";
            info.id = item.user_info.id;
          }

          info.admin = item.admin_info || null;
          info.user = item.user_info || null;
          info.facilitator = item.facilitator_info || null;
          info.message = item.message || null;
          info.time = item.created_at || null;
        }
        if (
          item.receiver == "admin" &&
          item.receiver_id == this.$store.getters.admin.id
        ) {
          if (item.admin) {
            info.type = "admin";
            info.id = item.admin.id;
          }
          if (item.facilitator) {
            info.type = "facilitator";
            info.id = item.facilitator.id;
          }
          if (item.user) {
            info.type = "user";
            info.id = item.user.id;
          }
          info.admin = item.admin || null;
          info.user = item.user || null;
          info.facilitator = item.facilitator || null;
          info.message = item.message || null;
          info.time = item.created_at || null;
        }
        return info;
      });
    },
    addinbox() {
      this.inbox.receiver_id = this.$props.mini_info.id;
      this.inbox.receiver = this.$props.mini_info.type;
      this.$http
        .post(`${this.$store.getters.url}/inboxes`, this.inbox, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.$toast.success("Message sent ");

            this.inboxes.push(res.data);

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
  left: 30%;
  border-radius: 10px 10px 0 0;
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
  width: 90%;
  margin-right: auto;
}
.right_text {
  font-size: 12px;
  padding: 10px;
  border-radius: 10px;
  width: 90%;
  margin-left: auto;
  background-color: #f7f8fa;
}
.chat_name {
  font-size: 13px;
  font-weight: bold;
}
.chatting_name {
  font-size: 12px;
}
</style>

<template>
  <div class="reply_box bg-white shadow border" v-if="showAll">
    <div
      class="d-flex px-2 py-2 align-items-center border-bottom bg-lighter-green"
    >
      <div class="d-flex flex-1 align-items-center">
        <b-avatar size="2rem" :src="mini_info.profile" class="mr-2"></b-avatar>
        <span
          v-if="mini_info.type == 'user'"
          class="chat_name hover_green"
          @click="$router.push(`/learner/profile/u/${mini_info.id}`)"
          >{{ mini_info.name }}</span
        >
        <span
          v-else-if="mini_info.type == 'facilitator'"
          class="chat_name hover_green"
          @click="$router.push(`/learner/profile/u/${mini_info.id}`)"
          >{{ mini_info.name }}</span
        >
        <span v-else class="chat_name">{{ mini_info.name }}</span>
      </div>
      <div class="d-flex align-items-center">
        <b-dropdown
          size="sm"
          variant="transparent"
          no-caret
          class="no-focus mr-1"
        >
          <template #button-content>
            <b-icon font-scale="1" icon="paperclip"></b-icon>
          </template>

          <Upload @getUpload="getUpload" :file_type="'image'" :id="'image'">
            <b-dropdown-text class="fs14 cursor-pointer">
              Insert image
            </b-dropdown-text>
          </Upload>
          <Upload @getUpload="getUpload" :file_type="'audio'" :id="'audio'">
            <b-dropdown-text class="fs14 cursor-pointer">
              Insert audio
            </b-dropdown-text>
          </Upload>
          <Upload @getUpload="getUpload" :file_type="'video'" :id="'video'">
            <b-dropdown-text class="fs14 cursor-pointer">
              Insert video
            </b-dropdown-text>
          </Upload>
        </b-dropdown>
        <b-icon
          class="mr-2 cursor-pointer"
          icon="arrows-angle-expand"
          font-scale=".9"
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
            class="mb-2"
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
            class="mb-2"
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
            <a :href="item.attachment" target="_blank" download class="mb-1">
              <b-img
                v-if="
                  item.attachment &&
                  img_ext.includes(getextension(item.attachment))
                "
                class="cursor-pointer"
                fluid-grow
                :src="item.attachment"
              ></b-img>
              <div
                v-if="
                  item.attachment &&
                  vid_ext.includes(getextension(item.attachment))
                "
                class="
                  p-1
                  bg-lighter-green
                  d-flex
                  align-items-center
                  rounded
                  cursor-pointer
                "
              >
                <div class="bg-dark-green text-center rounded p-2 mr-3">
                  <b-icon
                    icon="camera-video-fill"
                    variant="white"
                    font-scale="2rem"
                  ></b-icon>
                </div>
                <div
                  class="
                    d-flex
                    w-100
                    align-items-center
                    p-2
                    justify-content-center justify-content-center
                    text-dark
                    fs15
                  "
                >
                  <!-- {{ getFileDetails(item.attachment).then((res) => res) }} -->
                  Download Video
                </div>
              </div>
              <div
                v-if="
                  item.attachment &&
                  aud_ext.includes(getextension(item.attachment))
                "
                class="
                  p-1
                  bg-lighter-green
                  d-flex
                  align-items-center
                  rounded
                  cursor-pointer
                "
              >
                <div class="bg-dark-green text-center rounded p-2 mr-3">
                  <b-icon
                    icon="music-note-beamed"
                    variant="white"
                    font-scale="2rem"
                  ></b-icon>
                </div>
                <!-- <div class="d-flex align-items-center">
                  <audio
                    :src="item.attachment"
                    controls
                    class="bg-transparent"
                  ></audio>
                </div> -->
                <div
                  class="
                    d-flex
                    w-100
                    align-items-center
                    p-2
                    justify-content-center justify-content-center
                    text-dark
                    fs15
                  "
                >
                  Download Audio
                </div>
              </div>
              <div
                v-if="
                  item.attachment &&
                  doc_ext.includes(getextension(item.attachment))
                "
                class="
                  p-1
                  bg-lighter-green
                  d-flex
                  align-items-center
                  rounded
                  cursor-pointer
                "
              >
                <div class="bg-dark-green text-center rounded p-2 mr-3">
                  <b-icon
                    icon="file"
                    variant="white"
                    font-scale="2rem"
                  ></b-icon>
                </div>
                <div
                  class="
                    d-flex
                    align-items-center
                    p-2
                    justify-content-center
                    text-dark
                    fs15
                  "
                >
                  Download File
                </div>
              </div>
            </a>
            <span>{{ item.message }}</span>
          </div>
          <div
            v-if="item.facilitator_id"
            class="mb-2"
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
            <a :href="item.attachment" target="_blank" download class="mb-1">
              <b-img
                v-if="
                  item.attachment &&
                  img_ext.includes(getextension(item.attachment))
                "
                class="cursor-pointer"
                fluid-grow
                :src="item.attachment"
              ></b-img>
              <div
                v-if="
                  item.attachment &&
                  vid_ext.includes(getextension(item.attachment))
                "
                class="
                  p-1
                  bg-lighter-green
                  d-flex
                  align-items-center
                  rounded
                  cursor-pointer
                "
              >
                <div class="bg-dark-green text-center rounded p-2 mr-3">
                  <b-icon
                    icon="camera-video-fill"
                    variant="white"
                    font-scale="2rem"
                  ></b-icon>
                </div>
                <div
                  class="
                    d-flex
                    w-100
                    align-items-center
                    p-2
                    justify-content-center justify-content-center
                    text-dark
                    fs15
                  "
                >
                  <!-- {{ getFileDetails(item.attachment).then((res) => res) }} -->
                  Download Video
                </div>
              </div>
              <div
                v-if="
                  item.attachment &&
                  aud_ext.includes(getextension(item.attachment))
                "
                class="
                  p-1
                  bg-lighter-green
                  d-flex
                  align-items-center
                  rounded
                  cursor-pointer
                "
              >
                <div class="bg-dark-green text-center rounded p-2 mr-3">
                  <b-icon
                    icon="music-note-beamed"
                    variant="white"
                    font-scale="2rem"
                  ></b-icon>
                </div>
                <!-- <div class="d-flex align-items-center">
                  <audio
                    :src="item.attachment"
                    controls
                    class="bg-transparent"
                  ></audio>
                </div> -->
                <div
                  class="
                    d-flex
                    w-100
                    align-items-center
                    p-2
                    justify-content-center justify-content-center
                    text-dark
                    fs15
                  "
                >
                  Download Audio
                </div>
              </div>
              <div
                v-if="
                  item.attachment &&
                  doc_ext.includes(getextension(item.attachment))
                "
                class="
                  p-1
                  bg-lighter-green
                  d-flex
                  align-items-center
                  rounded
                  cursor-pointer
                "
              >
                <div class="bg-dark-green text-center rounded p-2 mr-3">
                  <b-icon
                    icon="file"
                    variant="white"
                    font-scale="2rem"
                  ></b-icon>
                </div>
                <div
                  class="
                    d-flex
                    align-items-center
                    p-2
                    justify-content-center
                    text-dark
                    fs15
                  "
                >
                  Download File
                </div>
              </div>
            </a>
            <span>{{ item.message }}</span>
          </div>
        </div>
      </div>
      <div class="text-left py-2 bg-light mb-1">
        <b-input-group class="mt-1">
          <template #append>
            <b-input-group-text class="border-0 bg-transparent">
              <b-icon
                @click="addinbox"
                font-scale="1"
                icon="cursor-fill"
                class="text-dark cursor-pointer"
              ></b-icon>
            </b-input-group-text>
          </template>
          <template #prepend>
            <b-input-group-text
              class="border-0 bg-transparent d-none d-md-block"
              ><span class=""
                ><b-icon
                  icon="emoji-smile-fill"
                  class="text-dark cursor-pointer"
                  font-scale="1"
                ></b-icon></span
            ></b-input-group-text>
          </template>
          <b-form-input
            @keyup.enter="addinbox"
            v-model="inbox.message"
            autocomplete="off"
            autocorrect="off"
            placeholder="Type here .."
            class="border-0 no-focus rounded-pill fs13"
          ></b-form-input>
        </b-input-group>
      </div>
    </div>
    <b-modal id="media" size="sm" centered hide-footer>
      <b-img
        v-if="
          inbox.attachment && img_ext.includes(getextension(inbox.attachment))
        "
        fluid-grow
        :src="inbox.attachment"
        blank-color="transparent"
        style="width: 7rem; height: 7rem; object-fit: contain"
        class="rounded mb-1"
      ></b-img>
      <video
        width="100%"
        controls
        v-if="
          inbox.attachment && vid_ext.includes(getextension(inbox.attachment))
        "
        :src="inbox.attachment"
        class="fluid-grow"
      ></video>

      <audio
        width="100%"
        controls
        v-if="
          inbox.attachment && aud_ext.includes(getextension(inbox.attachment))
        "
        :src="inbox.attachment"
        class="fluid-grow"
      ></audio>
      <div
        v-if="
          inbox.attachment && doc_ext.includes(getextension(inbox.attachment))
        "
        class="
          p-1
          bg-lighter-green
          d-flex
          align-items-center
          rounded
          cursor-pointer
        "
      >
        <div class="bg-dark-green text-center rounded p-2 mr-3">
          <b-icon icon="file" variant="white" font-scale="2rem"></b-icon>
        </div>
        <div
          class="
            d-flex
            align-items-center
            p-2
            justify-content-center
            text-dark
            fs15
          "
        >
          Download File
        </div>
      </div>
      <b-input-group class="mt-1">
        <template #append>
          <b-input-group-text class="border-0 bg-transparent">
            <b-icon
              @click="addinbox"
              font-scale="1"
              icon="cursor-fill"
              class="text-dark cursor-pointer"
            ></b-icon>
          </b-input-group-text>
        </template>
        <template #prepend>
          <b-input-group-text class="border-0 bg-transparent d-none d-md-block"
            ><span class=""
              ><b-icon
                icon="emoji-smile-fill"
                class="text-dark cursor-pointer"
                font-scale="1"
              ></b-icon></span
          ></b-input-group-text>
        </template>
        <b-form-input
          @keyup.enter="addinbox"
          v-model="inbox.message"
          autocomplete="off"
          autocorrect="off"
          placeholder="Type here .."
          class="border-0 no-focus rounded-pill fs13"
        ></b-form-input>
      </b-input-group>
    </b-modal>
  </div>
</template>
<script>
import Upload from "@/components/chatUpload";
export default {
  props: ["mini_info", "user", "open", "showAll"],
  data() {
    return {
      img_ext: ["jpg", "png", "jpeg", "gif"],
      vid_ext: ["mp4", "3gp", "mov", "flv"],
      aud_ext: ["mp3", "aac"],
      doc_ext: ["docx", "pdf", "ppt", "zip"],
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
  components: {
    Upload,
  },
  watch: {
    $route: "closeChat",
    mini_info: {
      handler() {
        this.markMessagesRead();
      },
      deep: true,
    },
  },

  computed: {
    unreadmesages() {
      return this.messages.filter((item) => !item.status);
    },
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
      if (!this.$props.mini_info) {
        return [];
      }
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
    markMessagesRead() {
      if (!this.unreadmesages.length) {
        return;
      }

      if (this.$props.user == "learner") {
        if (
          !this.unreadmesages.some(
            (item) =>
              item.receiver == "learner" &&
              item.receiver_id == this.$store.getters.learner.id
          )
        ) {
          return;
        }
      }

      if (this.$props.user == "facilitator") {
        if (
          !this.unreadmesages.some(
            (item) =>
              item.receiver == "facilitator" &&
              item.receiver_id == this.$store.getters.facilitator.id
          )
        ) {
          return;
        }
      }

      if (this.$props.user == "admin") {
        if (
          !this.unreadmesages.some(
            (item) =>
              item.receiver == "admin" &&
              item.receiver_id == this.$store.getters.admin.id
          )
        ) {
          return;
        }
      }
      let data = {
        ids: this.unreadmesages.map((item) => item.id),
      };
      this.$http
        .post(`${this.$store.getters.url}/inboxes/mark/read`, data)
        .then((res) => {
          if (res.status == 200) {
            if (this.$props.user == "learner") {
              this.$store.dispatch("getInbox", "learner");
            }

            if (this.$props.user == "facilitator") {
              this.$store.dispatch("getInbox", "facilitator");
            }

            if (this.$props.user == "admin") {
              this.$store.dispatch("getInbox", "admin");
            }
          }
        });
    },
    async getFileDetails(media) {
      window.URL = window.URL || window.webkitURL;
      var video = document.createElement("video");
      video.preload = "metadata";

      video.onloadedmetadata = function () {
        window.URL.revokeObjectURL(video.src);
        var duration = video.duration;

        return new Date(duration * 1000).toISOString().substr(11, 8);
      };
      video.src = media;
    },

    getextension(fileName) {
      if (fileName) {
        var regex = new RegExp("[^.]+$");
        var extension = fileName.match(regex);

        return extension[0];
      }
    },
    getUpload(val) {
      this.inbox.attachment = val;
      this.$bvModal.show("media");
    },
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
            if (this.inbox.attachment) {
              this.$bvModal.hide("media");
            }
            this.inbox = {
              attachment: "",
              message: "",
              receiver: "",
              receiver_id: "",
            };
          }
        })
        .catch(() => {
          this.$toast.error("Message not sent");
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
  margin-left: -165px;
}
.reply {
  height: 360px;
  overflow-y: scroll;
}
.reply::-webkit-scrollbar {
  display: none;
}

/* Hide scrollbar for IE, Edge and Firefox */
.reply {
  -ms-overflow-style: none; /* IE and Edge */
  scrollbar-width: none; /* Firefox */
}
.left_text {
  font-size: 12px;
  padding: 10px;
  background-color: #fbfbfb;
  border-radius: 0 10px 10px 0;
  border-left: 3px solid var(--dark-green);
  width: 80%;
  margin-right: auto;
  position: relative;
}
.left_text::after {
  content: "";
  width: 0;
  height: 0;
  border-top: 1px solid transparent;
  border-bottom: 10px solid transparent;
  border-left: 15px solid #fbfbfb;
  position: absolute;
  right: -12px;
  top: 0;
}
.right_text {
  font-size: 12px;
  padding: 10px;
  border-radius: 10px 0 0 10px;
  width: 80%;
  margin-left: auto;
  background-color: #f7f8fa;
  border-right: 3px solid var(--red);
  position: relative;
}
.right_text::before {
  content: "";
  width: 0;
  height: 0;
  border-top: 1px solid transparent;
  border-bottom: 10px solid transparent;
  border-right: 15px solid #fbfbfb;
  position: absolute;
  left: -12px;
  top: 0;
}
.chat_name {
  font-size: 13px;
  font-weight: bold;
}
.chatting_name {
  font-size: 12px;
}
audio {
  max-width: 200px;
  height: 44px;
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

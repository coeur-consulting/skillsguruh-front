<template>
  <div
    class="reply_box bg-white shadow border rounded overflow-hidden"
    :class="isMinimise ? 'minimise' : ''"

    v-if="isOpen"
  >
    <header
      class="d-flex px-2 py-2 align-items-center border-bottom"
      :class="isMinimise ? 'minimise' : ''"
    >
      <div class="d-flex flex-1 align-items-center">
        <b-avatar size="2rem" :src="chatter.profile" class="mr-2"></b-avatar>
        <span
          class="chat_name hover_green"
          @click="$router.push(`/member/profile/${chatter.name}`)"
          >{{ chatter.name }}</span
        >
      </div>
      <div class="d-flex align-items-center">
        <router-link to="/messages" target="_blank"> <b-icon
          class="mr-2 cursor-pointer"
          icon="arrows-angle-expand"
          variant="dark"
          font-scale="1"
          v-b-tooltip.hover="'Expand'"

        ></b-icon></router-link>
        <b-icon
         v-b-tooltip.hover="'Minimise'"
          class="mr-2 cursor-pointer"
          icon="dash"
          font-scale="1.4"
          @click="minimiseChat"
        ></b-icon>
        <b-icon
         v-b-tooltip.hover="'Close'"
          font-scale="1.5"
          class="cursor-pointer"
          icon="x"
          @click="closeChat"
        ></b-icon>
      </div>
    </header>

    <ul
     @click="markasread"
      v-if="!isMinimise"
      class="chatbody reply py-3 px-3 text-left pl-0 mb-0"
      v-chat-scroll="{ always: false, smooth: true, scrollonremoved: true }"
    >
      <li v-for="(item, index) in messages" :key="index">
        <div
          v-if="item.user_id"
          class="mb-2"
          :class="
            item.user_id == $store.getters.member.id
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
              v-if="item.user"
              >{{ item.user.username }}</span
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
              class="cursor-pointer chat_image"
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
          </a>
          <audio
            v-if="item.voicenote"
            :src="item.voicenote"
            controls
            style="width: 100%"
          ></audio>
          <div class="pt-2" v-if="item.message" v-html="item.message"></div>
        </div>
      </li>
    </ul>
    <div class="mic bg-light" v-if="record">
      <vue-dictaphone
        mime-type="audio/mp3"
        @stop="handleRecording($event)"
        v-slot="{ isRecording, startRecording, stopRecording, deleteRecording }"
      >
        <span v-if="!isRecording" @click="startRecording">
          Click to start recording
        </span>

        <span v-else class="d-flex align-items-center rounded-pill bg-light">
          <b-icon
            @click="deleteRecording"
            class="mr-4"
            icon="trash"
            variant="danger"
            font-scale=".8"
          ></b-icon>
          <span @click="stopRecording"> Stop recording </span>
        </span>
        <div class="mic_visual" v-if="isRecording">
          <vue-dictaphone-spectrum-analyser />
        </div>
      </vue-dictaphone>
    </div>

    <footer v-if="!isMinimise" class="text-left py-2 mb-1">
      <b-input-group class="mt-1">
        <template #append>
          <b-input-group-text class="border-0 bg-transparent py-0">
            <b-icon
              v-if="!inbox.message"
              class="cursor-pointer mr-2"
              @click="record = !record"
              icon="mic-fill"
              font-scale="1.1"
              :class="record ? 'text-muted' : 'text-dark'"
            ></b-icon>

            <b-icon
              v-else
              @click="addinbox"
              font-scale="1"
              icon="cursor-fill"
              class="text-dark cursor-pointer"
            ></b-icon>
          </b-input-group-text>
        </template>
        <template #prepend>
          <b-input-group-text
            class="border-0 bg-transparent d-flex align-item-center py-0 pr-0"
          >
            <emoji-picker @emoji="insert" :search="search">
              <div
                class="emoji-invoker2"
                slot="emoji-invoker"
                slot-scope="{ events: { click: clickEvent } }"
                @click.stop="clickEvent"
              >
                <svg
                  height="24"
                  viewBox="0 0 24 24"
                  width="24"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path d="M0 0h24v24H0z" fill="none" />
                  <path
                    d="M11.99 2C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8zm3.5-9c.83 0 1.5-.67 1.5-1.5S16.33 8 15.5 8 14 8.67 14 9.5s.67 1.5 1.5 1.5zm-7 0c.83 0 1.5-.67 1.5-1.5S9.33 8 8.5 8 7 8.67 7 9.5 7.67 11 8.5 11zm3.5 6.5c2.33 0 4.31-1.46 5.11-3.5H6.89c.8 2.04 2.78 3.5 5.11 3.5z"
                  />
                </svg>
              </div>
              <div slot="emoji-picker" slot-scope="{ emojis, insert }">
                <div class="emoji-picker picker">
                  <div class="emoji-picker__search">
                    <input type="text" v-model="search" v-focus />
                  </div>
                  <div>
                    <div
                      v-for="(emojiGroup, category) in emojis"
                      :key="category"
                    >
                      <h5>{{ category }}</h5>
                      <div class="emojis">
                        <span
                          v-for="(emoji, emojiName) in emojiGroup"
                          :key="emojiName"
                          @click="insert(emoji)"
                          :title="emojiName"
                          >{{ emoji }}</span
                        >
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </emoji-picker>
            <b-dropdown
              size="sm"
              variant="transparent"
              no-caret
              class="no-focus"
            >
              <template #button-content>
                <b-icon font-scale="1" icon="paperclip"></b-icon>
              </template>

              <Upload @getUpload="getUpload" :file_type="'image'" :id="'image'">
                <b-dropdown-text class="fs11 cursor-pointer">
                  Image
                </b-dropdown-text>
              </Upload>
              <Upload @getUpload="getUpload" :file_type="'audio'" :id="'audio'">
                <b-dropdown-text class="fs11 cursor-pointer">
                  Audio
                </b-dropdown-text>
              </Upload>
              <Upload @getUpload="getUpload" :file_type="'video'" :id="'video'">
                <b-dropdown-text class="fs11  cursor-pointer">
                  Video
                </b-dropdown-text>
              </Upload>
            </b-dropdown>
          </b-input-group-text>
        </template>
        <b-form-input
          @keyup.enter="addinbox"
          v-model="inbox.message"
          type="text"
          autocomplete="off"

          placeholder="Type a message ..."
          class="border-0 no-focus rounded-pill bg-light"
        ></b-form-input>
      </b-input-group>
    </footer>

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
          <b-input-group-text class="border-0 bg-transparent py-0">
            <b-icon
              @click="addinbox"
              font-scale="1"
              icon="cursor-fill"
              class="text-dark cursor-pointer"
            ></b-icon>
          </b-input-group-text>
        </template>
        <template #prepend>
          <b-input-group-text class="border-0 bg-transparent py-0">
            <emoji-picker @emoji="insert" :search="search">
              <div
                class="emoji-invoker2"
                slot="emoji-invoker"
                slot-scope="{ events: { click: clickEvent } }"
                @click.stop="clickEvent"
              >
                <svg
                  height="24"
                  viewBox="0 0 24 24"
                  width="24"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path d="M0 0h24v24H0z" fill="none" />
                  <path
                    d="M11.99 2C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8zm3.5-9c.83 0 1.5-.67 1.5-1.5S16.33 8 15.5 8 14 8.67 14 9.5s.67 1.5 1.5 1.5zm-7 0c.83 0 1.5-.67 1.5-1.5S9.33 8 8.5 8 7 8.67 7 9.5 7.67 11 8.5 11zm3.5 6.5c2.33 0 4.31-1.46 5.11-3.5H6.89c.8 2.04 2.78 3.5 5.11 3.5z"
                  />
                </svg>
              </div>
              <div slot="emoji-picker" slot-scope="{ emojis, insert }">
                <div class="emoji-picker picker">
                  <div class="emoji-picker__search">
                    <input type="text" v-model="search" v-focus />
                  </div>
                  <div>
                    <div
                      v-for="(emojiGroup, category) in emojis"
                      :key="category"
                    >
                      <h5>{{ category }}</h5>
                      <div class="emojis">
                        <span
                          v-for="(emoji, emojiName) in emojiGroup"
                          :key="emojiName"
                          @click="insert(emoji)"
                          :title="emojiName"
                          >{{ emoji }}</span
                        >
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </emoji-picker>
          </b-input-group-text>
        </template>
        <b-form-input
          @keyup.enter="addinbox"
          v-model="inbox.message"
          autocomplete="off"
          autocorrect="off"
          placeholder="Type a message .."
          class="border-0 no-focus rounded-pill fs13"
        ></b-form-input>
      </b-input-group>
    </b-modal>
  </div>
</template>
<script>
import Upload from "@/components/chatUpload";
import EmojiPicker from "vue-emoji-picker";
import { bus } from "@/main.js";
export default {
  props: ["user"],
  data() {
    return {
      blob: null,
      loading: false,
      img_ext: ["jpg", "png", "jpeg", "gif"],
      vid_ext: ["mp4", "3gp", "mov", "flv"],
      aud_ext: ["mp3", "aac"],
      doc_ext: ["docx", "pdf", "ppt", "zip"],
      record: false,

      inbox: {
        message: "",
        attachment: "",
        receiver: "",
        receiver_id: "",
        voicenote: "",
      },
      search: "",
    };
  },
  directives: {
    focus: {
      inserted(el) {
        el.focus();
      },
    },
  },

  components: {
    Upload,
    EmojiPicker,
  },
  watch: {
    isOpen: "markMessagesRead",
  },

  computed: {
    isMinimise() {
      return this.$store.getters.isMinimise;
    },
    isOpen() {
      return this.$store.getters.isOpen;
    },
    chatter() {
      return this.$store.getters.chatter;
    },
    unreadmesages() {
      return this.messages.filter((item) => !item.status);
    },
    inboxes() {
      return this.$store.getters.inboxes;
    },
    useraccess() {
      return this.$store.getters.member;
    },
    messages() {
      if (!this.chatter) {
        return [];
      }
      return this.inboxes.filter((item) => {
        if (
          (item.admin_id == this.chatter.id && this.chatter.type == "admin") ||
          (item.user_id == this.chatter.id && this.chatter.type == "user") ||
          (item.facilitator_id == this.chatter.id &&
            this.chatter.type == "facilitator") ||
          (item.receiver == this.chatter.type &&
            item.receiver_id == this.chatter.id)
        ) {
          return item;
        }
      });
    },
  },
  methods: {
    markasread() {
      let data = {
        id: this.chatter.id,
      };
      this.$http
        .post(`${this.$store.getters.url}/messages/mark/read`, data, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status === 200) {
            var val = {
              index: this.chatter.index,
            };
            bus.$emit("unreadmessage", val);
          }
        });
    },
    handleRecording({ blob, src }) {
      this.blob = blob;
      this.inbox.voicenote = src;
      this.addinbox();
    },
    insert(emoji) {
      this.inbox.message = this.inbox.message + emoji;
    },

    markMessagesRead() {
      // if (!this.unreadmesages.length) {
      //   return;
      // }

      if (this.user == "member") {
        if (
          !this.unreadmesages.some(
            (item) =>
              item.receiver == "user" &&
              item.receiver_id == this.$store.getters.member.id
          )
        ) {
          return;
        }
      }

      if (this.user == "facilitator") {
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

      if (this.user == "admin") {
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
            if (this.user == "member") {
              this.$store.dispatch("getInbox", "member");
            }

            if (this.user == "facilitator") {
              this.$store.dispatch("getInbox", "facilitator");
            }

            if (this.user == "admin") {
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

        return extension[0].toLowerCase();
      }
    },
    getUpload(val) {
      this.inbox.attachment = val;
      this.$bvModal.show("media");
    },
    closeChat() {
      this.$store.dispatch("toggleChat", false);
    },
    minimiseChat() {
      this.$store.dispatch("minChat", !this.isMinimise);
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
        if (this.user == "admin") {
          if (item.admin_id && item.admin_id == this.useraccess.id) {
            info.admin = item.admin_info || null;
            info.user = item.receiver_info || null;
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
        if (this.user == "facilitator") {
          if (
            item.facilitator_id &&
            item.facilitator_id == this.useraccess.id
          ) {
            info.admin = item.admin_info || null;
            info.user = item.receiver_info || null;
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
        if (this.user == "member") {
          if (item.user_id && item.user_id == this.useraccess.id) {
            info.admin = item.admin_info || null;
            info.user = item.receiver_info || null;
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
      this.getchatter(inboxes);
    },
    addinbox() {
      if (this.loading) return;
      this.loading = true;
      if (this.inbox.attachment && this.inbox.message && this.inbox.voicenote) {
        return this.$toast.info("Cannot be empty");
      }
      this.inbox.receiver_id = this.chatter.id;
      this.inbox.receiver = this.chatter.type;
      this.$http
        .post(`${this.$store.getters.url}/inboxes`, this.inbox, {
          headers: {
            Authorization: `Bearer ${this.useraccess.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.$toast.success("Message sent ");
            this.loading = false;
            this.inboxes.push(res.data);
            var val = {
              message: res.data.message,
              index: this.chatter.index,
            };
            bus.$emit("lastmessage", val);
            if (this.inbox.attachment) {
              this.$bvModal.hide("media");
            }
            if (this.record) {
              this.record = false;
            }
            this.inbox = {
              attachment: "",
              message: "",
              receiver: "",
              receiver_id: "",
              voicenote: "",
            };
          }
        })
        .catch(() => {
          this.loading = false;
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
.minimise {
  height: calc(480px * 0.11) !important;
}
.reply_box {
  transition: all 0.5s;
  position: fixed;
  bottom: 3px;
  width: 330px;
  height: 480px;
  right: 30px;
  border-radius: 10px 10px 0 0;
  z-index: 999;
}
.chatbox {
  height: 90%;
}
header {
  height: 11%;
}

.chatbody {
  height: 74%;
  overflow-y: scroll;
  position: relative;
  background-image: url("/img/whats.png");
  background-size: cover;
}
footer {
  height: 15%;
}
.mic {
  position: absolute;
  top: 0;
  bottom: 0;
  right: 0;
  left: 0;
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 2;
  height: 85%;
}
.mic_visual {
  width: 200px;
  height: 60px;
  overflow: hidden;
}
.reply::-webkit-scrollbar {
  display: none;
}

/* Hide scrollbar for IE, Edge and Firefox */
.reply {
  -ms-overflow-style: none; /* IE and Edge */
  scrollbar-width: none; /* Firefox */
}
ul {
  list-style-type: none;
}
.left_text {
  font-size: 12px;
  padding: 10px;
  background-color: #d0d2d5;
  border-radius: 0 10px 10px 0;

  border-right: 3px solid var(--dark-green);

  width: 70%;
  margin-right: auto;
  position: relative;
}
.left_text::after {
  content: "";
  width: 0;
  height: 0;
  border-top: 1px solid transparent;
  border-bottom: 10px solid transparent;
  border-right: 15px solid #d0d2d5;
  position: absolute;
  left: -12px;
  top: 0;
}
.right_text {
  font-size: 12px;
  padding: 10px;
  border-radius: 10px 0 0 10px;
  width: 70%;
  margin-left: auto;
  background-color: #d0d2d5;
  border-left: 3px solid var(--red);

  position: relative;
}
.right_text::before {
  content: "";
  width: 0;
  height: 0;
  border-top: 1px solid transparent;
  border-bottom: 10px solid transparent;
  border-left: 15px solid #d0d2d5;
  position: absolute;
  right: -12px;
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
  height: 44px;
}
.chat_image {
  width: 150px;
}
.emoji-picker.picker {
  position: absolute;
  z-index: 1;
  font-family: Montserrat;
  border: 1px solid #ccc;
  width: 15rem;
  height: 20rem;
  overflow: scroll;
  padding: 1rem;
  box-sizing: border-box;
  border-radius: 0.5rem;
  background: #fff;
  box-shadow: 1px 1px 8px #c7dbe6;
  top: unset;
  bottom: 60px;
  right: unset;
}
@media (max-width: 600px) {
  .reply_box {
    position: fixed;
    bottom: 0;
    width: 100vw;
    left: 0;
    right: 0;
    border-radius: 10px 10px 0 0;
    z-index: 1030;
    overflow: hidden;
    margin: 0 auto;
    height: 100vh;
  }
  .reply {
    height: 83vh;
  }
}
</style>

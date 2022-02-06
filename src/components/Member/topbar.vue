<template>
  <div id="topbar">
    <span class="d-none d-sm-block ml-auto mr-3 search">
      <b-input-group size="sm" class="topbar_search">
        <b-form-input
          placeholder="Search"
          class="no-focus bg-transparent border-0"
          type="search"
          aria-label="Text input "
        ></b-form-input>
        <b-input-group-append is-text>
          <b-iconstack font-scale="2rem" class="mr-2">
            <b-icon stacked icon="circle-fill" variant="lighter-green"></b-icon>
            <b-icon
              stacked
              icon="search"
              scale="0.5"
              variant="dark-green"
            ></b-icon>
          </b-iconstack>
        </b-input-group-append> </b-input-group
    ></span>

    <span class="mr-4 fs14 d-none d-md-block">{{
      new Date() | moment("ll")
    }}</span>

    <div class="d-flex align-items-center d-sm-none">
      <div class="mr-3">
        <PushRotate
          width="250"
          :isOpen="isOpen"
          @openMenu="isOpen = true"
          @closeMenu="isOpen = false"
        >
          <div class="logo d-flex align-items-center">
            <div style="width: 40px; height: 40px" class="mr-2">
              <b-img fluid :src="$store.getters.member.org_profile"></b-img>
            </div>
            <h5 class="mb-0">{{ $store.getters.member.org_name }}</h5>
          </div>

          <router-link to="/me">
            <div class="side_item">
              <home-icon size="1.2x" class="custom-class"></home-icon>
              <span class="side-link px-2">Dashboard</span>
            </div>
          </router-link>
          <router-link to="/member/connections">
            <div class="side_item">
              <link-icon size="1.2x" class="custom-class"></link-icon>
              <span class="side-link px-2">Connections</span>
            </div>
          </router-link>

          <div>
            <div class="side_item" @click="toggleCommunity = !toggleCommunity">
              <folder-icon size="1.2x" class="custom-class"></folder-icon>
              <span class="side-link px-2">Community</span>
            </div>
            <div
              class="px-3 py-1 animate__slideInDown animate__slideInUp"
              v-if="toggleCommunity"
            >
              <router-link to="/me">
                <div class="side_item py-1">
                  <rss-icon size="1.2x" class="custom-class"></rss-icon>
                  <span class="side-link px-2"
                    ><span class="mr-5">Feed</span>
                  </span>
                </div>
              </router-link>
              <router-link to="/me/discussions">
                <div class="side_item py-1">
                  <twitch-icon size="1.2x" class="custom-class"></twitch-icon>
                  <span class="side-link px-2">Discussions</span>
                </div>
              </router-link>

              <router-link to="/me/events">
                <div class="side_item py-1">
                  <bookmark-icon
                    size="1.2x"
                    class="custom-class"
                  ></bookmark-icon>
                  <span class="side-link px-2">
                    <span class="mr-5">Events</span>
                  </span>
                </div>
              </router-link>
            </div>
          </div>

          <div>
            <div class="side_item" @click="toggleCourse = !toggleCourse">
              <calendar-icon size="1.2x" class="custom-class"></calendar-icon>
              <span class="side-link px-2">Course</span>
            </div>

            <div
              class="
                px-3
                py-1
                animate__slideInDown animate__slideInUp animate__slow
              "
              v-if="toggleCourse"
            >
              <router-link to="/me/courses">
                <div class="side_item py-1">
                  <folder-icon size="1.2x" class="custom-class"></folder-icon>
                  <span class="side-link px-2">Courses</span>
                </div>
              </router-link>
              <router-link to="/me/assessments">
                <div class="side_item py-1">
                  <database-icon size="1x" class="custom-class"></database-icon>
                  <span class="side-link px-2">Assessments</span>
                </div>
              </router-link>
              <router-link to="/me/library">
                <div class="side_item py-1">
                  <book-icon size="1.2x" class="custom-class"></book-icon>
                  <span class="side-link px-2">Library</span>
                </div>
              </router-link>
            </div>
          </div>

          <div>
            <div class="side_item" @click="toggleSchedule = !toggleSchedule">
              <b-icon icon="tools"></b-icon>
              <span class="side-link px-2">Tools</span>
            </div>
            <div
              class="px-3 py-1 animate__slideInDown animate__slideInUp"
              v-if="toggleSchedule"
            >
              <router-link to="/me/schedule">
                <div class="side_item py-1">
                  <calendar-icon
                    size="1.2x"
                    class="custom-class"
                  ></calendar-icon>
                  <span class="side-link px-2">Schedule</span>
                </div>
              </router-link>
            </div>
          </div>

          <router-link to="/me/referrals">
            <div class="side_item">
              <credit-card-icon
                size="1.2x"
                class="custom-class"
              ></credit-card-icon>
              <span class="side-link px-2">Bonuses</span>
            </div>
          </router-link>

          <hr class="mb-0" />

          <router-link to="/explore">
            <div class="side_item">
              <b-icon
                icon="app-indicator"
                font-scale="1.1"
                class="custom-class"
              ></b-icon>
              <span class="side-link px-2">Explore</span>
            </div></router-link
          >
          <router-link to="/">
            <div class="side_item">
              <b-icon
                icon="arrow-left"
                font-scale="1.1"
                class="custom-class"
              ></b-icon>
              <span class="side-link px-2">Back to Home</span>
            </div>
          </router-link>
          <div
            class="side_item d-flex flex-row align-iteems-center"
            @click="logout"
          >
            <log-out-icon size="1x" class="custom-class"></log-out-icon>
            <span
              class="side-link px-2 font-weight-normal ml-0"
              style="color: #a2a2c2"
              >Log out</span
            >
          </div>
        </PushRotate>
      </div>
      <div class="org_name" @click="$router.push('/me')">
        {{ this.$store.getters.member.org_name }}
      </div>
    </div>

    <div class="d-flex align-items-center">
      <div class="position-relative mr-2">
        <mail-icon
          size="1.5x"
          class="custom-class text-muted"
          id="inbox"
        ></mail-icon>
        <small class="unread">
          <b-badge variant="danger" v-if="unreadmesages.length">{{
            unreadmesages.length
          }}</b-badge></small
        >
      </div>

      <b-popover id="inbox1" target="inbox" triggers="hover" placement="bottom">
        <template #title>Inbox</template>
        <div class="inbox" v-if="chatter.length">
          <div
            class="inbox_message"
            v-for="(message, index) in chatter"
            :key="index"
          >
            <div class="px-3 py-1 d-flex border-bottom">
              <b-avatar size="1.8rem" :src="message.profile"></b-avatar>

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
                <span class="message_name fs12">{{ message.name }}</span>
                <br />
                <div
                  class="last_message fs11"
                  :class="
                    !lastMessage(message).status &&
                    lastMessage(message).user_id != $store.getters.member.id
                      ? 'font-weight-bold'
                      : ''
                  "
                >
                  <span
                    v-if="lastMessage(message).message"
                    class="text-muted"
                    v-html="lastMessage(message).message"
                  >
                  </span>
                  <span v-else class="text-muted fs11"
                    ><i>Sent attachment</i></span
                  >
                </div>
              </div>

              <div>
                <span class="message_time fs11">
                  {{ lastMessage(message).time | moment("LT") }}</span
                >
              </div>
            </div>
          </div>
        </div>
        <div
          v-else
          class="inbox d-flex justify-content-center align-content-center p-5"
        >
          <div class="text-muted">No Message Available</div>
        </div>
      </b-popover>

      <span>
        <b-dropdown size="sm" variant="transparent" no-caret class="no-focus">
          <template #button-content>
            <b-avatar
              :src="$store.getters.member.profile"
              id="profile"
              class="cursor-pointer mr-2"
              size="30px"
            ></b-avatar>
            <span class="fs14 d-none d-sm-inline">{{
              $store.getters.member.username
            }}</span>
          </template>

          <b-dropdown-item class="fs14" @click="$router.push(`/me/profile`)"
            >Profile</b-dropdown-item
          >

          <b-dropdown-item class="fs12" @click="logout">Logout</b-dropdown-item>
        </b-dropdown>
      </span>
    </div>
  </div>
</template>
<script>
import { PushRotate } from "vue-burger-menu";
import { MailIcon } from "vue-feather-icons";

import {
  HomeIcon,
  CalendarIcon,
  FolderIcon,
  BookIcon,
  RssIcon,
  TwitchIcon,
  LinkIcon,
  BookmarkIcon,
  DatabaseIcon,
  CreditCardIcon,
  LogOutIcon
} from "vue-feather-icons";
export default {
  components: {
    PushRotate,

    MailIcon,

    HomeIcon,
    CalendarIcon,
    FolderIcon,
    BookIcon,
    RssIcon,
    TwitchIcon,
    DatabaseIcon,
    LinkIcon,
    BookmarkIcon,
    CreditCardIcon,
    LogOutIcon
  },
  data() {
    return {
      isOpen: false,
      toggleMessage: true,
      open: false,
      showAll: false,
      toggleCourse: false,
      toggleCommunity: false,
      toggleSchedule: false,

      current: {
        id: "",
        type: ""
      },
      mini_info: {
        id: "",
        name: "",
        type: "",
        profile: ""
      }
    };
  },

  watch: {
    $route: "close"
  },
  methods: {
    close() {
      this.isOpen = false;
    },
    togglechat() {
      this.mini_info = {
        id: "",
        name: "",
        type: "",
        profile: ""
      };
    },
    logout() {
      localStorage.removeItem("authMember");
      this.$router.push("/login");
    },
    markread() {
      this.$http.get(`${this.$store.getters.url}/mark-notifications`, {
        headers: {
          Authorization: `Bearer ${this.$store.getters.member.access_token}`
        }
      });
    },
    lastMessage(info) {
      var mess = this.sortmessages.filter(item => {
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
    getmessage(id, name, type, profile) {
      this.current.id = id;
      this.current.type = type;
      this.mini_info.id = id;
      this.mini_info.username = name;
      this.mini_info.type = type;
      this.mini_info.profile = profile;
      this.$store.dispatch("getChatter", this.mini_info);
    },
    getinbox() {
      this.$http
        .get(`${this.$store.getters.url}/inboxes`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`
          }
        })
        .then(res => {
          if (res.status == 200) {
            this.sortmessages(res.data.reverse());
          }
        })
        .catch(err => {
          this.$toast.error(err.response.data.message);
        });
    }
  },
  computed: {
    unreadmesages() {
      return this.inboxes.filter(
        item =>
          !item.status &&
          item.receiver_id == this.$store.getters.member.id &&
          item.receiver == "user"
      );
    },
    inboxes() {
      return this.$store.getters.inboxes;
    },
    notifications() {
      return this.$store.getters.notifications;
    },
    unreadnotifications() {
      return this.$store.getters.notifications.filter(item => !item.read_at);
    },
    sortmessages() {
      return this.inboxes.map(item => {
        var info = {};

        if (item.user_id && item.user_id == this.$store.getters.member.id) {
          info.user = item.receiver_info || null;

          info.message = item.message || null;
          info.time = item.created_at || null;
          info.status = item.status;
          info.id = item.id;
          info.user_id = item.user_id;
        }
        if (
          item.receiver == "user" &&
          item.receiver_id == this.$store.getters.member.id
        ) {
          info.user = item.user || null;

          info.message = item.message || null;
          info.time = item.created_at || null;
          info.status = item.status;
          info.id = item.id;
        }

        return info;
      });
    },
    chatter() {
      var allnames = this.sortmessages.map(item => {
        var checkers = {};

        if (item.user && item.user.id != this.$store.getters.member.id) {
          checkers.id = item.user.id;
          checkers.type = "user";
          checkers.name = item.user.username;
          checkers.message = item.message;
          checkers.time = item.time;
          checkers.profile = item.user.profile;

          return checkers;
        }
      });
      console.log(
        "🚀 ~ file: topbar.vue ~ line 488 ~ allnames ~ allnames",
        allnames
      );
      return [
        ...new Set(
          allnames
            .filter(item => item)
            .map(item => {
              return JSON.stringify({
                name: item.name,
                id: item.id,
                type: item.type,
                profile: item.profile
              });
            })
        )
      ].map(item => JSON.parse(item));
    }
  }
};
</script>
<style scoped>
#topbar {
  height: 80px;
  background: #f8f7f7;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;
}

.side_header {
  font-size: 12px;
  padding: 1px 0 1px 30px;
}
.side_item {
  font-size: 14px;
  font-style: normal;
  font-weight: 400;
  line-height: 1.4;
  letter-spacing: 0em;
  text-align: left;
  color: #a2a2c2 !important;
  width: 100%;
  /* padding: 4px 0 4px 30px; */
  /* margin-bottom: 4px; */
  cursor: pointer;
}
.router-link-exact-active.router-link-active .side_item {
  color: var(--dark-green);
  border-right: 2px solid #388087;
}

.router-link-exact-active.router-link-active .side_item .b-icon.bi {
  color: white !important;
}

.side_item:hover .b-icon.bi {
  color: white !important;
}

.logo {
  padding: 0px 0 40px;
  flex-direction: row;
}
.org_name {
  font-size: 17px;
  font-weight: 500;
}
.search {
  width: 300px;
  background: transparent;
}
::placeholder {
  text-align: right;
}
</style>

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
        <PushRotate :closeOnNavigation="true" width="250">
          <div class="logo d-flex align-items-center">
            <div style="width: 40px; height: 40px" class="mr-2">
              <b-img fluid :src="$store.getters.learner.org_profile"></b-img>
            </div>
            <h5 class="mb-0">{{ $store.getters.learner.org_name }}</h5>
          </div>

          <router-link to="/learner">
            <div class="side_item">
              <home-icon size="1.2x" class="custom-class"></home-icon>
              <span class="side-link px-2">Dashboard</span>
            </div>
          </router-link>
          <router-link to="/learner/courses">
            <div class="side_item">
              <folder-icon size="1.2x" class="custom-class"></folder-icon>
              <span class="side-link px-2">Courses</span>
            </div>
          </router-link>
          <router-link to="/learner/assessments">
            <div class="side_item">
              <database-icon size="1x" class="custom-class"></database-icon>
              <span class="side-link px-2">Assessments</span>
            </div>
          </router-link>
          <router-link to="/learner/library">
            <div class="side_item">
              <book-icon size="1.2x" class="custom-class"></book-icon>
              <span class="side-link px-2">Library</span>
            </div>
          </router-link>
          <router-link to="/learner/schedule">
            <div class="side_item">
              <calendar-icon size="1.2x" class="custom-class"></calendar-icon>
              <span class="side-link px-2">Schedule</span>
            </div>
          </router-link>
          <router-link to="/learner/feeds">
            <div class="side_item">
              <rss-icon size="1.2x" class="custom-class"></rss-icon>
              <span class="side-link px-2"
                ><span class="mr-5">Feed</span>
              </span>
            </div>
          </router-link>
          <router-link to="/learner/discussions">
            <div class="side_item">
              <twitch-icon size="1.2x" class="custom-class"></twitch-icon>
              <span class="side-link px-2">Discussions</span>
            </div>
          </router-link>
          <router-link to="/learner/connections">
            <div class="side_item">
              <link-icon size="1.2x" class="custom-class"></link-icon>
              <span class="side-link px-2">Connections</span>
            </div>
          </router-link>
          <router-link to="/learner/events">
            <div class="side_item">
              <bookmark-icon size="1.2x" class="custom-class"></bookmark-icon>
              <span class="side-link px-2">
                <span class="mr-5">Events</span>
              </span>
            </div>
          </router-link>
          <router-link to="/learner/referrals">
            <div class="side_item">
              <credit-card-icon
                size="1.2x"
                class="custom-class"
              ></credit-card-icon>
              <span class="side-link px-2">Bonuses</span>
            </div>
          </router-link>

          <hr />

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
            <div class="side_item mt-1">
              <b-icon
                icon="arrow-left"
                font-scale="1.1"
                class="custom-class"
              ></b-icon>
              <span class="side-link px-2">Back to Home</span>
            </div>
          </router-link>
          <div class="side_item mt-1" @click="logout">
            <log-out-icon size="1x" class="custom-class"></log-out-icon>
            <span
              class="side-link px-2 font-weight-normal ml-0"
              style="color: #a2a2c2"
              >Log out</span
            >
          </div>
        </PushRotate>
      </div>
      <div class="org_name" @click="$router.push('/learner')">
        {{ this.$store.getters.learner.org_name }}
      </div>
    </div>

    <div class="d-flex align-items-center">
      <div class="position-relative mr-4">
        <bell-icon
          size="1.5x"
          class="custom-class text-dark-green"
          id="bell"
        ></bell-icon>
        <small class="notify_badge">
          <b-badge variant="danger" v-if="unreadnotifications.length">{{
            unreadnotifications.length
          }}</b-badge></small
        >
      </div>
      <b-popover
        id="notification1"
        target="bell"
        triggers="hover"
        placement="bottom"
      >
        <template #title>Notifications</template>
        <div class="notifications" v-if="notifications.length">
          <div class="notification_container">
            <div
              class="notify border-bottom"
              v-for="(item, id) in notifications"
              :key="id"
            >
              <div
                v-if="!item.read_at"
                @click="
                  $store.dispatch('markNotification', {
                    id: item.id,
                    user: $store.getters.learner,
                  })
                "
              >
                <div
                  class="fs12"
                  :class="{ 'font-weight-bold': !item.read_at }"
                >
                  {{ item.data.notification }}
                </div>

                <div class="fs11 text-right">
                  {{ item.created_at | moment("calendar") }}
                </div>
              </div>
              <div v-else>
                <span :class="{ 'font-weight-bold': !item.read_at }">
                  {{ item.data.notification }}</span
                >
                <br />
                <span class="fs11">{{
                  item.created_at | moment("calendar")
                }}</span>
              </div>
            </div>
          </div>
          <div class="text-center py-2 border-top text-lighter-green fs11">
            <span
              class="cursor-pointer"
              @click="
                $store.dispatch('markNotifications', $store.getters.learner)
              "
            >
              Mark all as read</span
            >
          </div>
        </div>
        <div v-else class="text-center text-muted notify px-2">
          No new notification !
        </div>
      </b-popover>
      <div class="position-relative mr-4">
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
            <div class="px-3 py-2 d-flex border-bottom">
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
                    lastMessage(message).user_id != $store.getters.learner.id
                      ? 'font-weight-bold'
                      : ''
                  "
                >
                  {{ lastMessage(message).message }}
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
              :src="$store.getters.learner.profile"
              id="profile"
              class="cursor-pointer mr-2"
              size="30px"
            ></b-avatar>
            <span class="fs14 d-none d-sm-inline">{{
              $store.getters.learner.name
            }}</span>
          </template>

          <b-dropdown-item
            class="fs14"
            @click="$router.push(`/learner/profile`)"
            >Profile</b-dropdown-item
          >

          <b-dropdown-item class="fs12" @click="logout">Logout</b-dropdown-item>
        </b-dropdown>
      </span>
    </div>

    <Minichat
      class="minichats"
      :user="'learner'"
      :mini_info="mini_info"
      :open="open"
      :showAll="showAll"
      @togglechat="togglechat"
    />
  </div>
</template>
<script>
import { PushRotate } from "vue-burger-menu";
import { MailIcon, BellIcon } from "vue-feather-icons";
import Minichat from "../minichat";
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
  LogOutIcon,
} from "vue-feather-icons";
export default {
  components: {
    PushRotate,
    Minichat,
    MailIcon,
    BellIcon,
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
    LogOutIcon,
  },
  data() {
    return {
      toggleMessage: true,
      open: false,
      showAll: false,

      current: {
        id: "",
        type: "",
      },
      mini_info: {
        id: "",
        name: "",
        type: "",
        profile: "",
      },
    };
  },

  mounted() {},

  methods: {
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
    logout() {
      localStorage.removeItem("authLearner");
      this.$router.push("/login");
    },
    markread() {
      this.$http.get(`${this.$store.getters.url}/mark-notifications`, {
        headers: {
          Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
        },
      });
    },
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
    getmessage(id, name, type, profile) {
      this.current.id = id;
      this.current.type = type;
      this.mini_info.id = id;
      this.mini_info.name = name;
      this.mini_info.type = type;
      this.mini_info.profile = profile;
      this.open = true;
      this.showAll = true;
    },
    getinbox() {
      this.$http
        .get(`${this.$store.getters.url}/inboxes`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
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
  },
  computed: {
    unreadmesages() {
      return this.inboxes.filter(
        (item) =>
          !item.status &&
          item.receiver_id == this.$store.getters.learner.id &&
          item.receiver == "learner"
      );
    },
    inboxes() {
      return this.$store.getters.inboxes;
    },
    notifications() {
      return this.$store.getters.notifications;
    },
    unreadnotifications() {
      return this.$store.getters.notifications.filter((item) => !item.read_at);
    },
    sortmessages() {
      return this.inboxes.map((item) => {
        var info = {};

        if (item.user_id && item.user_id == this.$store.getters.learner.id) {
          info.admin = item.admin_info || null;
          info.user = item.learner_info || null;
          info.facilitator = item.facilitator_info || null;
          info.message = item.message || null;
          info.time = item.created_at || null;
          info.status = item.status;
          info.id = item.id;
          info.user_id = item.user_id;
        }
        if (
          item.receiver == "user" &&
          item.receiver_id == this.$store.getters.learner.id
        ) {
          info.admin = item.admin || null;
          info.user = item.user || null;
          info.facilitator = item.facilitator || null;
          info.message = item.message || null;
          info.time = item.created_at || null;
          info.status = item.status;
          info.id = item.id;
        }

        return info;
      });
    },
    chatter() {
      var allnames = this.sortmessages.map((item) => {
        var checkers = {};

        if (item.user && item.user.id != this.$store.getters.learner.id) {
          checkers.id = item.user.id;
          checkers.type = "user";
          checkers.name = item.user.name;
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
          checkers.name = item.facilitator.name;
          checkers.message = item.message;
          checkers.time = item.time;
          checkers.profile = item.facilitator.profile;

          return checkers;
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

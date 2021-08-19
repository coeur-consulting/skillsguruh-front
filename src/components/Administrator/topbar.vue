<template>
  <div id="topbar">
    <span class="d-none d-sm-block">
      <b-input-group size="sm" class="mb-2 topbar_search">
        <b-input-group-prepend is-text>
          <b-icon icon="search" font-scale="1" class="text-muted"></b-icon>
        </b-input-group-prepend>
        <b-form-input
          placeholder="Search"
          class="bg-transparent border-0"
          type="search"
          aria-label="Text input "
        ></b-form-input> </b-input-group
    ></span>

    <div class="d-flex align-items-center d-sm-none">
      <div class="mr-2">
        <PushRotate :closeOnNavigation="true" width="250">
          <div class="logo d-flex align-items-center">
            <div style="width: 40px; height: 40px" class="mr-2">
              <b-img fluid :src="$store.getters.admin.org_profile"></b-img>
            </div>
            <h5 class="mb-0">{{ $store.getters.admin.org_name }}</h5>
          </div>

          <h6 class="mt-3 mb-1 text-dark-green side_header">PERSONAL</h6>
          <router-link to="/administrator">
            <div class="side_item">
              <b-icon
                icon="grid1x2"
                font-scale="1.1"
                class="mr-2 dark-green"
              ></b-icon>
              <span class="side-link">Dashboard</span>
            </div>
          </router-link>
          <router-link to="/administrator/team">
            <div class="side_item">
              <b-icon
                icon="person-badge"
                font-scale="1.1"
                class="mr-2 dark-green"
              ></b-icon>
              <span class="side-link">Team</span>
            </div>
          </router-link>
          <!-- <router-link to="/administrator/members">
          <div class="side_item">
            <b-icon
              icon="people"
              font-scale="1.1"
              class="mr-2 dark-green"
            ></b-icon>
            <span class="side-link">Members</span>
          </div>
        </router-link> -->
          <router-link to="/administrator/schedule">
            <div class="side_item">
              <b-icon
                icon="calendar-event"
                font-scale="1.1"
                class="mr-2 dark-green"
              ></b-icon>
              <span class="side-link">Schedule</span>
            </div>
          </router-link>

          <h6 class="mt-3 mb-1 text-dark-green side_header">PROGRAMS</h6>

          <router-link to="/administrator/courses">
            <div class="side_item">
              <b-icon
                icon="book"
                font-scale="1.1"
                class="mr-2 dark-green"
              ></b-icon>
              <span class="side-link">Courses</span>
            </div>
          </router-link>
          <!-- <router-link to="/administrator/outlines">
          <div class="side_item">
            <b-icon
              icon="card-list"
              font-scale="1.1"
              class="mr-2 dark-green"
            ></b-icon>
            <span class="side-link">Course outline</span>
          </div>
        </router-link>
        <router-link to="/administrator/modules">
          <div class="side_item">
            <b-icon
              icon="card-list"
              font-scale="1.1"
              class="mr-2 dark-green"
            ></b-icon>
            <span class="side-link">Course modules</span>
          </div>
        </router-link> -->

          <h6 class="mt-3 mb-1 text-dark-green side_header">COMMUNITY</h6>

          <router-link to="/administrator/connections">
            <div class="side_item">
              <b-icon
                icon="link45deg"
                font-scale="1.1"
                class="mr-2 dark-green"
              ></b-icon>
              <span class="side-link">Connections</span>
            </div>
          </router-link>
          <router-link to="/administrator/feeds">
            <div class="side_item">
              <b-icon
                icon="rss"
                font-scale="1.1"
                class="mr-2 dark-green"
              ></b-icon>
              <span class="side-link"><span class="mr-5">Feeds</span> </span>
            </div>
          </router-link>
          <router-link to="/administrator/events">
            <div class="side_item">
              <b-icon
                icon="bookmark"
                font-scale="1.1"
                class="mr-2 dark-green"
              ></b-icon>
              <span class="side-link">
                <span class="mr-5">Events</span>
              </span>
            </div>
          </router-link>
          <router-link to="/administrator/discussions">
            <div class="side_item">
              <b-icon
                icon="chat-left-quote"
                font-scale="1.1"
                class="mr-2 dark-green"
              ></b-icon>
              <span class="side-link">Discussions</span>
            </div>
          </router-link>

          <h6 class="mt-3 mb-1 text-dark-green side_header">OTHERS</h6>

          <router-link to="/administrator/question/templates">
            <div class="side_item">
              <b-icon
                icon="signpost-split"
                font-scale="1.1"
                class="mr-2 dark-green"
              ></b-icon>
              <span class="side-link">Templates</span>
            </div>
          </router-link>
          <router-link to="/administrator/insights">
            <div class="side_item">
              <b-icon
                icon="receipt"
                font-scale="1.1"
                class="mr-2 dark-green"
              ></b-icon>
              <span class="side-link">Insights</span>
            </div>
          </router-link>
          <router-link to="/administrator/referrals">
            <div class="side_item">
              <b-icon
                icon="signpost-split"
                font-scale="1.1"
                class="mr-2 dark-green"
              ></b-icon>
              <span class="side-link">Bonuses</span>
            </div>
          </router-link>

          <hr class="my-1" />

          <router-link to="/explore">
            <div class="side_item">
              <b-icon
                icon="app-indicator"
                font-scale="1.1"
                class="mr-2 dark-green"
              ></b-icon>
              <span class="side-link">Explore</span>
            </div></router-link
          >
          <router-link to="/">
            <div class="side_item mt-1">
              <b-icon
                icon="arrow-left"
                font-scale="1.1"
                class="mr-2 dark-green"
              ></b-icon>
              <span class="side-link">Back to Home</span>
            </div>
          </router-link>
          <div class="side_item mt-1" @click="logout">
            <b-icon
              icon="box-arrow-left"
              font-scale="1.1"
              class="mr-2 dark-green"
            ></b-icon>
            <span class="side-link text-dark-green font-weight-normal ml-0"
              >Log out</span
            >
          </div>
        </PushRotate>
      </div>
      <div class="org_name h4 mb-0" @click="$router.push('/administrator')">
        {{ this.$store.getters.admin.org_name }}
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
                    user: $store.getters.admin,
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
            </div>
          </div>
          <div class="text-center py-2 border-top text-dark-green fs11">
            <span
              class="cursor-pointer"
              @click="
                $store.dispatch('markNotifications', $store.getters.admin)
              "
            >
              Mark all as read</span
            >
          </div>
        </div>
        <div v-else class="text-center text-muted notify p-2">
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
        <div class="inbox py-3" v-if="chatter.length">
          <div
            class="inbox_message"
            v-for="(message, index) in chatter"
            :key="index"
          >
            <div class="px-3 py-3 d-flex border-bottom">
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
                    lastMessage(message).admin_id != $store.getters.admin.id
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
              :src="$store.getters.admin.profile"
              id="profile"
              class="cursor-pointer"
              size="30px"
            ></b-avatar>
          </template>

          <b-dropdown-item
            class="fs14"
            @click="$router.push(`/administrator/profile`)"
            >Profile</b-dropdown-item
          >

          <b-dropdown-item class="fs14" @click="logout">Logout</b-dropdown-item>
        </b-dropdown>
      </span>
    </div>

    <Minichat
      class="minichats"
      :user="'admin'"
      :mini_info="mini_info"
      :open="open"
      :showAll="showAll"
      @togglechat="togglechat"
    />
  </div>
</template>
<script>
import { BellIcon, MailIcon } from "vue-feather-icons";
import { PushRotate } from "vue-burger-menu";
import Minichat from "../minichat";
export default {
  components: {
    PushRotate,
    Minichat,
    BellIcon,
    MailIcon,
  },
  data() {
    return {
      toggleMessage: true,

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
      open: false,
      showAll: false,
    };
  },

  methods: {
    markMessagesRead() {
      let data = {
        ids: this.unreadmesages.map((item) => item.id),
      };
      this.$http.post(`${this.$store.getters.url}/inboxes/mark/read`, data, {
        headers: {
          Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
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
      localStorage.removeItem("authAdmin");
      this.$router.push("/login");
    },
    markread() {
      this.$http.get(`${this.$store.getters.url}/mark-notifications`, {
        headers: {
          Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
        },
      });
    },
    getmessage(id, name, type, profile) {
      this.current.id = id;
      this.current.type = type;
      this.mini_info.id = id;
      this.mini_info.name = name;
      this.mini_info.type = type;
      this.mini_info.profile = profile;
      this.$store.dispatch("getChatter", this.mini_info);
    },
  },
  computed: {
    unreadmesages() {
      return this.inboxes.filter(
        (item) =>
          !item.status &&
          item.receiver_id == this.$store.getters.admin.id &&
          item.receiver == "admin"
      );
    },
    notifications() {
      return this.$store.getters.notifications;
    },
    unreadnotifications() {
      return this.$store.getters.notifications.filter((item) => !item.read_at);
    },
    inboxes() {
      return this.$store.getters.inboxes;
    },
    sortmessages() {
      return this.inboxes.map((item) => {
        var info = {};

        if (item.admin_id && item.admin_id == this.$store.getters.admin.id) {
          info.admin = item.admin_info || null;
          info.user = item.member_info || null;
          info.facilitator = item.facilitator_info || null;
          info.message = item.message || null;
          info.time = item.created_at || null;
          info.status = item.status;
          info.id = item.id;
          info.admin_id = item.admin_id;
        }
        if (
          item.receiver == "admin" &&
          item.receiver_id == this.$store.getters.admin.id
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
        if (item.user) {
          checkers.id = item.user.id;
          checkers.type = "user";
          checkers.name = item.user.name;
          checkers.message = item.message;
          checkers.time = item.time;
          checkers.profile = item.user.profile;

          return checkers;
        }
        if (item.admin && item.admin.id != this.$$store.getters.admin.id) {
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
  padding: 1px 0 1px 0px;
  color: var(--dark-green);
}
.side_item {
  font-size: 14px;
  font-style: normal;
  font-weight: 400;
  line-height: 1.4;
  letter-spacing: 0em;
  text-align: left;
  color: var(--dark-green);
  padding: 0px;
  margin-bottom: 0;
  cursor: pointer;
}

.logo {
  padding: 0px 0 30px;
}
.org_name {
  font-size: 17px;
  font-weight: 500;
}
.logo {
  background: white;
}
</style>

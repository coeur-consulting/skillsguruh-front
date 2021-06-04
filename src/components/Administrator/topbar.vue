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
      <div class="mr-3">
        <PushRotate :closeOnNavigation="true" width="250">
          <div class="logo">
            <b-img
              class="mr-2"
              width="30px"
              style="width: 30px"
              height="auto"
              :src="$store.getters.admin.org_profile"
            ></b-img>
            <h5 class="mb-0">{{ $store.getters.admin.org_name }}</h5>
          </div>

          <router-link to="/administrator">
            <div class="side_item">
              <b-icon
                icon="grid1x2"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Dashboard</span>
            </div>
          </router-link>

          <h6 class="mt-2 mb-0 text-white side_header">TEAM</h6>
          <router-link to="/administrator/facilitators">
            <div class="side_item">
              <b-icon
                icon="person-badge"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Facilitators</span>
            </div>
          </router-link>
          <router-link to="/administrator/learners">
            <div class="side_item">
              <b-icon
                icon="people"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Learners</span>
            </div>
          </router-link>

          <h6 class="mt-2 mb-0 text-white side_header">COMMUNITY</h6>

          <router-link to="/administrator/connection">
            <div class="side_item">
              <b-icon
                icon="link45deg"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Connection</span>
            </div>
          </router-link>

          <h6 class="mt-2 mb-0 text-white side_header">PROGRAMS</h6>

          <router-link to="/administrator/courses">
            <div class="side_item">
              <b-icon
                icon="book"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Courses</span>
            </div>
          </router-link>
          <router-link to="/administrator/outlines">
            <div class="side_item">
              <b-icon
                icon="card-list"
                font-scale="1.1"
                class="mr-3 text-dark-green"
              ></b-icon>
              <span class="side-link">Course outline</span>
            </div>
          </router-link>
          <router-link to="/administrator/events">
            <div class="side_item">
              <b-icon
                icon="bookmark"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Events</span>
            </div>
          </router-link>

          <h6 class="mt-2 mb-0 text-white side_header">ACTIVITIES</h6>

          <router-link to="/administrator/feeds">
            <div class="side_item">
              <b-icon
                icon="rss"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Feeds</span>
            </div>
          </router-link>
          <router-link to="/administrator/discussions">
            <div class="side_item">
              <b-icon
                icon="chat-left-quote"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Discussion</span>
            </div>
          </router-link>

          <h6 class="mt-2 mb-0 text-white side_header">OTHERS</h6>

          <router-link to="/administrator/schedule">
            <div class="side_item">
              <b-icon
                icon="calendar-event"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Schedule</span>
            </div>
          </router-link>
          <router-link to="/administrator/insights">
            <div class="side_item">
              <b-icon
                icon="receipt"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Insights</span>
            </div>
          </router-link>
          <router-link to="/administrator/referrals">
            <div class="side_item">
              <b-icon
                icon="signpost-split"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Referrals</span>
            </div>
          </router-link>
          <router-link to="/administrator/bonuses">
            <div class="side_item">
              <b-icon
                icon="credit-card"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Bonuses</span>
            </div>
          </router-link>

          <div class="side_item mt-2 mb-4">
            <b-icon
              icon="box-arrow-left"
              font-scale="1.1"
              class="mr-3 text-white"
            ></b-icon>
            <span class="side-link">Log out</span>
          </div>
        </PushRotate>
      </div>
      <div class="org_name" @click="$router.push('/organization')">
        {{ this.$store.getters.organization.name }}
      </div>
    </div>

    <div class="d-flex align-items-center">
      <div class="position-relative mr-4">
        <b-icon
          id="bell"
          icon="bell"
          font-scale="1.5rem"
          class="text-dark-green"
        ></b-icon>
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
              <span :class="{ 'font-weight-bold': !item.read_at }">
                {{ item.data.notification }}</span
              >
              <br />
              <span class="fs11">{{
                item.created_at | moment("calendar")
              }}</span>
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

      <b-icon
        icon="envelope"
        id="inbox"
        font-scale="1.5rem"
        class="mr-4 text-muted cursor-pointer"
      ></b-icon>

      <b-popover id="inbox1" target="inbox" triggers="hover" placement="bottom">
        <template #title>Inbox</template>
        <div class="inbox py-3" v-if="chatters.length">
          <div
            class="inbox_message"
            v-for="(message, index) in chatters"
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
                <div class="last_message fs11">
                  {{ message.message }}
                </div>
              </div>

              <div>
                <span class="message_time fs11">
                  {{ message.time | moment("LT") }}</span
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

      <span @click="$router.push('/administrator/profile')">
        <b-avatar
          :src="$store.getters.admin.profile"
          id="profile"
          class="cursor-pointer"
          size="30px"
        ></b-avatar
      ></span>
    </div>

    <Minichat
      class="minichats d-none d-md-block"
      :user="'admin'"
      :mini_info="mini_info"
    />
  </div>
</template>
<script>
import { PushRotate } from "vue-burger-menu";
import Minichat from "../minichat";
export default {
  components: {
    PushRotate,
    Minichat,
  },
  data() {
    return {
      toggleMessage: true,
      inboxes: [],
      chatters: [],
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
  mounted() {
    this.getinbox();
  },
  methods: {
    logout() {
      localStorage.removeItem("authOrg");
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
        if (item.admin_id && item.admin_id == this.$store.getters.admin.id) {
          info.admin = item.admin_info || null;
          info.user = item.learner_info || null;
          info.facilitator = item.facilitator_info || null;
          info.message = item.message || null;
          info.time = item.created_at || null;
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
  computed: {
    notifications() {
      return this.$store.getters.notifications;
    },
    unreadnotifications() {
      return this.$store.getters.notifications.filter((item) => !item.read_at);
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
  color: white;
}
.side_item {
  font-size: 14px;
  font-style: normal;
  font-weight: 400;
  line-height: 1.4;
  letter-spacing: 0em;
  text-align: left;
  color: white;
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
</style>

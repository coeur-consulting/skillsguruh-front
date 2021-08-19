<template>
  <div id="app" class="position-relative">
    <router-view name="header" />

    <router-view class="bod" />

    <router-view name="footer" class="foot" />

    <div
      class="d-flex align-items-center mainnotification cursor-pointer"
      id="bell"
      v-if="useraccess"
    >
      <div
        class="
          position-relative
          d-flex d-md-none
          bg-secondary
          align-items-center
          p-2
          rounded-pill
        "
      >
        <b-icon icon="bell-fill" font-scale="1.2" variant="white"></b-icon>
        <small class="notify_badge">
          <b-badge variant="secondary" v-if="unreadnotifications.length">{{
            unreadnotifications.length
          }}</b-badge></small
        >
      </div>
      <div
        class="
          d-none d-md-flex
          position-relative
          bg-secondary
          align-items-center
          p-2
          rounded-pill
        "
      >
        <b-icon
          icon="bell-fill"
          :class="unreadnotifications.length ? 'animate__animated' : ''"
          class="animate__slower animate__shakeX animate__infinite infinite"
          font-scale="1.2"
          variant="white"
        ></b-icon>

        <b-badge
          variant="secondary"
          class="ml-1"
          v-if="unreadnotifications.length"
          >{{ unreadnotifications.length }}</b-badge
        >
      </div>
      <b-popover
        id="notification1"
        target="bell"
        triggers="hover"
        placement="topleft"
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
                    user: useraccess,
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
          <div class="text-center py-1 border-top text-dark-green fs11">
            <span
              class="cursor-pointer"
              @click="$store.dispatch('markNotifications', useraccess)"
            >
              Mark all as read</span
            >
          </div>
        </div>
        <div v-else class="text-center text-muted notify px-2">
          No new notification !
        </div>
      </b-popover>
    </div>
    <Chat
      :user="user"
      :mini_info="mini_info"
      :open="open"
      :showAll="showAll"
      @togglechat="togglechat"
    />
  </div>
</template>

<script>
import Chat from "@/components/minichat";
export default {
  data() {
    return {
      user: null,
      showMessage: true,
      toggleMessage: true,

      chatters: [],
      open: true,
      showAll: true,
      mini_info: {
        id: "",
        name: "",
        type: "",
        profile: "",
      },
      auth: false,
    };
  },
  watch: {
    $route: "getnotification",
  },

  components: {
    Chat,
  },
  mounted() {
    if (localStorage.getItem("authAdmin")) {
      this.user = "admin";
      this.auth = true;
    }
    if (localStorage.getItem("authFacilitator")) {
      this.user = "facilitator";
      this.auth = true;
    }
    if (localStorage.getItem("authMember")) {
      this.user = "member";
      this.auth = true;
    }
    if (this.auth) {
      var channel = this.$pusher.subscribe(`inbox.${this.useraccess.id}`);
      var notificationChannel = this.$pusher.subscribe("notifications");

      channel.bind("inboxSent", (data) => {
        this.$store.commit("ADD_MESSAGE", data);
        var user;
        if (data.user.qualifications) {
          user = "facilitator";
        } else {
          user = "user";
        }

        this.getmessage(
          data.user.id,
          data.user.username,
          user,
          data.user.profile
        );
      });
      notificationChannel.bind("notificationSent", () => {
        this.$store.dispatch("getNotifications", this.user);
      });
      this.getnotification();
    }
  },
  computed: {
    notifications() {
      return this.$store.getters.notifications;
    },
    unreadnotifications() {
      return this.$store.getters.notifications.filter((item) => !item.read_at);
    },
    useraccess() {
      var token = null;
      if (localStorage.getItem("authAdmin")) {
        return this.$store.getters.admin;
      }
      if (localStorage.getItem("authFacilitator")) {
        return this.$store.getters.facilitator;
      }
      if (localStorage.getItem("authMember")) {
        return this.$store.getters.member;
      }
      return token;
    },
  },

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
    getmessage(id, name, type, profile) {
      this.mini_info.id = id;
      this.mini_info.name = name;
      this.mini_info.type = type;
      this.mini_info.profile = profile;
      this.$store.dispatch("getChatter", this.mini_info);
    },
    getnotification() {
      if (localStorage.getItem("authAdmin")) {
        this.$store.dispatch("getNotifications", "admin");
      }
      if (localStorage.getItem("authFacilitator")) {
        this.$store.dispatch("getNotifications", "facilitator");
      }
      if (localStorage.getItem("authMember")) {
        this.$store.dispatch("getNotifications", "member");
      }
    },
  },
};
</script>
<style lang="scss">
#app {
  font-family: "Poppins", sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#nav {
  padding: 30px;

  a {
    font-weight: bold;
    color: #2c3e50;

    &.router-link-exact-active {
      color: #42b983;
    }
  }
}
.mainnotification {
  position: fixed;
  bottom: 50px;
  right: 35px;
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 999;
}
</style>

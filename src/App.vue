<template>
  <div id="app" class="position-relative">
    <router-view name="header" />

    <router-view />

    <router-view name="footer" />

    <div class="d-flex align-items-center mainnotification" id="bell">
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
        <b-icon icon="bell-fill" font-scale="1.3" variant="white"></b-icon>
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
          class="mr-1"
          font-scale="1.4"
          variant="white"
        ></b-icon>

        <b-badge variant="secondary" v-if="unreadnotifications.length">{{
          unreadnotifications.length
        }}</b-badge>
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
          <div class="text-center py-1 border-top text-lighter-green fs11">
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
  </div>
</template>

<script>
// import { BellIcon } from "vue-feather-icons";
export default {
  watch: {
    $route: "getnotification",
  },

  created() {
    var channel = this.$pusher.subscribe("inbox");
    var notificationChannel = this.$pusher.subscribe("notifications");

    channel.bind("inboxSent", (data) => {
      this.$store.commit("ADD_MESSAGE", data);
    });
    notificationChannel.bind("notificationSent", () => {
      this.$store.dispatch("getNotifications", "member");
    });
  },
  components: {
    // BellIcon,
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
  mounted() {
    this.getnotification();
  },
  methods: {
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

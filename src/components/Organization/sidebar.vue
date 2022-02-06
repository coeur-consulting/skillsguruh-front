<template>
  <div id="sidebar">
    <div class="logo_bar bg-white">
      <b-img
        @click="$router.push('/')"
        class="mr-2"
        height="30"
        src="/img/logo.png"
      ></b-img>
    </div>
    <div class="side_items">
      <router-link to="/organization">
        <div class="side_item">
          <b-icon icon="grid1x2-fill" font-scale="1.25" class="mr-3"></b-icon>
          <span class="side-link">Dashboard</span>
        </div>
      </router-link>
      <router-link to="/organization/admins">
        <div class="side_item">
          <b-icon icon="shield-fill" font-scale="1.25" class="mr-3"></b-icon>
          <span class="side-link">Administrators</span>
        </div>
      </router-link>

      <router-link to="/organization/mes">
        <div class="side_item">
          <b-icon icon="people-fill" font-scale="1.25" class="mr-3"></b-icon>
          <span class="side-link">Members</span>
        </div>
      </router-link>
      <router-link to="/organization/discussions">
        <div class="side_item">
          <b-icon
            icon="chat-left-quote-fill"
            font-scale="1.25"
            class="mr-3"
          ></b-icon>
          <span class="side-link">Discussions</span>
        </div>
      </router-link>
      <router-link to="/organization/events">
        <div class="side_item">
          <b-icon icon="bookmark-fill" font-scale="1.25" class="mr-3"></b-icon>
          <span class="side-link">Events</span>
        </div>
      </router-link>
      <router-link to="/organization/feed">
        <div class="side_item">
          <b-icon icon="rss-fill" font-scale="1.25" class="mr-3"></b-icon>
          <span class="side-link">Feed</span>
        </div>
      </router-link>
      <router-link to="/organization/reports">
        <div class="side_item">
          <b-icon
            icon="info-circle-fill"
            font-scale="1.25"
            class="mr-3"
          ></b-icon>
          <span class="side-link">Reports</span>
        </div>
      </router-link>
      <router-link to="/organization/schedule">
        <div class="side_item">
          <b-icon
            icon="calendar-event-fill"
            font-scale="1.25"
            class="mr-3"
          ></b-icon>
          <span class="side-link">Schedule</span>
        </div>
      </router-link>
      <!-- <router-link to="/organization/chat">
        <div class="side_item">
          <b-icon
            icon="chat-square-text"
            font-scale="1.25"
            class="mr-3 "
          ></b-icon>
          <span class="side-link">Chat</span>
        </div>
      </router-link> -->

      <div class="side_item mt-4" @click="logout">
        <b-icon icon="box-arrow-left" font-scale="1.1" class="mr-3"></b-icon>
        <span class="side-link">Log out</span>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  methods: {
    logout() {
      localStorage.removeItem("authOrg");
      this.$router.push("/login");
    },
    markread() {
      this.$http.get(`${this.$store.getters.url}/mark-notifications`, {
        headers: {
          Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
        },
      });
    },
  },
};
</script>

<style scoped lang="scss">
#sidebar {
  height: 100vh;
  overflow: hidden;
  color: #fff;
}
.logo_bar {
  /* background: #337177; */
  height: 80px;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  padding-left: 30px;
  text-align: center;
}
.side_items {
  padding: 40px 0;
  background: linear-gradient(
    173.56deg,
    #388087 5.07%,
    #18696d 62.76%,
    rgba(56, 128, 135, 0.79) 90.63%
  );
  height: calc(100vh - 80px);
  text-align: left;
}
.side_item {
  font-size: 16px;
  font-style: normal;
  font-weight: 600;
  line-height: 22px;
  letter-spacing: 0em;
  text-align: left;
  color: #fff;
  padding: 8px 0 8px 30px;
  margin-bottom: 24px;
  cursor: pointer;
  .b-icon.bi {
    color: #fff;
  }
}
.router-link-exact-active.router-link-active .side_item {
  background: white;
  color: var(--dark-green);
}

.router-link-exact-active.router-link-active .side_item .b-icon.bi {
  color: var(--dark-green) !important;
}
.side_item:hover {
  background: white;
   color: var(--dark-green);
    .b-icon.bi {
  color: var(--dark-green) !important;
}
}
</style>

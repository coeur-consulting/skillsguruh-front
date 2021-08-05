<template>
  <div id="sidebar">
    <div class="logo_bar">
      <b-img
        class="mr-2"
        width="30"
        height="30"
        style="object-fit: contain"
        :src="$store.getters.admin.org_profile"
      ></b-img>
      <h5 class="mb-0">{{ $store.getters.admin.org_name }}</h5>
    </div>
    <div class="side_items">
      <div>
        <h6 class="mt-3 mb-1 text-dark-green side_header">PERSONAL</h6>
        <router-link to="/administrator">
          <div class="side_item">
            <home-icon size="1x" class="custom-class"></home-icon>
            <span class="side-link p-2">Dashboard</span>
          </div>
        </router-link>
        <router-link to="/administrator/team">
          <div class="side_item">
            <users-icon size="1x" class="custom-class"></users-icon>
            <span class="side-link p-2">Team</span>
          </div>
        </router-link>
        <router-link to="/administrator/schedule">
          <div class="side_item">
            <calendar-icon size="1x" class="custom-class"></calendar-icon>
            <span class="side-link p-2">Schedule</span>
          </div>
        </router-link>
      </div>

      <div>
        <h6 class="mt-3 mb-1 text-dark-green side_header">PROGRAMS</h6>

        <router-link to="/administrator/courses">
          <div class="side_item">
            <trello-icon size="1x" class="custom-class"></trello-icon>
            <span class="side-link p-2">Courses</span>
          </div>
        </router-link>
        <!--    <router-link to="/administrator/assessment">
          <div class="side_item">
           <database-icon size="1x" class="custom-class"></database-icon>
            <span class="side-link p-2">Assessment</span>
          </div>
        </router-link> -->
      </div>
      <div>
        <h6 class="mt-3 mb-1 text-dark-green side_header">COMMUNITY</h6>

        <router-link to="/administrator/connections">
          <div class="side_item">
            <link-icon size="1x" class="custom-class"></link-icon>
            <span class="side-link p-2">Connections</span>
          </div>
        </router-link>
        <router-link to="/administrator/feeds">
          <div class="side_item">
            <rss-icon size="1x" class="custom-class"></rss-icon>
            <span class="side-link p-2">Feed </span>
          </div>
        </router-link>
        <router-link to="/administrator/events">
          <div class="side_item">
            <bookmark-icon size="1x" class="custom-class"></bookmark-icon>
            <span class="side-link">
              <span class="p-2">Events</span>
              <span v-if="activeaccount"
                ><b-badge variant="danger" size="sm">{{
                  activeaccount
                }}</b-badge></span
              ></span
            >
          </div>
        </router-link>
        <router-link to="/administrator/discussions">
          <div class="side_item">
            <twitch-icon size="1x" class="custom-class"></twitch-icon>
            <span class="side-link p-2">Discussions</span>
          </div>
        </router-link>
      </div>

      <div>
        <h6 class="mt-3 mb-1 text-dark-green side_header">OTHERS</h6>
        <router-link to="/administrator/question/templates">
          <div class="side_item">
            <layout-icon size="1x" class="custom-class"></layout-icon>
            <span class="side-link p-2">Templates</span>
          </div>
        </router-link>
        <router-link to="/administrator/insights">
          <div class="side_item">
            <arrow-up-right-icon
              size="1x"
              class="custom-class"
            ></arrow-up-right-icon>
            <span class="side-link p-2">Insights</span>
          </div>
        </router-link>
        <router-link to="/administrator/referrals">
          <div class="side_item">
            <credit-card-icon size="1x" class="custom-class"></credit-card-icon>
            <span class="side-link p-2">Bonuses</span>
          </div>
        </router-link>
      </div>

      <div class="side_item mt-4" @click="logout">
        <log-out-icon size="1x" class="custom-class"></log-out-icon>
        <span class="side-link p-2">Log out</span>
      </div>
    </div>
  </div>
</template>
<script>
import {
  HomeIcon,
  UsersIcon,
  TrelloIcon,
  CalendarIcon,
  LinkIcon,
  RssIcon,
  TwitchIcon,
  BookmarkIcon,
  LayoutIcon,
  CreditCardIcon,
  ArrowUpRightIcon,
  LogOutIcon,
} from "vue-feather-icons";

export default {
  components: {
    HomeIcon,
    UsersIcon,
    TrelloIcon,
    CalendarIcon,
    LinkIcon,
    RssIcon,
    TwitchIcon,
    BookmarkIcon,

    LayoutIcon,
    ArrowUpRightIcon,
    CreditCardIcon,
    LogOutIcon,
  },
  data() {
    return {
      events: [],
    };
  },
  computed: {
    activeaccount() {
      return this.events.filter((item) => item.status == "active").length;
    },
  },
  methods: {
    logout() {
      localStorage.removeItem("authAdmin");
      this.$router.push("/login");
    },
    getevents() {
      this.$http
        .get(`${this.$store.getters.url}/events`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.events = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
  },
};
</script>
<style scoped>
#sidebar {
  height: 100vh;
  overflow: hidden;
  color: var(--dark-green) !important;
  background: white;
  border-right: 1px solid #f7f8fa;
}
.logo_bar {
  height: 80px;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  padding-left: 30px;
}
.side_items {
  padding: 40px 0;

  height: calc(100vh - 80px);
  text-align: left;
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
  color: var(--dark-green);
  padding: 4px 0 4px 30px;
  margin-bottom: 4px;
  cursor: pointer;
}
.router-link-exact-active.router-link-active .side_item {
  background: rgba(56, 128, 135, 0.17);
  border-left: 2px solid #388087;
  /* color: white; */
}

.router-link-exact-active.router-link-active .side_item .b-icon.bi {
  color: white !important;
}
.side_item:hover .b-icon.bi {
  color: white !important;
}
/* .side_item:hover {
  background: var(--light-green);
  color: white;
} */
</style>

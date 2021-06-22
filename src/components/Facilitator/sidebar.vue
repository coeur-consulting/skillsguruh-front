<template>
  <div id="sidebar">
    <div class="logo_bar">
      <b-img
        class="mr-2"
        width="30"
        height="30"
        style="object-fit: contain"
        :src="$store.getters.facilitator.org_profile"
      ></b-img>
      <h5 class="mb-0">{{ $store.getters.facilitator.org_name }}</h5>
    </div>
    <div class="side_items">
      <div>
        <h6 class="mt-3 mb-1 text-dark-green side_header">PERSONAL</h6>
        <router-link to="/facilitator">
          <div class="side_item">
            <home-icon size="1x" class="custom-class"></home-icon>
            <span class="side-link p-2">Dashboard</span>
          </div>
        </router-link>
        <router-link to="/facilitator/team">
          <div class="side_item">
             <users-icon size="1x" class="custom-class"></users-icon>
            <span class="side-link p-2">Team</span>
          </div>
        </router-link>
        <!-- <router-link to="/facilitator/learners">
          <div class="side_item">
            <b-icon
              icon="people"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Learners</span>
          </div>
        </router-link> -->
        <router-link to="/facilitator/schedule">
          <div class="side_item">
             <calendar-icon size="1x" class="custom-class"></calendar-icon>
            <span class="side-link p-2">Schedule</span>
          </div>
        </router-link>
      </div>

      <div>
        <h6 class="mt-3 mb-1 text-dark-green side_header">PROGRAMS</h6>

        <router-link to="/facilitator/courses">
          <div class="side_item">
            <trello-icon size="1x" class="custom-class"></trello-icon>
            <span class="side-link p-2">Courses</span>
          </div>
        </router-link>
               <router-link to="/facilitator/assessment">
          <div class="side_item">
           <database-icon size="1x" class="custom-class"></database-icon>
            <span class="side-link p-2">Assessment</span>
          </div>
        </router-link>
        <!-- <router-link to="/facilitator/outlines">
          <div class="side_item">
            <b-icon
              icon="card-list"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Course outline</span>
          </div>
        </router-link>
        <router-link to="/facilitator/modules">
          <div class="side_item">
            <b-icon
              icon="card-list"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Course modules</span>
          </div>
        </router-link> -->
      </div>
      <div>
        <h6 class="mt-3 mb-1 text-dark-green side_header">COMMUNITY</h6>

        <router-link to="/facilitator/connections">
          <div class="side_item">
         <link-icon size="1x" class="custom-class"></link-icon>
            <span class="side-link p-2">Connections</span>
          </div>
        </router-link>
        <router-link to="/facilitator/feeds">
          <div class="side_item">
             <rss-icon size="1x" class="custom-class"></rss-icon>
            <span class="side-link p-2">Feeds </span>
          </div>
        </router-link>
        <router-link to="/facilitator/events">
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
        <router-link to="/facilitator/discussions">
          <div class="side_item">
            <twitch-icon size="1x" class="custom-class"></twitch-icon>
            <span class="side-link p-2">Discussions</span>
          </div>
        </router-link>
      </div>

      <div>
        <h6 class="mt-3 mb-1 text-dark-green side_header">OTHERS</h6>
        <router-link to="/facilitator/question/templates">
          <div class="side_item">
             <layout-icon size="1x" class="custom-class"></layout-icon>
            <span class="side-link p-2">Templates</span>
          </div>
        </router-link>
        <router-link to="/facilitator/insights">
          <div class="side_item">
           <arrow-up-right-icon size="1x" class="custom-class"></arrow-up-right-icon>
            <span class="side-link p-2">Insights</span>
          </div>
        </router-link>
        <router-link to="/facilitator/referrals">
          <div class="side_item">
            <credit-card-icon size="1x" class="custom-class"></credit-card-icon>
            <span class="side-link p-2">Bonuses</span>
          </div>
        </router-link>
      </div>

      <div class="side_item mt-4" @click="logout">
      <log-out-icon size="1x" class="custom-class"></log-out-icon>
        <span class="side-link p-2">Log out</span>
      <hr />
      <div class="mt-4">
        <router-link to="/explore">
          <div class="side_item mt-1">
            <b-icon
              icon="app-indicator"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Explore</span>
          </div></router-link
        >
        <router-link to="/">
          <div class="side_item mt-1">
            <b-icon
              icon="arrow-left"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Back to Home</span>
          </div>
        </router-link>
        <div class="side_item mt-1" @click="logout">
          <b-icon
            icon="box-arrow-left"
            font-scale="1.1"
            class="mr-3 text-dark-green"
          ></b-icon>
          <span class="side-link">Log out</span>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import
 {HomeIcon, UsersIcon, TrelloIcon, CalendarIcon, LinkIcon, RssIcon, TwitchIcon,
  BookmarkIcon, DatabaseIcon, LayoutIcon, CreditCardIcon, ArrowUpRightIcon, LogOutIcon}
  from "vue-feather-icons";
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
    DatabaseIcon,
    LayoutIcon,
    ArrowUpRightIcon,
    CreditCardIcon,
    LogOutIcon
  
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
      localStorage.removeItem("authfacilitator");
      this.$router.push("/login");
    },
    getevents() {
      this.$http
        .get(`${this.$store.getters.url}/events`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
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

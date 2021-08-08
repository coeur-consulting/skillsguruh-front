<template>
  <div id="sidebar">
    <div class="logo_bar">
      <b-img
        class="mr-2"
        width="30"
        height="30"
        :src="$store.getters.learner.org_profile"
        style="object-fit: contain"
      ></b-img>
      <h5 class="mb-0">{{ $store.getters.learner.org_name }}</h5>
    </div>
    <div class="side_items">
      <div>
        <router-link to="/learner">
          <div class="side_item py-2">
            <home-icon size="1.2x" class="custom-class"></home-icon>
            <span class="side-link p-3">Dashboard</span>
          </div>
        </router-link>
        <router-link to="/learner/connections">
          <div class="side_item py-2">
            <link-icon size="1.2x" class="custom-class"></link-icon>
            <span class="side-link p-3">Connections</span>
          </div>
        </router-link>

        <div>
          <div
            class="side_item py-2"
            @click="toggleCommunity = !toggleCommunity"
          >
            <folder-icon size="1.2x" class="custom-class"></folder-icon>
            <span class="side-link p-3">Community</span>
          </div>
          <div
            class="px-3 py-1 animate__slideInDown animate__slideInUp"
            v-if="toggleCommunity"
          >
            <router-link to="/learner/feeds">
              <div class="side_item py-1">
                <rss-icon size="1.2x" class="custom-class"></rss-icon>
                <span class="side-link p-3"
                  ><span class="mr-5">Feed</span>
                </span>
              </div>
            </router-link>
            <router-link to="/learner/discussions">
              <div class="side_item py-1">
                <twitch-icon size="1.2x" class="custom-class"></twitch-icon>
                <span class="side-link p-3">Discussions</span>
              </div>
            </router-link>

            <router-link to="/learner/events">
              <div class="side_item py-1">
                <bookmark-icon size="1.2x" class="custom-class"></bookmark-icon>
                <span class="side-link p-3">
                  <span class="mr-5">Events</span>
                </span>
              </div>
            </router-link>
          </div>
        </div>

        <div>
          <div class="side_item py-2" @click="toggleCourse = !toggleCourse">
            <calendar-icon size="1.2x" class="custom-class"></calendar-icon>
            <span class="side-link p-3">Course</span>
          </div>

          <div
            class="
              px-3
              py-1
              animate__slideInDown animate__slideInUp animate__slow
            "
            v-if="toggleCourse"
          >
            <router-link to="/learner/courses">
              <div class="side_item py-1">
                <folder-icon size="1.2x" class="custom-class"></folder-icon>
                <span class="side-link p-3">Courses</span>
              </div>
            </router-link>
            <router-link to="/learner/assessments">
              <div class="side_item py-1">
                <database-icon size="1x" class="custom-class"></database-icon>
                <span class="side-link p-3">Assessments</span>
              </div>
            </router-link>
            <router-link to="/learner/library">
              <div class="side_item py-1">
                <book-icon size="1.2x" class="custom-class"></book-icon>
                <span class="side-link p-3">Library</span>
              </div>
            </router-link>
          </div>
        </div>

        <div>
          <div class="side_item py-2" @click="toggleSchedule = !toggleSchedule">
            <b-icon icon="tools"></b-icon>
            <span class="side-link p-3">Tools</span>
          </div>
          <div
            class="px-3 py-1 animate__slideInDown animate__slideInUp"
            v-if="toggleSchedule"
          >
            <router-link to="/learner/schedule">
              <div class="side_item py-1">
                <calendar-icon size="1.2x" class="custom-class"></calendar-icon>
                <span class="side-link p-3">Schedule</span>
              </div>
            </router-link>
          </div>
        </div>

        <router-link to="/learner/referrals">
          <div class="side_item py-2">
            <credit-card-icon
              size="1.2x"
              class="custom-class"
            ></credit-card-icon>
            <span class="side-link p-3">Bonuses</span>
          </div>
        </router-link>
      </div>

      <hr />
      <div class="mt-4">
        <router-link to="/explore">
          <div class="side_item mt-1">
            <b-icon
              icon="app-indicator"
              font-scale="1.1"
              class="custom-class"
            ></b-icon>
            <span class="side-link p-2">Explore</span>
          </div></router-link
        >
        <router-link to="/">
          <div class="side_item mt-1">
            <b-icon
              icon="arrow-left"
              font-scale="1.1"
              class="custom-class"
            ></b-icon>
            <span class="side-link p-2">Back to Home</span>
          </div>
        </router-link>
        <div class="side_item mt-1" @click="logout">
          <log-out-icon size="1x" class="custom-class"></log-out-icon>
          <span class="side-link p-2">Log out</span>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
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
      events: [],
      toggleCourse: false,
      toggleCommunity: false,
      toggleSchedule: false,
    };
  },
  computed: {
    activeaccount() {
      return this.events.filter((item) => item.status == "active").length;
    },
  },
  methods: {
    logout() {
      localStorage.removeItem("authLearner");
      this.$router.push("/login");
    },
    getevents() {
      this.$http
        .get(`${this.$store.getters.url}/events`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
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
  color: #a2a2c2;
  padding: 4px 0 4px 30px;
  margin-bottom: 4px;
  cursor: pointer;
}
.router-link-exact-active.router-link-active .side_item {
  color: var(--dark-green);
  border-right: 2px solid #388087;
}

/* .router-link-exact-active.router-link-active .side_item .b-icon.bi {
  color: white !important;
}
.side_item:hover .b-icon.bi {
  color: white !important;
} */
/* .side_item:hover {
  background: rgba(56, 128, 135, 0.17);
  color: var(--dark-green);

} */
</style>

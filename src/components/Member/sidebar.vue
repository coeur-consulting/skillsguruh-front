<template>
  <div id="sidebar" class="py-4 d-grid">
    <div>
      <div class="side_tab_1" v-if="!$route.meta.showtribe">
        <nav class="mb-3 class text-left">
          <b-nav vertical>
            <b-nav-item to="/member/tribes">
              <b-img
                :src="require('@/assets/images/mask.png')"
                class="imgtribe mr-2"
                alt="tribe"
              />
              Tribes</b-nav-item
            >
            <b-nav-item to="/member/community">
              <b-img
                :src="require('@/assets/images/globe.png')"
                alt="community"
                class="imgtribe mr-2"
              />
              Community</b-nav-item
            >
          </b-nav>
        </nav>
      </div>

      <div class="side_tab_1 text-left" v-if="$route.meta.showtribe && tribe">
        <div class="mb-4 text-muted">
          <small
            @click="$router.push('/member/tribes')"
            class="pl-3 cursor-pointer back"
          >
            <span class="mr-2">
              <b-icon icon="arrow-left" class=""></b-icon
            ></span>
            <span>Back</span>
          </small>
        </div>
        <div class="d-flex justify-content-start align-items-center tribe_name">
          <b-avatar size="sm" :src="tribe.cover" class="mr-2"></b-avatar>
          <span class="">{{ tribe.name }} Tribe</span>
        </div>
        <nav class="mb-3 class text-left">
          <b-nav vertical>
            <b-nav-item :to="`/member/tribe/feed/${$route.params.id}`"
              ><font-awesome-icon
                :icon="rss"
                class="icon mr-3"
              />Feeds</b-nav-item
            >
            <b-nav-item :to="`/member/tribe/discussions/${$route.params.id}`">
              <font-awesome-icon
                :icon="comments"
                class="icon mr-3"
              />Discussions</b-nav-item
            >
            <b-nav-item :to="`/member/tribe/courses/${$route.params.id}`">
              <font-awesome-icon
                :icon="bookopen"
                class="icon mr-3"
              />Courses</b-nav-item
            >
            <b-nav-item :to="`/member/tribe/events/${$route.params.id}`">
              <font-awesome-icon
                :icon="calendar"
                class="icon mr-3"
              />Events</b-nav-item
            >
          </b-nav>
        </nav>
      </div>
    </div>

    <div class="mt-auto">
      <div
        class="side_item my-3"
        @click="leavetribe"
        v-if="$route.meta.showtribe"
      >
        <log-out-icon size="1x" class="custom-class"></log-out-icon>
        <span class="side-link p-2">Leave tribe</span>
      </div>

      <div class="border-top">
        <router-link to="/explore">
          <div class="side_item mt-1">
            <b-icon icon="app-indicator" font-scale="1.1" class="mr-2"></b-icon>
            <span class="side-link">Explore</span>
          </div></router-link
        >
        <router-link to="/">
          <div class="side_item mt-1">
            <b-icon icon="arrow-left" font-scale="1.1" class="mr-2"></b-icon>
            <span class="side-link">Back to Home</span>
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
  faCircle,
  faBell,
  faCaretDown,
  faCaretUp,
  faUsers,
  faRss,
  faBookOpen,
  faComments,
  faCalendar,
} from "@fortawesome/free-solid-svg-icons";
import { LogOutIcon } from "vue-feather-icons";
export default {
  components: {
    LogOutIcon,
  },
  data() {
    return {
      events: [],
      toggleCourse: false,
      toggleCommunity: false,
      toggleSchedule: false,
      circle: faCircle,
      bell: faBell,
      caretDown: faCaretDown,
      caretUp: faCaretUp,
      users: faUsers,
      comments: faComments,
      bookopen: faBookOpen,
      calendar: faCalendar,
      rss: faRss,
      tribe: {},
    };
  },
  watch: {
    $route: "handletribe",
  },
  computed: {
    activeaccount() {
      return this.events.filter((item) => item.status == "active").length;
    },
  },
  created() {},

  methods: {
    leavetribe() {
      var details = {
        tribe_id: this.$route.params.id,
        user: this.$store.getters.member,
      };
      this.$bvModal
        .msgBoxConfirm("Do you wish to leave this tribe?")
        .then((val) => {
          if (val) {
            this.$store.dispatch("leaveTribe", details).then((res) => {
              if (res.status == 200 && res.data.message == "successful") {
                this.$router.push(`/member/community`);
                this.$toast.success("You have left the tribe");
              }
            });
          }
        });
    },
    handletribe() {
      if (this.$route.params.id) {
        this.gettribe();
      }
    },
    gettribe() {
      this.$http
        .get(`${this.$store.getters.url}/tribes/${this.$route.params.id}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.tribe = res.data.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    switchTab(data) {
      switch (data) {
        case "one":
          if (!this.toggleCourse) {
            this.toggleCourse = true;
            this.toggleCommunity = this.toggleSchedule = false;
          } else {
            this.toggleCourse = false;
          }
          return;
        case "two":
          if (!this.toggleCommunity) {
            this.toggleCommunity = true;
            this.toggleCourse = this.toggleSchedule = false;
          } else {
            this.toggleCommunity = false;
          }
          return;
        case "three":
          if (!this.toggleSchedule) {
            this.toggleSchedule = true;
            this.toggleCommunity = this.toggleCourse = false;
          } else {
            this.toggleSchedule = false;
          }
          return;

        default:
          this.toggleSchedule =
            this.toggleCommunity =
            this.toggleCourse =
              false;
          break;
      }
    },
    logout() {
      localStorage.removeItem("authMember");
      this.$router.push("/login");
    },
    getevents() {
      this.$http
        .get(`${this.$store.getters.url}/events`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
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
  height: 90vh;
  overflow: hidden;
  width: 80%;
  color: var(--dark-green) !important;
  background: transparent;
  border-right: 1px solid #f7f8fa;
}
.logo_bar {
  display: flex;
  justify-content: flex-start;
  align-items: center;
  padding: 30px 0 0 30px;
}
.imgtribe {
  width: 30px;
}
nav .nav li {
  text-align: left;
}
nav .nav li a {
  color: #777777;
  font-weight: 500;
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
.icon {
  width: 25px;
}
.nav-item .nav-link.router-link-exact-active.router-link-active {
  color: var(--dark-green);
  background: #f4f4f8;
  border-right: 2px solid var(--dark-green);
}
.tribe_name {
  font-weight: bold;
  padding: 15px;
}
</style>

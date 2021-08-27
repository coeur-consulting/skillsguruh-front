<template>
  <b-navbar
    toggleable="md"
    type="light"
    variant="white"
    sticky
    class="shadow-sm py-2"
  >
    <b-col cols="4" sm="3" class="text-left d-flex align-items-center"
      ><b-navbar-brand href="/" class="mr-4"
        ><b-img class="logo" src="/icon.png"></b-img
      ></b-navbar-brand>

      <div class="position-relative d-none d-md-flex align-items-center">
        <b-icon icon="search" class="sbtn" font-scale=".9"></b-icon>
        <b-form-input
          class="rounded-pill pl-5 tsrch"
          size="sm"
          placeholder="Search Nzukoor"
        ></b-form-input>
      </div>
    </b-col>

    <b-col cols="2" sm="6" class="d-flex align-items-center">
      <b-navbar-toggle
        target="sidebar-right"
        v-b-toggle.sidebar-right
        class="border-0 w-100"
      >
        <template #default="{ expanded }">
          <div class="navtog">
            <div class="checked" v-if="expanded"></div>
            <span></span>
            <span></span>
            <span></span>
          </div>
        </template>
      </b-navbar-toggle>
      <b-collapse id="mynav" is-nav class="w-100">
        <b-navbar-nav class="align-items-center justify-content-center mx-auto">
          <b-nav-item to="/member/feeds" class="mr-sm-4 position-relative">
            <b-icon icon="circle-fill" class="dot" font-scale=".8"></b-icon>
            <font-awesome-icon :icon="rss" size="2x" class="icon"
          /></b-nav-item>
          <b-nav-item to="/member/community" class="mr-sm-4 position-relative">
            <b-icon icon="circle-fill" class="dot" font-scale=".8"></b-icon>
            <font-awesome-icon :icon="users" size="2x" class="icon" />
          </b-nav-item>

          <b-nav-item to="/member/courses" class="mr-sm-4 position-relative">
            <b-icon icon="circle-fill" font-scale=".8" class="dot"></b-icon>
            <font-awesome-icon :icon="bookopen" size="2x" class="icon"
          /></b-nav-item>
          <b-nav-item
            to="/member/discussions"
            class="mr-sm-4 position-relative"
          >
            <b-icon icon="circle-fill" class="dot" font-scale=".8"></b-icon>
            <font-awesome-icon :icon="comments" size="2x" class="icon"
          /></b-nav-item>

          <b-nav-item to="/member/events" class="position-relative">
            <b-icon icon="circle-fill" class="dot" font-scale=".8"></b-icon>
            <font-awesome-icon :icon="calendar" size="2x" class="icon"
          /></b-nav-item>
        </b-navbar-nav>
      </b-collapse>
    </b-col>

    <b-col cols="5" sm="3">
      <b-navbar-nav class="align-items-center justify-content-end flex-row">
        <b-nav-item class="mr-1">
          <b-avatar
            :src="$store.getters.member.profile"
            id="profile"
            class="cursor-pointer mr-2"
            size="30px"
          ></b-avatar>
          <span class="fs14 d-none d-sm-inline">{{
            $store.getters.member.username
          }}</span>
        </b-nav-item>
        <b-nav-item class="mr-1 position-relative">
          <span style="padding: 0.25rem 0.5rem; font-size: 0.875rem">
            <font-awesome-layers class="fa-3x" id="notifybell">
              <font-awesome-icon :icon="circle" class="text-lighter-green" />
              <font-awesome-icon
                :icon="bell"
                transform="shrink-6"
                class="text-dark-green"
              />
            </font-awesome-layers>
            <b-icon
              v-if="unreadnotifications.length"
              icon="circle-fill"
              variant="danger"
              font-scale=".8"
              class="notifier"
            ></b-icon>
          </span>
        </b-nav-item>

        <b-nav-item>
          <b-dropdown size="sm" variant="transparent" no-caret class="no-focus">
            <template #button-content>
              <font-awesome-layers class="fa-3x">
                <font-awesome-icon :icon="circle" class="text-lighter-green" />
                <font-awesome-icon
                  :icon="caretDown"
                  transform="shrink-6"
                  class="text-dark-green"
                />
              </font-awesome-layers>
            </template>

            <b-dropdown-item
              class="fs14"
              @click="$router.push(`/member/profile`)"
              >Profile</b-dropdown-item
            >

            <b-dropdown-item class="fs12" @click="logout"
              >Logout
            </b-dropdown-item>
          </b-dropdown>
        </b-nav-item>
      </b-navbar-nav>
    </b-col>
    <b-sidebar id="sidebar-right" left shadow>
      <template #title>
        <div><b-img style="width: 90px" src="/img/logo.png"></b-img></div>
      </template>
      <div>
        <div class="px-3 py-2">
          <b-navbar-nav
            class="align-items-center justify-content-center mx-auto flex-row"
          >
            <b-nav-item to="/member/feeds" class="mr-4 position-relative">
              <font-awesome-icon :icon="rss" size="2x" class="icon"
            /></b-nav-item>
            <b-nav-item to="/member/community" class="mr-4 position-relative">
              <font-awesome-icon :icon="users" size="2x" class="icon" />
            </b-nav-item>
            <b-nav-item to="/member/courses" class="mr-4 position-relative">
              <font-awesome-icon :icon="bookopen" size="2x" class="icon"
            /></b-nav-item>
            <b-nav-item to="/member/discussions" class="mr-4 position-relative">
              <font-awesome-icon :icon="comments" size="2x" class="icon"
            /></b-nav-item>

            <b-nav-item to="/member/events" class="position-relative">
              <font-awesome-icon :icon="calendar" size="2x" class="icon"
            /></b-nav-item>
          </b-navbar-nav>
        </div>
        <hr />
        <div id="sidebar" class="py-4">
          <div class="side_tab_1" v-if="!$route.meta.showtribe && tribe">
            <nav class="mb-3 class text-left">
              <b-nav vertical>
                <b-nav-item to="/member/tribe">
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
          <div
            class="side_tab_1 text-left"
            v-if="$route.meta.showtribe && tribe"
          >
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
            <div
              class="d-flex justify-content-start align-items-center tribe_name"
            >
              <b-avatar size="sm" :src="tribe.cover" class="mr-2"></b-avatar>
              <span class="">{{ tribe.name }} Tribe</span>
            </div>
            <nav class="mb-3 class text-left">
              <b-nav vertical>
                <b-nav-item :to="`/member/tribe/feed/${$route.params.tribe}`"
                  ><font-awesome-icon
                    :icon="rss"
                    class="icon mr-3"
                  />Feeds</b-nav-item
                >
                <b-nav-item
                  :to="`/member/tribe/discussions/${$route.params.tribe}`"
                >
                  <font-awesome-icon
                    :icon="comments"
                    class="icon mr-3"
                  />Discussions</b-nav-item
                >
                <b-nav-item
                  :to="`/member/tribe/courses/${$route.params.tribe}`"
                >
                  <font-awesome-icon
                    :icon="bookopen"
                    class="icon mr-3"
                  />Courses</b-nav-item
                >
                <b-nav-item :to="`/member/tribe/events/${$route.params.tribe}`">
                  <font-awesome-icon
                    :icon="calendar"
                    class="icon mr-3"
                  />Events</b-nav-item
                >
              </b-nav>
            </nav>
          </div>
          <div class="mt-auto">
            <div
              class="side_item my-3"
              @click="invitetotribe"
              v-if="$route.meta.showtribe"
            >
              <b-icon
                icon="person-plus"
                font-scale=""
                class="custom-class"
              ></b-icon>
              <span class="side-link p-2">Invite members</span>
            </div>
            <div
              class="side_item my-3"
              @click="leavetribe"
              v-if="$route.meta.showtribe"
            >
              <log-out-icon size="1x" class="custom-class"></log-out-icon>
              <span class="side-link p-2">Leave tribe</span>
            </div>
            <div class="border-top text-left p-3">
              <router-link to="/explore">
                <div class="side_item mt-1">
                  <b-icon
                    icon="app-indicator"
                    font-scale="1.1"
                    class="mr-2"
                  ></b-icon>
                  <span class="side-link">Explore</span>
                </div></router-link
              >
              <router-link to="/">
                <div class="side_item mt-1">
                  <b-icon
                    icon="arrow-left"
                    font-scale="1.1"
                    class="mr-2"
                  ></b-icon>
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
      </div>
    </b-sidebar>
    <b-popover
      id="notification1"
      target="notifybell"
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
              <div class="fs12" :class="{ 'font-weight-bold': !item.read_at }">
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
  </b-navbar>
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
  data() {
    return {
      authMember: false,
      authAdmin: false,
      authOrg: false,
      authFacilitator: false,
      showShadow: false,
      windowHeight: null,
      scrollPosition: null,
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
  components: {
    LogOutIcon,
  },
  watch: {
    $route: "getnotification",
  },

  created() {
    window.addEventListener("scroll", this.changeOnScroll);
  },

  mounted() {
    if (localStorage.getItem("authMember")) {
      this.authMember = true;
    } else if (localStorage.getItem("authFacilitator")) {
      this.authFacilitator = true;
    } else if (localStorage.getItem("authAdmin")) {
      this.authAdmin = true;
    } else if (localStorage.getItem("authOrg")) {
      this.authOrg = true;
    } else {
      return;
    }
  },
  computed: {
    version() {
      return process.env.VUE_APP_VERSION;
    },
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
    invitetotribe() {},
    leavetribe() {
      var details = {
        tribe_id: this.$route.params.tribe,
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
    gettribe() {
      this.$http
        .get(`${this.$store.getters.url}/tribes/${this.$route.params.tribe}`, {
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
    getnotification() {
      if (this.$route.params.tribe && !this.$route.meta.showtribe) {
        this.gettribe();
      }
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
    changeOnScroll() {
      this.scrollPosition = window.scrollY;
      this.scrollPosition > this.windowHeight * 0.1
        ? (this.showShadow = true)
        : (this.showShadow = false);
    },

    logout() {
      localStorage.clear();
      window.location.reload();
    },
  },
};
</script>
<style scoped lang="scss">
.tribe_name {
  font-size: 0.9rem;
  font-weight: bold;
  padding: 15px;
}
.shadow-sm {
  box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.15) !important;
}
.navbar-light .navbar-nav .nav-link {
  color: rgb(0, 0, 0);
  font-weight: 500;
}
.navbar-light .navbar-nav .nav-link:hover,
.navbar-light .navbar-nav .nav-link:focus {
  color: var(--secondary);
}

.nav-link .icon {
  color: rgba(0, 0, 0, 0.35);
}
.nav-link .dot {
  opacity: 0;
}
.nav-link.router-link-exact-active .dot,
.nav-link.router-link-exact-active .icon {
  color: var(--dark-green);
  opacity: 1;
}
.navtog {
  display: flex;
  flex-direction: column;
  cursor: pointer;
  margin: 0;
}

.navtog span {
  background: var(--dark-green);
  border-radius: 10px;
  height: 3px;
  margin: 3px 0;
  transition: 0.4s cubic-bezier(0.68, -0.6, 0.32, 1.6);
}

.navtog span:nth-of-type(1) {
  width: 50%;
}

.navtog span:nth-of-type(2) {
  width: 100%;
}

.navtog span:nth-of-type(3) {
  width: 75%;
}

.checked ~ span:nth-of-type(1) {
  transform-origin: bottom;
  transform: rotatez(45deg) translate(5px, 0px);
}

.checked ~ span:nth-of-type(2) {
  transform-origin: top;
  transform: rotatez(-45deg);
}

.checked ~ span:nth-of-type(3) {
  transform-origin: bottom;
  width: 50%;
  transform: translate(13px, -5px) rotatez(45deg);
}
.logo {
  width: 30px;
}

.tsrch {
  background: var(--lighter-green);
  color: var(--dark-green);
}
.sbtn {
  position: absolute;
  left: 10px;
  color: rgba(0, 0, 0, 0.55);
}
.sbtn:hover {
  color: rgba(0, 0, 0, 0.7);
}
.dot {
  position: absolute;
  top: -25px;
  transform: translateX(50%);
  margin-left: 0px;
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
}
.imgtribe {
  width: 30px;
}
nav .nav li {
  text-align: left;
}
nav .nav li a {
  color: #777777;
}
.notifier {
  position: absolute;
  top: 8px;
  right: 10px;
}

@media (max-width: 600px) {
  .navbar-light .navbar-nav .nav-link {
    font-size: 14px;
  }
  .fa-layers {
    font-size: 2.5em !important;
  }
  .side_item {
    font-size: 14px;
  }
  a {
    color: #777777;
  }
  #sidebar {
    height: 60vh;
    display: grid;
  }
}
</style>

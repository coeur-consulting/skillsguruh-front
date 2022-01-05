<template>
  <b-navbar
    toggleable="md"
    type="light"
    variant="white"
    sticky
    class="border-bottom py-0"
  >
    <b-col
      cols="3"
      sm="4"
      class="text-left d-flex align-items-center pl-0 pl-md-3"
    >
      <b-navbar-toggle
        target="sidebar-right"
        v-b-toggle.sidebar-right
        class="border-0 w-100 mr-3"
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
      <b-navbar-brand href="/" class="mr-md-4">
        <b-img class="logo" src="/img/logo.png"></b-img>
      </b-navbar-brand>

      <div class="position-relative d-none d-md-flex align-items-center">
        <!-- <b-icon icon="search" class="sbtn" font-scale=".9"></b-icon>
        <b-form-input
          class="rounded-pill pl-5 tsrch"
          size="sm"
          placeholder="Search Nzukoor"
        ></b-form-input> -->
        <div id="google_translate_element"></div>

      </div>
    </b-col>

    <b-col cols="2" sm="4" class="d-flex align-items-center">
      <b-collapse id="mynav" is-nav class="w-100">
        <b-navbar-nav class="align-items-center justify-content-center mx-auto">
          <b-nav-item to="/explore" class="mr-sm-4 position-relative">
            <b-icon icon="circle-fill" class="dot" font-scale=".8"></b-icon>
            <font-awesome-icon
              :icon="globe"
              size="2x"
              class="icon"
              v-b-tooltip.hover
              title="Explore"
          /></b-nav-item>

          <b-nav-item to="/member/feeds" class="mr-sm-4 position-relative">
            <b-icon icon="circle-fill" class="dot" font-scale=".8"></b-icon>
            <font-awesome-icon
              :icon="rss"
              size="2x"
              class="icon"
              v-b-tooltip.hover
              title="Feed"
          /></b-nav-item>
          <b-nav-item to="/explore/community" class="mr-sm-4 position-relative">
            <b-icon icon="circle-fill" class="dot" font-scale=".8"></b-icon>
            <font-awesome-icon
              :icon="users"
              size="2x"
              class="icon"
              v-b-tooltip.hover
              title="Community"
            />
          </b-nav-item>
          <!--
          <b-nav-item to="/member/courses" class="mr-sm-4 position-relative">
            <b-icon icon="circle-fill" font-scale=".8" class="dot"></b-icon>
            <font-awesome-icon :icon="bookopen" size="2x" class="icon"
          /></b-nav-item> -->
          <b-nav-item
            v-if="useraccess"
            to="/member/discussions"
            class="mr-sm-4 position-relative"
          >
            <b-icon icon="circle-fill" class="dot" font-scale=".8"></b-icon>
            <font-awesome-icon
              :icon="comments"
              size="2x"
              class="icon"
              v-b-tooltip.hover
              title="Discussions"
          /></b-nav-item>

          <b-nav-item
            v-else
            to="/member/explore/discussions"
            class="mr-sm-4 position-relative"
          >
            <b-icon icon="circle-fill" class="dot" font-scale=".8"></b-icon>
            <font-awesome-icon :icon="comments" size="2x" class="icon"
          /></b-nav-item>

          <!-- <b-nav-item to="/member/events" class="position-relative">
            <b-icon icon="circle-fill" class="dot" font-scale=".8"></b-icon>
            <font-awesome-icon :icon="calendar" size="2x" class="icon"
          /></b-nav-item> -->
        </b-navbar-nav>
      </b-collapse>
    </b-col>

    <b-col cols="7" sm="4" class="pr-0 pr-sm-3">
      <b-navbar-nav
        class="align-items-center justify-content-end flex-row"
        v-if="useraccess"
      >
        <b-nav-item class="position-relative last_nav mr-2">
          <div class="position-relative">
            <font-awesome-layers class="fa-2x" id="notifybell">
              <font-awesome-icon :icon="circle" class="text-lighter-green" />
              <font-awesome-icon
                :icon="bell"
                transform="shrink-7"
                class="text-dark-green"
              />
            </font-awesome-layers>
            <span class="notifier" v-if="unreadnotifications.length">
              <b-icon
                icon="circle-fill"
                variant="danger"
                font-scale=".53"
                class="circle-dot"
              ></b-icon>
            </span>
          </div>
        </b-nav-item>
        <b-nav-item class="last_nav mr-2">
          <div class="position-relative d-none d-md-block" id="inbox">
            <font-awesome-layers class="fa-2x">
              <font-awesome-icon :icon="circle" class="text-lighter-green" />
              <font-awesome-icon
                :icon="envelope"
                transform="shrink-7"
                class="text-dark-green"
              />
            </font-awesome-layers>
            <small class="unread">
              <b-badge variant="danger" v-if="unreadmesages">{{
                unreadmesages
              }}</b-badge></small
            >
          </div>
           <div class="position-relative d-md-none" @click="$router.push('/messages')">
            <font-awesome-layers class="fa-2x">
              <font-awesome-icon :icon="circle" class="text-lighter-green" />
              <font-awesome-icon
                :icon="envelope"
                transform="shrink-7"
                class="text-dark-green"
              />
            </font-awesome-layers>
            <small class="unread">
              <b-badge variant="danger" v-if="unreadmesages">{{
                unreadmesages
              }}</b-badge></small
            >
          </div>


          <b-popover
            id="inbox1"
            target="inbox"
            triggers="hover"
            placement="bottom"
          >
            <template #title>Inbox</template>
            <div class="inbox" v-if="connections.length">
              <b-list-group>
                <b-list-group-item
                  v-for="(item, index) in connections"
                  :key="index"
                  class="d-flex px-2 border-0 border-bottom list"
                  @click="
                    getmessage(
                      item.user_follower.id,
                      item.user_follower.username,
                      'user',
                      item.user_follower.profile,
                      index
                    )
                  "
                >
                  <b-avatar
                    class="mr-2"
                    :src="item.user_follower.profile"
                  ></b-avatar>
                  <span class="text-left flex-grow-1">
                    <span
                      class="
                        d-flex
                        align-items-center
                        justify-content-between
                        flex-1
                      "
                      ><p
                        class="
                          mb-0
                          text-truncate text-truncate--1
                          text-capitalize
                        "
                        :class="
                          item.unread_message
                            ? 'font-weight-bold'
                            : 'text-muted'
                        "
                      >
                        {{ item.user_follower.username }}
                      </p>
                      <span
                        class="chat_time"
                        :class="
                          item.unread_message
                            ? 'font-weight-bold'
                            : 'text-muted'
                        "
                        v-if="item.last_message"
                        >{{
                          $moment(item.last_message.created_at).fromNow()
                        }}</span
                      ></span
                    >
                    <span
                      class="d-flex justify-content-between w-100"
                      v-if="item.last_message"
                    >
                      <small
                        class="text-truncate text-truncate--1"
                        :class="
                          item.unread_message
                            ? 'font-weight-bold'
                            : 'text-muted'
                        "
                        >{{
                          item.last_message.message
                            ? item.last_message.message
                            : "Sent attachment..."
                        }}</small
                      >
                      <small v-if="item.unread_message">
                        <b-badge variant="primary">{{
                          item.unread_message
                        }}</b-badge></small
                      >
                    </span>
                  </span>
                </b-list-group-item>
              </b-list-group>
            </div>
            <div
              v-else
              class="
                inbox
                d-flex
                justify-content-center
                align-content-center
                p-md-5 p-3
                mb-1
              "
            >
              <div class="text-muted">No Message Available</div>
            </div>
          </b-popover>
        </b-nav-item>

        <b-nav-item class="profile">
          <b-dropdown
            size="sm"
            variant="transparent"
            no-caret
            class="no-focus"
            id="prof_ava"
          >
            <template #button-content>
              <!-- <font-awesome-layers class="fa-3x">
                <font-awesome-icon :icon="circle" class="text-lighter-green" />
                <font-awesome-icon
                  :icon="caretDown"
                  transform="shrink-6"
                  class="text-dark-green"
                />
              </font-awesome-layers> -->
              <b-avatar
                :src="$store.getters.member.profile"
                id="profile"
                class="cursor-pointer mr-sm-2"
                size="30px"
              ></b-avatar>
              <span class="fs14 d-none d-sm-inline">{{
                $store.getters.member.username
              }}</span>
            </template>

            <b-dropdown-item
              class="fs14"
              @click="$router.push(`/member/profile`)"
            >
              <div class="d-flex align-items-center justify-content-between">
                <span class="mr-4"> Profile</span>
                <b-icon font-scale=".8" icon="chevron-right"></b-icon>
              </div>
            </b-dropdown-item>

            <b-dropdown-item class="fs14" @click="logout"
              >Logout
            </b-dropdown-item>
          </b-dropdown>
        </b-nav-item>
      </b-navbar-nav>
      <b-navbar-nav
        v-else
        class="align-items-center justify-content-end flex-row"
      >
        <b-nav-item to="/login">Login</b-nav-item>
        <b-nav-item to="/register">Register</b-nav-item>
      </b-navbar-nav>
    </b-col>
    <b-sidebar id="sidebar-right" left shadow>
      <template #title>
        <div><b-img style="width: 90px" src="/img/logo.png"></b-img></div>
      </template>
      <div>
        <div class="px-3 py-2">
          <b-navbar-nav
            class="
              align-items-center
              justify-content-md-center
              mx-md-auto
              flex-row
            "
          >
            <b-nav-item to="/explore" class="mr-4 position-relative">
              <font-awesome-icon :icon="globe" size="2x" class="icon" />
            </b-nav-item>
            <b-nav-item to="/member/feeds" class="mr-4 position-relative">
              <font-awesome-icon :icon="rss" size="2x" class="icon"
            /></b-nav-item>
            <b-nav-item to="/explore/community" class="mr-4 position-relative">
              <font-awesome-icon :icon="users" size="2x" class="icon" />
            </b-nav-item>
            <!-- <b-nav-item to="/member/courses" class="mr-4 position-relative">
              <font-awesome-icon :icon="bookopen" size="2x" class="icon"
            /></b-nav-item> -->
            <b-nav-item to="/member/discussions" class="mr-4 position-relative">
              <font-awesome-icon :icon="comments" size="2x" class="icon"
            /></b-nav-item>

            <!-- <b-nav-item to="/member/events" class="position-relative">
              <font-awesome-icon :icon="calendar" size="2x" class="icon"
            /></b-nav-item> -->
          </b-navbar-nav>
        </div>
        <hr />
        <div id="sidebar" class="py-4">
          <div class="side_tab_1" v-if="!$route.meta.showtribe && tribe">
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
                <!-- <b-nav-item
                  :to="`/member/tribe/courses/${$route.params.tribe}`"
                >
                  <font-awesome-icon
                    :icon="bookopen"
                    class="icon mr-3"
                  />Courses</b-nav-item
                > -->
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
              class="side_item my-2"
              @click="leavetribe"
              v-if="$route.meta.showtribe"
            >
              <log-out-icon size="1x" class="custom-class"></log-out-icon>
              <span class="side-link p-2">Leave tribe</span>
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
                  url: item.data.url ? item.data.url : null,
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
            <div v-else @click="handleNotificationClick(item)">
              <div
                :class="{ 'font-weight-bold': !item.read_at }"
                v-html="item.data.notification"
              ></div>

              <div class="fs11 text-right">
                {{ item.created_at | moment("calendar") }}
              </div>
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
    <b-modal id="sharecourse" centered hide-footer>
      <div class="box p-3 text-center">
        <h6 class="text-center">Invite your friends</h6>
        <div>
          <div
            v-for="(item, id) in inviteUsers"
            :key="id"
            class="mb-1 text-center"
          >
            <b-input-group size="sm" class="">
              <template #append>
                <b-button @click="inviteUsers.splice(id, 1)"
                  ><strong>x</strong></b-button
                >
              </template>
              <b-form-input
                type="email"
                v-model="item.email"
                placeholder="Enter email address"
              ></b-form-input>
            </b-input-group>
          </div>
          <div class="text-center mt-3">
            <b-button
              size="sm"
              class="mr-3"
              variant="lighter-green"
              @click="addinvite"
            >
              <b-icon icon="plus" font-scale="1.4"></b-icon> Add email</b-button
            >
            <b-button
              size="sm"
              variant="dark-green"
              @click="sendinvite"
              :disabled="sending"
            >
              Send Invite
            </b-button>
          </div>
        </div>
        <div class="p-2 text-center">
          <h6 class="font-weight-bold mb-3">Share</h6>
          <ShareNetwork
            class="mr-3"
            network="facebook"
            :url="link"
            title="Come Join my tribe on Nzùkóór:"
            :description="description"
            quote="Nzukoor"
            hashtags="Nzukoor,  Social learning"
          >
            <b-button
              size="sm"
              class="mb-2 mb-sm-0"
              variant="outline-dark-green"
              ><b-icon class="mr-1" icon="facebook"></b-icon>
              <span class="d-none d-md-block">Facebook</span></b-button
            >
          </ShareNetwork>
          <ShareNetwork
            class="mr-3"
            network="twitter"
            :url="link"
            title="Come Join my tribe on Nzùkóór:"
            :description="description"
            quote="Nzukoor"
            hashtags="Nzukoor,  Social learning"
          >
            <b-button
              size="sm"
              class="mb-2 mb-sm-0"
              variant="outline-dark-green"
              ><b-icon class="mr-1" icon="twitter"></b-icon>
              <span class="d-none d-md-block">Twitter</span>
            </b-button>
          </ShareNetwork>
          <ShareNetwork
            class="mr-3"
            network="whatsApp"
            :url="link"
            title="Come Join my tribe on Nzùkóór:"
            :description="description"
            quote="Nzukoor"
            hashtags="Nzukoor,  Social learning"
          >
            <b-button
              size="sm"
              class="mb-2 mb-sm-0"
              variant="outline-dark-green"
            >
              <b-iconstack>
                <b-icon
                  stacked
                  icon="circle-fill"
                  variant="dark-green"
                ></b-icon>
                <b-icon
                  stacked
                  icon="telephone-plus"
                  variant="light"
                  scale="0.5"
                ></b-icon>
              </b-iconstack>
              <span class="d-none d-md-block">Whatsapp</span>
            </b-button>
          </ShareNetwork>
          <ShareNetwork
            class="mr-3"
            network="Telegram"
            :url="link"
            title="Come Join my tribe on Nzùkóór:"
            :description="description"
            quote="Nzukoor"
            hashtags="Nzukoor,  Social learning, Feeds"
          >
            <b-button
              size="sm"
              class="mb-2 mb-sm-0"
              variant="outline-dark-green"
              ><b-icon class="mr-1" icon="cursor-fill"></b-icon>
              <span class="d-none d-md-block">Telegram</span>
            </b-button>
          </ShareNetwork>
        </div>
      </div>
    </b-modal>
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
  faEnvelope,
  faGlobe,
} from "@fortawesome/free-solid-svg-icons";
import { LogOutIcon } from "vue-feather-icons";
import { bus } from "@/main.js";
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
      envelope: faEnvelope,
      globe: faGlobe,
      tribe: {},
      inviteUsers: [
        {
          email: "",
        },
      ],

      sending: false,
      link: "",
      description: "",
      connections: [],
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
    var channel = this.$pusher.subscribe(
      `inbox.${this.$store.getters.member.id}`
    );

    channel.bind("inboxSent", (data) => {
      var id = data.message.user.id;
      this.connections.map((item) => {
        if (item.user_follower.id == id) {
          item.unread_message = item.unread_message + 1;
          item.last_message = data.message;
        }
        return item;
      });
      var index = this.connections.findIndex((item) => {
        return item.user_follower.id == id;
      });

      this.connections = this.arrMove(this.connections, index, 0);
    });
    bus.$on("lastmessage", (res) => {
      this.connections[res.index].last_message.message = res.message;
      this.connections[res.index].last_message.created_at = this.$moment.now();
      this.connections = this.arrMove(this.connections, res.index, 0);
    });
    bus.$on("unreadmessage", (res) => {
      this.connections[res.index].unread_message = 0;
    });
  },

  mounted() {
    this.link = `https://nzukoor.com/register?tribe_id=${this.$route.params.tribe}`;

    this.gettribe();
    if (localStorage.getItem("authMember")) {
      this.authMember = true;
    }
    this.getconnections();
  },
  computed: {
    version() {
      return process.env.VUE_APP_VERSION;
    },
    notifications() {
      if (!this.$store.getters.notifications) {
        return [];
      }
      return this.$store.getters.notifications;
    },
    unreadnotifications() {
      if (!this.$store.getters.notifications) {
        return [];
      }
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
    unreadmesages() {
      return this.connections
        .map((item) => item.unread_message)
        .reduce((a, b) => {
          return a + b;
        }, 0);
    },
    inboxes() {
      if (!this.$store.getters.inboxes) {
        return [];
      }
      return this.$store.getters.inboxes;
    },

    sortmessages() {
      if (!this.$store.getters.notifications) {
        return [];
      }
      return this.inboxes.map((item) => {
        var info = {};

        if (item.user_id && item.user_id == this.$store.getters.member.id) {
          info.user = item.receiver_info || null;
          info.message = item.message || null;
          info.time = item.created_at || null;
          info.status = item.status;
          info.id = item.id;
          info.user_id = item.user_id;
        }
        if (
          item.receiver == "user" &&
          item.receiver_id == this.$store.getters.member.id
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

        if (item.user && item.user.id != this.$store.getters.member.id) {
          checkers.id = item.user.id;
          checkers.type = "user";
          checkers.name = item.user.username;
          checkers.message = item.message;
          checkers.time = item.time;
          checkers.profile = item.user.profile;

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
  methods: {
    markMessagesRead(id) {
      let data = {
        id: id,
      };
      this.$http.post(`${this.$store.getters.url}/messages/mark/read`, data, {
        headers: {
          Authorization: `Bearer ${this.$store.getters.member.access_token}`,
        },
      });
    },
    arrMove(arr, oldIndex, newIndex) {
      if (newIndex >= arr.length) {
        let i = newIndex - arr.length + 1;
        while (i--) {
          arr.push(undefined);
        }
      }
      arr.splice(newIndex, 0, arr.splice(oldIndex, 1)[0]);
      return arr;
    },

    async getconnections() {
      return this.$http
        .get(`${this.$store.getters.url}/get/chat/connections`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.connections = res.data;
            var info = res.data[0].user_follower;
            info.index = 0;
            bus.$emit("switchchat", info);
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    handleNotificationClick(item) {
      if (item.data.url) {
        window.open(item.data.url, "_blank");
      }
    },
    lastMessage(info) {
      var mess = this.sortmessages.filter((item) => {
        if (info.type == "user" && item.user && item.user.id == info.id) {
          return item;
        }
      });

      return mess.pop();
    },
    getmessage(id, name, type, profile, index) {
      if (window.innerWidth < 768) {
        this.$router.push("/messages");
        return;
      }
      var mini_info = {};
      mini_info.id = id;
      mini_info.name = name;
      mini_info.type = type;
      mini_info.profile = profile;
      mini_info.index = index;
      this.$store.dispatch("getChatter", mini_info);
      if (this.connections[index].unread_message) {
        this.markMessagesRead(id);
      }
      this.connections[index].unread_message = 0;
    },
    addinvite() {
      this.inviteUsers.push({
        email: "",
      });
    },
    sendinvite() {
      this.sending = true;
      var data = {
        emails: this.inviteUsers,
        id: this.$route.params.tribe,
      };
      this.$http
        .post(`${this.$store.getters.url}/tribe/invite`, data, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Invite Sent");
            this.sending = false;
            this.$bvModal.hide("sharecourse");
            this.inviteUsers = [
              {
                email: "",
              },
            ];
          }
        })
        .catch(() => {
          this.sending = false;
          this.$toast.error("Sending failed!");
        });
    },
    invitetotribe() {},
    leavetribe() {
      var details = {
        tribe_id: this.$route.params.tribe,
        user: this.$store.getters.member,
      };
      this.$bvModal
        .msgBoxConfirm("Are you sure you wish to exit this tribe?")
        .then((val) => {
          if (val) {
            this.$store.dispatch("leaveTribe", details).then((res) => {
              if (res.status == 200 && res.data.message == "successful") {
                this.$router.push(`/member/tribes`);
                this.$toast.success("You have left the tribe");
              }
            });
          }
        });
    },
    gettribe() {
      if (!this.$route.params.tribe || !this.$route.meta.showtribe) {
        return;
      }
      this.$http
        .get(`${this.$store.getters.url}/tribes/${this.$route.params.tribe}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.tribe = res.data.data;
            this.description = this.tribe.description;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getnotification() {
      // if (this.$route.params.tribe && this.$route.meta.showtribe) {
      //   this.gettribe();
      // }
      // if (localStorage.getItem("authAdmin")) {
      //   this.$store.dispatch("getNotifications", "admin");
      // }
      // if (localStorage.getItem("authFacilitator")) {
      //   this.$store.dispatch("getNotifications", "facilitator");
      // }
      // if (localStorage.getItem("authMember")) {
      //   this.$store.dispatch("getNotifications", "member");
      // }
    },
    changeOnScroll() {
      this.scrollPosition = window.scrollY;
      this.scrollPosition > this.windowHeight * 0.1
        ? (this.showShadow = true)
        : (this.showShadow = false);
    },

    logout() {
      localStorage.clear();
      window.location.href = "/";
    },
  },
};
</script>
<style scoped lang="scss">
.chat_time {
  font-size: 0.65rem;
}

.chat_time {
  color: #333;
}
.logo {
  width: 150px;
}
.list:hover {
  background: rgba($color: #000000, $alpha: 0.02);
  cursor: pointer;
}
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
  border-bottom: 2px solid transparent;
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
  width: 30px;
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
  width: 100px;
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
  border-color: var(--dark-green);
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
  top: -9px;
  right: 5px;
}

@media (max-width: 600px) {
  .notifier {
    position: absolute;
    top: -7px;
    right: 6px;
  }

  .navbar-light .navbar-nav .nav-link {
    font-size: 14px;
  }
  .fa-layers {
    font-size: 2em !important;
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
  #profile {
    width: 28px;
    height: 28px;
  }
}
</style>

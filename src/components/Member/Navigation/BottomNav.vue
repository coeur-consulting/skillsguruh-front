<template lang="">
  <div class="position-fixed bottom-nav d-flex justify-content-between align-items-center border-top bg-white">
    <router-link to="/">  <font-awesome-icon
                :icon="rss"
                style="font-size:14px"
                class="  mr-1"
                v-b-tooltip.hover
                title="Feed"
              /> <span v-show="$route.path==='/member'"> Feed</span></router-link>
      <router-link to="/member/tribes">  <font-awesome-icon
                :icon="users"
                style="font-size:14px"
                class="  mr-1"
                v-b-tooltip.hover
                title="Tribes"
              /> <span v-show="$route.path==='/member/tribes'">  Tribes</span></router-link>
      <router-link to="/member/community">  <font-awesome-icon
                :icon="link"
                style="font-size:14px"
                class="  mr-1"
                v-b-tooltip.hover
                title="connections"
              /> <span v-show="$route.path==='/member/community'"> Connections</span></router-link>
      <router-link to="/messages" class="position-relative">   <font-awesome-icon
                :icon="envelope"
                style="font-size:14px"
                class="  mr-1"
                v-b-tooltip.hover
                title="Messages"
              />  <span v-show="$route.path==='/messages'"> Chat</span>
              <small class="unread">
              <b-badge variant="danger" v-if="unreadmesages">{{
                unreadmesages
              }}</b-badge></small
            >
              </router-link>

  </div>
</template>
<script>
import {
  faLink,
  faRss,
  faEnvelope,
  faUsers,
  faGlobe,
} from "@fortawesome/free-solid-svg-icons";
import { bus } from "@/main.js";
export default {
  data() {
    return {
      users: faUsers,
      link: faLink,
      rss: faRss,
      envelope: faEnvelope,
      globe: faGlobe,
      connections: [],
    };
  },
  created() {
    var channel = this.$pusher.subscribe(
      `inbox.${this.$store.getters.member.id}`
    );

    channel.bind("inboxSent", (data) => {
      var id = data.message.user.id;
      this.connections.map((item) => {
        if (item.user_follower.id == id) {
          item.unread_message = item.unread_message + 1;
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
    this.getconnections();
  },
  computed: {
    unreadmesages() {
      return this.connections
        .map((item) => item.unread_message)
        .reduce((a, b) => {
          return a + b;
        }, 0);
    },
  },
  methods: {
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
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
  },
};
</script>
<style lang="scss" scoped>
.bottom-nav {
  bottom: 0;
  width: 100vw;
  padding: 10px 25px;
  z-index: 999;
  a {
    font-size: 0.8rem;
    color: rgba($color: #000000, $alpha: 0.64);
    &.router-link-exact-active {
      color: var(--dark-green);
      background: var(--lighter-green);
      padding: 5px 15px;
      border-radius: 5px;
    }
  }
}
</style>
<template>
  <div class="py-3">
    <div class="text-center mb-3 px-3">
     <router-link to="/member/feeds"> <b-img class="logo" src="/img/logo.png"></b-img></router-link>
    </div>
    <div class="mb-2 px-2">
      <b-form-input
        type="search"
        placeholder="Search username"
        class="rounded-pill"
        v-model="search"
      ></b-form-input>
    </div>
    <hr />
    <b-list-group>
      <b-list-group-item
        v-for="(item, index) in filteredconnections"
        :key="index"
        class="d-flex px-2 border-0 border-bottom list"
        :class="active === item.user_follower.id ? 'active' : ''"
        @click="toggleChat(item.user_follower, index)"
      >
        <b-avatar class="mr-2" :src="item.user_follower.profile"></b-avatar>
        <span class="text-left flex-grow-1">
          <span class="d-flex align-items-center justify-content-between flex-1"
            ><p
              class="mb-0 text-truncate text-truncate--1 text-capitalize"
              :class="item.unread_message ? 'font-weight-bold' : 'text-muted'"
            >
              {{ item.user_follower.username }}
            </p>
            <span
              class="chat_time"
              :class="item.unread_message ? 'font-weight-bold' : 'text-muted'"
              v-if="item.last_message"
              >{{ $moment(item.last_message.created_at).fromNow() }}</span
            ></span
          >
          <span
            class="d-flex justify-content-between w-100"
            v-if="item.last_message"
          >
            <small
              class="text-truncate text-truncate--1"
              :class="item.unread_message ? 'font-weight-bold' : 'text-muted'"
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
</template>
<script>
import { bus } from "@/main.js";
export default {
  data() {
    return {
      connections: [],
      active: 1,
      search: "",
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
  computed: {
    filteredconnections() {
      return this.connections.filter((item) =>
        item.user_follower.username
          .toLowerCase()
          .includes(this.search.toLowerCase())
      );
    },
  },
  mounted() {
    this.getconnections();
  },
  methods: {
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
    toggleChat(val, index) {
      this.active = val.id;
      if (this.connections[index].unread_message) {
        this.markMessagesRead(val.id);
      }
      val.index = index;
      this.connections[index].unread_message = 0;
      bus.$emit("switchchat", val);
      this.$emit('toggleView','chat')
    },
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
  },
};
</script>


<style lang="scss" scoped>
.list-group-item.active {

    color: #333;

}
.chat_time {
  font-size: 0.65rem;
}
.active {
  background: rgba($color: #000000, $alpha: 0.02);
}
.chat_time {
  color: #333;
}
.logo {
  width: 150px;
}
.list:hover{
 background: rgba($color: #000000, $alpha: 0.02);
 cursor: pointer;
}
</style>
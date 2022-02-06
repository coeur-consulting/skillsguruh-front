<template>
  <div class="text-left">
    <h6 class="mb-4">Members</h6>
    <ul class="ml-0 pl-0 suggestion">
      <li
        class="d-flex align-items-center mb-3"
        v-for="(item, id) in members"
        :key="id"
      >
        <b-avatar size="sm" :src="item.profile" class="mr-2"></b-avatar>
        <div class="text-left">
          <div

            class="connection_name cursor-pointer fs13"
            :id="id+item.username"
          >
            {{ item.username }}
          </div>
          <b-popover :target="id+item.username"  triggers="hover">
            <b-button class="mr-3" variant="light" size="sm" @click="getmessage(item.id, item.username, 'user', item.profile,0)">Message</b-button>
             <b-button variant="light" size="sm" @click="$router.push(`/me/profile/${item.username}`)">View profile</b-button>

          </b-popover>
        </div>
      </li>
    </ul>
  </div>
</template>


<script>
export default {
  data() {
    return {
      mini_info: {
        id: "",
        name: "",
        type: "",
        profile: "",
      },
      search: "",
      suggested_search: "",
      connections: [],
      member_connections: [],
      facilitators_connections: [],
      open: false,
      showAll: false,
      similarconnections: [],
      members: [],
    };
  },
  components: {},
  mounted() {
    if (this.$route.params.tribe) {
      this.getmembers();
    }
  },

  methods: {
    togglechat() {
      this.mini_info = {
        id: "",
        name: "",
        type: "",
        profile: "",
      };
      this.open = false;
      this.showAll = false;
    },

    getmessage(id, name, type, profile,index) {
      this.mini_info.id = id;
      this.mini_info.name = name;
      this.mini_info.type = type;
      this.mini_info.profile = profile;
       this.mini_info.index = index;
      this.$store.dispatch("getChatter", this.mini_info);
    },
    async getmembers() {
      return this.$http
        .get(
          `${this.$store.getters.url}/tribe/mes/${this.$route.params.tribe}`,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.members = res.data.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    async getmyconnections() {
      return this.$http
        .get(`${this.$store.getters.url}/my/connections`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.myconnections = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    async getsimilarusers() {
      return this.$http
        .get(`${this.$store.getters.url}/similar/users`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.similarconnections = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    async addconnections(id, type) {
      return this.$http
        .post(
          `${this.$store.getters.url}/connections`,
          { following_id: id, follow_type: type },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200 || res.status == 201) {
            this.$toast.success("Connected");
            this.getsimilarusers();
            this.getconnections();

            this.$store.dispatch("newConnection", {
              id,
              type,
              token: this.$store.getters.member.access_token,
            });
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
  },
};
</script>
<style scoped lang="scss">
.tribe_img {
  width: 100%;
}
.topright {
  height: 100vh;
  overflow: hidden;
}
.tribe_name {
  font-size: 0.9rem;
  color: rgba($color: #000000, $alpha: 0.64);
}
.tribe_members {
  font-size: 0.7rem;
  color: rgba($color: #000000, $alpha: 0.44);
}
.suggestion {
  height: calc(100vh - 300px);
  overflow-y: auto;
  padding-bottom: 75px;
}
.box {
  /* box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important; */
  border-radius: 8px;
  background: white;
}

.connection_box {
  height: 50vh;
  overflow: auto;
}
.suggestion_box {
  max-height: 40vh;
  overflow: auto;
}
.btn-sm,
.btn-group-sm > .btn {
  padding: 0.25rem 0.5rem;
  font-size: 0.7rem !important;
  line-height: 1.4;
  border-radius: 0.2rem;
}
h6 {
  font-size: 0.95rem;
}

@media (max-width: 600px) {
  h6 {
    font-size: 0.9rem;
  }
}
@media (max-width: 600px) {
  h4.card-title {
    font-size: 0.9rem;
  }
  nav ul li {
    font-size: 12px !important;
  }
  .btn-sm,
  .btn-group-sm > .btn {
    padding: 0.2rem 0.5rem;
    font-size: 0.5rem !important;
    line-height: 1.3;
    border-radius: 0.2rem;
  }
  p {
    margin-bottom: 1px;
  }
}
</style>

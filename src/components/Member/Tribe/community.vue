<template>
  <b-container class="py-5 text-left">
    <b-row>
      <b-col class="">
        <tribes></tribes>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import Tribes from "@/components/Member/Tribe/components/alltribes.vue";
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
      myconnections: [],
    };
  },
  components: {
    Tribes,
  },
  mounted() {
    this.getconnections();
    this.getmyconnections();
    this.getsimilarusers();
  },
  computed: {
    filteredmyconnections() {
      return this.connections.filter((item) => {
        return (
          item.username &&
          item.username.toLowerCase().includes(this.search.toLowerCase())
        );
      });
    },
    filteredConnections() {
      return this.connections.filter((item) => {
        if (item.user_follower) {
          return item.user_follower.username
            .toLowerCase()
            .includes(this.search.toLowerCase());
        }
        // if (item.facilitator_follower) {
        //   return item.facilitator_follower.username
        //     .toLowerCase()
        //     .includes(this.search.toLowerCase());
        // }
      });
    },
    filteredMemberSuggested() {
      return this.member_connections.filter(
        (item) =>
          !this.connections
            .filter((ite) => ite.user_follower)
            .map((val) => val.user_follower.id)
            .includes(item.id)
      );
    },
    filteredFacilitatorSuggested() {
      return this.facilitators_connections.filter(
        (item) =>
          !this.connections
            .filter((ite) => ite.facilitator_follower)
            .map((val) => val.facilitator_follower.id)
            .includes(item.id)
      );
    },
  },
  methods: {
    verifyConnection(id, user) {
      if (id) {
        if (user == "user") {
          return this.connections.some(
            (item) => item.user_follower && item.user_follower.id == id
          );
        } else {
          return this.connections.find(
            (item) =>
              item.facilitator_follower && item.facilitator_follower.id == id
          );
        }
      }
    },
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
    async getconnections() {
      return this.$http
        .get(`${this.$store.getters.url}/connections`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.connections = res.data;
          }
        })
        .catch(() => {
          this.$toast.error("Request failed");
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
        .catch(() => {
          this.$toast.error("Request failed");
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
        .catch(() => {
          this.$toast.error("Request failed");
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
        .catch(() => {
          this.$toast.error("Request failed");
        });
    },
  },
};
</script>
<style scoped>
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

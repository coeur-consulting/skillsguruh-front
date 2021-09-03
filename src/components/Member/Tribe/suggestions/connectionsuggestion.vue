<template>
  <div class="text-left">
    <h6 class="mb-4">Suggested Connections</h6>
    <ul class="ml-0 pl-0 suggestion">
      <li
        class="d-flex align-items-center mb-3"
        v-for="(item, id) in similarconnections.slice(0, 9)"
        :key="id"
      >
        <b-avatar size="sm" :src="item.profile" class="mr-2"></b-avatar>
        <div class="text-left">
          <div
            v-if="item.qualifications"
            @click="$router.push(`/member/profile/f/${item.id}`)"
            class="connection_name cursor-pointer fs13"
          >
            {{ item.username }}
          </div>

          <div
            v-else
            @click="$router.push(`/member/profile/u/${item.id}`)"
            class="connection_name cursor-pointer fs13"
            :id="`similar-${id}`"
          >
            {{ item.username }}
          </div>
        </div>
        <b-popover
          :target="`similar-${id}`"
          triggers="hover"
          class="sugpop"
          style="padding: 0"
        >
          <b-card
            no-body
            class="position-relative overflow-hidden border-0"
            style="max-width: 150px"
          >
            <b-card-img
              :src="
                item.profile
                  ? item.profile
                  : require('@/assets/images/default.jpeg')
              "
            ></b-card-img>
            <b-card-body class="text-center p-2">
              <div class="text-left">
                <div class="name text-capitalize text-left mb-1 cursor-pointer">
                  {{ item.username }}
                </div>

                <div class="fs11 mb-2">
                  {{ item.similar }} similar interests
                </div>
              </div>
              <b-button
                variant="dark-green"
                size="sm"
                block
                class="fs10 py-1"
                v-if="item.qualifications"
                @click="addconnections(item.id, 'facilitator')"
                >Connect</b-button
              >
              <b-button
                variant="dark-green"
                size="sm"
                block
                class="fs10 py-1"
                v-else
                @click="addconnections(item.id, 'user')"
                >Connect</b-button
              >
            </b-card-body>
          </b-card>
        </b-popover>
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
      myconnections: [],
    };
  },
  components: {},
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
          return item.user_follower.name
            .toLowerCase()
            .includes(this.search.toLowerCase());
        }
        if (item.facilitator_follower) {
          return item.facilitator_follower.name
            .toLowerCase()
            .includes(this.search.toLowerCase());
        }
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

    getmessage(id, name, type, profile) {
      this.mini_info.id = id;
      this.mini_info.name = name;
      this.mini_info.type = type;
      this.mini_info.profile = profile;
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
.suggestion img {
  height: 100px;
  width: 100%;
  object-fit: cover;
}
.name {
  font-size: 0.72rem;
  font-weight: 500;
}
.name:hover {
  color: rgba($color: #000000, $alpha: 0.44);
}
@media (max-width: 768px) {
  .name {
    font-size: 0.7rem;
  }
}
.popover-body {
  padding: 0;
  color: #212529;
}
</style>

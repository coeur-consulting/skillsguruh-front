<template>
  <b-container class="py-5 text-left">
    <b-row>
      <b-col class="mb-5">
        <div class="box py-4 px-3">
          <h6 class="mb-3">{{ filteredConnections.length }} Connections</h6>
          <div class="px-3 py-2 d-flex align-items-center search bg-light">
            <b-icon icon="search"></b-icon>
            <b-form-input
              autocomplete="off"
              autocorrect="off"
              size="sm"
              v-model="search"
              class="flex-1 border-0 no-focus search-bg"
              type="search"
              placeholder="Search name"
            ></b-form-input>
            <b-icon icon="sliders"></b-icon>
          </div>
          <b-tabs content-class="mt-3 " class="connect_tab mt-3">
            <b-tab title="Connections" active>
              <div
                class="py-4 connection_box"
                v-if="filteredConnections.length"
              >
                <div v-for="(item, id) in filteredConnections" :key="id">
                  <div
                    v-if="item.user_follower"
                    class="d-flex align-items-end mb-3"
                  >
                    <div class="d-flex align-items-center flex-1">
                      <b-avatar class="mr-2" size="2rem"></b-avatar>
                      <div>
                        <div
                          class="connection_name cursor-pointer"
                          @click="
                            $router.push(
                              `/member/profile/u/${item.user_follower.id}`
                            )
                          "
                        >
                          {{ item.user_follower.username }}
                        </div>
                      </div>
                    </div>

                    <div>
                      <span>
                        <b-button
                          variant="lighter-green"
                          size="sm"
                          class="mr-3 rounded-pill connection_button"
                          @click="
                            getmessage(
                              item.user_follower.id,
                              item.user_follower.username,
                              'user',
                              item.user_follower.profile
                            )
                          "
                          ><span class="connection_button"
                            >Message</span
                          ></b-button
                        ></span
                      >
                    </div>
                  </div>
                  <div v-else class="d-flex align-items-end mb-3">
                    <div class="d-flex align-items-center flex-1">
                      <b-avatar class="mr-2" size="2rem"></b-avatar>
                      <div>
                        <div
                          @click="
                            $router.push(
                              `/member/profile/f/${item.facilitator_follower.id}`
                            )
                          "
                          class="connection_name cursor-pointer"
                        >
                          {{ item.facilitator_follower.username }}
                        </div>
                      </div>
                    </div>

                    <div>
                      <span>
                        <b-button
                          variant="lighter-green"
                          size="sm"
                          class="mr-3 rounded-pill"
                          @click="
                            getmessage(
                              item.facilitator_follower.id,
                              item.facilitator_follower.username,
                              'facilitator',
                              item.facilitator_follower.profile
                            )
                          "
                          ><span class="connection_button"
                            >Message</span
                          ></b-button
                        >
                      </span>
                    </div>
                  </div>
                </div>
              </div>
              <div v-else class="text-center p-4">No connection available</div>
            </b-tab>
            <b-tab title="Connected to you" lazy>
              <div
                class="py-4 connection_box"
                v-if="filteredmyconnections.length"
              >
                <div v-for="(item, id) in filteredmyconnections" :key="id">
                  <div
                    v-if="!item.qualifications"
                    class="d-flex align-items-end mb-3"
                  >
                    <div class="d-flex align-items-center flex-1">
                      <b-avatar class="mr-2" size="2rem"></b-avatar>
                      <div>
                        <div
                          class="connection_name cursor-pointer"
                          @click="$router.push(`/member/profile/u/${item.id}`)"
                        >
                          {{ item.username }}
                        </div>
                      </div>
                    </div>

                    <div>
                      <span>
                        <b-button
                          @click="addconnections(item.id, 'user')"
                          variant="outline-dark-green"
                          size="sm"
                          class="rounded-pill mr-3"
                          v-if="!verifyConnection(item.id, 'user')"
                        >
                          <span>Connect</span></b-button
                        >
                        <b-button
                          variant="lighter-green"
                          class="rounded-pill mr-3"
                          size="sm"
                          @click="
                            getmessage(
                              item.id,
                              item.username,
                              'user',
                              item.profile
                            )
                          "
                          ><span class="connection_button"
                            >Message</span
                          ></b-button
                        >
                      </span>
                    </div>
                  </div>
                  <div v-else class="d-flex align-items-end mb-3">
                    <div class="d-flex align-items-center flex-1">
                      <b-avatar class="mr-2" size="2rem"></b-avatar>
                      <div>
                        <div
                          @click="$router.push(`/member/profile/f/${item.id}`)"
                          class="connection_name cursor-pointer"
                        >
                          {{ item.username }}
                        </div>
                      </div>
                    </div>

                    <div>
                      <span>
                        <b-button
                          v-if="!verifyConnection(item.id, 'facilitator')"
                          @click="addconnections(item.id, 'facilitator')"
                          variant="outline-dark-green"
                          size="sm"
                          class="rounded-pill mr-3"
                          ><span>Connect</span></b-button
                        >
                        <b-button
                          variant="lighter-green"
                          size="sm"
                          class="rounded-pill"
                          @click="
                            getmessage(
                              item.id,
                              item.username,
                              'facilitator',
                              item.profile
                            )
                          "
                          ><span class="connection_button"
                            >Message</span
                          ></b-button
                        >
                      </span>
                    </div>
                  </div>
                </div>
              </div>
            </b-tab>
            <b-tab title="My Tribes" lazy>
              <Tribes />
            </b-tab>
          </b-tabs>
        </div>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import Tribes from "./Tribe/components/mytribes.vue";
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

<template>
  <b-container class="p-3 p-sm-5 text-left">
    <b-row>
      <b-col sm="7" class="mb-5">
        <div class="box px-2 py-4 p-sm-5">
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

          <div class="py-4 connection_box" v-if="filteredConnections.length">
            <div v-for="(item, id) in filteredConnections" :key="id">
              <div
                v-if="item.user_follower"
                class="d-flex align-items-end mb-4"
              >
                <div class="d-flex align-items-center flex-1">
                  <b-avatar class="mr-2" size="2rem"></b-avatar>
                  <div>
                    <div
                      class="connection_name cursor-pointer"
                      @click="
                        $router.push(
                          `/facilitator/profile/u/${item.user_follower.id}`
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
                          item.user_follower.profile,
                          0
                        )
                      "
                      ><span class="connection_button">Message</span></b-button
                    ></span
                  >
                </div>
              </div>
              <div v-else class="d-flex align-items-end mb-4">
                <div class="d-flex align-items-center flex-1">
                  <b-avatar class="mr-2" size="2rem"></b-avatar>
                  <div>
                    <div
                      @click="
                        $router.push(
                          `/facilitator/profile/f/${item.facilitator_follower.id}`
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
                          item.facilitator_follower.profile,
                          0
                        )
                      "
                      ><span class="connection_button">Message</span></b-button
                    >
                  </span>
                </div>
              </div>
            </div>
          </div>
          <div v-else class="text-center p-4">No connection available</div>
        </div>
      </b-col>
      <b-col sm="5">
        <div class="box p-2 p-sm-4 mb-5">
          <h6 class="mb-3">Suggested</h6>

          <div class="py-1 suggestion_box" v-if="similarconnections.length">
            <div
              class="d-flex align-items-end mb-4"
              v-for="(item, id) in similarconnections.slice(0, 9)"
              :key="id"
            >
              <div class="d-flex align-items-center flex-1">
                <b-avatar class="mr-2" size="2rem"></b-avatar>
                <div style="line-height: 1.2">
                  <span
                    v-if="item.qualifications"
                    @click="$router.push(`/facilitator/profile/f/${item.id}`)"
                    class="connection_name cursor-pointer"
                    >{{ item.username }}</span
                  >

                  <span
                    v-else
                    @click="$router.push(`/facilitator/profile/u/${item.id}`)"
                    class="connection_name cursor-pointer"
                    >{{ item.username }}</span
                  >
                </div>
              </div>

              <div>
                <b-button
                  v-if="item.qualifications"
                  @click="addconnections(item.id, 'facilitator')"
                  size="sm"
                  variant="outline-dark-green"
                  class="rounded-pill fs11"
                  ><span class="connection_button">Connect</span></b-button
                >
                <b-button
                  v-else
                  @click="addconnections(item.id, 'user')"
                  size="sm"
                  variant="outline-dark-green"
                  class="rounded-pill fs11"
                  >Connect</b-button
                >
              </div>
            </div>
          </div>
          <div v-else class="p-3">
            <h6 class="text-muted text-center">Not available</h6>
          </div>
        </div>
      </b-col>
    </b-row>
    <Minichat
      class="minichats"
      :user="'facilitator'"
      :mini_info="mini_info"
      :open="open"
      :showAll="showAll"
      @togglechat="togglechat"
    />
  </b-container>
</template>

<script>
import Minichat from "../minichat";
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
    };
  },
  components: {
    Minichat,
  },
  mounted() {
    this.getconnections();
    this.getsimilarusers();
  },
  computed: {
    filteredConnections() {
      if (!this.connections.length) {
        return [];
      }
      return this.connections.filter((item) => {
        if (item.user_follower) {
          return item.user_follower.username
            .toLowerCase()
            .includes(this.search.toLowerCase());
        }
        if (item.facilitator_follower) {
          return item.facilitator_follower.username
            .toLowerCase()
            .includes(this.search.toLowerCase());
        }
      });
    },
    filteredMemberSuggested() {
      if (!this.connections.length) {
        return this.member_connections;
      }
      return this.member_connections.filter(
        (item) =>
          !this.connections
            .filter((ite) => ite.user_follower)
            .map((val) => val.user_follower.id)
            .includes(item.id)
      );
    },
    filteredFacilitatorSuggested() {
      if (!this.connections.length) {
        return this.facilitators_connections;
      }
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
    async getsimilarusers() {
      return this.$http
        .get(`${this.$store.getters.url}/similar/users`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
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
              Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200 || res.status == 201) {
            this.$toast.success("Successful");
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
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
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
    getUsersWithInterest() {
      this.$http
        .get(
          `${this.$store.getters.url}/identical-members`,

          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.member_connections = res.data;
          }
        });
    },
    getFacilitatorsWithInterest() {
      this.$http
        .get(
          `${this.$store.getters.url}/identical-facilitators`,

          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.facilitators_connections = res.data;
          }
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
h6 {
  font-size: 0.95rem;
}
@media (max-width: 600px) {
  h6 {
    font-size: 0.9rem;
  }
}
</style>

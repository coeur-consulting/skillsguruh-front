<template>
  <b-container class="p-5 text-left">
    <b-row>
      <b-col sm="7">
        <div class="box p-5">
          <h5 class="mb-3">{{ filteredConnections.length }} Connections</h5>
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

          <div class="py-4 connection_box">
            <div
              class="d-flex align-items-end mb-4"
              v-for="(item, id) in filteredConnections"
              :key="id"
            >
              <div class="d-flex align-items-center flex-1">
                <b-avatar class="mr-2" size="2.8rem"></b-avatar>
                <div>
                  <span>{{ item.user_follower.name }}</span> <br />
                  <span class="fs14 text-muted">{{
                    item.user_follower.email
                  }}</span>
                </div>
              </div>

              <div>
                <b-button
                  variant="outline-dark-green"
                  size="sm"
                  class="mr-3 rounded-pill"
                  @click="
                    getmessage(
                      item.user_follower.id,
                      item.user_follower.name,
                      'user',
                      item.user_follower.profile
                    )
                  "
                  >Message</b-button
                >
                <b-icon icon="three-dots-vertical"></b-icon>
              </div>
            </div>
          </div>
        </div>
      </b-col>
      <b-col sm="5">
        <div class="box p-4">
          <h6 class="mb-3">Suggested connections</h6>
          <div class="px-3 py-2 d-flex align-items-center search bg-light">
            <b-icon icon="search"></b-icon>
            <b-form-input
              autocomplete="off"
              autocorrect="off"
              size="sm"
              v-model="suggested_search"
              class="flex-1 border-0 no-focus search-bg"
              type="search"
              placeholder="Search name"
            ></b-form-input>
            <b-icon icon="sliders"></b-icon>
          </div>
          <div class="py-4 suggestion_box" v-if="suggestedConnections.length">
            <div
              class="d-flex align-items-end mb-4"
              v-for="(item, id) in suggestedConnections"
              :key="id"
            >
              <div class="d-flex align-items-center flex-1">
                <b-avatar class="mr-2" size="2rem"></b-avatar>
                <div style="line-height: 1.2">
                  <span class="fs14">{{ item.name }}</span> <br />
                  <span class="fs12 text-muted">{{ item.email }}</span>
                </div>
              </div>

              <div>
                <b-button
                  @click="addconnections(item.id, 'user')"
                  size="sm"
                  variant="outline-dark-green"
                  class="rounded-pill fs11"
                  >Connect</b-button
                >
              </div>
            </div>
          </div>
        </div>
      </b-col>
    </b-row>
    <Minichat
      class="minichats d-none d-md-block"
      :user="'learner'"
      :mini_info="mini_info"
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
      suggestedConnections: [],
    };
  },
  components: {
    Minichat,
  },
  mounted() {
    this.getconnections();
  },
  computed: {
    filteredConnections() {
      return this.connections.filter((item) =>
        item.user_follower.name
          .toLowerCase()
          .includes(this.search.toLowerCase())
      );
    },
    filteredSuggested() {
      return this.suggestedConnections.filter((item) =>
        item.includes(this.suggested_search)
      );
    },
  },
  methods: {
    getmessage(id, name, type, profile) {
      this.mini_info.id = id;
      this.mini_info.name = name;
      this.mini_info.type = type;
      this.mini_info.profile = profile;
    },
    async getconnections() {
      return this.$http
        .get(`${this.$store.getters.url}/connections`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
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

    async addconnections(id, type) {
      return this.$http
        .post(
          `${this.$store.getters.url}/connections`,
          { following_id: id, follow_type: type },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Successful");
            this.getconnections();
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
  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
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
</style>

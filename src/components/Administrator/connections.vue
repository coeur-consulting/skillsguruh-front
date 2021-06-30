<template>
  <b-container class="p-3 p-sm-5 text-left">
    <b-row>
      <b-col sm="7">
        <div class="box p-5 mb-5">
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
            <div class="d-flex align-items-end mb-4">
              <div class="d-flex align-items-center flex-1">
                <b-avatar class="mr-2" size="2rem"></b-avatar>
                <div style="line-height: 1.2">
                  <span class="fs14">John Doe</span> <br />
                  <span class="fs12 text-muted">succy@gmail.com</span>
                </div>
              </div>

              <div>
                <b-button
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
      class="minichats"
      :user="'admin'"
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
      suggestedConnections: [],
      open: false,
      showAll: false,
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
      this.open = true;
      this.showAll = true;
    },
    async getconnections() {
      return this.$http
        .get(`${this.$store.getters.url}/connections`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
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
</style>

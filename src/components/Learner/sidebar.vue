<template>
  <div id="sidebar">
    <div class="logo_bar">
      <b-img
        class="mr-2"
        width="30"
        height="auto"
        :src="$store.getters.learner.org_profile"
      ></b-img>
      <h5 class="mb-0">{{ $store.getters.learner.org_name }}</h5>
    </div>
    <div class="side_items">
      <div>
        <h6 class="mt-3 mb-1 text-dark-green side_header">PERSONAL</h6>
        <router-link to="/learner">
          <div class="side_item">
            <b-icon
              icon="grid1x2"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Dashboard</span>
          </div>
        </router-link>

        <router-link to="/learner/schedule">
          <div class="side_item">
            <b-icon
              icon="calendar-event"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Schedule</span>
          </div>
        </router-link>
      </div>

      <div>
        <h6 class="mt-3 mb-1 text-dark-green side_header">NETWORK</h6>

        <router-link to="/learner/connections">
          <div class="side_item">
            <b-icon
              icon="link45deg"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Connections</span>
          </div>
        </router-link>
        <router-link to="/learner/feeds">
          <div class="side_item">
            <b-icon
              icon="rss"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link"><span class="mr-5">Feeds</span> </span>
          </div>
        </router-link>
        <router-link to="/learner/events">
          <div class="side_item">
            <b-icon
              icon="bookmark"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">
              <span class="mr-5">Events</span>
              <span
                ><b-badge variant="danger" size="sm">{{
                  activeaccount
                }}</b-badge></span
              ></span
            >
          </div>
        </router-link>
        <router-link to="/learner/discussions">
          <div class="side_item">
            <b-icon
              icon="chat-left-quote"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Discussions</span>
          </div>
        </router-link>
      </div>
      <div>
        <h6 class="mt-3 mb-1 text-dark-green side_header">LEARN</h6>

        <router-link to="/learner/courses">
          <div class="side_item">
            <b-icon
              icon="book"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Courses</span>
          </div>
        </router-link>

        <router-link to="/learner/library">
          <div class="side_item">
            <b-icon
              icon="card-list"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Library</span>
          </div>
        </router-link>
        <router-link to="/learner/assessments">
          <div class="side_item">
            <b-icon
              icon="card-list"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Assessments</span>
          </div>
        </router-link>
        <router-link to="/learner/grades">
          <div class="side_item">
            <b-icon
              icon="card-list"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Grades</span>
          </div>
        </router-link>
      </div>
      <div>
        <h6 class="mt-3 mb-1 text-dark-green side_header">EARN</h6>

        <router-link to="/learner/referrals">
          <div class="side_item">
            <b-icon
              icon="signpost-split"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Bonuses</span>
          </div>
        </router-link>
      </div>

      <div class="side_item mt-4" @click="logout">
        <b-icon
          icon="box-arrow-left"
          font-scale="1.1"
          class="mr-3 text-dark-green"
        ></b-icon>
        <span class="side-link">Log out</span>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      events: [],
    };
  },
  computed: {
    activeaccount() {
      return this.events.filter((item) => item.status).length;
    },
  },
  methods: {
    logout() {
      localStorage.removeItem("authLearner");
      this.$router.push("/login");
    },
    getevents() {
      this.$http
        .get(`${this.$store.getters.url}/events`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.events = res.data;
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
#sidebar {
  height: 100vh;
  overflow: hidden;
  color: var(--dark-green) !important;
  background: white;
  border-right: 1px solid #f7f8fa;
}
.logo_bar {
  height: 80px;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  padding-left: 30px;
}
.side_items {
  padding: 40px 0;

  height: calc(100vh - 80px);
  text-align: left;
}
.side_header {
  font-size: 12px;
  padding: 1px 0 1px 30px;
}
.side_item {
  font-size: 14px;
  font-style: normal;
  font-weight: 400;
  line-height: 1.4;
  letter-spacing: 0em;
  text-align: left;
  color: var(--dark-green);
  padding: 4px 0 4px 30px;
  margin-bottom: 4px;
  cursor: pointer;
}
.router-link-exact-active.router-link-active .side_item {
  background: var(--dark-green);
  color: white;
}

.router-link-exact-active.router-link-active .side_item .b-icon.bi {
  color: white !important;
}
.side_item:hover .b-icon.bi {
  color: white !important;
}
.side_item:hover {
  background: var(--light-green);
  color: white;
}
</style>

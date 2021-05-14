<template>
  <div id="topbar">
    <span class="d-none d-sm-block">
      <b-input-group size="sm" class="mb-2 topbar_search">
        <b-input-group-prepend is-text>
          <b-icon icon="search" font-scale="1" class="text-muted"></b-icon>
        </b-input-group-prepend>
        <b-form-input
          placeholder="Search"
          class="bg-transparent border-0"
          type="search"
          aria-label="Text input "
        ></b-form-input> </b-input-group
    ></span>

    <div class="d-flex align-items-center d-sm-none">
      <div class="mr-3">
        <PushRotate :closeOnNavigation="true" width="250">
          <div class="logo">LOGO</div>

          <router-link to="/administrator">
            <div class="side_item">
              <b-icon
                icon="grid1x2"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Dashboard</span>
            </div>
          </router-link>

          <h6 class="mt-2 mb-0 text-white side_header">TEAM</h6>
          <router-link to="/administrator/facilitators">
            <div class="side_item">
              <b-icon
                icon="person-badge"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Facilitators</span>
            </div>
          </router-link>
          <router-link to="/administrator/learners">
            <div class="side_item">
              <b-icon
                icon="people"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Learners</span>
            </div>
          </router-link>

          <h6 class="mt-2 mb-0 text-white side_header">COMMUNITY</h6>

          <router-link to="/administrator/schedule">
            <div class="side_item">
              <b-icon
                icon="link45deg"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Connection</span>
            </div>
          </router-link>

          <h6 class="mt-2 mb-0 text-white side_header">PROGRAMS</h6>

          <router-link to="/administrator/schedule">
            <div class="side_item">
              <b-icon
                icon="book"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Courses</span>
            </div>
          </router-link>
          <router-link to="/administrator/schedule">
            <div class="side_item">
              <b-icon
                icon="bookmark"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Events</span>
            </div>
          </router-link>

          <h6 class="mt-2 mb-0 text-white side_header">ACTIVITIES</h6>

          <router-link to="/administrator/feeds">
            <div class="side_item">
              <b-icon
                icon="rss"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Feeds</span>
            </div>
          </router-link>
          <router-link to="/administrator/discussions">
            <div class="side_item">
              <b-icon
                icon="chat-left-quote"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Discussion</span>
            </div>
          </router-link>

          <h6 class="mt-2 mb-0 text-white side_header">OTHERS</h6>

          <router-link to="/administrator/schedule">
            <div class="side_item">
              <b-icon
                icon="calendar-event"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Schedule</span>
            </div>
          </router-link>
          <router-link to="/administrator/schedule">
            <div class="side_item">
              <b-icon
                icon="receipt"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Insights</span>
            </div>
          </router-link>
          <router-link to="/administrator/schedule">
            <div class="side_item">
              <b-icon
                icon="signpost-split"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Referrals</span>
            </div>
          </router-link>
          <router-link to="/administrator/schedule">
            <div class="side_item">
              <b-icon
                icon="credit-card"
                font-scale="1.1"
                class="mr-3 text-white"
              ></b-icon>
              <span class="side-link">Bonuses</span>
            </div>
          </router-link>

          <div class="side_item mt-2 mb-4">
            <b-icon
              icon="box-arrow-left"
              font-scale="1.1"
              class="mr-3 text-white"
            ></b-icon>
            <span class="side-link">Log out</span>
          </div>
        </PushRotate>
      </div>
      <div class="org_name" @click="$router.push('/organization')">
        {{ this.$store.getters.organization.name }}
      </div>
    </div>

    <div class="d-flex align-items-center">
      <b-icon
        id="bell"
        icon="bell"
        font-scale="1.2"
        class="mr-4 text-dark-green"
      ></b-icon>
      <b-popover target="bell" triggers="hover" placement="bottom">
        <template #title>Notifications</template>
        <div class="noti">I am notification!</div>
      </b-popover>
      <b-icon
        icon="envelope"
        font-scale="1.2"
        class="mr-4 text-muted cursor-pointer"
      ></b-icon>
      <b-avatar id="profile" class="cursor-pointer" size="30px"></b-avatar>
      <b-popover target="profile" id="prof" triggers="click" placement="bottom">
        <div class="cursor-pointer px-3" @click="logout">Log out</div>
      </b-popover>
    </div>
  </div>
</template>
<script>
import { PushRotate } from "vue-burger-menu";
export default {
  components: {
    PushRotate,
  },
  methods: {
    logout() {
      localStorage.removeItem("authOrg");
      this.$router.push("/login");
    },
  },
};
</script>
<style scoped>
#topbar {
  height: 80px;
  background: #f8f7f7;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;
}
.noti {
  width: 300px;
}

.side_header {
  font-size: 12px;
  padding: 1px 0 1px 0px;
  color: white;
}
.side_item {
  font-size: 14px;
  font-style: normal;
  font-weight: 400;
  line-height: 1.4;
  letter-spacing: 0em;
  text-align: left;
  color: white;
  padding: 0px;
  margin-bottom: 0;
  cursor: pointer;
}

.logo {
  padding: 0px 0 30px;
}
.org_name {
  font-size: 17px;
  font-weight: 500;
}
</style>

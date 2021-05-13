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
          <router-link to="/organization">
            <div class="side_item">
              <b-icon
                icon="grid1x2-fill"
                font-scale="1.25"
                class="mr-3 text-lemon"
              ></b-icon>
              <span class="side-link">Dashboard</span>
            </div>
          </router-link>
          <router-link to="/organization/admins">
            <div class="side_item">
              <b-icon
                icon="shield-fill-check"
                font-scale="1.25"
                class="mr-3 text-lemon"
              ></b-icon>
              <span class="side-link">Administrators</span>
            </div>
          </router-link>
          <router-link to="/organization/facilitators">
            <div class="side_item">
              <b-icon
                icon="person-badge-fill"
                font-scale="1.25"
                class="mr-3 text-lemon"
              ></b-icon>
              <span class="side-link">Facilitators</span>
            </div>
          </router-link>
          <router-link to="/organization/learners">
            <div class="side_item">
              <b-icon
                icon="people-fill"
                font-scale="1.25"
                class="mr-3 text-lemon"
              ></b-icon>
              <span class="side-link">Learners</span>
            </div>
          </router-link>
          <router-link to="/organization/schedule">
            <div class="side_item">
              <b-icon
                icon="calendar-event-fill"
                font-scale="1.25"
                class="mr-3 text-lemon"
              ></b-icon>
              <span class="side-link">Schedule</span>
            </div>
          </router-link>
          <router-link to="/organization/chat">
            <div class="side_item">
              <b-icon
                icon="chat-square-text-fill"
                font-scale="1.25"
                class="mr-3 text-lemon"
              ></b-icon>
              <span class="side-link">Chat</span>
            </div>
          </router-link>
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

.side_item {
  font-size: 16px;
  font-style: normal;
  font-weight: 600;
  line-height: 20px;
  letter-spacing: 0em;
  text-align: left;
  color: #fff;
  padding: 8px 0 8px 3px;

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

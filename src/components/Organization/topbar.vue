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
          <div class="logo">
            <b-img
              class="mr-2"
              width="30"
              height="30"
              style="object-fit: contain"
              :src="$store.getters.organization.profile"
            ></b-img>
            <h5 class="mb-0">{{ $store.getters.organization.name }}</h5>
          </div>
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
      <b-popover
        id="notification2"
        target="bell"
        triggers="hover"
        placement="bottom"
      >
        <template #title>Notifications</template>
        <div class="notifications" v-if="notifications.length">
          <div class="notification_container">
            <div
              class="notify border-bottom"
              v-for="(item, id) in notifications"
              :key="id"
            >
              <div
                v-if="!item.read_at"
                @click="$store.dispatch('markNotification', item.id)"
              >
                <span :class="{ 'font-weight-bold': !item.read_at }">
                  {{ item.data.notification }}</span
                >
                <br />
                <span class="fs11">{{
                  item.created_at | moment("calendar")
                }}</span>
              </div>
              <div v-else>
                <span :class="{ 'font-weight-bold': !item.read_at }">
                  {{ item.data.notification }}</span
                >
                <br />
                <span class="fs11">{{
                  item.created_at | moment("calendar")
                }}</span>
              </div>
            </div>
          </div>
          <div class="text-center py-2 border-top text-dark-green fs11">
            <span
              class="cursor-pointer"
              @click="$store.dispatch('markNotifications')"
            >
              Mark all as read</span
            >
          </div>
        </div>
        <div v-else class="text-center text-muted notify p-2">
          No new notification !
        </div>
      </b-popover>
      <b-icon
        icon="envelope"
        font-scale="1.5rem"
        class="mr-4 text-muted cursor-pointer"
      ></b-icon>

      <span>
        <b-dropdown size="sm" variant="transparent" no-caret class="no-focus">
          <template #button-content>
            <b-avatar
              :src="$store.getters.organization.profile"
              id="profile"
              class="cursor-pointer"
              size="30px"
            ></b-avatar>
          </template>

          <b-dropdown-item
            class="fs14"
            @click="$router.push(`/organization/profile`)"
            >Profile</b-dropdown-item
          >

          <b-dropdown-item class="fs14" @click="logout">Logout</b-dropdown-item>
        </b-dropdown>
      </span>
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
    markread() {
      this.$http.get(`${this.$store.getters.url}/mark-notifications`, {
        headers: {
          Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
        },
      });
    },
  },
  computed: {
    notifications() {
      return this.$store.getters.notifications;
    },
    unreadnotifications() {
      return this.$store.getters.notifications.filter((item) => !item.read_at);
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

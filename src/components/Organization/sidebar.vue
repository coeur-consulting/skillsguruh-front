<template>
  <div id="sidebar">
    <div class="logo_bar">NY LOGO</div>
    <div class="side_items">
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
    </div>
  </div>
</template>

<style scoped>
#sidebar {
  height: 100vh;
  overflow: hidden;
  color: #fff;
}
.logo_bar {
  background: #337177;
  height: 80px;
  display: flex;
  justify-content: flex-start;
  align-items: center;
  padding-left: 30px;
}
.side_items {
  padding: 40px 0;
  background: linear-gradient(
    173.56deg,
    #388087 5.07%,
    #18696d 62.76%,
    rgba(56, 128, 135, 0.79) 90.63%
  );
  height: calc(100vh - 80px);
  text-align: left;
}
.side_item {
  font-size: 18px;
  font-style: normal;
  font-weight: 600;
  line-height: 22px;
  letter-spacing: 0em;
  text-align: left;
  color: #fff;
  padding: 8px 0 8px 30px;
  margin-bottom: 24px;
  cursor: pointer;
}
.router-link-exact-active.router-link-active .side_item {
  background: var(--lighter-green);
  color: var(--dark-green);
}

.router-link-exact-active.router-link-active .side_item .b-icon.bi {
  color: var(--dark-green) !important;
}
.side_item:hover {
  background: var(--lighter-green);
}
</style>

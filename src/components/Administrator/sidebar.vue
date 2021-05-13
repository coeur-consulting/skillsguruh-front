<template>
  <div id="sidebar">
    <div class="logo_bar">NY LOGO</div>
    <div class="side_items">
      <router-link to="/administrator">
        <div class="side_item">
          <b-icon
            icon="grid1x2"
            font-scale="1.1"
            class="mr-3 text-dark-green"
          ></b-icon>
          <span class="side-link">Dashboard</span>
        </div>
      </router-link>

      <div>
        <h6 class="mt-3 mb-1 text-dark-green side_header">TEAM</h6>
        <router-link to="/administrator/facilitators">
          <div class="side_item">
            <b-icon
              icon="person-badge"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Facilitators</span>
          </div>
        </router-link>
        <router-link to="/administrator/learners">
          <div class="side_item">
            <b-icon
              icon="people"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Learners</span>
          </div>
        </router-link>
      </div>
      <div>
        <h6 class="mt-3 mb-1 text-dark-green side_header">COMMUNITY</h6>

        <router-link to="/administrator/schedule">
          <div class="side_item">
            <b-icon
              icon="link45deg"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Connection</span>
          </div>
        </router-link>
      </div>
      <div>
        <h6 class="mt-3 mb-1 text-dark-green side_header">PROGRAMS</h6>

        <router-link to="/administrator/schedule">
          <div class="side_item">
            <b-icon
              icon="book"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Courses</span>
          </div>
        </router-link>
        <router-link to="/administrator/schedule">
          <div class="side_item">
            <b-icon
              icon="bookmark"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Events</span>
          </div>
        </router-link>
      </div>
      <div>
        <h6 class="mt-3 mb-1 text-dark-green side_header">ACTIVITIES</h6>

        <router-link to="/administrator/schedule">
          <div class="side_item">
            <b-icon
              icon="rss"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Feeds</span>
          </div>
        </router-link>
        <router-link to="/administrator/schedule">
          <div class="side_item">
            <b-icon
              icon="chat-left-quote"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Discussion</span>
          </div>
        </router-link>
      </div>

      <div>
        <h6 class="mt-3 mb-1 text-dark-green side_header">OTHERS</h6>

        <router-link to="/administrator/schedule">
          <div class="side_item">
            <b-icon
              icon="calendar-event"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Schedule</span>
          </div>
        </router-link>
        <router-link to="/administrator/schedule">
          <div class="side_item">
            <b-icon
              icon="receipt"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Insights</span>
          </div>
        </router-link>
        <router-link to="/administrator/schedule">
          <div class="side_item">
            <b-icon
              icon="signpost-split"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Referrals</span>
          </div>
        </router-link>
        <router-link to="/administrator/schedule">
          <div class="side_item">
            <b-icon
              icon="credit-card"
              font-scale="1.1"
              class="mr-3 text-dark-green"
            ></b-icon>
            <span class="side-link">Bonuses</span>
          </div>
        </router-link>
      </div>

      <div class="side_item mt-4">
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
  background: var(--dark-green);
  color: white;
}
</style>

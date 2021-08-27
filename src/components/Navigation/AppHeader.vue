<template>
  <b-navbar
    toggleable="md"
    type="light"
    variant="white"
    sticky
    :class="{ 'shadow-sm': showShadow }"
  >
    <b-container>
      <b-navbar-brand href="/"
        ><b-img class="logo" src="/img/logo.png"></b-img
      ></b-navbar-brand>

      <b-navbar-toggle target="nav-collapse" class="border-0">
        <template #default="{ expanded }">
          <div class="navtog">
            <div class="checked" v-if="expanded"></div>
            <span></span>
            <span></span>
            <span></span>
          </div>
        </template>
      </b-navbar-toggle>
      <b-collapse id="nav-collapse" is-nav>
        <b-navbar-nav class="ml-auto align-items-center">
          <b-nav-item to="/explore" class="mr-sm-4">Explore</b-nav-item>
          <b-nav-item to="/about" class="mr-sm-4">About</b-nav-item>

          <b-nav-item v-if="authMember">
            <b-dropdown
              size="sm"
              variant="transparent"
              no-caret
              class="no-focus"
            >
              <template #button-content>
                <span class="d-flex align-items-center">
                  <b-avatar
                    :src="$store.getters.member.profile"
                    id="profile"
                    class="cursor-pointer mr-2"
                    size="30px"
                  ></b-avatar>
                  <span class="fs14 d-none d-sm-inline">{{
                    $store.getters.member.username
                  }}</span>
                </span>
              </template>
              <!-- <b-dropdown-item to="/member/community"
                >Community</b-dropdown-item
              > -->
              <b-dropdown-item to="/tribes">Tribes</b-dropdown-item>
              <b-dropdown-item to="/member/feeds"> My Home</b-dropdown-item>

              <b-dropdown-item @click="logout"> Logout </b-dropdown-item>
            </b-dropdown>
          </b-nav-item>

          <!-- <b-nav-item
            class="px-4"
            v-else-if="authFacilitator"
            @click="$router.push('/facilitator')"
          >
            Dashboard</b-nav-item
          >

          <b-nav-item
            class="px-4"
            v-else-if="authAdmin"
            @click="$router.push('/administrator')"
          >
            Dashboard</b-nav-item
          >

          <b-nav-item
            class="px-4"
            v-else-if="authOrg"
            @click="$router.push('/organization')"
          >
            Dashboard</b-nav-item
          >
         -->
          <b-nav-item
            href="#"
            v-if="!authMember && !authFacilitator && !authAdmin && !authOrg"
          >
            <b-button
              class="px-5"
              @click="$router.push('/login')"
              variant="dark-green"
            >
              Login</b-button
            >
          </b-nav-item>
        </b-navbar-nav>
      </b-collapse>
    </b-container>
  </b-navbar>
</template>
<script>
export default {
  data() {
    return {
      authMember: false,
      authAdmin: false,
      authOrg: false,
      authFacilitator: false,
      showShadow: false,
      windowHeight: null,
      scrollPosition: null,
    };
  },
  created() {
    window.addEventListener("scroll", this.changeOnScroll);
  },
  mounted() {
    if (localStorage.getItem("authMember")) {
      this.authMember = true;
    } else if (localStorage.getItem("authFacilitator")) {
      this.authFacilitator = true;
    } else if (localStorage.getItem("authAdmin")) {
      this.authAdmin = true;
    } else if (localStorage.getItem("authOrg")) {
      this.authOrg = true;
    } else {
      return;
    }
  },
  methods: {
    changeOnScroll() {
      this.scrollPosition = window.scrollY;
      this.scrollPosition > this.windowHeight * 0.1
        ? (this.showShadow = true)
        : (this.showShadow = false);
    },

    logout() {
      localStorage.clear();
      window.location.reload();
    },
  },
};
</script>
<style scoped lang="scss">
.shadow-sm {
  box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.15) !important;
}
.navbar-light .navbar-nav .nav-link {
  color: rgb(0, 0, 0);
  font-weight: 500;
}
.navbar-light .navbar-nav .nav-link:hover,
.navbar-light .navbar-nav .nav-link:focus {
  color: var(--secondary);
}
.navbar-light .navbar-nav .nav-link.router-link-exact-active {
  color: var(--secondary);
}
.navtog {
  display: flex;
  flex-direction: column;
  width: 30px;
  cursor: pointer;
  margin: 0;
}

.navtog span {
  background: var(--dark-green);
  border-radius: 10px;
  height: 3px;
  margin: 3px 0;
  transition: 0.4s cubic-bezier(0.68, -0.6, 0.32, 1.6);
}

span:nth-of-type(1) {
  width: 50%;
}

span:nth-of-type(2) {
  width: 100%;
}

span:nth-of-type(3) {
  width: 75%;
}

.checked ~ span:nth-of-type(1) {
  transform-origin: bottom;
  transform: rotatez(45deg) translate(5px, 0px);
}

.checked ~ span:nth-of-type(2) {
  transform-origin: top;
  transform: rotatez(-45deg);
}

.checked ~ span:nth-of-type(3) {
  transform-origin: bottom;
  width: 50%;
  transform: translate(13px, -5px) rotatez(45deg);
}
.logo {
  width: 100px;
}
@media (max-width: 600px) {
  .navbar-light .navbar-nav .nav-link {
    font-size: 14px;
  }
}
</style>

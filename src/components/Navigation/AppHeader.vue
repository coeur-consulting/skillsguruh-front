<template>
  <div class="position-absolute w-100">
    <b-navbar toggleable="md" type="light" variant="transparent" sticky>
      <b-container fluid>
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
        <b-collapse id="nav-collapse" is-nav class="dark_bg">
          <b-navbar-nav class="ml-auto align-items-center">
            <!-- <b-nav-item to="/" class="mr-sm-4">Home</b-nav-item> -->
            <b-nav-item to="/explore" class="mr-sm-4">Explore</b-nav-item>
            <!-- <b-nav-item to="/about" class="mr-sm-4">About</b-nav-item>
            <b-nav-item to="/contact" class="mr-sm-4">Contact Us</b-nav-item> -->

            <b-nav-item v-if="authMember">
              <b-dropdown
                size="sm"
                variant="transparent"
                no-caret
                class="no-focus d-block"
              >
                <template #button-content>
                  <div class="d-flex align-items-center">
                    <b-avatar
                      :src="$store.getters.member.profile"
                      id="profile"
                      class="cursor-pointer mr-2"
                      size="30px"
                    ></b-avatar>
                    <span class="fs14 text-white">{{
                      $store.getters.member.username
                    }}</span>
                  </div>
                </template>

                <b-dropdown-item to="/member" class="fs14">
                  <div
                    class="d-flex align-items-center justify-content-between"
                  >
                    <span class="mr-5 d-flex align-items-center"> Home</span>
                    <b-icon font-scale=".8" icon="chevron-right"></b-icon></div
                ></b-dropdown-item>

                <b-dropdown-item @click="logout" class="fs14">
                  <div class="d-flex align-items-center">
                    <span>Logout</span>
                  </div>
                </b-dropdown-item>
              </b-dropdown>
            </b-nav-item>

            <b-nav-item to="/login" v-if="!authMember">
              Login
              <font-awesome-icon :icon="signIn"
            /></b-nav-item>
            <!-- <b-nav-item v-if="!authMember">
              <b-button
                @click="$router.push('/register')"
                variant="light"
                class="text-dark-green px-4"
              >
                Get Started</b-button
              >
            </b-nav-item> -->
          </b-navbar-nav>
        </b-collapse>
      </b-container>
    </b-navbar>
  </div>
</template>
<script>
import { faSignInAlt } from "@fortawesome/free-solid-svg-icons";
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
      signIn: faSignInAlt,
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
  color: #fff;
  font-weight: 500;
}
.navbar-light .navbar-nav .nav-link:hover,
.navbar-light .navbar-nav .nav-link:focus {
  color: var(--dark-green);
}
.navbar-light .navbar-nav .nav-link.router-link-exact-active {
  color: var(--dark-green);
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
  width: 150px;
}
@media (max-width: 768px) {
  .logo {
    width: 100px;
  }
  .navbar-light .navbar-nav .nav-link {
    font-size: 14px;
  }
  .dark_bg {
    background: var(--dark);
    padding: 15px;
    border-radius: 8px;
  }
  // span:nth-of-type(1) {
  //   width: 100%;
  // }
}
</style>

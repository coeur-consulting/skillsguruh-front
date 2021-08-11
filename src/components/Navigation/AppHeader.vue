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
        ><b-img src="/img/logo.png"></b-img
      ></b-navbar-brand>

      <b-navbar-toggle target="nav-collapse">
        <template #default="{ expanded }">
          <b-icon
            v-if="expanded"
            font-scale="1.3"
            icon="chevron-bar-up"
            class="text-dark-green"
          ></b-icon>
          <b-icon
            v-else
            font-scale="1.3"
            icon="chevron-bar-down"
            class="text-dark-green"
          ></b-icon>
        </template>
      </b-navbar-toggle>
      <b-collapse id="nav-collapse" is-nav>
        <b-navbar-nav class="ml-auto align-items-center">
          <b-nav-item to="/" class="mr-sm-4">Home</b-nav-item>
          <b-nav-item to="/explore" class="mr-sm-4">Explore</b-nav-item>
          <b-nav-item to="/about" class="mr-sm-4">About</b-nav-item>

          <b-nav-item to="/contact">Contact</b-nav-item>

          <b-nav-item
            v-if="authMember"
            class="px-4"
            @click="$router.push('/member')"
          >
            Dashboard</b-nav-item
          >

          <b-nav-item
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
          <b-nav-item
            v-if="authMember || authFacilitator || authAdmin || authOrg"
          >
            <b-button class="px-4" @click="logout" variant="dark-green">
              Logout</b-button
            >
          </b-nav-item>

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

    this.windowHeight = window.innerHeight;
    window.addEventListener("scroll", this.changeOnScroll);
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
@media (max-width: 600px) {
  .navbar-light .navbar-nav .nav-link {
    font-size: 14px;
  }
}
</style>

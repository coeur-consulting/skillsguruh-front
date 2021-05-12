<template>
  <div class="bg-skills-grey">
    <b-container>
      <b-navbar toggleable="lg" type="light" variant="skills-grey">
        <b-navbar-brand href="/"
          ><b-img src="/img/logo.png"></b-img
        ></b-navbar-brand>

        <b-navbar-toggle target="nav-collapse">
          <template #default="{ expanded }">
            <b-icon
              v-if="expanded"
              icon="chevron-bar-up"
              class="text-dark-green"
            ></b-icon>
            <b-icon
              v-else
              icon="chevron-bar-down"
              class="text-dark-green"
            ></b-icon>
          </template>
        </b-navbar-toggle>
        <b-collapse id="nav-collapse" is-nav>
          <b-navbar-nav class="ml-auto">
            <b-nav-item to="/" class="mr-sm-4">Home</b-nav-item>
            <b-nav-item to="/about" class="mr-sm-4">About</b-nav-item>
            <b-nav-item href="/#how-it-works" class="mr-sm-4"
              >How It Works</b-nav-item
            >
            <b-nav-item to="/contact">Contact</b-nav-item>
          </b-navbar-nav>

          <b-navbar-nav class="ml-auto">
            <b-nav-item href="#">
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
      </b-navbar>
    </b-container>
  </div>
</template>

<style scoped lang="scss">
.navbar-light .navbar-nav .nav-link {
  color: rgb(0, 0, 0);
  font-weight: 500;
}
.navbar-light .navbar-nav .nav-link:hover,
.navbar-light .navbar-nav .nav-link:focus {
  color: var(--dark-green);
}
.navbar-light .navbar-nav .nav-link.router-link-exact-active {
  color: var(--dark-green);
}
@media (max-width: 600px) {
  .navbar-light .navbar-nav .nav-link {
    font-size: 14px;
  }
}
</style>

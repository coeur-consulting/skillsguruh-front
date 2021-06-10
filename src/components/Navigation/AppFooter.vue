<template>
  <footer>
    <b-container>
      <b-row>
        <b-col md="3" class="text-left">
          <b-img src="/img/logo.svg" class="mb-2" width="150"></b-img>
          <p>A platform for business owners and entreprenuer to upskill</p>

          <div class="mb-3">
            <b-iconstack font-scale="2.2" class="mr-3">
              <b-icon stacked icon="circle-fill" variant="dark-green"></b-icon>
              <b-icon
                stacked
                icon="facebook"
                variant="light"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
            <b-iconstack font-scale="2.2" class="mr-3">
              <b-icon stacked icon="circle-fill" variant="dark-green"></b-icon>
              <b-icon
                stacked
                icon="twitter"
                variant="light"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
            <b-iconstack font-scale="2.2" class="">
              <b-icon stacked icon="circle-fill" variant="dark-green"></b-icon>
              <b-icon
                stacked
                icon="instagram"
                variant="light"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
          </div>
          <small class="text-muted"
            >&copy; {{ new Date().getFullYear() }} SkillsGuruh</small
          >
        </b-col>
        <b-col class="link" md="3">
          <h5>About</h5>
          <router-link to="">Mission</router-link> <br />
          <router-link to="">Vision</router-link><br />
          <router-link to="">About Us</router-link><br />
          <router-link to="">FAQS</router-link><br />
          <router-link to="">Help Center</router-link>
        </b-col>
        <b-col class="link" md="3">
          <h5>Company</h5>
          <router-link to="">Mission</router-link> <br />
          <router-link to="">Vision</router-link><br />
          <router-link to="">About Us</router-link><br />
          <router-link to="">FAQS</router-link><br />
          <router-link to="">Help Center</router-link>
        </b-col>
        <b-col class="link" md="3">
          <h5>Quick Links</h5>
          <router-link to="">Mission</router-link> <br />
          <router-link to="">Vision</router-link><br />
          <router-link to="">About Us</router-link><br />
          <router-link to="">FAQS</router-link><br />
          <router-link to="">Help Center</router-link>
        </b-col>
      </b-row>
    </b-container>
  </footer>
</template>

<style scoped>
footer {
  position: relative;
  padding-top: 6rem;
  padding-bottom: 4rem;
  background: rgba(194, 237, 206, 0.06);
}
.link h5 {
  font-size: 16px;
  font-weight: 500;
  margin-bottom: 10px;
}
.link a {
  color: rgba(0, 0, 0, 0.5);
  font-size: 14px;
}
</style>

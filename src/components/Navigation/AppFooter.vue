<template>
  <footer>
    <b-container>
      <b-row>
        <b-col cols="12" md="3" class="d-none d-sm-inline-flex text-sm-left">
          <b-img src="/img/logo.svg" class="mb-2 logo"></b-img>
          <p class="fs14 text-muted">
            A platform for business owners and entreprenuer to upskill
          </p>

          <div class="mb-3">
            <b-iconstack font-scale="2.2" class="mr-3">
              <b-icon
                stacked
                icon="circle-fill"
                variant="lighter-green"
              ></b-icon>
              <b-icon
                stacked
                icon="facebook"
                variant="dark"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
            <b-iconstack font-scale="2.2" class="mr-3">
              <b-icon
                stacked
                icon="circle-fill"
                variant="lighter-green"
              ></b-icon>
              <b-icon
                stacked
                icon="twitter"
                variant="dark"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
            <b-iconstack font-scale="2.2" class="">
              <b-icon
                stacked
                icon="circle-fill"
                variant="lighter-green"
              ></b-icon>
              <b-icon
                stacked
                icon="instagram"
                variant="dark"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
          </div>
          <small class="text-muted"
            >&copy; {{ new Date().getFullYear() }} SkillsGuruh</small
          >
        </b-col>
        <b-col class="link" cols="4" md="3">
          <h5>About</h5>
          <router-link to=""><div>Mission</div></router-link>
          <router-link to=""><div>Vision</div></router-link>
          <router-link to="/about"><div>About Us</div></router-link>
          <router-link to="/contact"><div>FAQS</div></router-link>
          <router-link to="/contact"><div>Help Center</div></router-link>
        </b-col>
        <b-col class="link" cols="4" md="3">
          <h5>Company</h5>
          <router-link to=""><div>Mission</div></router-link>
          <router-link to=""><div>Vision</div></router-link>
          <router-link to="/about"><div>About Us</div></router-link>
          <router-link to="/contact"><div>FAQS</div></router-link>
          <router-link to="/contact"><div>Help Center</div></router-link>
        </b-col>
        <b-col class="link" cols="4" md="3">
          <h5>Quick Links</h5>
          <router-link to=""><div>Mission</div></router-link>
          <router-link to=""><div>Vision</div></router-link>
          <router-link to="/about"><div>About Us</div></router-link>
          <router-link to="/contact"><div>FAQS</div></router-link>
          <router-link to="/contact"><div>Help Center</div></router-link>
        </b-col>
        <b-col cols="12" md="3" class="d-sm-none text-sm-left">
          <b-img src="/img/logo.svg" class="mb-2 logo"></b-img>
          <p class="fs14 text-muted">
            A platform for business owners and entreprenuer to upskill
          </p>

          <div class="mb-3">
            <b-iconstack font-scale="2.2" class="mr-3">
              <b-icon
                stacked
                icon="circle-fill"
                variant="lighter-green"
              ></b-icon>
              <b-icon
                stacked
                icon="facebook"
                variant="dark"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
            <b-iconstack font-scale="2.2" class="mr-3">
              <b-icon
                stacked
                icon="circle-fill"
                variant="lighter-green"
              ></b-icon>
              <b-icon
                stacked
                icon="twitter"
                variant="dark"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
            <b-iconstack font-scale="2.2" class="">
              <b-icon
                stacked
                icon="circle-fill"
                variant="lighter-green"
              ></b-icon>
              <b-icon
                stacked
                icon="instagram"
                variant="dark"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
          </div>
          <small class="text-muted"
            >&copy; {{ new Date().getFullYear() }} SkillsGuruh</small
          >
        </b-col>
      </b-row>
    </b-container>
  </footer>
</template>

<style scoped>
.logo {
  width: 120px;
}
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
.link a div {
  color: rgba(0, 0, 0, 0.5);
  font-size: 14px;
  margin-bottom: 10px;
}
@media (max-width: 600px) {
  .container {
    height: 100%;
  }

  .row {
    flex-direction: row-reverse;
  }
  footer {
    padding-top: 3rem;
    padding-bottom: 2rem;
  }
  .logo {
    width: 100px;
  }
  .link h5 {
    font-size: 13px;
  }
  .link a div {
    font-size: 12px;
  }
}
</style>

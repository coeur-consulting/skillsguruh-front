<template>
  <footer>
    <b-container>
      <b-row>
        <b-col
          cols="12"
          md="3"
          class="d-none d-md-block text-center text-sm-left mt-4 mt-md-0"
        >
          <b-img src="" class="mb-2 logo" alt="Nzukoor"></b-img>
          <div class="d-flex mb-3">
            <b-img
              class="googleplay"
              :src="require('@/assets/images/landing/googleplay.png')"
            ></b-img>
            <b-img
              class="appstore"
              :src="require('@/assets/images/landing/appstore.png')"
            ></b-img>
          </div>

          <div class="mb-3">
            <b-iconstack font-scale="1.8" class="mr-3">
              <b-icon stacked icon="circle-fill" variant="white"></b-icon>
              <b-icon
                stacked
                icon="facebook"
                variant="mustard"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
            <b-iconstack font-scale="1.8" class="mr-3">
              <b-icon stacked icon="circle-fill" variant="white"></b-icon>
              <b-icon
                stacked
                icon="twitter"
                variant="mustard"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
            <b-iconstack font-scale="1.8" class="">
              <b-icon stacked icon="circle-fill" variant="white"></b-icon>
              <b-icon
                stacked
                icon="instagram"
                variant="mustard"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
          </div>
          <small class="text-muted"
            >&copy; {{ new Date().getFullYear() }} Nzukoor</small
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
        <b-col cols="12" md="3" class="d-md-none text-sm-left mt-4">
          <b-img src="" class="mb-2 logo" alt="Nzukoor"></b-img>
          <div class="d-flex justify-content-center mb-3">
            <b-img
              class="googleplay"
              :src="require('@/assets/images/landing/googleplay.png')"
            ></b-img>
            <b-img
              class="appstore"
              :src="require('@/assets/images/landing/appstore.png')"
            ></b-img>
          </div>

          <div class="mb-3">
            <b-iconstack font-scale="1.8" class="mr-3">
              <b-icon stacked icon="circle-fill" variant="white"></b-icon>
              <b-icon
                stacked
                icon="facebook"
                variant="mustard"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
            <b-iconstack font-scale="1.8" class="mr-3">
              <b-icon stacked icon="circle-fill" variant="white"></b-icon>
              <b-icon
                stacked
                icon="twitter"
                variant="mustard"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
            <b-iconstack font-scale="1.8" class="">
              <b-icon stacked icon="circle-fill" variant="white"></b-icon>
              <b-icon
                stacked
                icon="instagram"
                variant="mustard"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
          </div>
          <small class="text-muted"
            >&copy; {{ new Date().getFullYear() }} Nzukoor</small
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
  background: var(--mustard);
  text-align: left;
}
.link h5 {
  color: hsl(43deg 74% 25%);
  font-size: 0.95rem;
  font-weight: 500;
  margin-bottom: 6px;
}
.link a div {
  color: hsl(43deg 74% 25%);
  font-size: 0.8rem;
  margin-bottom: 5px;
}
.googleplay {
  margin-right: 10px;
}
.googleplay,
.appstore {
  width: 45%;
}
@media (max-width: 768px) {
  .container {
    height: 100%;
  }

  .row {
    flex-direction: row-reverse;
  }
  .googleplay,
  .appstore {
    width: 30%;
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
  p {
    font-size: 0.75rem;
  }
}
</style>

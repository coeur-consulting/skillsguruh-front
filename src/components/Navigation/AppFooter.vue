<template>
  <footer class="position-relative border-top">
    <b-container>
      <b-row>
        <b-col cols="12" md="6" class="text-center text-sm-left mb-4 mb-md-0">
          <b-img src="/icon.png" class="mb-4 logo" alt="Nzukoor"></b-img>
          <div
            class="d-flex mb-3 justify-content-center justify-content-md-start"
          >
            <b-img
              class="googleplay"
              :src="require('@/assets/images/landing/googleplay.png')"
            ></b-img>
            <b-img
              class="appstore"
              :src="require('@/assets/images/landing/appstore.png')"
            ></b-img>
          </div>

          <div>
            <small
              ><span @click="$router.push('/terms')">Terms of services</span><span class="mx-1">|</span
              ><span  @click="$router.push('/policy')">Privacy Policy</span></small
            >
          </div>

          <small class="text-muted"
            >&copy; {{ new Date().getFullYear() }} Nzukoor</small
          >
        </b-col>

        <b-col class="link mb-3 mb-md-0" cols="6" md="3">
          <h5>Company</h5>

          <router-link to="/about"><div>About Us</div></router-link>
          <router-link to="/contact"><div>FAQs</div></router-link>
          <router-link to="/contact"><div>Contact Us</div></router-link>
        </b-col>
        <b-col class="link mb-3 mb-md-0 d-md-none" cols="6" md="3">
          <b-img
            :src="require('@/assets/images/landing/black-brush.png')"
            class="black_brush"
          ></b-img>
          <b-img
            :src="require('@/assets/images/landing/mustard-brush.png')"
            class="mustard_brush"
          ></b-img>
        </b-col>

        <b-col class="link text-center text-sm-left" cols="12" md="3">
          <h4>Get In Touch</h4>
          <p class="text-muted mb-0">Partnership and general enquiries</p>
          <p>info@nzukoor.com</p>

          <div class="mb-3">
            <b-iconstack font-scale="1.8" class="mr-3">
              <b-icon
                stacked
                icon="circle-fill"
                class="lighter-circle"
              ></b-icon>
              <b-icon
                stacked
                icon="facebook"
                variant="dark-green"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
            <b-iconstack font-scale="1.8" class="mr-3">
              <b-icon
                stacked
                icon="circle-fill"
                class="lighter-circle"
              ></b-icon>
              <b-icon
                stacked
                icon="twitter"
                variant="dark-green"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
            <b-iconstack font-scale="1.8" class="">
              <b-icon
                stacked
                icon="circle-fill"
                class="lighter-circle"
              ></b-icon>
              <b-icon
                stacked
                icon="instagram"
                variant="dark-green"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
          </div>
        </b-col>
      </b-row>
    </b-container>

    <b-img
      :src="require('@/assets/images/landing/black-brush.png')"
      class="black_brush d-none d-md-block"
    ></b-img>
    <b-img
      :src="require('@/assets/images/landing/mustard-brush.png')"
      class="mustard_brush d-none d-md-block"
    ></b-img>
  </footer>
</template>

<style scoped lang="scss">
.logo {
  width: 100px;
}
footer {
  position: relative;
  padding-top: 6rem;
  padding-bottom: 4rem;
  background: white;
  text-align: left;
  color: rgba($color: #000000, $alpha: 0.54);
}
.black_brush {
  width: 18%;
  position: absolute;
  right: 0;
  transform: rotate(153deg);
}
.mustard_brush {
  width: 18%;
  position: absolute;
  right: 0;
  transform: rotate(153deg);
  bottom: 18px;
}
p {
  color: rgba($color: #000000, $alpha: 0.54);
  font-size: 0.85rem;
}
.lighter-circle {
  color: hsl(0deg, 0%, 96%);
}
.lighter-circle:hover {
  color: hsl(0deg, 0%, 93%);
}
.link h5 {
  color: var(--dark-green);
  font-size: 0.95rem;
  font-weight: 500;
  margin-bottom: 6px;
}
.link h4 {
  color: var(--dark-green);
  font-size: 1.3rem;
  font-weight: 600;
  margin-bottom: 6px;
}
.link a div {
  color: rgba($color: #000000, $alpha: 0.64);
  font-size: 0.8rem;
  margin-bottom: 5px;
}
.googleplay {
  margin-right: 10px;
}
.googleplay,
.appstore {
  width: 25%;
  max-height: 40px;
}
@media (max-width: 768px) {
  .black_brush {
    width: 25%;
  }
  .mustard_brush {
    width: 25%;
  }
}
@media (max-width: 600px) {
  .black_brush {
    position: relative;
    width: 100%;
    transform: unset;
  }
  .mustard_brush {
    position: relative;
    width: 100%;
    transform: unset;
  }
  .container {
    height: 100%;
  }

  .googleplay,
  .appstore {
    width: 25%;
  }
  footer {
    padding-top: 3rem;
    padding-bottom: 2rem;
  }
  .logo {
    width: 40px;
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

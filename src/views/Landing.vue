<template>
  <div id="main">
    <section class="banner" id="banner">
      <span class="vector1"></span>
      <span class="vector2"></span>
      <span class="vector3"></span>
      <span class="vector4"></span>
      <span class="vector5"></span>
      <span class="vector6"></span>
      <b-container class="h-100 d-flex align-items-end">
        <b-row
          class="
            justify-content-center
            align-items-center
            banner_row
            overflow-hidden
          "
        >
          <b-col md="6" sm="12" class="mb-sm-0 top_b">
            <div class="banner-text mb-3 mb-sm-5">
              <h1 class="mb-3 mt-4 mt-sm-0">
                Discover People, Knowledge, and Opportunities for Growth!
              </h1>
              <p>Enjoy a more engaging and organized virtual learning</p>
            </div>
            <div class="banner-buttons d-none d-sm-flex">
              <b-button
                block
                size="lg"
                variant="dark-green"
                @click="$router.push('/explore')"
                class="m-0 mr-3"
              >
                Explore Interest</b-button
              >
              <b-button
                v-if="!auth"
                block
                size="lg"
                class="m-0"
                variant="outline-dark-green"
                @click="$router.push('/register')"
              >
                Get Connected</b-button
              >
              <b-button
                v-if="auth"
                block
                size="sm"
                class="m-0"
                variant="outline-dark-green"
                v-b-tooltip.hover
                title="You are  connected"
              >
                Connected</b-button
              >
            </div>
            <div class="banner-buttons d-sm-none">
              <b-button
                block
                size="sm"
                variant="dark-green"
                @click="$router.push('/explore')"
                class="m-0 mr-3"
              >
                Explore Interest</b-button
              >
              <b-button
                v-if="auth"
                block
                size="sm"
                class="m-0"
                variant="outline-dark-green"
                v-b-tooltip.hover
                title="You are  connected"
              >
                Connected</b-button
              >
              <b-button
                v-if="!auth"
                block
                size="sm"
                class="m-0"
                variant="outline-dark-green"
                @click="$router.push('/register')"
              >
                Get Connected</b-button
              >
            </div>
          </b-col>
          <b-col md="6" class="position-relative down_b">
            <b-img
              class="
                animate__animated animate__slideInUp animate__slow
                img-fluid
                banner_image
              "
              alt="nzukoor"
              :src="require('../assets/images/banner-img.png')"
            ></b-img>
          </b-col>
        </b-row>
      </b-container>
    </section>

    <section id="how-it-works">
      <b-container class="">
        <h2 class="text-center">How it works</h2>
        <b-row class="mb-6">
          <b-col sm="6" class="d-flex align-items-center">
            <div class="onboard">
              <h5 class="mb-2">
                Join as an Organization and onboard your employees
              </h5>
              <p class="mb-4 pr-3">
                No longer do your employees have to struggle to get on the same
                page. Keep teams aligned and productive by signing them up to
                tailor-made courses that improve their skills.
              </p>
              <b-button
                size="lg"
                variant="dark-green"
                class="px-5 mb-5 mb-sm-0"
                @click="$router.push('/register')"
              >
                Invite Your Team
              </b-button>
            </div>
          </b-col>
          <b-col sm="6">
            <b-img
              v-animate-onscroll="
                'animate__animated animate__zoomIn animate__slow'
              "
              :src="require('../assets/images/onboard.png')"
            ></b-img>
          </b-col>
        </b-row>

        <b-row class="mb-6 flex-column-reverse flex-sm-row">
          <b-col sm="6">
            <b-img
              v-animate-onscroll="
                'animate__animated animate__zoomIn animate__slow'
              "
              :src="require('../assets/images/onboard2.png')"
            ></b-img>
          </b-col>
          <b-col sm="6" class="d-flex align-items-center">
            <div class="onboard">
              <h5 class="mb-2">Share your skills and expertise</h5>
              <p class="mb-4 pr-3">
                Now you can put your knowledge to work. Convert what you know to
                a course in minutes and enjoy teaching a more engaged group of
                members. Manage your private group, connect with external
                members and collaborate with other experts— the choice is yours!
              </p>
              <b-button
                size="lg"
                variant="dark-green"
                class="px-5"
                @click="$router.push('/login')"
              >
                Start Teaching
              </b-button>
            </div>
          </b-col>
        </b-row>

        <b-row class="">
          <b-col sm="6" class="d-flex align-items-center">
            <div class="onboard">
              <h5 class="mb-2">Shared interest is all you need</h5>
              <p class="mb-4 pr-3">
                Connect with experts and members with similar interests to gain
                rich insight to your most pressing questions, then pay it
                forward by lending your voice to trending discussions. Maximize
                the group access feature and make learning a party with your
                friends.
              </p>
              <p class="mb-3">Yes, you can be social even while learning.</p>
              <b-button
                size="lg"
                variant="dark-green"
                class="px-5 mb-5 mb-sm-0"
                @click="$router.push('/login')"
              >
                Connect & Learn
              </b-button>
            </div>
          </b-col>
          <b-col sm="6">
            <b-img
              v-animate-onscroll="
                'animate__animated animate__zoomIn animate__slow'
              "
              :src="require('../assets/images/onboard3.png')"
            ></b-img>
          </b-col>
        </b-row>
      </b-container>
    </section>
    <section id="facilitators">
      <b-container>
        <b-row
          v-animate-onscroll="'animate__animated animate__zoomIn animate__slow'"
        >
          <b-col class="ex-facilitators text-center">
            <h2 class="mb-2">Most Popular Facilitators</h2>
            <p class="mb-5">
              All our facilitators are awesome, but these ones really stand
              <br class="d-none d-sm-block" />
              out in our community. Get to know them!
            </p>

            <b-row class="facilitators d-none d-sm-flex">
              <b-col sm="4" class="mb-5 mb-sm-0 py-3 px-4">
                <div class="position-relative">
                  <div class="facilitator shadow-sm position-relative">
                    <b-img
                      class="rounded mb-4"
                      fluid-grow
                      src="/img/fac1.jpg"
                    ></b-img>
                    <div>Ada Okafor</div>
                    <div class="text-muted"><small>Facilitator</small></div>
                    <div>
                      <b-icon class="text-gold" icon="star-fill"></b-icon>
                      <b-icon class="text-gold" icon="star-fill"></b-icon>
                      <b-icon class="text-gold" icon="star-fill"></b-icon>
                      <b-icon class="text-gold" icon="star-fill"></b-icon>
                      <b-icon class="text-gold" icon="star-fill"></b-icon>
                    </div>
                  </div>
                  <span class="hover_box"></span>
                </div>
              </b-col>
              <b-col sm="4" class="mb-5 mb-sm-0 py-3 px-4">
                <div class="position-relative">
                  <div class="facilitator shadow-sm position-relative">
                    <b-img
                      class="rounded mb-4"
                      fluid-grow
                      src="/img/fac2.jpg"
                    ></b-img>
                    <div>John Obi Uchendu</div>
                    <div class="text-muted"><small>Facilitator</small></div>
                    <div>
                      <b-icon class="text-gold" icon="star-fill"></b-icon>
                      <b-icon class="text-gold" icon="star-fill"></b-icon>
                      <b-icon class="text-gold" icon="star-fill"></b-icon>
                      <b-icon class="text-gold" icon="star-fill"></b-icon>
                      <b-icon class="text-gold" icon="star-fill"></b-icon>
                    </div>
                  </div>
                  <span class="hover_box"></span>
                </div>
              </b-col>
              <b-col sm="4" class="mb-5 mb-sm-0 py-3 px-4">
                <div class="position-relative">
                  <div class="facilitator shadow-sm position-relative">
                    <b-img
                      class="rounded mb-4"
                      fluid-grow
                      src="/img/fac3.jpg"
                    ></b-img>
                    <div>Nkechi Ezeukwu</div>
                    <div class="text-muted"><small>Facilitator</small></div>
                    <div>
                      <b-icon class="text-gold" icon="star-fill"></b-icon>
                      <b-icon class="text-gold" icon="star-fill"></b-icon>
                      <b-icon class="text-gold" icon="star-fill"></b-icon>
                      <b-icon class="text-gold" icon="star-fill"></b-icon>
                      <b-icon class="text-gold" icon="star-fill"></b-icon>
                    </div>
                  </div>
                  <span class="hover_box"></span>
                </div>
              </b-col>
            </b-row>
            <b-row class="d-sm-none">
              <b-col>
                <carousel
                  :perPage="1"
                  :paginationEnabled="true"
                  navigationNextLabel=""
                  navigationPrevLabel=""
                  :autoplay="true"
                  :speed="1000"
                  :autoplayTimeout="5000"
                  :loop="true"
                >
                  <slide class="mb-sm-0 py-3 px-4">
                    <div class="position-relative">
                      <div class="facilitator shadow-sm position-relative">
                        <b-img
                          class="rounded mb-4"
                          fluid-grow
                          src="/img/fac1.jpg"
                        ></b-img>
                        <div>Ada Okafor</div>
                        <div class="text-muted"><small>Facilitator</small></div>
                        <div>
                          <b-icon class="text-gold" icon="star-fill"></b-icon>
                          <b-icon class="text-gold" icon="star-fill"></b-icon>
                          <b-icon class="text-gold" icon="star-fill"></b-icon>
                          <b-icon class="text-gold" icon="star-fill"></b-icon>
                          <b-icon class="text-gold" icon="star-fill"></b-icon>
                        </div>
                      </div>
                      <span class="hover_box"></span>
                    </div>
                  </slide>
                  <slide class="mb-sm-0 py-3 px-4">
                    <div class="position-relative">
                      <div class="facilitator shadow-sm position-relative">
                        <b-img
                          class="rounded mb-4"
                          fluid-grow
                          src="/img/fac2.jpg"
                        ></b-img>
                        <div>John Obi Uchendu</div>
                        <div class="text-muted"><small>Facilitator</small></div>
                        <div>
                          <b-icon class="text-gold" icon="star-fill"></b-icon>
                          <b-icon class="text-gold" icon="star-fill"></b-icon>
                          <b-icon class="text-gold" icon="star-fill"></b-icon>
                          <b-icon class="text-gold" icon="star-fill"></b-icon>
                          <b-icon class="text-gold" icon="star-fill"></b-icon>
                        </div>
                      </div>
                      <span class="hover_box"></span>
                    </div>
                  </slide>
                  <slide class="mb-sm-0 py-3 px-4">
                    <div class="position-relative">
                      <div class="facilitator shadow-sm position-relative">
                        <b-img
                          class="rounded mb-4"
                          fluid-grow
                          src="/img/fac3.jpg"
                        ></b-img>
                        <div>Nkechi Ezeukwu</div>
                        <div class="text-muted"><small>Facilitator</small></div>
                        <div>
                          <b-icon class="text-gold" icon="star-fill"></b-icon>
                          <b-icon class="text-gold" icon="star-fill"></b-icon>
                          <b-icon class="text-gold" icon="star-fill"></b-icon>
                          <b-icon class="text-gold" icon="star-fill"></b-icon>
                          <b-icon class="text-gold" icon="star-fill"></b-icon>
                        </div>
                      </div>
                      <span class="hover_box"></span>
                    </div>
                  </slide>
                </carousel>
              </b-col>
            </b-row>
          </b-col>
        </b-row>
      </b-container>
    </section>

    <section id="members">
      <b-container>
        <b-row>
          <b-col class="text-center members">
            <h2 class="mb-2">NZUKOOR STORIES</h2>
            <p class="mb-5">
              Stories of people whose lives were changed through Nzukoor
            </p>

            <div class="shadow member position-relative">
              <b-iconstack font-scale="3.5" class="nav-left shadow-sm">
                <b-icon stacked icon="circle-fill" variant="white"></b-icon>
                <b-icon
                  stacked
                  icon="arrow-left"
                  scale="0.5"
                  variant="dark-green"
                ></b-icon>
              </b-iconstack>

              <b-iconstack font-scale="3.5" class="nav-right shadow-sm">
                <b-icon
                  stacked
                  icon="circle-fill"
                  variant="dark-green"
                ></b-icon>
                <b-icon
                  stacked
                  icon="arrow-right"
                  scale="0.5"
                  variant="white"
                ></b-icon>
              </b-iconstack>
              <carousel
                :perPage="1"
                :paginationEnabled="false"
                :autoplay="true"
                :speed="1000"
                :autoplayTimeout="5000"
                :loop="true"
              >
                <slide>
                  <b-row>
                    <b-col sm="4" class="d-flex align-items-center">
                      <div class="p-4 testimonial">
                        <b-img class="member-img" src="/img/fac5.jpg"></b-img>
                      </div>
                    </b-col>
                    <b-col sm="8" class="d-flex align-items-center">
                      <div class="text-center p-2 p-sm-4 py-sm-5">
                        <b-icon
                          icon="chat-quote-fill"
                          class="text-dark-green mb-4"
                          font-scale="3.5"
                        ></b-icon>
                        <p>
                          My Customer Service team took the course on marketing
                          and I can already see the impact in their productivity
                          and results. Kudos to the Nzukoor team for such
                          innovation.
                        </p>
                        <div class="test-1">Oscar Eze— Entrepreneur, Lagos</div>
                      </div>
                    </b-col>
                  </b-row>
                </slide>
                <slide>
                  <b-row>
                    <b-col sm="4" class="d-flex align-items-center">
                      <div class="p-4 testimonial">
                        <b-img class="member-img" src="/img/fac4.jpg"></b-img>
                      </div>
                    </b-col>
                    <b-col sm="8" class="d-flex align-items-center">
                      <div class="text-center p-2 p-sm-4 py-sm-5">
                        <b-icon
                          icon="chat-quote-fill"
                          class="text-dark-green mb-4"
                          font-scale="3.5"
                        ></b-icon>
                        <p>
                          Thanks to Nzukoor I’ve been able to establish myself
                          as a supply chain expert. I find the groups to be more
                          engaged due to their shared interests and that really
                          drives me to be my best.
                        </p>
                        <div class="test-1">Umoh— Entrepreneur, Uyo</div>
                      </div>
                    </b-col>
                  </b-row>
                </slide>
                <slide>
                  <b-row>
                    <b-col sm="4" class="d-flex align-items-center">
                      <div class="p-4 testimonial">
                        <b-img
                          class="member-img"
                          :src="require('../assets/images/test.png')"
                        ></b-img>
                      </div>
                    </b-col>
                    <b-col sm="8" class="d-flex align-items-center">
                      <div class="text-center p-2 p-sm-4 py-sm-5">
                        <b-icon
                          icon="chat-quote-fill"
                          class="text-dark-green mb-4"
                          font-scale="3.5"
                        ></b-icon>
                        <p>
                          I invited my friends to take the BizGuruh course on
                          self-discovery via the free group access and that just
                          took us all to the next level. We’ve recently launched
                          our business and I can confirm that winning is
                          sweetest with my tribe.
                        </p>
                        <div class="test-1">Yetty — Student, Enugu</div>
                      </div>
                    </b-col>
                  </b-row>
                </slide>
              </carousel>
            </div>
          </b-col>
        </b-row>
      </b-container>
    </section>

    <section id="joinnow">
      <b-container>
        <b-row>
          <b-col class="joinnow bg-dark-green position-relative">
            <span class="eli1">
              <b-img :src="require('../assets/images/dot-im.png')"></b-img>
            </span>
            <span class="eli2">
              <b-img :src="require('../assets/images/large-elli.png')"></b-img>
            </span>
            <h2 class="mb-3 mb-sm-5 text-white">
              Create and deliver curated <br />
              learning in minutes
            </h2>
            <b-row class="d-flex position-relative">
              <b-col cols="12" sm="8" class="mb-3 mb-sm-0">
                <b-form-input placeholder="Enter your email"></b-form-input
              ></b-col>
              <b-col cols="12" sm="4"
                ><b-button
                  size="lg"
                  variant="outline-dark-green"
                  class="bg-white px-3 px-lg-5"
                  >Join Now</b-button
                ></b-col
              >
            </b-row>
          </b-col>
        </b-row>
      </b-container>
    </section>
  </div>
</template>
<script>
export default {
  data() {
    return {
      auth: null,
    };
  },
  mounted() {
    if (localStorage.getItem("authMember")) {
      this.auth = true;
    } else if (localStorage.getItem("authFacilitator")) {
      this.auth = true;
    } else if (localStorage.getItem("authAdmin")) {
      this.auth = true;
    } else if (localStorage.getItem("authOrg")) {
      this.auth = true;
    } else {
      return;
    }
  },
};
</script>
<style scoped lang="scss">
#main {
  max-width: 100vw;
  overflow-x: hidden;
}
#main ::-webkit-scrollbar {
  display: none;
}

/* Hide scrollbar for IE, Edge and Firefox */
.notification_container {
  -ms-overflow-style: none; /* IE and Edge */
  scrollbar-width: none; /* Firefox */
}
.testimonial {
  width: 100%;
}
#banner {
  position: relative;
  height: calc(100vh - 90px);
}
.banner {
  background-color: var(--skills-grey);
}
.banner-text {
  text-align: left;
}
.banner-text h1 {
  font-size: 30px;
  font-style: normal;
  font-weight: 700;
  line-height: 41px;
  letter-spacing: 0.06em;
  text-align: left;
  word-wrap: break-word;
}
.banner-text p {
  font-size: 18px;
  font-style: normal;
  font-weight: 400;
  line-height: 22px;
  letter-spacing: 0.06em;
  text-align: left;
}
.banner-buttons {
  display: flex;
}
.banner-image {
  position: relative;
}
.banner-image img {
  width: 100%;
  object-position: bottom;
  margin-bottom: -90px;
}
.vector1 {
  position: absolute;
  top: 20%;
  right: 0;
  background-image: url("../assets/images/eclipse-half.png");
  height: 50px;
  width: 18px;
  background-repeat: no-repeat;
}
.vector2 {
  position: absolute;
  bottom: 20%;
  left: 0;
  background-image: url("../assets/images/ellipse-half.png");
  height: 50px;
  width: 20px;
  background-repeat: no-repeat;
}
.vector3 {
  position: absolute;
  top: 20%;
  left: 0;
  background-image: url("../assets/images/poly.png");
  height: 100px;
  width: 60px;
  background-repeat: no-repeat;
}
.vector4 {
  position: absolute;
  top: 32.2%;
  left: 19.3%;
  background-image: url("../assets/images/ellipse2.png");
  height: 100px;
  width: 100px;
  background-repeat: no-repeat;
}
.vector5 {
  position: absolute;
  top: 33%;
  left: 57.4%;
  background-image: url("../assets/images/eli.png");
  height: 100px;
  width: 100px;
  background-repeat: no-repeat;
}
.vector6 {
  position: absolute;
  top: 33%;
  left: 77%;
  background-image: url("../assets/images/ellipse.png");
  height: 100px;
  width: 100px;
  background-repeat: no-repeat;
}
#how-it-works {
  min-height: 100vh;
  padding-top: 8rem;
  padding-bottom: 4rem;
}
.onboard {
  text-align: left;
}
.onboard h2 {
  font-size: 24px;
  font-style: normal;
  font-weight: 700;
  line-height: 29px;
  letter-spacing: 0.06em;
  text-align: left;
  padding-bottom: 1.5rem;
}
.onboard h3 {
  font-style: normal;
  font-weight: 500;
  line-height: 29px;
  text-align: left;
}
.onboard p {
  font-style: normal;
  font-weight: 400;
  line-height: 28px;
  letter-spacing: 0.06em;
  text-align: left;
}
.mb-6 {
  margin-bottom: 6rem;
}
#facilitators {
  position: relative;
  padding-top: 8rem;
  padding-bottom: 5rem;
}
.ex-facilitators {
}

.ex-facilitators h2 {
  font-size: 25px;
  font-style: normal;
  font-weight: 600;
  line-height: 33px;
  letter-spacing: 0em;
  text-align: center;
}
.ex-facilitators p {
  font-size: 16px;
  font-style: normal;
  font-weight: 400;
  line-height: 28px;
  letter-spacing: 0.06em;
  text-align: center;
  color: #828282;
}
.facilitators {
  display: flex;
  width: 100%;
  margin: 0 auto;
  justify-content: space-around;
  background: #fff;
}

.facilitator {
  padding: 25px;
  text-align: left;
  border-radius: 10px;
  z-index: 1;
  background: #f9fdfc;
}
.facilitator:hover ~ .hover_box {
  right: -5px;
  transform: rotate(5deg);
  opacity: 1;
}
.facilitator img {
  width: 100%;
  height: 200px;
}
.facilitator > div {
}
.text-gold {
  color: gold;
}
.test-1 {
  font-weight: 600;
}
#members {
  position: relative;
  padding-top: 8rem;
  padding-bottom: 5rem;
  background: rgba(194, 237, 206, 0.09);
}
.members h2 {
  font-size: 25px;
  font-style: normal;
  font-weight: 600;
  line-height: 33px;
  letter-spacing: 0em;
  text-align: center;
}
.members p {
  font-size: 16px;
  font-style: normal;
  font-weight: 400;
  line-height: 28px;
  letter-spacing: 0.06em;
  text-align: center;
  color: #828282;
}
.member {
  border-radius: 10px;
  background-color: #fff;
  position: relative;
  width: 80%;
  margin: 0 auto;
}
.member-img {
  border-radius: 10px;
  border-radius: 10px;
  width: 100%;
  height: 250px;
  object-fit: cover;
}
.text-1 {
  font-size: 17px;
}
.nav-left {
  position: absolute;
  left: -28px;
  top: 50%;
  margin-top: -28px;
  border-radius: 50%;
}
.nav-right {
  position: absolute;
  right: -28px;
  top: 50%;
  margin-top: -28px;
  border-radius: 50%;
}
#joinnow {
  position: relative;
  padding-top: 8rem;
  padding-bottom: 5rem;
}
.joinnow {
  padding: 8rem 15rem;
  border-radius: 10px;
  text-align: center;
}
.joinnow h2 {
  font-size: 36px;
  font-style: normal;
  font-weight: 700;
  line-height: 44px;
  letter-spacing: 0.14em;
  text-align: center;
}
.eli1 {
  position: absolute;
  top: 50%;
  right: 0;
  margin-top: -78.5px;
}
.eli2 {
  position: absolute;
  bottom: -25px;
  left: 10%;
}
.form-control {
  height: 56px;
  background: var(--lighter-green);
}
.btn {
  height: 56px;
}
img {
  width: 100%;
}
@media (max-width: 1024px) {
  .joinnow {
    padding: 5rem 10rem;
    border-radius: 10px;
    text-align: center;
  }
  .eli2 {
    bottom: -75px;
  }
}

@media (max-width: 1024px) {
  .test-1 {
    font-size: 0.9rem;
  }
  .joinnow {
    padding: 4rem 6rem;
    border-radius: 10px;
    text-align: center;
  }
  .eli2 {
    bottom: -75px;
  }
  .joinnow h2 {
    font-size: 26px;
    line-height: 34px;
  }
  .member {
    width: 90%;
  }
}

@media (max-width: 600px) {
  .banner-text h1 {
    font-size: 24px;
    font-style: normal;
    font-weight: 700;
    line-height: 31px;
    letter-spacing: 0.06em;
    text-align: left;
  }
  h2 {
    font-size: 17px !important;
  }
  .mb-6 {
    margin-bottom: 4.5rem;
  }
  .ex-facilitators p {
    line-height: 24px;
  }
  #facilitators {
    position: relative;
    padding-top: 4rem;
    padding-bottom: 3rem;
  }
  .joinnow {
    padding: 5rem 10rem;
    border-radius: 10px;
    text-align: center;
  }
  .eli2 {
    bottom: -75px;
  }
  .joinnow {
    padding: 2rem 1rem;
    border-radius: unset;
    text-align: center;
  }
  .joinnow h2 {
    font-size: 16px !important;
  }
  .form-control {
    height: 40px;
    font-size: 14px;
    background: var(--lighter-green);
  }
  .top_b {
    height: 50%;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }
  .down_b {
    height: 50%;
  }
  .banner_row {
    height: 100%;
  }
  .onboard p {
    font-style: normal;
    font-weight: 400;
    line-height: 24px;
    letter-spacing: 0.06em;
    text-align: left;
  }
  h5 {
    font-size: 1rem;
  }
  #how-it-works {
    padding-top: 5rem;
    padding-bottom: 0rem;
  }
  .members p {
    font-size: 12px;
    line-height: 1.5;
  }
  .member-img {
    height: 200px;
  }
  #joinnow {
    padding-top: 0rem;
    padding-bottom: 0rem;
  }
}
</style>

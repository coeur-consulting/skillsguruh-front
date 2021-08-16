<template>
  <div id="main">
    <section class="banner" id="banner">
      <b-container class="h-100 d-flex align-items-center pt-5 pt-md-0">
        <b-row class="justify-content-center align-items-center banner_row">
          <b-col md="6" sm="12" class="mb-sm-0 top_b">
            <div class="banner-text mb-3">
              <h1 class="d-none d-md-block mb-5 mb-md-4">
                <VueTextTransition
                  tag="h1"
                  name="fade"
                  :show="showTitle"
                  :interval="30"
                >
                  Discover People, Knowledge, and
                </VueTextTransition>
                <span class="d-flex">
                  <VueTextTransition
                    tag="h1"
                    name="fade"
                    :show="showTitle"
                    :interval="30"
                    class="mr-2"
                  >
                    Opportunities for
                  </VueTextTransition>

                  <span
                    class="
                      position-relative
                      text-secondary
                      growth-text
                      animate__animated animate__zoomIn
                    "
                    >Growth
                    <b-img
                      :src="require('@/assets/images/landing/black-brush.png')"
                    ></b-img>
                  </span>
                </span>
              </h1>

              <h1 class="mb-4 mb-sm-4 d-md-none">
                Discover People, Knowledge, and <br class="d-none d-md-block" />
                Opportunities for
                <span class="position-relative text-secondary growth-text"
                  >Growth
                  <b-img
                    :src="require('@/assets/images/landing/black-brush.png')"
                  ></b-img>
                </span>
              </h1>
              <p>Enjoy a more engaging and organized virtual network</p>
            </div>
            <div class="banner-buttons d-none d-sm-flex">
              <b-button
                block
                size="lg"
                variant="dark-green"
                @click="$router.push('/explore')"
                class="m-0 mr-3 btn-shadow"
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
                Get Started</b-button
              >
              <b-button
                v-if="auth"
                block
                size="lg"
                class="m-0 btn-shadow"
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
                class="m-0 mr-3 btn-shadow"
              >
                Explore Interest</b-button
              >
              <b-button
                v-if="auth"
                block
                size="sm"
                class="m-0 btn-shadow"
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
                class="m-0 btn-shadow"
                variant="outline-dark-green"
                @click="$router.push('/register')"
              >
                Get Started</b-button
              >
            </div>
          </b-col>
          <b-col md="6" class="position-relative down_b text-md-right">
            <kinesis-container>
              <kinesis-element :strength="10" type="depth">
                <b-img
                  v-animate-onscroll.repeat="
                    'animate__animated animate__pulse animate__repeat-1'
                  "
                  class="img-fluid banner_image"
                  alt="nzukoor"
                  :src="require('../assets/images/landing/banner-img.png')"
                ></b-img>
              </kinesis-element>
            </kinesis-container>
          </b-col>
        </b-row>
      </b-container>
    </section>

    <section id="with_nzukoor">
      <h2 class="mb-5"><span>Get N-circled</span></h2>
      <p class="mb-5">
        Follow our 3E-I to make the most of your time here. We promise it’ll be
        well worth your while.
      </p>
      <b-container>
        <b-row class="d-flex flex-column flex-md-row">
          <b-col
            sm="6"
            md="6"
            lg="3"
            class="mb-5 px-3 cursor-pointer"
            v-for="(item, id) in about"
            :key="id"
            v-animate-onscroll="item.animation"
            @click="$router.push(item.url)"
          >
            <div class="rules shadow-sm position-relative">
              <kinesis-container>
                <kinesis-element :strength="8" type="depth">
                  <b-img class="rounded mb-4" :src="item.image"></b-img>
                </kinesis-element>
                <div>{{ item.name }}</div>
                <p class="text-muted text-center text-md-left">
                  {{ item.text }}
                </p>
              </kinesis-container>
            </div>
          </b-col>
        </b-row>
      </b-container>
    </section>

    <section id="facilitators">
      <h2 class="mb-5"><span>Our Top Facilitators</span></h2>
      <p class="mb-5">
        All our facilitators are awesome, but these ones really stand out in our
        community. Get to know them!
      </p>

      <b-container>
        <b-row>
          <b-col>
            <carousel
              :perPage="1"
              :perPageCustom="[
                [600, 1],
                [768, 3],
              ]"
              :paginationEnabled="true"
              navigationNextLabel=""
              navigationPrevLabel=""
              :autoplay="true"
              :speed="1000"
              :autoplayTimeout="5000"
              :loop="true"
              class="py-3"
            >
              <slide
                class="mb-sm-0 px-3 py-1"
                v-for="(item, id) in facilitators"
                :key="id"
                v-animate-onscroll="'animate__animated animate__zoomIn '"
              >
                <div class="position-relative">
                  <div class="facilitator shadow-sm position-relative">
                    <kinesis-container>
                      <kinesis-element :strength="10">
                        <b-img
                          class="rounded mb-4"
                          fluid-grow
                          :src="item.image"
                        ></b-img>
                      </kinesis-element>
                    </kinesis-container>

                    <div>{{ item.name }}</div>
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
      </b-container>
    </section>
    <section id="joinnow" class="bg-dark-green">
      <b-img class="eli1" :src="require('../assets/images/dot-im.png')"></b-img>

      <b-container>
        <b-row>
          <b-col class="joinnow position-relative">
            <span class="eli2">
              <b-img :src="require('../assets/images/large-elli.png')"></b-img>
            </span>
            <h2 class="mb-3 mb-sm-5 text-white">
              Create and deliver curated learning in minutes
            </h2>

            <b-button
              @click="$router.push('/register')"
              size="lg"
              variant="outline-dark-green"
              class="
                bg-white
                text-dark-green
                px-3 px-lg-5
                border-white
                btn-raised btn-shadow
              "
              >Join Now</b-button
            >
          </b-col>
        </b-row>
        <b-img
          class="brush"
          :src="require('../assets/images/landing/white-brush.png')"
        ></b-img>
      </b-container>
    </section>

    <section id="members">
      <h2 class="mb-5"><span>Nzukoor Stories</span></h2>
      <p class="mb-5">
        Connect with experts and learners with similar interests. Join trending
        discussions and lend your voice to issues of
      </p>
      <b-container>
        <b-row>
          <b-col class="text-center members">
            <div class="shadow member position-relative">
              <b-iconstack
                font-scale="2.5"
                class="nav-left shadow-sm"
                v-if="index > 0"
                @click="index--"
              >
                <b-icon stacked icon="circle-fill" variant="white"></b-icon>
                <b-icon
                  stacked
                  icon="arrow-left"
                  scale="0.5"
                  variant="secondary"
                ></b-icon>
              </b-iconstack>

              <b-iconstack
                font-scale="2.5"
                class="nav-right shadow-sm"
                @click="index++"
                v-if="index < stories.length - 1"
              >
                <b-icon stacked icon="circle-fill" variant="secondary"></b-icon>
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
                :navigationEnabled="false"
                :autoplay="true"
                :speed="1000"
                :autoplayTimeout="5000"
                :loop="true"
                class="py-3"
                :navigateTo="index"
              >
                <slide v-for="(item, id) in stories" :key="id" class="py-1">
                  <b-row>
                    <b-col sm="4" class="d-flex align-items-center">
                      <div class="p-4 testimonial">
                        <kinesis-container>
                          <kinesis-element :strength="10">
                            <b-img class="member-img" :src="item.image"></b-img>
                          </kinesis-element>
                        </kinesis-container>
                      </div>
                    </b-col>
                    <b-col sm="8" class="d-flex align-items-center">
                      <div class="text-center p-2 p-sm-4 py-sm-5">
                        <b-icon
                          :icon="item.icon"
                          class="text-secondary mb-4"
                          font-scale="3.5"
                        ></b-icon>
                        <p class="p-3">
                          {{ item.story }}
                        </p>
                        <div class="test-1">{{ item.name }}</div>
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
  </div>
</template>
<script>
import { KinesisContainer, KinesisElement } from "vue-kinesis";
import VueTextTransition from "vue-text-transition";
export default {
  data() {
    return {
      showTitle: false,
      auth: null,
      index: 0,
      stories: [
        {
          name: "Oscar Eze— Entrepreneur, Lagos",
          story:
            " My Customer Service team took the course on marketing and I can already see the impact in their productivity and results. Kudos to the Nzukoor team for such innovation.",
          icon: "chat-quote-fill",
          image: require("@/assets/images/landing/test.png"),
        },
        {
          name: "Umoh— Entrepreneur, Uyo",
          story:
            "  Thanks to Nzukoor I’ve been able to establish myself  as a supply chain expert. I find the groups to be more engaged due to their shared interests and that really drives me to be my best",
          icon: "chat-quote-fill",
          image: require("@/assets/images/landing/fac4.jpg"),
        },
        {
          name: "Yetty — Student, Enugu",
          story:
            "I invited my friends to take the BizGuruh course on self-discovery via the free group access and that just took us all to the next level. We’ve recently launched  our business and I can confirm that winning is sweetest with my tribe.",
          icon: "chat-quote-fill",
          image: require("@/assets/images/landing/fac5.jpg"),
        },
      ],
      facilitators: [
        {
          name: "Ada Okafor, Lagos",

          image: require("@/assets/images/landing/story1.png"),
        },
        {
          name: "Obi Uchendu, Imo",

          image: require("@/assets/images/landing/story2.png"),
        },
        {
          name: "Nkechi Ezeukwu , Enugu",

          image: require("@/assets/images/landing/story3.png"),
        },
      ],
      about: [
        {
          name: "Explore",
          text: "Discover people, knowledge and opportunities across interests",
          image: require("@/assets/images/landing/explore.png"),
          animation: "animate__animated animate__slideInUp ",
          url: "/explore",
        },
        {
          name: "Engage",
          text: "Start and join discussions to connect with your tribe",
          image: require("@/assets/images/landing/engage.png"),
          animation: " animate__animated animate__slideInUp",
          url: "/explore/discussions",
        },
        {
          name: "Evolve",
          text: "Maximize courses and events, and soar",
          image: require("@/assets/images/landing/evolve.png"),
          animation: "animate__animated animate__slideInUp ",
          url: "/explore/courses",
        },
        {
          name: "Impact",
          text: "Invite your friends and win with your tribe",
          image: require("@/assets/images/landing/impact.png"),
          animation: "animate__animated animate__slideInUp",
          url: "explore/members",
        },
      ],
    };
  },
  components: {
    KinesisContainer,
    KinesisElement,
    VueTextTransition,
  },
  mounted() {
    setTimeout(() => {
      this.showTitle = true;
    }, 500);
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
  height: calc(100vh - 76px);
}
.banner {
  background-image: url("../assets/images/landing/transparent.png");
  background-position: center;
  background-repeat: no-repeat;
  background-size: contain;
}
.banner-text {
  text-align: left;
}
.banner-text h1 {
  font-size: 28px;
  font-style: normal;
  font-weight: 600;
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
  width: 70%;
}
.banner-image {
  position: relative;
}
.banner-image img {
  width: 100%;
  object-position: bottom;
  margin-bottom: 0px;
}
.down_b {
  justify-content: center;
  img {
    width: 90%;
    object-fit: contain;
  }
}
#with_nzukoor {
  padding-top: 80px;
  padding-bottom: 105px;
  background-image: url("../assets/images/landing/with_nzukoor.png");
  background-repeat: no-repeat;
  text-align: center;
  background-size: contain;
  h2 span {
    position: relative;
  }
  h2 span::after {
    content: "";
    background-image: url("../assets/images/landing/mustard-brush.png");
    position: absolute;
    width: 150px;
    height: 20px;
    background-size: 150px 20px;
    background-repeat: no-repeat;
    bottom: -24px;
    right: -15%;
  }
  > p {
    width: 35%;
    margin: 0 auto;
  }
}
@media (max-width: 1440px) {
  #with_nzukoor {
    > p {
      width: 40%;
    }
  }
}
@media (max-width: 768px) {
  .banner-buttons {
    width: 100%;
  }
  #with_nzukoor {
    > p {
      width: 95%;
    }
  }
}
.rules {
  background-color: white;
  border-radius: 8px;
  padding: 15px;
  text-align: left;
  height: 100%;
  img {
    width: 90%;
    object-position: center;
    object-fit: contain;
  }
  div {
    font-size: 0.9rem;
    font-weight: 500;
  }
  p {
    text-align: left;
    font-size: 0.9rem;
  }
}
.growth-text img {
  position: absolute;
  bottom: -15px;
  left: 0;
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
  padding-top: 80px;
  padding-bottom: 105px;
  text-align: center;
  background-image: url("../assets/images/landing/transparent.png");
  background-position: center;
  background-repeat: no-repeat;
  background-size: contain;

  h2 span {
    position: relative;
  }
  h2 span::after {
    content: "";
    background-image: url("../assets/images/landing/mustard-brush.png");
    position: absolute;
    width: 150px;
    height: 20px;
    background-size: 150px 20px;
    background-repeat: no-repeat;
    bottom: -24px;
    right: -15%;
  }
  > p {
    width: 35%;
    margin: 0 auto;
  }
}
@media (max-width: 1440px) {
  #facilitators {
    > p {
      width: 40%;
    }
  }
}
@media (max-width: 768px) {
  #facilitators {
    > p {
      width: 95%;
    }
  }
  .rules {
    width: 80%;
    margin: 0 auto;
    text-align: center;

    img {
      width: 60%;
    }
  }
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
  background: #fff;
}
.facilitator:hover ~ .hover_box {
  right: -5px;
  transform: rotate(6deg);
  opacity: 1;
}
.facilitator img {
  width: 100%;
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
  padding-top: 80px;
  padding-bottom: 105px;
  background: rgba(194, 237, 206, 0.09);
  text-align: center;
  background-image: url("../assets/images/landing/transparent.png");
  background-position: center;
  background-repeat: no-repeat;
  background-size: contain;

  h2 span {
    position: relative;
  }
  h2 span::after {
    content: "";
    background-image: url("../assets/images/landing/mustard-brush.png");
    position: absolute;
    width: 150px;
    height: 20px;
    background-size: 150px 20px;
    background-repeat: no-repeat;
    bottom: -24px;
    right: -15%;
  }
  > p {
    width: 35%;
    margin: 0 auto;
  }
}
@media (max-width: 1440px) {
  #members {
    > p {
      width: 40%;
    }
  }
}
@media (max-width: 768px) {
  #members {
    > p {
      width: 95%;
    }
  }
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

#joinnow {
  position: relative;
  padding-top: 105px;
  padding-bottom: 105px;
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;

  .brush {
    width: 35%;
    position: absolute;
    bottom: 25px;
    left: 50px;
  }
}

.joinnow h2 {
  font-size: 30px;
  font-style: normal;
  font-weight: 500;
  line-height: 1.5;
  letter-spacing: 0.14em;
  text-align: center;
}
.eli1 {
  width: 10%;
  position: absolute;
  top: 25px;
  right: 25px;
}
.eli2 {
  position: absolute;
  bottom: -15px;
  left: 10%;
}
.form-control {
  height: 56px;
  background: var(--lighter-green);
}
.btn {
  height: 46px;
}
img {
  width: 100%;
}
@media (max-width: 1024px) {
}

@media (max-width: 1024px) {
  .test-1 {
    font-size: 0.9rem;
  }

  .joinnow h2 {
    font-size: 26px;
  }
  .member {
    width: 90%;
  }
}

@media (max-width: 768px) {
  .banner-text {
    h1 {
      font-size: 22px;
      font-style: normal;
      font-weight: 700;
      line-height: 30px;
      letter-spacing: 0.06em;
      text-align: left;
    }
    p {
      font-size: 15px;
    }
  }

  h2 {
    font-size: 22px !important;
    color: rgba($color: #000000, $alpha: 0.64);
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

  .joinnow h2 {
    font-size: 16px !important;
  }
  .form-control {
    height: 40px;
    font-size: 14px;
    background: var(--lighter-green);
  }
  .top_b {
    display: flex;
    justify-content: center;
    flex-direction: column;
  }
  .down_b img {
    width: 80%;
  }
  .banner_row {
    height: 100%;
  }
  .onboard {
    text-align: center;
  }
  .onboard p {
    font-style: normal;
    font-weight: 400;
    line-height: 24px;
    letter-spacing: 0.06em;
    text-align: center;
  }
  h5 {
    font-size: 1rem;
    text-align: center;
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
}
</style>

<template>
  <div id="main">
    <section id="banner" class="position-relative">
      <carousel
        :perPage="1"
        :paginationEnabled="false"
        :navigationEnabled="false"
        :autoplay="true"
        :speed="1000"
        :autoplayTimeout="5000"
        :loop="true"
        v-model="bannerIndex"
        class="banner"
      >
        <!-- <slide>
          <div class="banner_1"></div>
        </slide> -->
        <slide>
          <div class="banner_2"></div>
        </slide>
      </carousel>
      <div class="banner_info">
        <div class="banner_text">
          <h1 class="mb-5 d-none d-md-block">
            <VueTextTransition
              tag="h1"
              name="fade"
              :show="showTitle"
              :interval="30"
            >
              Get comfortable, your tribe is here
            </VueTextTransition>

            <VueTextTransition
              tag="h1"
              name="fade"
              :show="showTitle"
              :interval="50"
            >
              Your most authentic connections in one place
            </VueTextTransition>
          </h1>
          <h1 class="mb-5 d-md-none">
            Get comfortable, your tribe is here. Your most authentic connections
            in one place
          </h1>
        </div>
        <div
          class="
            banner_search
            mb-4
            position-relative
            rounded-lg
            bg-white
            overflow-hidden
          "
        >
          <b-input-group>
            <b-input
              class="banner-search"
              type="search"
              v-model="query"
              :autofocus="false"
              autocomplete="off"
              aria-label="Search across over 100 tribes and find yourself"
              placeholder="Search across over 100 tribes and find yourself"
            ></b-input>

            <b-input-group-append>
              <b-button
                @click="searchProducts"
                @keyup.enter="searchProducts"
                class="banner-btn px-2 px-sm-4"
                variant="dark-green"
              >
                <!-- <span class="d-none d-md-block">Search</span> -->
                <span
                  ><b-icon
                    icon="search"
                    class="search-icon"
                    font-scale="1.1"
                  ></b-icon></span
              ></b-button>
            </b-input-group-append>
          </b-input-group>

          <div class="search_container" v-show="query.length">
            <div v-if="!groupedTribes.length">
              <span class="text-muted search_result">
                <b-icon icon="search"></b-icon> No search result</span
              >
            </div>
            <div v-else>
              <div class="text-muted mb-3 search_result">
                <b-icon icon="search"></b-icon>
                {{ groupedTribes.length }} search
                {{ groupedTribes.length > 1 ? "results" : "result" }}
              </div>
              <div
                v-for="(item, index) in groupedTribes"
                :key="index"
                class="bg-light rounded mb-3 p-2 d-flex result"
              >
                <div style="width: 20%">
                  <b-avatar
                    :src="item.cover"
                    icon="image"
                    size="4rem"
                    variant="transparent"
                  />
                </div>
                <div class="text-left px-2" style="width: 80%">
                  <span> {{ item.name }}</span> <br />
                  <span
                    class="text-truncate text-truncate--1 text-muted"
                    style="font-size: 0.85rem"
                  >
                    {{ item.description }}</span
                  >

                  <span
                    class="w-100 d-flex justify-content-between"
                    v-if="item.users"
                  >
                    <span class="fs10 text-muted"
                      >{{ item.users }}
                      {{ item.users > 1 ? "members" : "member" }}</span
                    >

                  </span>
                  <div
                      class=" text-right"

                      > <span  class="text-dark-green jointribe fs14 cursor-pointer"  @click="entertribe(item.id)">Join Tribe</span> </div
                    >
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="banner_button" v-if="!auth">
          <b-button-group size="lg">
            <b-button
              style="background-color: #227f74; border-color: #227f74"
              class="d-flex align-items-center"
            >
              <font-awesome-icon :icon="angle" class="fa-2x"
            /></b-button>
            <b-button
              to="/register"
              class="px-4 px-sm-5 d-flex align-items-center"
              variant="dark-green"
              >Get Started</b-button
            >
          </b-button-group>
        </div>
      </div>

      <div class="banner_nav" v-if="!query.length">
        <b-icon
          @click="bannerIndex > 0 ? bannerIndex-- : ''"
          icon="arrow-left-circle"
          class="mr-3 "
          :class="bannerIndex > 0 ? 'text-white' : 'text-light'"
          :font-scale="bannerIndex > 0 ? '1.5' : '1'"
        ></b-icon>
        <b-icon
          icon="arrow-right-circle"
          class=""
          :class="bannerIndex < 1 ? 'text-white' : 'text-light'"
          :font-scale="bannerIndex < 1 ? '1.5' : '1'"
        ></b-icon>
      </div>
    </section>
  </div>
</template>
<script>
//import { KinesisContainer, KinesisElement } from "vue-kinesis";
import { faAngleRight } from "@fortawesome/free-solid-svg-icons";
import VueTextTransition from "vue-text-transition";
import { mapGetters } from "vuex";
import _ from "lodash";
export default {
  data() {
    return {
      angle: faAngleRight,
      showTitle: false,
      auth: null,
      index: 0,
      bannerIndex: 0,
      query: "",
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
          url: "explore/mes",
        },
      ],
    };
  },
  components: {
    // KinesisContainer,
    // KinesisElement,
    VueTextTransition,
  },
  watch: {
    query: {
      handler: _.debounce(function () {
        this.searchProducts();
      }, 100),
    },
  },
  mounted() {
    var channel = this.$pusher.subscribe(`search`);
    channel.bind("searchResults", (e) => {
      this.$store.commit("SET_TRIBES", e.result);
    });
    this.$store.dispatch("GET_TRIBES");

    setTimeout(() => {
      this.showTitle = true;
    }, 350);
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
  methods: {
    searchProducts() {
      if (!this.query.length) return;
      this.$store.dispatch("SEARCH_TRIBES", this.query);
    },
    entertribe(id) {
      if (!this.auth) {
        this.$toast.error("login to access");
        return;
      }
      var details = {
        tribe_id: id,
        user: this.$store.getters.member,
      };

      this.$store.dispatch("checkTribe", details).then((res) => {
        if (res.status == 200 && res.data.message == "found") {
          window.location.href = `/me/tribe/discussions/${id}`;
        } else {
          this.$bvModal
            .msgBoxConfirm("Do you wish to join this tribe?")
            .then((val) => {
              if (val) {
                this.$store.dispatch("joinTribe", details).then((res) => {
                  if (res.status == 200 && res.data.message == "successful") {
                    this.$toast.success("Joined successfully");
                    window.location.href = `/me/tribe/discussions/${id}`;
                  }
                });
              }
            });
        }
      });
    },
  },
  computed: {
    groupedTribes() {
      return this.tribes;
    },
    ...mapGetters(["tribes"]),
  },
};
</script>
<style scoped lang="scss">
#main {
  max-width: 100vw;
  overflow-x: hidden;
  transition: all 0.6s;
}
#main ::-webkit-scrollbar {
  display: none;
}
.btn {
  height: 46px;
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
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}
.banner {
  background-image: url("../assets/images/landing/transparent.png");
  background-position: center;
  background-repeat: no-repeat;
  background-size: contain;
  height: 100%;
  width: 100%;
}
.banner_1 {
  background-image: url("../assets/images/landing/hero-img-1.png");
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  height: 100vh;
  width: 100vw;
  display: flex;
  justify-content: center;
  align-items: center;
}
.banner_2 {
  background-image: url("../assets/images/landing/optimized-hero-img-2.png");
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  height: 100vh;
  width: 100vw;
  display: flex;
  justify-content: center;
  align-items: center;
}
.banner_nav {
  position: absolute;
  bottom: 50px;
  right: 50px;
  display: flex;
  align-items: center;
}
.banner_info {
  width: 70%;
  position: absolute;
}
.banner_text {
  text-align: center;
  color: rgba($color: #ffffff, $alpha: 0.85);

  margin: 0 auto;
}
.banner_text h1 {
  font-size: 36px;
  font-style: normal;
  font-weight: 600;
  letter-spacing: 0.06em;
  word-wrap: break-word;
  color: white;
}
.btn.banner-btn {
  height: 52px;
}
.banner-search {
  height: 52px;
}
.banner_search {
  width: 65%;
  margin: 0 auto;
  transition: all 0.6s;
  @media (max-width: 600px) {
    width: 90%;
  }
  .search_container {
    transition: all 0.6s;
    width: 100%;
    background: #fff;
    max-height: 450px;
    overflow-y: scroll;
    padding: 15px;
    // position: absolute;
    z-index: 4;
  }
}

.banner_text p {
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
.result {

  height: 90px;
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
h1 {
  color: white;
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
  .result,
  .search_result,
  .jointribe {
    font-size: 0.7rem;
  }
  .result {
    height: 70px;
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
  .banner_text {
    h1 {
      font-size: 20px;
      font-style: normal;
      font-weight: 600;
      line-height: 30px;
      letter-spacing: 0.05em;
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
  .banner_info {
    width: 94%;
  }
  .form-control {
    height: 40px;
    font-size: 0.9rem;
  }
  ::placeholder {
    font-size: 0.75rem;
  }
  .btn {
    height: 40px;
  }

  .btn.banner-btn {
    height: 40px;
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
  .search-icon {
    font-size: 0.9rem;
  }
}
</style>

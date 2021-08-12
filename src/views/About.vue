<template>
  <div class="main_cont text-center text-md-left">
    <div class="position-relative">
      <div class="stbg">
        <div class="bg_overlay">
          <h2 class="text-white">About Us</h2>
        </div>
      </div>
    </div>
    <b-container class="">
      <b-row class="mb-4 py-5 align-items-center">
        <b-col
          sm="6"
          class="d-flex flex-column align-items-center text-center text-md-left"
        >
          <div>
            <div class="trending mb-5">
              <h2><span>What do I value?</span></h2>
            </div>

            <h5 class="mb-4 text-dark-green">
              How will I leave an eternal legacy?
            </h5>
            <p class="">These are questions that keep us awake at night.</p>

            <p>
              At
              <span class="text-dark-green font-weight-bold">Nzukoor</span>, our
              mission is to help people build their capacity to be more, so we
              connect them with <span class="font-weight-bold">Knowledge</span>,
              <span class="font-weight-bold">People</span> and
              <span class="font-weight-bold">Opportunities</span> everyday.
            </p>
            <p>
              Our desire is that as our users experience the growth, it
              transforms what they value, and inspires them to pay it forward so
              that others can live a full life as well.
            </p>
            <p>
              When you teach at SkillGuruh, you get to take part in something
              that has lasting value: helping people around the world experience
              growth and fulfillment.
            </p>
          </div>
        </b-col>
        <b-col sm="6" class="">
          <b-img
            v-animate-onscroll="
              'animate__animated animate__zoomIn animate__slow'
            "
            :src="require('../assets/images/about1.png')"
          ></b-img>
        </b-col>
      </b-row>
    </b-container>
    <section id="with_nzukoor">
      <h2 class="mb-5"><span>Get N-circled</span></h2>
      <p class="mb-5 text-center">
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
  </div>
</template>
<script>
import { KinesisContainer, KinesisElement } from "vue-kinesis";
export default {
  data() {
    return {
      about: [
        {
          name: "Explore",
          text: "Discover people, knowledge and opportunities across interests",
          image: require("@/assets/images/landing/explore.png"),
          animation: "animate__animated animate__slideInRight ",
          url: "/explore",
        },
        {
          name: "Engage",
          text: "Connect with your tribe",
          image: require("@/assets/images/landing/engage.png"),
          animation: " animate__animated animate__slideInRight",
          url: "/explore/discussions",
        },
        {
          name: "Evolve",
          text: "Maximize opportunities and soar",
          image: require("@/assets/images/landing/evolve.png"),
          animation: "animate__animated animate__slideInRight animate__slow",
          url: "/explore/courses",
        },
        {
          name: "Impact",
          text: "Invite your friends and win with your tribe",
          image: require("@/assets/images/landing/impact.png"),
          animation: "animate__animated animate__slideInRight animate__slow",
          url: "explore/members",
        },
      ],
    };
  },
  components: {
    KinesisContainer,
    KinesisElement,
  },
};
</script>
<style scoped lang="scss">
.main_cont {
  background: #f7f7f7;
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
.trending {
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
    right: 50%;
    margin-right: -75px;
  }
  > p {
    width: 35%;
    margin: 0 auto;
  }
}
.stbg {
  width: 100%;
  height: 250px;
  background-repeat: no-repeat;
  background-image: linear-gradient(to right, #388087 0%, #388087 100%),
    url("/img/explore_banner.jpg");
  background-blend-mode: overlay;
  background-size: cover;
  background-position: center;
}
.bg_overlay {
  height: 250px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(56, 128, 135, 0.85);
}
p {
  color: rgba(0, 0, 0, 0.54);
  line-height: 1.6;
}
p {
  text-align: justify;
}
@media (max-width: 1440px) {
  #with_nzukoor {
    > p {
      width: 40%;
    }
  }
}
@media (max-width: 768px) {
  .main_cont {
    text-align: center;
  }
  .banner-buttons {
    width: 100%;
  }
  #with_nzukoor {
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
  .trending {
    h2 {
      font-size: 1.3rem;
    }
  }
  p {
    text-align: center;
  }
}

@media (max-width: 600px) {
  .container {
    height: auto;
  }
  p {
    text-align: center;
  }
}
</style>

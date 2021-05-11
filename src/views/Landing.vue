<template>
  <div id="main">
    <section id="banner">
      <span class="vector1"></span>
      <span class="vector2"></span>
      <span class="vector3"></span>
      <span class="vector4"></span>
      <span class="vector5"></span>
      <span class="vector6"></span>
      <b-container class="h-100">
        <b-row class="align-items-center h-100 banner-vectors">
          <b-col sm="6">
            <div class="banner-text mb-5">
              <h1 class="mb-4 mt-4 mt-sm-0">
                A platform for employees and business owners to upskill
              </h1>
              <p>Enjoy a more engaging and organized virtual learning</p>
            </div>
            <div class="banner-buttons d-none d-sm-flex">
              <b-button block size="lg" variant="dark-green" class="m-0 mr-3">
                Explore Interest</b-button
              >
              <b-button
                block
                size="lg"
                class="m-0"
                variant="outline-dark-green"
              >
                Become a Facilitator</b-button
              >
            </div>

            <div class="banner-buttons d-flex d-sm-none">
              <b-button block size="sm" variant="dark-green" class="m-0 mr-3">
                Explore Interest</b-button
              >
              <b-button
                block
                size="sm"
                class="m-0"
                variant="outline-dark-green"
              >
                Become a Facilitator</b-button
              >
            </div>
          </b-col>
          <b-col sm="6" class="banner-image">
            <b-img :src="require('../assets/images/side-image.png')"></b-img>
          </b-col>
        </b-row>
      </b-container>
    </section>
    <section id="how-it-works">
      <b-container>
        <b-row class="mb-6">
          <b-col sm="6" class="d-flex align-items-center">
            <div class="onboard">
              <h2 class="mb-4">
                Join has an Organization and onboard your employees
              </h2>
              <p class="mb-4 pr-3">
                Join the platform as an organization and onboard your employee.
                No longer do your employees have to struggle to get on the same
                page. Keep teams aligned and productive with tailor-made courses
                that improve their skills.
              </p>
              <b-button
                size="lg"
                variant="dark-green"
                class="px-5 mb-5 mb-sm-0"
              >
                Invite Your Team
              </b-button>
            </div>
          </b-col>
          <b-col sm="6">
            <b-img :src="require('../assets/images/onboard.png')"></b-img>
          </b-col>
        </b-row>

        <b-row class="mb-6">
          <b-col sm="6">
            <b-img :src="require('../assets/images/onboard2.png')"></b-img>
          </b-col>
          <b-col sm="6" class="d-flex align-items-center">
            <div class="onboard">
              <h2 class="mb-4">
                Join as a facilitator and share your skills and expertise
              </h2>
              <p class="mb-4 pr-3">
                Now you can put your knowledge to work. Convert what you know to
                a course and enjoy teaching a more engaged group of learners.
                Manage your private group, collaborate with other experts and
                extend your expertise to external learners.
              </p>
              <b-button size="lg" variant="dark-green" class="px-5">
                Share Your Knowledge
              </b-button>
            </div>
          </b-col>
        </b-row>

        <b-row class="">
          <b-col sm="6" class="d-flex align-items-center">
            <div class="onboard">
              <h2 class="mb-4">
                Join as a learner and get access to expert and other learners
                like you
              </h2>
              <p class="mb-4 pr-3">
                Connect with experts and learners with similar interests. Join
                trending discussions and lend your voice to issues of public
                interest. You can be social even while learning.
              </p>
              <b-button
                size="lg"
                variant="dark-green"
                class="px-5 mb-5 mb-sm-0"
              >
                Connect & Learn
              </b-button>
            </div>
          </b-col>
          <b-col sm="6">
            <b-img :src="require('../assets/images/onboard3.png')"></b-img>
          </b-col>
        </b-row>
      </b-container>
    </section>
    <section id="facilitators">
      <b-container>
        <b-row>
          <b-col class="ex-facilitators text-center">
            <h2 class="mb-4">Most Popular Facilitators</h2>
            <p class="mb-5">
              Connect with experts and learners with similar interests. <br />
              Join trending discussions and lend your voice to issues of
            </p>

            <b-row class="facilitators">
              <b-col sm="4" class="mb-5 mb-sm-0">
                <div class="facilitator shadow">
                  <b-img
                    class="rounded mb-4"
                    :src="require('../assets/images/test.png')"
                  ></b-img>
                  <div>John Snow</div>
                  <div class="text-muted"><small>Facilitator</small></div>
                  <div>
                    <b-icon class="text-gold" icon="star-fill"></b-icon>
                    <b-icon class="text-gold" icon="star-fill"></b-icon>
                    <b-icon class="text-gold" icon="star-fill"></b-icon>
                    <b-icon class="text-gold" icon="star-fill"></b-icon>
                    <b-icon class="text-gold" icon="star-fill"></b-icon>
                  </div>
                </div>
              </b-col>
              <b-col sm="4" class="mb-5 mb-sm-0">
                <div class="facilitator shadow">
                  <b-img
                    class="rounded mb-4"
                    :src="require('../assets/images/test.png')"
                  ></b-img>
                  <div>John Snow</div>
                  <div class="text-muted"><small>Facilitator</small></div>
                  <div>
                    <b-icon class="text-gold" icon="star-fill"></b-icon>
                    <b-icon class="text-gold" icon="star-fill"></b-icon>
                    <b-icon class="text-gold" icon="star-fill"></b-icon>
                    <b-icon class="text-gold" icon="star-fill"></b-icon>
                    <b-icon class="text-gold" icon="star-fill"></b-icon>
                  </div>
                </div>
              </b-col>
              <b-col sm="4" class="mb-5 mb-sm-0">
                <div class="facilitator shadow">
                  <b-img
                    class="rounded mb-4"
                    :src="require('../assets/images/test.png')"
                  ></b-img>
                  <div>John Snow</div>
                  <div class="text-muted"><small>Facilitator</small></div>
                  <div>
                    <b-icon class="text-gold" icon="star-fill"></b-icon>
                    <b-icon class="text-gold" icon="star-fill"></b-icon>
                    <b-icon class="text-gold" icon="star-fill"></b-icon>
                    <b-icon class="text-gold" icon="star-fill"></b-icon>
                    <b-icon class="text-gold" icon="star-fill"></b-icon>
                  </div>
                </div>
              </b-col>
            </b-row>
          </b-col>
        </b-row>
      </b-container>
    </section>

    <section id="learners">
      <b-container>
        <b-row>
          <b-col class="text-center learners">
            <h2 class="mb-4">Learner’s Experience</h2>
            <p class="mb-5">
              Connect with experts and learners with similar interests. <br />
              Join trending discussions and lend your voice to issues of
            </p>

            <div class="shadow learner position-relative">
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
                :navigationEnabled="true"
                navigationNextLabel=""
                navigationPrevLabel=""
              >
                <slide>
                  <b-row>
                    <b-col sm="4" class="d-flex align-items-center">
                      <div class="p-4">
                        <b-img
                          class="learner-img"
                          :src="require('../assets/images/test.png')"
                        ></b-img>
                      </div>
                    </b-col>
                    <b-col sm="8" class="d-flex align-items-center">
                      <div class="text-center p-4 py-5">
                        <b-icon
                          icon="chat-quote-fill"
                          class="text-dark-green mb-4"
                          font-scale="3.5"
                        ></b-icon>
                        <p>
                          Every aspect of learning in skillsguruh as brought my
                          business closer and close to my dream business, im so
                          grateful to this platform
                        </p>
                        <div class="test-1">Jane Doe</div>
                      </div>
                    </b-col>
                  </b-row>
                </slide>
                <slide>
                  <b-row>
                    <b-col sm="4" class="d-flex align-items-center">
                      <div class="p-4">
                        <b-img
                          class="learner-img"
                          :src="require('../assets/images/test.png')"
                        ></b-img>
                      </div>
                    </b-col>
                    <b-col sm="8" class="d-flex align-items-center">
                      <div class="text-center p-4 py-5">
                        <b-icon
                          icon="chat-quote-fill"
                          class="text-dark-green mb-4"
                          font-scale="3.5"
                        ></b-icon>
                        <p>
                          Every aspect of learning in skillsguruh as brought my
                          business closer and close to my dream business, im so
                          grateful to this platform
                        </p>
                        <div class="test-1">Jane Doe</div>
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

<style scoped lang="scss">
#main {
  overflow-x: hidden;
}
#banner {
  position: relative;
  background-color: var(--skills-grey);
  height: calc(100vh - 70px);
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
}
.onboard p {
  font-size: 16px;
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
}
.facilitator {
  padding: 25px;
  text-align: left;
  border-radius: 10px;
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
#learners {
  position: relative;
  padding-top: 8rem;
  padding-bottom: 5rem;
  background: rgba(194, 237, 206, 0.09);
}
.learners h2 {
  font-size: 25px;
  font-style: normal;
  font-weight: 600;
  line-height: 33px;
  letter-spacing: 0em;
  text-align: center;
}
.learners p {
  font-size: 16px;
  font-style: normal;
  font-weight: 400;
  line-height: 28px;
  letter-spacing: 0.06em;
  text-align: center;
  color: #828282;
}
.learner {
  border-radius: 10px;
  background-color: #fff;
  position: relative;
  width: 80%;
  margin: 0 auto;
}
.learner-img {
  border-radius: 10px;
  border-radius: 10px;
  width: 100%;
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
  .learner {
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
    font-size: 20px !important;
  }
  p {
    font-size: 15px !important;
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
}
</style>

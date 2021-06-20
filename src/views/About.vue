<template>
  <div class="main_content text-left py-5">
    <div class="position-relative">
      <div class="stbg">
        <div class="bg_overlay">
          <h1 class="text-white font-weight-bold">About Us</h1>
        </div>
      </div>
    </div>
    <b-container class="">
      <b-row class="mb-4 py-5 align-items-center">
        <b-col sm="6" class="d-flex flex-column align-items-center">
          <div>
            <h5>What do I value?</h5>

            <h6 class="mb-4">How will I leave an eternal legacy?</h6>

            <p>
              These are questions that keep us awake at night. At SkillsGuruh,
              our mission is to help people build their capacity to be more, so
              we connect them with knowledge, people and opportunities everyday.
              Our desire is that as our users experience the growth, it
              transforms what they value, and inspires them to pay it forward so
              that others can live a full life as well. When you teach at
              SkillGuruh, you get to take part in something that has lasting
              value: helping people around the world experience growth and
              fulfillment.
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

      <b-row class="align-items-center">
        <b-col sm="6" class="">
          <b-img
            v-animate-onscroll="
              'animate__animated animate__zoomIn animate__slow'
            "
            :src="require('../assets/images/about.png')"
          ></b-img>
        </b-col>
        <b-col sm="6" class="">
          <h6 class="mb-4">
            Want to be part of the change we work for everyday?
          </h6>
          <p>
            Do you want to join our amazing team of facilitators or do you want
            to connect abd becme part of yhrs amazing community?
          </p>
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
              block
              size="lg"
              class="m-0"
              variant="outline-dark-green"
              @click="$router.push('/register')"
            >
              Connect & Learn</b-button
            >
          </div>
          <div class="banner-buttons d-flex d-sm-none">
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
              block
              size="sm"
              class="m-0"
              variant="outline-dark-green"
              @click="$router.push('/register')"
            >
              Connect & Learn</b-button
            >
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<style scoped lang="scss">
.main_content {
  background: #f7f7f7;
}
.container {
  min-height: calc(100vh - 100px);
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
  line-height: 28px;
}
</style>

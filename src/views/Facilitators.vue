<template>
  <b-container>
    <b-row class="facilitators">
      <b-col
        sm="4"
        class="mb-5 mb-sm-0 py-3 px-4"
        v-for="(item, id) in facilitators"
        :key="id"
      >
        <div class="position-relative">
          <div class="facilitator shadow-sm position-relative">
            <b-img class="rounded mb-4" fluid-grow src="/img/fac1.jpg"></b-img>
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
    </b-row>
  </b-container>
</template>

<script>
export default {
  data() {
    return {
      facilitators: [],
    };
  },
  mounted() {
    this.getfacilitators();
  },
  methods: {
    getfacilitators() {
      this.$http
        .get(`${this.$store.getters.url}/guest/facilitators`)
        .then((res) => {
          if (res.status == 200) {
            this.facilitators = res.data;
          }
        });
    },
  },
};
</script>

<style scoped>
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
.hover_box {
  width: 100%;
  height: 100%;
  background: var(--dark-green);
  position: absolute;
  right: 0px;
  top: 0;
  border-radius: 10px;
  z-index: 0;
  transition: 0.25s;
  opacity: 0;
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
</style>

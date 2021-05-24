<template>
  <b-container class="p-0 pb-5">
    <b-row class="main bg-white">
      <b-col
        sm="12"
        class="text-left p-4 main-bg h-100 mb-4"
        :style="{ backgroundImage: `url(${event.cover})` }"
      >
        <div
          class="event-overlay d-flex flex-column justify-content-center p-5 text-white"
        >
          <div class="event_content">
            <div class="display-4 mb-3">{{ event.title }}</div>
            <div>
              <h6>Facilitators</h6>
              <ul>
                <li
                  v-for="item in sortfacilitators"
                  :key="item.id"
                  class="text-capitalize"
                >
                  {{ item.name }}
                </li>
              </ul>
            </div>
          </div>
        </div>

        <div class="event_box shadow-lg">
          <h6 class="mb-1 font-weight-bolder px-3 py-2 text-dark-green">
            When & Where
          </h6>
          <div class="mb-1 px-3 py-1 border-bottom">
            <span class="font-weight-bold fs14 text-dark-green"
              >Event Type</span
            >
            <br />
            <span class="fs16 text-capitalize"> {{ event.type }}</span>
          </div>
          <div class="mb-1 px-3 py-1">
            <span class="font-weight-bold fs14 text-dark-green"
              >Event Duration</span
            >
            <br />
            <span class="fs16"> {{ event.schedule }}</span>
          </div>

          <div
            class="mb-1 px-3 py-2 bg-dark-green text-white d-flex justify-content-between"
          >
            <span
              ><span class="font-weight-bold fs15">Start</span>
              <br />
              <span class="fs16"> {{ event.start | moment("ll") }}</span></span
            >
            -
            <span>
              <span class="font-weight-bold fs15"> End</span>
              <br />
              <span class="fs16"> {{ event.end | moment("ll") }}</span></span
            >
          </div>

          <div class="mb-1 px-3 py-2 fs15 bg-light">
            <span class="font-weight-bold fs14 text-dark-green"
              >Event Link</span
            >
            <br />
            <div class="fs12">{{ event.url }}</div>
          </div>
          <div class="mb-1 px-3 py-2">
            <b-badge>{{ event.status }}</b-badge>
          </div>
        </div>
      </b-col>
      <b-col class="h-100 p-5">
        <div class="bg-white shadow-lg rounded text-left p-4">
          <h5 class="font-weight-bold">ABOUT THIS EVENT</h5>
          <p>{{ event.description }}</p>
        </div>
      </b-col>
    </b-row>
  </b-container>
</template>
<script>
export default {
  data() {
    return {
      event: {},
      facilitators: [],
    };
  },
  mounted() {
    this.getfacilitators().then(() => {
      this.getevent();
    });
  },
  computed: {
    sortfacilitators() {
      if (!this.event.facilitators) {
        return "Unavailable";
      }
      return this.facilitators.filter((val) =>
        JSON.parse(this.event.facilitators).includes(val.id)
      );
    },
  },
  methods: {
    async getfacilitators() {
      return this.$http
        .get(`${this.$store.getters.url}/facilitators`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.facilitators = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getevent() {
      this.$http
        .get(`${this.$store.getters.url}/events/${this.$route.params.id}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.event = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
  },
};
</script>

<style scoped>
.container {
  height: calc(100vh - 100px);
}
.main {
  height: 50vh;
}
.main-bg {
  background-position: center;
  background-size: cover;
  position: relative;
}
.event_box {
  position: absolute;
  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
  border-radius: 1px;
  background: white;
  top: 50%;
  transform: translateY(-50%);
  right: 8%;
  z-index: 3;
  width: 300px;
}
.event_text {
  z-index: 2;
  position: relative;
}
.event-overlay {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background: rgba(0, 0, 0, 0.5);
  z-index: 1;
}
.event_content {
  width: 50%;
}
</style>

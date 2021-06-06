<template>
  <b-container class="p-0 pb-5">
    <b-row class="main bg-white">
      <b-col
        sm="12"
        class="text-left p-4 main-bg h-100 mb-4 position-relative"
        :style="{ backgroundImage: `url(${event.cover})` }"
      >
        <div class="back text-left text-white">
          <span @click="$router.go(-1)" class="cursor-pointer">
            <b-icon icon="arrow-left"></b-icon> Back</span
          >
        </div>
        <div
          class="event-overlay d-flex flex-column justify-content-center p-5 text-white"
        >
          <div class="event_content">
            <div class="display-4 mb-3">{{ event.title }}</div>
          </div>
        </div>

        <div class="event_box shadow-lg">
          <div class="d-flex justify-content-between">
            <h6 class="font-weight-bolder px-3 py-2 text-dark-green">
              When & Where
            </h6>
            <div class="mb-1 px-3 py-2">
              <b-badge
                class="text-capitalize"
                :class="{
                  'bg-success': event.status == 'active',
                  'bg-danger': event.status == 'expired',
                  'bg-primary': event.status == 'pending',
                }"
                >{{ event.status }}</b-badge
              >
            </div>
          </div>
          <div class="mb-1 px-3 py-1 border-bottom">
            <span class="font-weight-bold fs13 text-dark-green"
              >Event Type</span
            >
            <br />
            <span class="fs14 text-capitalize"> {{ event.type }}</span>
          </div>
          <div class="mb-1 px-3 py-1">
            <span class="font-weight-bold fs13 text-dark-green"
              >Event Duration</span
            >
            <br />
            <span class="fs14"> {{ event.schedule }}</span>
          </div>

          <div
            class="px-3 py-2 bg-dark-green text-white d-flex justify-content-between"
          >
            <span
              ><span class="font-weight-bold fs13">Start</span>
              <br />
              <span class="fs13">
                {{ event.start | moment(" MMMM Do YYYY, h:mm:ss a") }}</span
              >
            </span>

            <span>
              <span class="font-weight-bold fs13"> End</span>
              <br />
              <span class="fs13">
                {{ event.end | moment(" MMMM Do YYYY, h:mm:ss a") }}</span
              ></span
            >
          </div>
          <div class="px-3 py-2 fs15 bg-light">
            <span class="font-weight-bold fs13 text-dark-green"
              >Event Venue</span
            >
            <br />
            <div class="fs12">{{ event.venue }}</div>
          </div>

          <div class="mb-1 px-3 py-2 fs15 bg-light" v-if="event.url">
            <span class="font-weight-bold fs13 text-dark-green"
              >Event Link</span
            >
            <br />
            <div class="fs12">
              <a :href="event.url" target="_blank">{{ event.url }}</a>
            </div>
          </div>
        </div>
      </b-col>
      <b-col class="h-100">
        <b-row>
          <b-col sm="7">
            <div class="bg-white shadow rounded text-left p-4">
              <h5 class="font-weight-bold">ABOUT THIS EVENT</h5>
              <p>{{ event.description }}</p>

              <div v-if="sortfacilitators.length">
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
          </b-col>
          <b-col sm="5" class="pl-3" v-if="event.resource">
            <div class="bg-white shadow p-1 rounded">
              <video
                controls
                :src="event.resource"
                width="100%"
                fluid-grow
                v-if="vid_ext.includes(this.getextension(event.resource))"
              ></video>
              <div v-else>
                <a
                  :href="event.resource"
                  download=""
                  target="_blank"
                  rel="noopener noreferrer"
                >
                  <div class="rounded shadow p-4 bg-lighter-green d_file">
                    <h5 class="mb-2">Download event resource</h5>
                    <b-icon
                      icon="cloud-download"
                      class="text-muted"
                      font-scale="3rem"
                    ></b-icon></div
                ></a>
              </div>
            </div>
          </b-col>
        </b-row>
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
      vid_ext: ["mp4", "3gp"],
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
        return [];
      }
      return this.facilitators.filter((val) =>
        JSON.parse(this.event.facilitators).includes(val.id)
      );
    },
  },
  methods: {
    getextension(fileName) {
      if (fileName) {
        var regex = new RegExp("[^.]+$");
        var extension = fileName.match(regex);

        return extension[0];
      }
    },
    async getfacilitators() {
      return this.$http
        .get(`${this.$store.getters.url}/admin-get-facilitators`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
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
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
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
span {
  line-height: 1.3;
}
.back {
  position: absolute;
  top: 15px;
  left: 15px;
  z-index: 999;
}
</style>

<template>
  <b-container class="pb-5">
    <b-row class="main bg-white" v-if="showEvent">
      <b-col
        sm="12"
        class="text-left p-4 main-bg h-100 mb-4 position-relative"
        :style="{ backgroundImage: `url(${event.cover})` }"
      >
        <div
          class="
            event-overlay
            d-flex
            flex-column
            justify-content-center
            p-5
            text-white
          "
        >
          <div class="event_content">
            <h3 class="">{{ event.title }}</h3>
          </div>
        </div>
        <div class="event_box shadow d-none d-md-block rounded">
          <div class="d-flex justify-content-between">
            <span class="font-weight-bold fs14 px-3 py-2 text-dark-green">
              When & Where
            </span>
            <div class="mb-1 px-3 py-2">
              <b-badge
                class="text-capitalize"
                :class="{
                  'bg-success': event.status == 'ongoing',
                  'bg-danger': event.status == 'expired',
                  'bg-primary': event.status == 'pending',
                }"
                >{{ event.status }}</b-badge
              >
            </div>
          </div>
          <div class="d-flex justify-content-between border-top">
            <div class="mb-1 px-3 py-1">
              <span class="font-weight-bold font-sm text-dark-green"
                >Event Type</span
              >
              <br />
              <span class="fs14 text-capitalize"> {{ event.type }}</span>
            </div>
            <div class="mb-1 px-3 py-1">
              <span class="font-weight-bold font-sm text-dark-green"
                >Event Duration</span
              >
              <br />
              <span class="fs14"> {{ event.schedule }}</span>
            </div>
          </div>
          <div
            class="px-3 py-2 bg-lighter-green d-flex justify-content-between"
          >
            <span
              ><span class="font-weight-bold font-sm">Start</span>
              <br />
              <span class="fs12">
                {{ event.start | moment(" MMM D YYYY, h:mm a") }}</span
              >
            </span>

            <span>
              <span class="font-weight-bold font-sm"> End</span>
              <br />
              <span class="fs12">
                {{ event.end | moment(" MMM D YYYY, h:mm a") }}</span
              ></span
            >
          </div>

          <div class="d-flex justify-content-between bg-light border-bottom">
            <div class="px-3 py-2 fs15">
              <span class="font-weight-bold font-sm text-dark-green"
                >Event Venue</span
              >
              <br />
              <div class="fs13">{{ event.venue }}</div>
            </div>

            <div class="mb-1 px-3 py-2 fs15" v-if="event.url">
              <span class="font-weight-bold font-sm text-dark-green"
                >Event Link</span
              >
              <br />

              <div class="fs12">
                <a :href="event.url" target="_blank">{{ event.url }}</a>
              </div>
            </div>
          </div>

          <div class="share p-3 d-flex justify-content-between">
            <span class="text-muted fs14">
              <b-icon icon="people-fill" class="mr-2 text-muted"></b-icon>
              {{ event.eventattendance.length }} Attending
            </span>
          </div>
        </div>
      </b-col>

      <b-col cols="12" class="h-100 mb-5">
        <b-row>
          <b-col sm="7" class="pl-sm-0">
            <div class="bg-white rounded text-left py-4 p-sm-4">
              <div class="mb-3">
                <span @click="$router.go(-1)" class="cursor-pointer">
                  <span class="mr-2">
                    <b-icon icon="arrow-left" class=""></b-icon
                  ></span>
                  <span>Back</span>
                </span>
              </div>
              <h6 class="">ABOUT THIS EVENT</h6>
              <p>{{ event.description }}</p>
            </div>
          </b-col>
          <b-col sm="5" class="pl-3 pr-sm-0">
            <div class="bg-white p-1 rounded">
              <div v-if="event.resource" class="mb-2">
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
                    <div
                      class="rounded p-4 bg-lighter-green d_file cursor-pointer"
                    >
                      <h5 class="mb-2">Download event resource</h5>
                      <b-icon
                        icon="cloud-download"
                        class="text-muted"
                        font-scale="3rem"
                      ></b-icon></div
                  ></a>
                </div>
              </div>

              <div class="event_box d-md-none rounded mt-3">
                <div class="d-flex justify-content-between">
                  <span class="font-weight-bold fs14 px-3 py-2 text-dark-green">
                    When & Where
                  </span>
                  <div class="mb-1 px-3 py-2">
                    <b-badge
                      class="text-capitalize"
                      :class="{
                        'bg-success': event.status == 'ongoing',
                        'bg-danger': event.status == 'expired',
                        'bg-primary': event.status == 'pending',
                      }"
                      >{{ event.status }}</b-badge
                    >
                  </div>
                </div>
                <div class="d-flex justify-content-between border-top">
                  <div class="mb-1 px-3 py-1">
                    <span class="font-weight-bold font-sm text-dark-green"
                      >Event Type</span
                    >
                    <br />
                    <span class="fs14 text-capitalize"> {{ event.type }}</span>
                  </div>
                  <div class="mb-1 px-3 py-1">
                    <span class="font-weight-bold font-sm text-dark-green"
                      >Event Duration</span
                    >
                    <br />
                    <span class="fs14"> {{ event.schedule }}</span>
                  </div>
                </div>
                <div
                  class="
                    px-3
                    py-2
                    bg-lighter-green
                    d-flex
                    justify-content-between
                  "
                >
                  <span
                    ><span class="font-weight-bold font-sm">Start</span>
                    <br />
                    <span class="fs12">
                      {{ event.start | moment(" MMM D YYYY, h:mm a") }}</span
                    >
                  </span>

                  <span>
                    <span class="font-weight-bold font-sm"> End</span>
                    <br />
                    <span class="fs12">
                      {{ event.end | moment(" MMM D YYYY, h:mm a") }}</span
                    ></span
                  >
                </div>
                <div class="d-flex justify-content-between">
                  <div class="px-3 py-2 fs15 bg-light">
                    <span class="font-weight-bold font-sm text-dark-green"
                      >Event Venue</span
                    >
                    <br />
                    <div class="fs13">{{ event.venue }}</div>
                  </div>

                  <div class="mb-1 px-3 py-2 fs15 bg-light" v-if="event.url">
                    <span class="font-weight-bold font-sm text-dark-green"
                      >Event Link</span
                    >
                    <br />

                    <div class="fs12">
                      <a :href="event.url" target="_blank">{{ event.url }}</a>
                    </div>
                  </div>
                </div>

                <div class="share p-3 d-flex justify-content-between">
                  <span class="text-muted fs14">
                    <b-icon icon="people-fill" class="mr-2 text-muted"></b-icon>
                    {{ event.eventattendance.length }} Attending
                  </span>
                </div>
              </div>
            </div>
          </b-col>
        </b-row>
      </b-col>
    </b-row>
    <b-row v-else>
      <b-col cols="12" class="mb-4">
        <b-skeleton-img no-aspect height="350px"></b-skeleton-img>
      </b-col>
      <b-col cols="7">
        <b-skeleton-img></b-skeleton-img>
      </b-col>
      <b-col>
        <b-skeleton-img></b-skeleton-img>
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
      vid_ext: ["mp4", "3gp", "mov", "flv"],
      showEvent: false,
      search: "",
      feed: {},
      inviteUsers: {
        title: "",
        users: [],
      },
      connections: [],
      emails: [],
      link: "",
      checkEvent: null,
    };
  },
  mounted() {
    this.myEvent();

    this.getevent();

    this.link = "https://nzukoor.com/explore/event/" + this.$route.params.id;
  },
  computed: {},
  methods: {
    getextension(fileName) {
      if (fileName) {
        var regex = new RegExp("[^.]+$");
        var extension = fileName.match(regex);

        return extension[0].toLowerCase();
      }
    },
    myEvent() {
      this.$http
        .get(
          `${this.$store.getters.url}/get/organization/events/${this.$route.params.id}`,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.checkEvent = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    getevent() {
      this.$http
        .get(
          `${this.$store.getters.url}/get/organization/events/${this.$route.params.id}`,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.event = res.data;
            window.document.title = `${res.data.title} | Nzukoor`;
            this.showEvent = true;
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
  overflow-y: scroll;
}
.main {
  height: 40vh;
}
.main-bg {
  background-position: center;
  background-size: cover;
  position: relative;
}
.event_box {
  position: absolute;
  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35);
  border-radius: 1px;
  background: white;
  top: 50%;
  transform: translateY(-50%);
  right: 5%;
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
  width: 55%;
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
.event_box {
  z-index: 99;
}
.font-sm {
  font-size: 0.65rem;
}
@media (max-width: 600px) {
  .shadow {
    box-shadow: unset !important;
  }
  .container {
    height: auto;
    overflow-y: unset;
  }
}
</style>

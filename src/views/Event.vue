<template>
  <div class="bg-light">
    <b-container fluid class="pb-5">
      <b-row class="main" v-if="showEvent">
        <b-col
          sm="12"
          class="text-left p-4 main-bg mb-5 position-relative"
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
              <div class="display-4 mb-3">{{ event.title }}</div>
            </div>
          </div>

          <div class="event_box shadow-lg d-none d-sm-block">
            <div class="d-flex justify-content-between">
              <h6 class="font-weight-bolder px-3 py-2 text-dark-green">
                When & Where
              </h6>
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
              class="px-3 py-2 bg-lighter-green d-flex justify-content-between"
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
            <div class="my-3 px-3" v-if="event.status == 'pending'">
              <b-button
                block
                variant="dark-green"
                @click="attendEvent"
                v-if="!checkEvent && event.status == 'pending'"
                >I'll Be Attending</b-button
              >
              <b-button
                disabled
                block
                variant="dark-green"
                v-if="checkEvent && event.status == 'pending'"
                >You are Attending</b-button
              >
            </div>
            <div class="share p-3 d-flex justify-content-between">
              <span class="text-muted fs14">
                <b-icon icon="people" class="mr-2 text-muted"></b-icon>
                {{ event.eventattendance.length }} Attending
              </span>
              <span>
                <span
                  class="mr-3 fs12 cursor-pointer"
                  @click="$bvModal.show('share')"
                  >Share <b-icon icon="share-fill" font-scale=".9"></b-icon
                ></span>
                <span
                  class="fs12 cursor-pointer"
                  @click="$bvModal.show('invite')"
                  >Invite
                  <b-icon icon="person-plus-fill" font-scale=".9"></b-icon
                ></span>
              </span>
            </div>
          </div>
        </b-col>

        <b-container class="position-relative">
          <div class="text-left pb-3">
            <span @click="$router.go(-1)" class="cursor-pointer">
              <b-icon icon="arrow-left"></b-icon> Back</span
            >
          </div>
          <b-row>
            <b-col cols="12" class="h-100 mb-5">
              <b-row>
                <b-col sm="7" class="pl-sm-0">
                  <div class="bg-white shadow rounded text-left p-4">
                    <h5 class="font-weight-bold">ABOUT THIS EVENT</h5>
                    <p
                      class="mb-1 schedule font-weight-bold"
                      v-if="event.tribe"
                    >
                      {{ event.tribe.name }} tribe
                    </p>
                    <p>{{ event.description }}</p>

                    <div v-if="sortfacilitators" class="mb-2">
                      <h6>Facilitators</h6>
                      <ul>
                        <li
                          v-for="item in sortfacilitators"
                          :key="item.id"
                          class="text-capitalize fs14"
                        >
                          {{ item.name }}
                        </li>
                      </ul>
                    </div>
                  </div>
                </b-col>
                <b-col sm="5" class="pl-3 pr-sm-0" v-if="event.resource">
                  <div class="">
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
                          class="
                            rounded
                            shadow
                            p-4
                            bg-lighter-green
                            d_file
                            cursor-pointer
                          "
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
                </b-col>
              </b-row>
            </b-col>
          </b-row>
        </b-container>
        <b-col cols="12">
          <div
            class="event_box shadow-lg p-3 d-block d-sm-none bg-white text-left"
          >
            <div class="d-flex justify-content-between bg-white">
              <h4 class="font-weight-bolder px-3 py-2 text-dark-green">
                When & Where
              </h4>
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
            <div class="mb-1 px-3 py-1 border-bottom">
              <span class="font-weight-bold fs14 text-dark-green"
                >Event Type :
              </span>

              <span class="fs14 text-capitalize"> {{ event.type }}</span>
            </div>
            <div class="mb-1 px-3 py-1">
              <span class="font-weight-bold fs14 text-dark-green"
                >Event Duration :
              </span>

              <span class="fs14"> {{ event.schedule }}</span>
            </div>

            <div class="px-3 py-2 bg-lighter-green">
              <span
                ><span class="font-weight-bold fs14">Start : </span>

                <span class="fs14">
                  {{ event.start | moment(" MMMM Do YYYY, h:mm:ss a") }}</span
                >
              </span>
              <br />

              <span>
                <span class="font-weight-bold fs14"> End :</span>

                <span class="fs14">
                  {{ event.end | moment(" MMMM Do YYYY, h:mm:ss a") }}</span
                ></span
              >
            </div>
            <div class="px-3 py-2 fs14">
              <span class="font-weight-bold fs14 text-dark-green"
                >Event Venue :
              </span>

              <span class="fs14">{{ event.venue }}</span>
            </div>

            <div class="mb-1 px-3 py-2 fs14" v-if="event.url">
              <span class="font-weight-bold fs14 text-dark-green"
                >Event Link :
              </span>

              <div class="fs12">
                <a :href="event.url" target="_blank">{{ event.url }}</a>
              </div>
            </div>
            <div class="my-3" v-if="event.status == 'pending'">
              <b-button
                block
                variant="dark-green"
                @click="attendEvent"
                v-if="!checkEvent && event.status == 'pending'"
                >I'll Be Attending</b-button
              >
              <b-button
                disabled
                block
                variant="dark-green"
                v-if="checkEvent && event.status == 'pending'"
                >You are Attending</b-button
              >
            </div>
            <div class="share p-3 d-flex justify-content-between">
              <span class="text-muted fs14">
                <b-icon icon="people" class="mr-2 text-muted"></b-icon>
                {{ event.eventattendance.length }} Attending
              </span>
              <span>
                <span
                  class="mr-3 fs12 cursor-pointer"
                  @click="$bvModal.show('share')"
                  >Share <b-icon icon="share-fill" font-scale=".9"></b-icon
                ></span>
                <span
                  class="fs12 cursor-pointer"
                  @click="$bvModal.show('invite')"
                  >Invite
                  <b-icon icon="person-plus-fill" font-scale=".9"></b-icon
                ></span>
              </span>
            </div>
          </div>
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
      <b-modal no-close-on-backdrop id="share" hide-footer centered size="lg">
        <div class="p-2 text-center">
          <h6 class="font-weight-bold mb-3">Share Invite</h6>
          <ShareNetwork
            v-if="event.title"
            class="mr-3"
            network="facebook"
            :url="link"
            title="EVENT INVITATION"
            :description="`I will be attending the event, ${event.title.toUpperCase()}  and I think you’d like it. Join me!`"
            quote="Nzukoor"
            hashtags="Nzukoor,  Social learning"
          >
            <b-button variant="outline-dark-green"
              ><b-icon class="mr-1" icon="facebook"></b-icon>
              <span class="d-none d-md-block">Facebook</span></b-button
            >
          </ShareNetwork>
          <ShareNetwork
            v-if="event.title"
            class="mr-3"
            network="twitter"
            :url="link"
            title="EVENT INVITATION"
            :description="`I will be attending the event, ${event.title.toUpperCase()}  and I think you’d like it. Join me!`"
            quote="Nzukoor"
            hashtags="Nzukoor,  Social learning"
          >
            <b-button variant="outline-dark-green"
              ><b-icon class="mr-1" icon="twitter"></b-icon>
              <span class="d-none d-md-block">Twitter</span>
            </b-button>
          </ShareNetwork>
          <ShareNetwork
            v-if="event.title"
            class="mr-3"
            network="whatsApp"
            :url="link"
            title="EVENT INVITATION"
            :description="`I will be attending the event, ${event.title.toUpperCase()}  and I think you’d like it. Join me!`"
            quote="Nzukoor"
            hashtags="Nzukoor,  Social learning"
          >
            <b-button variant="outline-dark-green">
              <b-iconstack>
                <b-icon
                  stacked
                  icon="circle-fill"
                  variant="dark-green"
                ></b-icon>
                <b-icon
                  stacked
                  icon="telephone-plus"
                  variant="light"
                  scale="0.5"
                ></b-icon>
              </b-iconstack>
              <span class="d-none d-md-block">Whatsapp</span>
            </b-button>
          </ShareNetwork>
          <ShareNetwork
            v-if="event.title"
            class="mr-3"
            network="Telegram"
            :url="link"
            title="EVENT INVITATION"
            :description="`I will be attending the event, ${event.title.toUpperCase()}  and I think you’d like it. Join me!`"
            quote="Nzukoor"
            hashtags="Nzukoor,  Social learning"
          >
            <b-button variant="outline-dark-green"
              ><b-icon class="mr-1" icon="cursor-fill"></b-icon>
              <span class="d-none d-md-block">Telegram</span>
            </b-button>
          </ShareNetwork>
          <b-button variant="outline-dark-green" @click="addToFeed">
            <b-icon icon="rss-fill" variant="dark-green"></b-icon>

            <span class="d-none d-md-block">Feed</span>
          </b-button>
        </div>
      </b-modal>

      <b-modal no-close-on-backdrop id="invite" size="sm" centered hide-footer>
        <div class="box text-center">
          <h6 class="text-center">Invite your friends</h6>
          <div class="mb-4">
            <div
              v-for="(item, id) in inviteUsers.users"
              :key="id"
              class="mb-1 text-center"
            >
              <b-input-group size="sm" class="">
                <template #append>
                  <b-button @click="inviteUsers.users.splice(id, 1)"
                    ><strong>x</strong></b-button
                  >
                </template>
                <b-form-input
                  v-model="item.email"
                  placeholder="Enter email address"
                ></b-form-input>
              </b-input-group>
            </div>
            <div class="text-center mt-3">
              <b-button
                size="sm"
                class="mr-3 py-1 px-2 fs12"
                variant="lighter-green"
                @click="addinvite"
              >
                <b-icon icon="plus" font-scale="1.4"></b-icon> Add
                email</b-button
              >
              <b-button
                size="sm"
                variant="dark-green"
                class="fs12 py-1 px-2"
                @click="sendinvite(event.title)"
              >
                Send Invite
              </b-button>
            </div>
          </div>
        </div>
      </b-modal>
    </b-container>
  </div>
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
    this.getfacilitators().then(() => {
      this.getevent();
    });

    this.link = "https://nzukoor.com/event/" + this.$route.params.id;
  },
  computed: {
    useraccess() {
      var token = null;
      if (localStorage.getItem("authAdmin")) {
        return this.$store.getters.admin;
      }
      if (localStorage.getItem("authFacilitator")) {
        return this.$store.getters.facilitator;
      }
      if (localStorage.getItem("authMember")) {
        return this.$store.getters.member;
      }
      return token;
    },
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
    attendEvent() {
      if (!this.useraccess) {
        this.$toast.info("Login to join event!");
        this.$router.push(`/login?redirect=${this.$route.path}`);
      }
      var data = {
        event_id: this.$route.params.id,
      };
      this.$http
        .post(`${this.$store.getters.url}/event/attendance`, data, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.checkEvent = res.data;
            this.getevent();
            this.$toast.success("Event scheduled");
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    addToFeed() {
      this.$toast.info("Login to join discussion!");
      this.$router.push("/login");
    },

    sendinvite() {
      var emails = this.emails.map((item) => {
        return {
          email: item,
        };
      });
      this.inviteUsers.title = this.event.title;
      this.inviteUsers.id = this.event.id;
      this.inviteUsers.users = this.inviteUsers.users.concat(emails);
      this.$http
        .post(
          `${this.$store.getters.url}/guest/send/event/invite`,
          this.inviteUsers,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Invite Sent");
            this.$bvModal.hide("invite");
            this.inviteUsers = {
              title: "",
              users: [
                {
                  email: "",
                },
              ],
            };
          }
        });
    },
    addinvite() {
      this.inviteUsers.users.push({
        email: "",
      });
    },
    getextension(fileName) {
      if (fileName) {
        var regex = new RegExp("[^.]+$");
        var extension = fileName.match(regex);

        return extension[0].toLowerCase();
      }
    },
    async getfacilitators() {
      return this.$http
        .get(`${this.$store.getters.url}/guest/facilitators`)
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
        .get(`${this.$store.getters.url}/guest/events/${this.$route.params.id}`)
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
  min-height: calc(100vh - 100px);
}
.main {
  height: 100%;
}
.main-bg {
  background-position: center;
  background-size: cover;
  position: relative;
  height: 600px;
}
.event_box {
  position: absolute;
  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35);
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
@media (max-width: 600px) {
  .shadow {
    box-shadow: unset !important;
  }
}
</style>

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

        <div class="event_box shadow-lg">
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
            class="
              px-3
              py-2
              bg-dark-green
              text-white
              d-flex
              justify-content-between
            "
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
          <div class="share px-3 text-right">
            <span class="mr-3 fs12" @click="$bvModal.show('share')">Share</span>
            <span class="fs12" @click="$bvModal.show('invite')">Invite</span>
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
          quote="SkillsGuruh"
          hashtags="SkillsGuruh,  Social learning"
        >
          <b-button variant="outline-dark-green"
            ><b-icon class="mr-1" icon="facebook"></b-icon> Facebook</b-button
          >
        </ShareNetwork>
        <ShareNetwork
          v-if="event.title"
          class="mr-3"
          network="twitter"
          :url="link"
          title="EVENT INVITATION"
          :description="`I will be attending the event, ${event.title.toUpperCase()}  and I think you’d like it. Join me!`"
          quote="SkillsGuruh"
          hashtags="SkillsGuruh,  Social learning"
        >
          <b-button variant="outline-dark-green"
            ><b-icon class="mr-1" icon="twitter"></b-icon> Twitter</b-button
          >
        </ShareNetwork>
        <ShareNetwork
          v-if="event.title"
          class="mr-3"
          network="whatsApp"
          :url="link"
          title="EVENT INVITATION"
          :description="`I will be attending the event, ${event.title.toUpperCase()}  and I think you’d like it. Join me!`"
          quote="SkillsGuruh"
          hashtags="SkillsGuruh,  Social learning"
        >
          <b-button variant="outline-dark-green">
            <b-iconstack>
              <b-icon stacked icon="circle-fill" variant="dark-green"></b-icon>
              <b-icon
                stacked
                icon="telephone-plus"
                variant="light"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
            Whatsapp</b-button
          >
        </ShareNetwork>
        <ShareNetwork
          v-if="event.title"
          class="mr-3"
          network="Telegram"
          :url="link"
          title="EVENT INVITATION"
          :description="`I will be attending the event, ${event.title.toUpperCase()}  and I think you’d like it. Join me!`"
          quote="SkillsGuruh"
          hashtags="SkillsGuruh,  Social learning"
        >
          <b-button variant="outline-dark-green"
            ><b-icon class="mr-1" icon="cursor-fill"></b-icon>
            Telegram</b-button
          >
        </ShareNetwork>
        <b-button variant="outline-dark-green" @click="addToFeed">
          <b-icon icon="rss-fill" variant="dark-green"></b-icon>

          Feeds</b-button
        >
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
              <b-icon icon="plus" font-scale="1.4"></b-icon> Add email</b-button
            >
            <b-button
              size="sm"
              variant="dark-green"
              class="fs12 py-1 px-2"
              @click="sendinvite(event.title)"
            >
              Drop Email
            </b-button>
          </div>
        </div>

        <div class="connections p-3 border rounded">
          <h6 class="mb-3 fs13 text-left">Connections</h6>
          <div class="px-2 py-1 d-flex align-items-center search bg-light mb-3">
            <b-icon icon="search"></b-icon>
            <b-form-input
              autocomplete="off"
              autocorrect="off"
              size="sm"
              v-model="search"
              class="flex-1 border-0 no-focus search-bg"
              type="search"
              placeholder="Search name"
            ></b-form-input>
          </div>
          <div v-for="(item, id) in filteredConnections" :key="id">
            <div v-if="item.user_follower" class="d-flex align-items-end mb-4">
              <b-form-checkbox
                size="sm"
                v-model="emails"
                :value="item.user_follower.email"
              >
                <div class="d-flex align-items-center flex-1">
                  <b-avatar class="mr-2" size="1.3rem"></b-avatar>
                  <div class="text-left" style="line-height: 1.1">
                    <span class="fs12">{{ item.user_follower.name }}</span>
                  </div>
                </div>
              </b-form-checkbox>
            </div>
            <div v-else class="d-flex align-items-end mb-4">
              <b-form-checkbox
                size="sm"
                :value="item.facilitator_follower.email"
                v-model="emails"
              >
                <div class="d-flex align-items-center flex-1">
                  <b-avatar class="mr-2" size="1.3rem"></b-avatar>
                  <div>
                    <span>{{ item.facilitator_follower.name }}</span>
                  </div>
                </div>
              </b-form-checkbox>
            </div>
          </div>
        </div>
      </div>
    </b-modal>
  </b-container>
</template>
<script>
export default {
  data() {
    return {
      event: {},
      facilitators: [],
      vid_ext: ["mp4", "3gp"],
      feed: {},
      search: "",
      inviteUsers: {
        title: "",
        users: [],
      },
      connections: [],
      emails: [],
      link: "",
    };
  },
  mounted() {
    this.getfacilitators().then(() => {
      this.getevent();
      this.getconnections();
      this.link =
        "https://skillsguruh.herokuapp.com/learner/event/" + this.event.id;
    });
  },
  computed: {
    filteredConnections() {
      return this.connections.filter((item) => {
        if (item.user_follower) {
          return item.user_follower.name
            .toLowerCase()
            .includes(this.search.toLowerCase());
        }
        if (item.facilitator_follower) {
          return item.facilitator_follower.name
            .toLowerCase()
            .includes(this.search.toLowerCase());
        }
      });
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
    async getconnections() {
      return this.$http
        .get(`${this.$store.getters.url}/connections`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.connections = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    addToFeed() {
      this.feed = {
        media: this.event.cover,
        message:
          "Let’s attend the event, " +
          this.event.title.toUpperCase() +
          " together",
        url: "https://skillsguruh.herokuapp.com/learner/event/" + this.event.id,
      };
      this.$http
        .post(`${this.$store.getters.url}/feeds`, this.feed, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201 || res.status == 200) {
            this.$toast.success("Added to feeds ");
            this.$bvModal.hide("share");

            this.feed = {
              media: "",
              message: "",
            };
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
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
          `${this.$store.getters.url}/send/event/invite`,
          this.inviteUsers,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
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

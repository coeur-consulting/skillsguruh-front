<template>
  <div>
    <b-container>
      <b-row>
        <b-col class="mb-3 mb-sm-0">
          <div class="rounded">
            <div
              class="
                top_heading
                p-2 p-sm-4
                border-bottom
                d-flex
                justify-content-between
              "
            >
              <h4>Events</h4>
              <div>
                <b-form-input
                  placeholder="Search event"
                  size="sm"
                  type="search"
                  class="search bg-white"
                  v-model="search"
                ></b-form-input>
              </div>
            </div>

            <div class="event-container py-5">
              <div
                class="border-bottom py-3 d-flex mb-4 justify-content-between"
              >
                <div class="d-flex">
                  <span
                    class="
                      mr-4
                      d-flex
                      align-items-center
                      cursor-pointer
                      event_title
                    "
                    @click="showing = 'ongoing'"
                    ><b-icon
                      :icon="showing == 'ongoing' ? 'circle-fill' : 'circle'"
                      font-scale=".7rem"
                      variant="dark-green"
                      class="mr-1"
                    ></b-icon>
                    Ongoing</span
                  >
                  <span
                    class="
                      mr-4
                      d-flex
                      align-items-center
                      cursor-pointer cursor-pointer
                      event_title
                    "
                    @click="showing = 'upcoming'"
                    ><b-icon
                      :icon="showing == 'upcoming' ? 'circle-fill' : 'circle'"
                      font-scale=".7rem"
                      variant="dark-green"
                      class="mr-1"
                    ></b-icon>
                    Upcoming</span
                  >
                  <span
                    @click="showing = 'past'"
                    class="
                      d-flex
                      align-items-center
                      cursor-pointer cursor-pointer
                      event_title
                    "
                    ><b-icon
                      :icon="showing == 'past' ? 'circle-fill' : 'circle'"
                      class="mr-1"
                      font-scale=".7rem"
                      variant="dark-green"
                    ></b-icon>
                    Past</span
                  >
                </div>
              </div>
              <div v-if="showEvents">
                <div class="events" v-if="filter.length">
                  <div
                    class="
                      border
                      rounded
                      overflow-hidden
                      text-left
                      mb-5
                      position-relative
                    "
                    v-for="item in filter"
                    :key="item.id"
                  >
                    <b-img
                      class="event_image"
                      fluid-grow
                      :src="item.cover"
                    ></b-img>
                    <div class="px-3 py-2 bg-white">
                      <p class="mb-1 text-muted">
                        <b-icon
                          icon="calendar2-check"
                          class="mr-2 text-muted"
                        ></b-icon>
                        {{ item.schedule }}
                      </p>
                      <p class="mb-1 text-muted">
                        <b-icon icon="people" class="mr-2 text-muted"></b-icon>
                        {{ item.eventattendance.length }} Attending
                      </p>
                      <div class="d-flex">
                        <b-icon
                          class="mr-2 text-muted"
                          icon="info-circle"
                        ></b-icon>
                        <p class="description text-muted">
                          {{ item.description }}
                        </p>
                      </div>
                    </div>
                    <div
                      class="
                        bg-light
                        px-3
                        py-3
                        text-left text-dark
                        d-flex
                        justify-content-between
                        align-items-center
                      "
                    >
                      <h4 class="text-capitalize mb-0 flex-1 event_title">
                        {{ item.title }}
                      </h4>
                      <span @click="view(item.id)" class="viewevent">
                        <span class="cursor-pointer pl-2 d-none d-sm-inline">
                          View Event
                        </span>
                        <b-icon icon="chevron-right"></b-icon>
                      </span>
                    </div>
                  </div>
                  <div
                    class="py-3 d-flex justify-content-between"
                    v-if="filter.length > 10"
                  >
                    <div class="fs12 text-muted">
                      Showing 1-10 of {{ filter.length }} items
                    </div>
                    <b-pagination
                      pills
                      size="sm"
                      variant="dark-green"
                      align="right"
                      v-model="currentPage"
                      :total-rows="rows"
                      :per-page="perPage"
                    ></b-pagination>
                  </div>
                </div>
                <div v-else class="text-center admin_tab p-3 p-sm-5">
                  <div>
                    <b-img
                      :src="require('@/assets/images/creator.svg')"
                    ></b-img>
                    <h6 class="text-muted my-3 fs14">
                      It appears you have no event,
                      <br class="d-none d-sm-block" />
                    </h6>
                  </div>
                </div>
              </div>
              <div v-else class="p-3">
                <div class="w-100 mb-3">
                  <div class="w-100">
                    <div class="mb-3">
                      <b-skeleton-img no-aspect height="250px"></b-skeleton-img>
                    </div>
                    <b-skeleton animation="wave" width="85%"></b-skeleton>
                    <b-skeleton animation="wave" width="35%"></b-skeleton>
                  </div>
                </div>

                <div class="w-100 mb-3">
                  <div class="w-100">
                    <div class="mb-3">
                      <b-skeleton-img no-aspect height="250px"></b-skeleton-img>
                    </div>
                    <b-skeleton animation="wave" width="85%"></b-skeleton>
                    <b-skeleton animation="wave" width="35%"></b-skeleton>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
export default {
  data() {
    return {
      id: null,
      search: "",
      currentPage: 1,
      rows: null,
      perPage: 10,
      events: [],
      facilitators: [],
      showing: "ongoing",
      event: {
        title: "",
        duration: "",
        description: "",
        type: "",
        url: "",
        cover: "",
        start: "",
        end: "",
        resource: "",
        facilitators: [],
      },
      showEvents: false,
    };
  },
  components: {},
  computed: {
    filter() {
      var event = this.events
        .filter((item) =>
          item.title.toLowerCase().includes(this.search.toLowerCase())
        )
        .slice(
          this.perPage * this.currentPage - this.perPage,
          this.perPage * this.currentPage
        );

      if (this.showing == "upcoming") {
        return event.filter((item) => item.status == "pending");
      }
      if (this.showing == "ongoing") {
        return event.filter((item) => item.status == "ongoing");
      }
      return event.filter((item) => item.status == "expired");
    },
  },
  mounted() {
    this.getevents();
    this.getfacilitators();
  },
  methods: {
    getUpload(val, id) {
      if (id == "cover") {
        this.event.cover = val;
      }
      if (id == "resource") {
        this.event.resource = val;
      }
    },
    async getfacilitators() {
      return this.$http
        .get(`${this.$store.getters.url}/user-get-facilitators`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
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

    getevents() {
      this.$http
        .get(`${this.$store.getters.url}/events`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.events = res.data;
            this.rows = res.data.length;
            this.showEvents = true;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    register() {
      this.$http
        .post(`${this.$store.getters.url}/events`, this.event, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.$toast.success("Added successfully");
            this.$bvModal.hide("add");
            this.events.unshift(res.data);
            this.event = {
              title: "",
              duration: "",
              description: "",
              type: "",
              url: "",
              cover: "",
              start: "",
              end: "",
              resource: "",
              facilitators: [],
            };
          }
        })
        .catch((err) => {
          if (err.response.data.errors.email[0]) {
            this.$toast.error(err.response.data.errors.email[0]);
          }
          if (err.response.data.errors.phone[0]) {
            this.$toast.error(err.response.data.errors.phone[0]);
          }
          if (err.response.data.errors.name[0]) {
            this.$toast.error(err.response.data.errors.name[0]);
          }
          if (err.response.data.errors.password[0]) {
            this.$toast.error(err.response.data.errors.password[0]);
          }
        });
    },
    edit(data) {
      this.$bvModal.show("edit");
      this.event = data;
      this.event.duration = data.schedule;
    },
    update() {
      this.$http
        .put(`${this.$store.getters.url}/events/${this.event.id}`, this.event, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Update successful");
            this.$bvModal.hide("edit");
            this.event = {
              title: "",
              duration: "",
              description: "",
              type: "",
              url: "",
              cover: "",
              start: "",
              end: "",
              resource: "",
              facilitators: [],
            };
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    view(id) {
      this.$router.push(`/member/event/${id}`);
    },
    drop(id, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/events/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.member.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success("Removed successfully");
                this.events.splice(index, 1);
              }
            })
            .catch((err) => {
              this.$toast.error(err.response.data.message);
            });
        }
      });
    },
  },
};
</script>
<style scoped lang="scss">
.container {
  max-width: 1100px;
  padding-top: 25px;
}
.event-container {
  width: 85%;
  margin: 0 auto;
}
.events {
  // max-height: 70vh;
  // overflow-y: auto;
  // -ms-overflow-style: none; /* IE and Edge */
  // scrollbar-width: none; /* Firefox */
}

.events::-webkit-scrollbar {
  display: none;
}

.shadow {
  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
  border-radius: 8px;
}
.search.form-control {
  width: 250px;
  border: 1px solid rgba($color: #000000, $alpha: 0.07) !important;
}
.search::placeholder {
  color: rgba($color: #000000, $alpha: 0.2);
}
.admin_tab {
  min-height: 350px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.description {
  font-size: 15px;
  color: rgba($color: #000000, $alpha: 0.54);
  display: -webkit-box;
  line-clamp: 2;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  line-height: 1.3;
}
.options {
  position: absolute;
  right: 15px;
  top: 15px;
}
</style>

<template>
  <div>
    <b-container>
      <b-row>
        <b-col class="mb-5 mb-sm-0">
          <div class="shadow rounded bg-white">
            <div
              class="top_heading p-4 border-bottom mb-4 d-flex justify-content-between"
            >
              <h4>Events</h4>
              <div>
                <b-form-input
                  placeholder="Search"
                  size="sm"
                  type="search"
                  class="search"
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
                    class="mr-4 d-flex align-items-center"
                    @click="showing = 'upcoming'"
                    ><b-icon
                      :icon="showing == 'upcoming' ? 'circle-fill' : 'circle'"
                      font-scale=".7rem"
                      variant="dark-green"
                      class="mr-1"
                    ></b-icon>
                    Upcoming Events</span
                  >
                  <span
                    @click="showing = 'past'"
                    class="d-flex align-items-center"
                    ><b-icon
                      :icon="showing == 'past' ? 'circle-fill' : 'circle'"
                      class="mr-1"
                      font-scale=".7rem"
                      variant="dark-green"
                    ></b-icon>
                    Past Events</span
                  >
                </div>

                <span
                  class="text-dark-green font-weight-bold"
                  @click="$bvModal.show('add')"
                  >Create Event</span
                >
              </div>
              <div class="events" v-if="filter.length">
                <div
                  class="border rounded text-left mb-5 position-relative"
                  v-for="item in filter"
                  :key="item.id"
                >
                  <div class="options">
                    <b-icon
                      icon="three-dots"
                      class="cursor-pointer"
                      :id="item.id.toString() + item.title"
                    ></b-icon>
                    <b-popover
                      :target="item.id.toString() + item.title"
                      triggers="hover"
                      placement="bottom"
                    >
                      <div class="">
                        <small
                          class="px-0 text-left cursor-pointer"
                          @click="edit(item)"
                        >
                          <b-icon class="mr-2" icon="pencil"></b-icon
                          ><span>Edit</span>
                        </small>
                        <br />
                        <hr class="my-1" />
                        <small
                          class="px-0 cursor-pointer"
                          @click="drop(item.id, index)"
                        >
                          <b-icon class="mr-2" icon="trash"></b-icon
                          ><span>Drop</span>
                        </small>
                      </div>
                    </b-popover>
                  </div>
                  <div class="px-3 py-2">
                    <h5 class="text-capitalize">{{ item.title }}</h5>
                    <p class="mb-1 text-muted fs15">
                      <b-icon
                        icon="calendar2-check"
                        class="mr-2 text-muted"
                      ></b-icon>
                      {{ item.schedule }}
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
                  <b-img fluid-grow :src="item.cover"></b-img>
                  <div
                    class="bg-lighter-green px-3 py-2 text-left text-dark-green"
                  >
                    <span @click="view(item.id)">
                      <span class=""> View Event </span>
                      <b-icon icon="chevron-double-right"></b-icon>
                    </span>
                  </div>
                </div>
                <div class="py-3 d-flex justify-content-between">
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
                  <b-img :src="require('@/assets/images/creator.svg')"></b-img>
                  <h6 class="text-muted my-3 fs14">
                    It appears you haven't added any Event yet,
                    <br class="d-none d-sm-block" />
                    Add your first Event now!
                  </h6>
                  <b-button
                    @click="$bvModal.show('add')"
                    variant="dark-green"
                    size="lg"
                    >Add Event</b-button
                  >
                </div>
              </div>
            </div>
          </div>
        </b-col>
      </b-row>
    </b-container>

    <b-modal id="add" hide-footer centered size="lg" title="Add Event">
      <b-form @submit.prevent="register" class="event">
        <div>
          <b-form-row class="mb-2">
            <b-col sm="6" class="pr-sm-3">
              <b-form-group label="Event name">
                <b-form-input
                  size="lg"
                  v-model="event.title"
                  required
                  placeholder="Enter event name"
                ></b-form-input>
              </b-form-group>
            </b-col>
            <b-col sm="6" class="pr-sm-3">
              <b-form-group label="Event Duration">
                <b-form-input
                  size="lg"
                  required
                  v-model="event.duration"
                  placeholder="Enter event duration.. e.g 2 weeks"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-form-row>
          <b-form-row class="mb-2">
            <b-col sm="6" class="pr-sm-3">
              <b-form-group label="Event venue">
                <b-form-input
                  size="lg"
                  v-model="event.venue"
                  required
                  placeholder="Enter event venue"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-form-row>

          <b-form-row class="mb-2">
            <b-col sm="12" class="pr-sm-3">
              <b-form-group label="Event Description">
                <b-form-textarea
                  size="lg"
                  v-model="event.description"
                  required
                  placeholder="Describe this event"
                ></b-form-textarea>
              </b-form-group>
            </b-col>
          </b-form-row>

          <b-form-row class="mb-2">
            <b-col cols="6" class="pr-sm-3">
              <b-form-group label="Event Start">
                <vc-date-picker
                  placeholder="Choose start time"
                  v-model="event.start"
                  mode="dateTime"
                >
                  <template v-slot="{ inputValue, inputEvents }">
                    <input
                      class="px-2 py-1 border rounded focus:outline-none focus:border-blue-300"
                      :value="inputValue"
                      v-on="inputEvents"
                    />
                  </template>
                </vc-date-picker>
              </b-form-group>
            </b-col>
            <b-col cols="6" class="pr-sm-3">
              <b-form-group label="Event End">
                <vc-date-picker
                  placeholder="Choose end time"
                  v-model="event.end"
                  mode="dateTime"
                >
                  <template v-slot="{ inputValue, inputEvents }">
                    <input
                      class="px-2 py-1 border rounded focus:outline-none focus:border-blue-300"
                      :value="inputValue"
                      v-on="inputEvents"
                    />
                  </template>
                </vc-date-picker>
              </b-form-group>
            </b-col>
          </b-form-row>
          <b-form-row class="mb-2">
            <b-col sm="6" class="pr-sm-3">
              <b-form-group label="Event type">
                <b-form-select
                  v-model="event.type"
                  required
                  placeholder="Choose type of event"
                >
                  <b-form-select-option value=""
                    >Choose event type</b-form-select-option
                  >
                  <b-form-select-option value="seminar"
                    >Seminar</b-form-select-option
                  >
                </b-form-select>
              </b-form-group>
            </b-col>
            <b-col sm="6" class="pr-sm-3">
              <b-form-group label="Event Url (optional)">
                <b-form-input
                  size="lg"
                  v-model="event.url"
                  placeholder="Enter event link"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-form-row>
          <b-form-row class="mb-2">
            <b-col sm="6" class="pr-sm-3">
              <b-form-group label="Event resource(optional)">
                <Upload
                  class="text-center"
                  :id="'resource'"
                  @getUpload="getUpload"
                >
                  <b-icon
                    class="text-muted ml-3"
                    icon="files"
                    font-scale="4rem"
                  ></b-icon
                ></Upload>
              </b-form-group>
            </b-col>
            <b-col sm="6" class="pr-sm-3">
              <b-form-group label="Upload event cover">
                <Upload class="text-left" :id="'cover'" @getUpload="getUpload">
                  <b-icon
                    class="text-muted ml-3"
                    icon="card-image"
                    font-scale="4rem"
                  ></b-icon>
                </Upload>
              </b-form-group>
            </b-col>
          </b-form-row>
          <b-form-row class="mb-2">
            <b-col sm="12" class="pr-sm-3">
              <b-form-group label="Add Facilitators to event (optional)">
                <b-button size="sm" @click="$bvModal.show('addfac')"
                  >Click to add Facilitators to event</b-button
                >
              </b-form-group>
            </b-col>
          </b-form-row>

          <b-form-group class="mt-4">
            <div class="mb-3 text-center">
              <b-button
                type="submit"
                variant="dark-green"
                size="lg"
                class="px-5 d-none d-sm-block mx-auto"
                >Register</b-button
              >
              <b-button
                type="submit"
                variant="dark-green"
                size="lg"
                block
                class="px-5 d-sm-none mx-auto"
                >Register</b-button
              >
            </div>
          </b-form-group>
        </div>
      </b-form>
    </b-modal>
    <b-modal id="edit" hide-footer centered size="lg" title="Update Event">
      <b-form @submit.prevent="update" class="event">
        <div>
          <b-form-row class="mb-2">
            <b-col sm="6" class="pr-sm-3">
              <b-form-group label="Event name">
                <b-form-input
                  size="lg"
                  v-model="event.title"
                  required
                  placeholder="Enter event name"
                ></b-form-input>
              </b-form-group>
            </b-col>
            <b-col sm="6" class="pr-sm-3">
              <b-form-group label="Event Duration">
                <b-form-input
                  size="lg"
                  required
                  v-model="event.duration"
                  placeholder="Enter event duration.. e.g 2 weeks"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-form-row>

          <b-form-row class="mb-2">
            <b-col sm="6" class="pr-sm-3">
              <b-form-group label="Event venue">
                <b-form-input
                  size="lg"
                  v-model="event.venue"
                  required
                  placeholder="Enter event venue"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-form-row>

          <b-form-row class="mb-2">
            <b-col sm="12" class="pr-sm-3">
              <b-form-group label="Event Description">
                <b-form-textarea
                  size="lg"
                  v-model="event.description"
                  required
                  placeholder="Describe this event"
                ></b-form-textarea>
              </b-form-group>
            </b-col>
          </b-form-row>

          <b-form-row class="mb-2">
            <b-col cols="6" class="pr-sm-3">
              <b-form-group label="Event Start">
                <vc-date-picker
                  placeholder="Choose end time"
                  v-model="event.start"
                  mode="dateTime"
                  :is24hr="false"
                >
                  <template v-slot="{ inputValue, inputEvents }">
                    <input
                      class="px-2 py-1 border rounded focus:outline-none focus:border-blue-300"
                      :value="inputValue"
                      v-on="inputEvents"
                    />
                  </template>
                </vc-date-picker>
              </b-form-group>
            </b-col>
            <b-col cols="6" class="pr-sm-3">
              <b-form-group label="Event End">
                <vc-date-picker
                  placeholder="Choose end time"
                  v-model="event.end"
                  mode="dateTime"
                  :is24hr="false"
                >
                  <template v-slot="{ inputValue, inputEvents }">
                    <input
                      class="px-2 py-1 border rounded focus:outline-none focus:border-blue-300"
                      :value="inputValue"
                      v-on="inputEvents"
                    />
                  </template>
                </vc-date-picker>
              </b-form-group>
            </b-col>
          </b-form-row>
          <b-form-row class="mb-2">
            <b-col sm="6" class="pr-sm-3">
              <b-form-group label="Event type">
                <b-form-select
                  size="lg"
                  v-model="event.type"
                  required
                  placeholder="Choose type of event"
                >
                  <b-form-select-option value=""
                    >Choose event type</b-form-select-option
                  >
                  <b-form-select-option value="seminar"
                    >Seminar</b-form-select-option
                  >
                </b-form-select>
              </b-form-group>
            </b-col>
            <b-col sm="6" class="pr-sm-3">
              <b-form-group label="Event Url (optional)">
                <b-form-input
                  size="lg"
                  v-model="event.url"
                  placeholder="Enter event link"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-form-row>
          <b-form-row class="mb-2">
            <b-col sm="6" class="pr-sm-3">
              <b-form-group label="Event resource(optional)">
                <Upload
                  class="text-center"
                  :id="'resource'"
                  @getUpload="getUpload"
                >
                  <b-icon
                    class="text-muted ml-3"
                    icon="files"
                    font-scale="4rem"
                  ></b-icon
                ></Upload>
              </b-form-group>
            </b-col>
            <b-col sm="6" class="pr-sm-3">
              <b-form-group label="Upload event cover">
                <Upload class="text-left" :id="'cover'" @getUpload="getUpload">
                  <b-icon
                    class="text-muted ml-3"
                    icon="card-image"
                    font-scale="4rem"
                  ></b-icon>
                </Upload>
              </b-form-group>
            </b-col>
          </b-form-row>
          <b-form-row class="mb-2">
            <b-col sm="12" class="pr-sm-3">
              <b-form-group label="Add Facilitators to event (optional)">
                <b-button size="sm" @click="$bvModal.show('addfac')"
                  >Click to add Facilitators to event</b-button
                >
              </b-form-group>
            </b-col>
          </b-form-row>

          <b-form-group class="mt-4">
            <div class="mb-3 text-center w-100">
              <b-button
                type="submit"
                variant="dark-green"
                size="lg"
                class="px-5 d-none d-sm-block mx-auto"
                >Update</b-button
              >
              <b-button
                type="submit"
                variant="dark-green"
                size="lg"
                block
                class="px-5 d-sm-none mx-auto"
                >Update</b-button
              >
            </div>
          </b-form-group>
        </div>
      </b-form>
    </b-modal>
    <b-modal id="addfac" size="lg" hide-footer hide-header centered>
      <div class="p-4">
        <h6 class="text-center mb-3">Select Facilitators</h6>
        <b-row>
          <b-col cols="4">
            <b-form-checkbox
              v-model="event.facilitators"
              :value="item.id"
              v-for="(item, id) in facilitators"
              :key="id"
              >{{ item.name }}</b-form-checkbox
            ></b-col
          >
        </b-row>

        <div class="text-center my-3">
          <b-button @click="$bvModal.hide('addfac')">Close</b-button>
        </div>
      </div>
    </b-modal>
  </div>
</template>
<script>
import Upload from "../fileupload";
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
      showing: "upcoming",
      event: {
        title: "",
        venue: "",
        duration: "",
        description: "",
        type: "",
        url: "",
        cover: "",
        start: new Date(),
        end: new Date(),
        resource: "",
        facilitators: [],
      },
    };
  },
  components: {
    Upload,
  },
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
        return event.filter((item) => item.status != "expired");
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

    getevents() {
      this.$http
        .get(`${this.$store.getters.url}/events`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.events = res.data;
            this.rows = res.data.length;
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
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
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
              venue: "",
              type: "",
              url: "",
              cover: "",
              start: new Date(),
              end: new Date(),
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
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Update successful");
            this.$bvModal.hide("edit");
            this.event = {
              title: "",
              venue: "",
              duration: "",
              description: "",
              type: "",
              url: "",
              cover: "",
              start: new Date(),
              end: new Date(),
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
      this.$router.push(`/facilitator/event/${id}`);
    },
    drop(id, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/events/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
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
  padding-top: 30px;
}
.event-container {
  width: 65%;
  margin: 0 auto;
}
.events {
  max-height: 70vh;
  overflow: auto;
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

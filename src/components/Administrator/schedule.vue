<template>
  <div>
    <b-container>
      <b-row>
        <b-col sm="9">
          <b-row class="mb-4 mb-sm-5">
            <b-col>
              <div class="box p-3">
                <div class="d-flex align-items-center mb-1">
                  <b-iconstack font-scale="2.5" class="mr-3">
                    <b-icon
                      stacked
                      icon="circle-fill"
                      variant="lighter-green"
                    ></b-icon>
                    <b-icon
                      stacked
                      icon="person-badge-fill"
                      scale="0.5"
                      variant="dark-green"
                    ></b-icon>
                  </b-iconstack>
                  <div class="h6 mb-0 text-dark-green">Events</div>
                </div>
              </div>
            </b-col>
          </b-row>

          <b-row>
            <b-col>
              <div class="box">
                <div
                  class="d-flex justify-content-between align-items-center p-3 w-100 border-bottom"
                >
                  <b-button
                    size="sm"
                    variant="dark-green"
                    @click="$bvModal.show('add')"
                    ><b-icon icon="plus"></b-icon
                  ></b-button>
                  <span>{{ new Date() | moment("LL") }}</span>
                </div>

                <div class="w-100 p-3">
                  <b-table-simple responsive borderless>
                    <b-tbody>
                      <b-tr>
                        <b-th sticky-column class="">Monday</b-th>
                        <b-td>
                          <div class="d-flex tabl">
                            <div
                              v-for="(item, id) in daySchedule('monday')"
                              :key="id"
                              class="m_schedule p-2 rounded mr-3"
                              :style="{
                                'background-color':
                                  color[Math.floor(Math.random() * 5)],
                              }"
                            >
                              <div
                                class="d-flex justify-content-between w-100 align-items-center"
                              >
                                <span class="fs12">{{
                                  new Date("2021-05-18 " + item.start_time)
                                    | moment("LT")
                                }}</span>
                                <span
                                  class="border rounded-pill px-3 py-1 bg-light fs11"
                                >
                                  {{
                                    duration(
                                      new Date("2021-05-18 " + item.start_time),
                                      new Date("2021-05-18 " + item.end_time)
                                    )
                                  }}
                                  hour{{
                                    duration(
                                      new Date("2021-05-18 " + item.start_time),
                                      new Date("2021-05-18 " + item.end_time)
                                    ) > 1
                                      ? "s"
                                      : ""
                                  }}
                                </span>
                              </div>
                              <div class="fs14">{{ item.course.title }}</div>
                              <div class="fs13 d-flex justify-content-between">
                                <span> {{ item.facilitator.name }}</span>
                                <b-icon
                                  class="cursor-pointer"
                                  @click="drop(item.id)"
                                  icon="x"
                                ></b-icon>
                              </div>
                            </div>
                          </div>
                        </b-td>
                      </b-tr>
                      <b-tr>
                        <b-th sticky-column>Tuesday</b-th>
                        <b-td>
                          <div class="d-flex tabl">
                            <div
                              v-for="(item, id) in daySchedule('tuesday')"
                              :key="id"
                              class="m_schedule p-2 rounded mr-3"
                              :style="{
                                'background-color':
                                  color[Math.floor(Math.random() * 5)],
                              }"
                            >
                              <div
                                class="d-flex justify-content-between w-100 align-items-center"
                              >
                                <span class="fs12">{{
                                  new Date("2021-05-18 " + item.start_time)
                                    | moment("LT")
                                }}</span>
                                <span
                                  class="border rounded-pill px-3 py-1 bg-light fs11"
                                  >{{
                                    duration(
                                      new Date("2021-05-18 " + item.start_time),
                                      new Date("2021-05-18 " + item.end_time)
                                    )
                                  }}
                                  hour{{
                                    duration(
                                      new Date("2021-05-18 " + item.start_time),
                                      new Date("2021-05-18 " + item.end_time)
                                    ) > 1
                                      ? "s"
                                      : ""
                                  }}
                                </span>
                              </div>
                              <div class="fs14">{{ item.course.title }}</div>
                              <div class="fs13 d-flex justify-content-between">
                                <span> {{ item.facilitator.name }}</span>
                                <b-icon
                                  class="cursor-pointer"
                                  @click="drop(item.id)"
                                  icon="x"
                                ></b-icon>
                              </div>
                            </div>
                          </div>
                        </b-td>
                      </b-tr>
                      <b-tr>
                        <b-th sticky-column>Wednesday</b-th>
                        <b-td>
                          <div class="d-flex tabl">
                            <div
                              v-for="(item, id) in daySchedule('wednesday')"
                              :key="id"
                              class="m_schedule p-2 rounded mr-3"
                              :style="{
                                'background-color':
                                  color[Math.floor(Math.random() * 5)],
                              }"
                            >
                              <div
                                class="d-flex justify-content-between w-100 align-items-center"
                              >
                                <span class="fs12">{{
                                  new Date("2021-05-18 " + item.start_time)
                                    | moment("LT")
                                }}</span>
                                <span
                                  class="border rounded-pill px-3 py-1 bg-light fs11"
                                  >{{
                                    duration(
                                      new Date("2021-05-18 " + item.start_time),
                                      new Date("2021-05-18 " + item.end_time)
                                    )
                                  }}
                                  hour{{
                                    duration(
                                      new Date("2021-05-18 " + item.start_time),
                                      new Date("2021-05-18 " + item.end_time)
                                    ) > 1
                                      ? "s"
                                      : ""
                                  }}
                                </span>
                              </div>
                              <div class="fs14">{{ item.course.title }}</div>
                              <div class="fs13 d-flex justify-content-between">
                                <span> {{ item.facilitator.name }}</span>
                                <b-icon
                                  class="cursor-pointer"
                                  @click="drop(item.id)"
                                  icon="x"
                                ></b-icon>
                              </div>
                            </div>
                          </div>
                        </b-td>
                      </b-tr>
                      <b-tr>
                        <b-th sticky-column>Thursday</b-th>
                        <b-td>
                          <div class="d-flex tabl">
                            <div
                              v-for="(item, id) in daySchedule('thursday')"
                              :key="id"
                              class="m_schedule p-2 rounded mr-3"
                              :style="{
                                'background-color':
                                  color[Math.floor(Math.random() * 5)],
                              }"
                            >
                              <div
                                class="d-flex justify-content-between w-100 align-items-center"
                              >
                                <span class="fs12">{{
                                  new Date("2021-05-18 " + item.start_time)
                                    | moment("LT")
                                }}</span>
                                <span
                                  class="border rounded-pill px-3 py-1 bg-light fs11"
                                  >{{
                                    duration(
                                      new Date("2021-05-18 " + item.start_time),
                                      new Date("2021-05-18 " + item.end_time)
                                    )
                                  }}
                                  hour{{
                                    duration(
                                      new Date("2021-05-18 " + item.start_time),
                                      new Date("2021-05-18 " + item.end_time)
                                    ) > 1
                                      ? "s"
                                      : ""
                                  }}
                                </span>
                              </div>
                              <div class="fs14">{{ item.course.title }}</div>
                              <div class="fs13 d-flex justify-content-between">
                                <span> {{ item.facilitator.name }}</span>
                                <b-icon
                                  class="cursor-pointer"
                                  @click="drop(item.id)"
                                  icon="x"
                                ></b-icon>
                              </div>
                            </div>
                          </div>
                        </b-td>
                      </b-tr>
                      <b-tr>
                        <b-th sticky-column>Friday</b-th>
                        <b-td>
                          <div class="d-flex tabl">
                            <div
                              v-for="(item, id) in daySchedule('friday')"
                              :key="id"
                              class="m_schedule p-2 rounded mr-3"
                              :style="{
                                'background-color':
                                  color[Math.floor(Math.random() * 5)],
                              }"
                            >
                              <div
                                class="d-flex justify-content-between w-100 align-items-center"
                              >
                                <span class="fs12">{{
                                  new Date("2021-05-18 " + item.start_time)
                                    | moment("LT")
                                }}</span>
                                <span
                                  class="border rounded-pill px-3 py-1 bg-light fs11"
                                  >{{
                                    duration(
                                      new Date("2021-05-18 " + item.start_time),
                                      new Date("2021-05-18 " + item.end_time)
                                    )
                                  }}
                                  hour{{
                                    duration(
                                      new Date("2021-05-18 " + item.start_time),
                                      new Date("2021-05-18 " + item.end_time)
                                    ) > 1
                                      ? "s"
                                      : ""
                                  }}
                                </span>
                              </div>
                              <div class="fs14">{{ item.course.title }}</div>
                              <div class="fs13 d-flex justify-content-between">
                                <span> {{ item.facilitator.name }}</span>
                                <b-icon
                                  class="cursor-pointer"
                                  @click="drop(item.id)"
                                  icon="x"
                                ></b-icon>
                              </div>
                            </div>
                          </div>
                        </b-td>
                      </b-tr>

                      <b-tr>
                        <b-th sticky-column>Saturday</b-th>
                        <b-td>
                          <div class="d-flex tabl">
                            <div
                              v-for="(item, id) in daySchedule('saturday')"
                              :key="id"
                              class="m_schedule p-2 rounded mr-3"
                              :style="{
                                'background-color':
                                  color[Math.floor(Math.random() * 5)],
                              }"
                            >
                              <div
                                class="d-flex justify-content-between w-100 align-items-center"
                              >
                                <span class="fs12">{{
                                  new Date("2021-05-18 " + item.start_time)
                                    | moment("LT")
                                }}</span>
                                <span
                                  class="border rounded-pill px-3 py-1 bg-light fs11"
                                  >{{
                                    duration(
                                      new Date("2021-05-18 " + item.start_time),
                                      new Date("2021-05-18 " + item.end_time)
                                    )
                                  }}
                                  hour
                                  {{
                                    duration(
                                      new Date("2021-05-18 " + item.start_time),
                                      new Date("2021-05-18 " + item.end_time)
                                    ) > 1
                                      ? "s"
                                      : ""
                                  }}
                                </span>
                              </div>
                              <div class="fs14">{{ item.course.title }}</div>
                              <div class="fs13 d-flex justify-content-between">
                                <span> {{ item.facilitator.name }}</span>
                                <b-icon
                                  class="cursor-pointer"
                                  @click="drop(item.id)"
                                  icon="x"
                                ></b-icon>
                              </div>
                            </div>
                          </div>
                        </b-td>
                      </b-tr>
                      <b-tr>
                        <b-th sticky-column>Sunday</b-th>
                        <b-td>
                          <div class="d-flex tabl">
                            <div
                              v-for="(item, id) in daySchedule('sunday')"
                              :key="id"
                              class="m_schedule p-2 rounded mr-3"
                              :style="{
                                'background-color':
                                  color[Math.floor(Math.random() * 5)],
                              }"
                            >
                              <div
                                class="d-flex justify-content-between w-100 align-items-center"
                              >
                                <span class="fs12">{{
                                  new Date("2021-05-18 " + item.start_time)
                                    | moment("LT")
                                }}</span>
                                <span
                                  class="border rounded-pill px-3 py-1 bg-light fs11"
                                  >{{
                                    duration(
                                      new Date("2021-05-18 " + item.start_time),
                                      new Date("2021-05-18 " + item.end_time)
                                    )
                                  }}
                                  hour
                                  {{
                                    duration(
                                      new Date("2021-05-18 " + item.start_time),
                                      new Date("2021-05-18 " + item.end_time)
                                    ) > 1
                                      ? "s"
                                      : ""
                                  }}
                                </span>
                              </div>
                              <div class="fs14">{{ item.course.title }}</div>
                              <div class="fs13 d-flex justify-content-between">
                                <span> {{ item.facilitator.name }}</span>
                                <b-icon
                                  class="cursor-pointer"
                                  @click="drop(item.id)"
                                  icon="x"
                                ></b-icon>
                              </div>
                            </div>
                          </div>
                        </b-td>
                      </b-tr>
                    </b-tbody>
                  </b-table-simple>
                </div>
              </div>
            </b-col>
          </b-row>
        </b-col>
        <b-col sm="3" class="text-left px-0">
          <div class="turn_over_box">
            <div class="tob_1 mb-4 p-3">
              <vc-calendar
                color="teal"
                is-expanded
                title-position="left"
                show-weeknumbers
                :attributes="attributes"
              ></vc-calendar>
            </div>
            <div class="tob_2">
              <div class="d-flex align-items-center p-3">
                <h6 class="flex-1">Course schedule</h6>
                <b-form-select class="border-0" style="width: 100px" size="sm">
                  <b-form-select-option value="">Today</b-form-select-option>
                </b-form-select>
              </div>
              <div class="schedule">
                <div
                  v-if="
                    daySchedule(
                      new Date().toLocaleString('en-us', { weekday: 'long' })
                    ).length
                  "
                >
                  <div
                    class="p-3 border-bottom"
                    v-for="(item, id) in daySchedule(
                      new Date().toLocaleString('en-us', { weekday: 'long' })
                    )"
                    :key="id"
                  >
                    <div class="course_title d-flex mb-3 fs13">
                      <b-iconstack font-scale="1.5" class="mr-3">
                        <b-icon
                          stacked
                          icon="circle-fill"
                          variant="lighter-green"
                        ></b-icon>
                        <b-icon
                          stacked
                          icon="person-badge-fill"
                          scale="0.5"
                          variant="dark-green"
                        ></b-icon>
                      </b-iconstack>
                      <div>
                        <span class="title font-weight-bold">
                          {{ item.course.title }}</span
                        >
                      </div>
                    </div>
                    <div>
                      <span class="fs12"
                        ><b-icon icon="clock" class="mr-2"></b-icon>
                        <span
                          >{{
                            new Date("2021-05-18 " + item.start_time)
                              | moment("LT")
                          }}
                          -
                          {{
                            new Date("2021-05-18 " + item.end_time)
                              | moment("LT")
                          }}</span
                        ></span
                      >
                    </div>
                    <div class="mb-3">
                      <span class="fs12"
                        ><b-icon icon="calendar3" class="mr-2"></b-icon>
                        <span>Today</span></span
                      >
                    </div>

                    <b-button
                      block
                      variant="lighter-green"
                      class="text-dark-green"
                      >Reschedule</b-button
                    >
                  </div>
                </div>
                <div v-else class="p-4 text-center">
                  <h5 class="text-muted">Nothing Scheduled Today</h5>
                </div>
              </div>
            </div>
          </div>
        </b-col>
      </b-row>
    </b-container>
    <b-modal
      id="add"
      hide-footer
      centered
      size="lg"
      title="Add Course Schedule"
    >
      <b-container>
        <b-form @submit.prevent="register">
          <b-form-row>
            <b-col sm="5" class="px-3">
              <b-form-group label="Course">
                <b-form-select v-model="detail.course_id">
                  <b-form-select-option value=""
                    >Choose Course</b-form-select-option
                  >
                  <b-form-select-option
                    :value="item.id"
                    v-for="(item, id) in courses"
                    :key="id"
                    >{{ item.title }}</b-form-select-option
                  ></b-form-select
                >
              </b-form-group>
            </b-col>
          </b-form-row>
          <div
            class="border p-3 rounded mb-3"
            v-for="(item, id) in detail.schedule"
            :key="id"
          >
            <b-form-row>
              <b-col sm="6" class="mb-3 px-3">
                <b-form-group label="Day">
                  <b-form-select v-model="item.day">
                    <b-form-select-option value="monday"
                      >Monday</b-form-select-option
                    >
                    <b-form-select-option value="tuesday"
                      >Tuesday</b-form-select-option
                    >
                    <b-form-select-option value="wednesday"
                      >Wednesday</b-form-select-option
                    >
                    <b-form-select-option value="thursday"
                      >Thursday</b-form-select-option
                    >
                    <b-form-select-option value="friday"
                      >Friday</b-form-select-option
                    >
                    <b-form-select-option value="saturday"
                      >Saturday</b-form-select-option
                    >
                    <b-form-select-option value="sunday"
                      >Sunday</b-form-select-option
                    >
                  </b-form-select>
                </b-form-group>
              </b-col>
              <b-col sm="6" class="mb-3 px-3">
                <b-form-group label="Facilitator">
                  <b-form-select v-model="item.facilitator_id">
                    <b-form-select-option
                      :value="item.id"
                      v-for="(item, id) in facilitators"
                      :key="id"
                      >{{ item.name }}</b-form-select-option
                    ></b-form-select
                  >
                </b-form-group>
              </b-col>
            </b-form-row>
            <b-form-row>
              <b-col sm="6" class="mb-3 px-3">
                <b-form-group label="Start time">
                  <b-form-timepicker
                    :hour12="true"
                    placeholder="Choose start time"
                    v-model="item.start_time"
                  ></b-form-timepicker>
                </b-form-group>
              </b-col>
              <b-col sm="6" class="mb-3 px-3">
                <b-form-group label="End time">
                  <b-form-timepicker
                    :hour12="true"
                    placeholder="Choose end time"
                    v-model="item.end_time"
                  ></b-form-timepicker>
                </b-form-group>
              </b-col>
            </b-form-row>
            <div>
              <b-button
                variant="outline-dark-green"
                class="my-2 mr-3"
                size="sm"
                @click="detail.schedule.splice(id, 1)"
                v-if="detail.schedule.length > 1"
                >Delete schedule</b-button
              >
              <b-button
                variant="dark-green"
                class="my-2"
                size="sm"
                @click="addschedule"
                v-if="detail.schedule.length == id + 1"
                >Add new schedule</b-button
              >
            </div>
          </div>
          <div class="text-center my-3">
            <b-button size="lg" variant="dark-green" type="submit"
              >Create schedule</b-button
            >
          </div>
        </b-form>
      </b-container>
    </b-modal>
  </div>
</template>

<script>
export default {
  data() {
    return {
      color: ["red", "blue", "green", "brown", "purple"],
      facilitators: [],
      schedules: [],
      courses: [],
      detail: {
        course_id: null,
        schedule: [
          {
            day: "",
            start_time: "",
            end_time: "",
            facilitator_id: null,
          },
        ],
      },
    };
  },
  components: {},
  watch: {},
  mounted() {
    this.getcourses();
    this.getfacilitators();
    this.getschedules();
  },
  computed: {
    attributes() {
      return [
        // This is a single attribute
        {
          // An optional key can be used for retrieving this attribute later,
          // and will most likely be derived from your data object
          key: 1,
          // Attribute type definitions
          highlight: true, // Boolean, String, Object
          dot: false, // Boolean, String, Object
          bar: false, // Boolean, String, Object
          content: false, // Boolean, String, Object
          popover: {}, // Only objects allowed
          // Your custom data object for later access, if needed
          customData: {},
          // We also need some dates to know where to display the attribute
          // We use a single date here, but it could also be an array of dates,
          //  a date range or a complex date pattern.
          dates: new Date(),
          // You can optionally provide dates to exclude
          excludeDates: null,
          // Think of `order` like `z-index`
          order: 0,
        },
      ];
    },
  },
  methods: {
    daySchedule(day) {
      return this.schedules.filter(
        (item) => item.day.toLowerCase() == day.toLowerCase()
      );
    },
    addschedule() {
      this.detail.push({
        day: "",
        start_time: "",
        end_time: "",
        facilitator_id: null,
      });
    },
    duration(a, b) {
      return this.$moment(b).diff(this.$moment(a), "hours");
    },
    async getschedules() {
      return this.$http
        .get(`${this.$store.getters.url}/courseschedules`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.schedules = res.data;
            this.rows = res.data.length;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
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

    async getcourses() {
      return this.$http
        .get(`${this.$store.getters.url}/courses`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.courses = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    register() {
      this.$http
        .post(`${this.$store.getters.url}/courseschedules`, this.detail, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.$toast.success("Added successfully");
            this.$bvModal.hide("add");
            this.schedules.unshift(res.data);
            this.detail.schedule = {
              day: "",
              start_time: "",
              end_time: "",
              facilitator_id: null,
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
      this.detail = data.courseschedule;
    },
    updatecourse() {
      this.$http
        .put(
          `${this.$store.getters.url}/courseschedules/${this.detail.id}`,
          this.detail,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Updated successfully");
            this.detail.schedule = {
              day: "",
              start_time: "",
              end_time: "",
              facilitator_id: null,
            };
            this.getschedules();
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    drop(id) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/courseschedules/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success("Removed successfully");
                this.getschedules();
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
th {
  font-size: 14px;
  font-weight: 500;
  padding-right: 0;
  padding-left: 0;
}
td {
  color: white;
}
.bg-light {
  color: black;
}
.box {
  min-height: 130px;
  display: flex;
  align-items: flex-start;
  flex-direction: column;
  justify-content: center;
  text-align: left;

  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35);
  border-radius: 8px;
  background: white;
}
.new_add {
  color: rgba(0, 0, 0, 0.44);
  font-size: 14px;
}
// .box:hover {
//   background: linear-gradient(127.24deg, #388087 28.41%, #c2edce 100%);
// }
// .box:hover > div > div,
// .box:hover > div > .h6 {
//   color: white !important;
// }

// .box:hover > div > .new_add > .ic {
//   color: white !important;
// }
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
.turn_over_box {
  height: 100%;
}
.tob_1 {
  min-height: 200px;
  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
  border-radius: 8px;
  text-align: center;
  background: white;
}
.tob_2 {
  min-height: 200px;
  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
  border-radius: 8px;
  padding: 0;
  background: white;
}
.admin_tab {
  min-height: 400px;
}
.todos {
  padding: 10px;
  height: 200px;
  overflow: auto;
}
.todo {
  background: var(--skills-grey);
  border-radius: 5px;
}
.text-sm {
  font-size: 0.7rem;
}
.schedule {
  height: 300px;
  overflow: auto;
}
.m_schedule {
  width: 230px;
}
// .tabl {
//   width: 600px;
//   overflow-x: auto;
// }
@media (max-width: 600px) {
  .box {
    margin-bottom: 24px;
  }
  .admin_tab {
    min-height: 200px;
  }
}
</style>

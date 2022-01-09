<template>
  <div class="suggestion">
    <b-container class="p-0">
      <b-row>
        <b-col class="text-left">
          <div class="turn_over_box">
            <div class="tob_1 mb-4">
              <vc-calendar
                class="custom-calendar max-w-full"
                :masks="masks"
                :attributes="attributes"
                disable-page-swipe
                is-expanded
                title-position="left"
              >
                <template #day-popover="{ dayTitle, attributes }">
                  <div class="text-xs text-gray-300 font-semibold text-center">
                    {{ dayTitle }}
                  </div>
                  <popover-row
                    v-for="attr in attributes"
                    :key="attr.key"
                    :attribute="attr"
                    class="border-bottom pb-2"
                  >
                    <div>
                      <p class="mb-1 text-capitalize">
                        {{ attr.customData.title }}
                      </p>
                      <p class="fs11 mb-0 text-capitalize">
                        <span class="mr-2"> {{ attr.customData.type }} </span>
                      </p>
                    </div>
                  </popover-row>
                </template>
              </vc-calendar>
            </div>
            <div class="tob_2">
              <div class="d-flex align-items-center p-3">
                <h6 class="flex-1">Today schedule</h6>
                <b-form-select class="border-0" style="width: 100px" size="sm">
                  <b-form-select-option value="">Today</b-form-select-option>
                </b-form-select>
              </div>
              <div class="schedule" v-if="showschedule">
                <div v-if="todaySchedule().length">
                  <div
                    class="p-3 border-bottom"
                    v-for="(item, id) in todaySchedule()"
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
                          icon="calendar"
                          scale="0.5"
                          variant="dark-green"
                        ></b-icon>
                      </b-iconstack>
                      <div>
                        <span
                          class="title font-weight-bold"
                          v-if="item.customData.title"
                        >
                          {{ item.customData.title }}</span
                        >
                      </div>
                    </div>
                    <div>
                      <span class="fs12"
                        ><b-icon icon="clock" class="mr-2"></b-icon>
                        <span
                          >{{ item.dates.start | moment("LT") }}
                          -
                          {{ item.dates.end | moment("LT") }}</span
                        ></span
                      >
                    </div>

                    <div class="text-right">
                      <a :href="item.customData.url" target="_blank">
                        <b-button
                          block
                          variant="lighter-green"
                          class="text-dark-green"
                          >Attend
                        </b-button></a
                      >
                    </div>
                  </div>
                </div>
                <div v-else class="p-4 text-center">
                  <p class="text-muted">Nothing Scheduled Today</p>
                </div>
              </div>

              <div v-else class="p-4">
                <div class="p-1">
                  <b-skeleton animation="wave" width="100%"></b-skeleton>
                  <b-skeleton animation="wave" width="25%"></b-skeleton>
                </div>
                <div class="p-1">
                  <b-skeleton animation="wave" width="100%"></b-skeleton>
                  <b-skeleton animation="wave" width="25%"></b-skeleton>
                </div>
                <div class="p-1">
                  <b-skeleton animation="wave" width="100%"></b-skeleton>
                  <b-skeleton animation="wave" width="25%"></b-skeleton>
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
import PopoverRow from "v-calendar/lib/components/popover-row.umd.min";

export default {
  data() {
    return {
      color: ["red", "blue", "green", "brown", "purple", "teal"],
      days: [
        "monday",
        "tuesday",
        "wednesday",
        "thursday",
        "friday",
        "saturday",
        "sunday",
      ],
      events: [],
      facilitators: [],
      schedules: [],
      courses: [],
      current_schedule: 0,
      schedule_num: 1,
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
      detail: {
        course_id: null,
        schedule: [
          {
            day: "",
            venue: "",
            url: "",
            start_time: new Date(),
            end_time: new Date(),
            facilitator_id: null,
          },
        ],
      },
      masks: {
        weekdays: "WWW",
      },
      showTable: false,
      showEvent: false,
      showschedule: false,
      options: [],
      searchText: "", // If value is falsy, reset searchText & searchItem
      items: [],
      lastSelectItem: {},
    };
  },
  components: {
    PopoverRow,
  },
  watch: {},
  created() {

      this.getfacilitators().then(() => {
        this.getevents();
      });

  },
  mounted() {
    this.$root.$on("bv::modal::hide", () => {
      this.schedule_num = 1;
      this.$bvModal.hide("addopen");
    });
  },
  computed: {
    joinedSchedule() {
      return this.myevents;
    },
    myschedule() {
      return this.schedules.map((item, index) => {
        var res = {
          key: index,

          highlight: {
            start: { color: "teal", fillMode: "outline" },
            base: { color: "teal", fillMode: "light" },
            end: { color: "teal", fillMode: "solid" },
          },
          dot: false,
          bar: false,
          content: false,
          popover: true,
          customData: {
            title: item.course.title,
            url: item.url,
            facilitator: item.facilitator ? item.facilitator.name : "",
            color: JSON.parse(item.course.courseoutline.knowledge_areas).color,
            duration:
              this.$moment(item.start_time).diff(
                this.$moment(item.end_time),
                "weeks"
              ) + "weeks",
            type: "Course",
            class: "bg-red-600 text-white",
          },
          dates: {
            start: new Date(item.start_time),
            end: new Date(item.end_time),
          },
        };
        return res;
      });
    },
    myevents() {
      return this.events.map((item, index) => {
        var res = {
          key: index,

          highlight: {
            start: { color: "green", fillMode: "outline" },
            base: { color: "green", fillMode: "light" },
            end: { color: "green", fillMode: "solid" },
          },
          dot: false,
          bar: false,
          content: false,
          popover: true,
          customData: {
            title: item.title,
            url: item.url,
            color: "#276749",
            facilitator: item.facilitator ? item.facilitator.name : "",
            duration: item.schedule,
            type: item.type,
            class: "bg-red-600 text-white",
          },
          dates: { start: new Date(item.start), end: new Date(item.end) },
        };
        return res;
      });
    },
    attributes() {
      return this.myevents.map((item, index) => {
        var res = {
          key: index,
          highlight: item.highlight,
          popover: true,
          customData: item.customData,
          dates: item.dates,
        };
        return res;
      });
    },
    comingevents() {
      return this.events
        .filter((item) => item.status !== "expired")
        .slice(0, 5);
    },
  },
  methods: {
    daySchedule(day) {
      if (this.joinedSchedule.length) {
        return this.joinedSchedule.filter(
          (item) =>
            this.$moment(item.dates.start, "YYYY-MM-DD HH:mm:ss")
              .format("dddd")
              .toLowerCase() == day.toLowerCase() &&
            this.$moment().isBetween(
              this.$moment(item.dates.start),
              this.$moment(item.dates.end)
            )
        );
      }
      return [];
    },
    todaySchedule() {
      if (this.joinedSchedule.length) {
        return this.joinedSchedule.filter(
          (item) =>
            this.$moment().isAfter(item.dates.start) &&
            this.$moment().isBefore(item.dates.end)
        );
      }
      return [];
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
      if (this.$moment(b).diff(this.$moment(a), "weeks") > 0) {
        return `${this.$moment(b).diff(this.$moment(a), "weeks")}
         ${
           this.$moment(b).diff(this.$moment(a), "weeks") > 1 ? "weeks" : "week"
         }`;
      }
      return `${this.$moment(b).diff(this.$moment(a), "days")}
       ${this.$moment(b).diff(this.$moment(a), "days") > 1 ? "days" : "day"}`;
    },
    async getschedules() {
      return this.$http
        .get(`${this.$store.getters.url}/courseschedules`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.schedules = res.data.filter(
              (item) =>
                this.$moment().isBefore(item.start_time) ||
                this.$moment().isBefore(item.end_time)
            );
            this.rows = this.schedules.length;
            this.showTable = true;
            this.showschedule = true;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
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

    // async getcourses() {
    //   return this.$http
    //     .get(`${this.$store.getters.url}/courses`, {
    //       headers: {
    //         Authorization: `Bearer ${this.$store.getters.member.access_token}`,
    //       },
    //     })
    //     .then((res) => {
    //       if (res.status == 200) {
    //         this.courses = res.data;
    //       }
    //     })
    //     .catch((err) => {
    //       this.$toast.error(err.response.data.message);
    //     });
    // },

    async getevents() {
      return this.$http
        .get(
          `${this.$store.getters.url}/get/tribe/myevents/${this.$route.params.tribe}`,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.events = res.data;
            this.showEvent = true;
            this.showschedule = true;
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
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
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
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
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
                Authorization: `Bearer ${this.$store.getters.member.access_token}`,
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

  // box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35);
  border-radius: 8px;
  background: white;
}
.top_box {
  height: 250px;
  display: flex;
  align-items: flex-start;
  text-align: left;
  overflow: hidden;
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
  // box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
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
  // box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
  border-radius: 8px;
  text-align: center;
  background: white;
}
.tob_2 {
  min-height: 200px;
  // box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
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
.event_image {
  border-radius: 10rem 0 0 0;
  overflow: hidden;
  width: 100%;
}
.upcoming {
  position: absolute;
  top: 0;
  left: 0;
  padding: 3px 15px;
  background: var(--dark-green);
  color: white;
  font-size: 12px;
  z-index: 2;
}
.suggestion {
  height: calc(100vh - 300px);
  overflow-y: auto;
  padding-bottom: 75px;
}
@media (max-width: 600px) {
  .box {
    margin-bottom: 24px;
  }
  .admin_tab {
    min-height: 200px;
  }
  .top_box {
    height: 400px;
  }
}
</style>

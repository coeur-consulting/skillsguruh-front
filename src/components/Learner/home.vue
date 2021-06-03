<template>
  <div>
    <b-container>
      <b-row>
        <b-col sm="9">
          <div
            class="top_banner text-left p-3 p-sm-5 rounded position-relative mb-5"
          >
            <h4 class="text-dark-green">
              Welcome {{ $store.getters.learner.name }}
            </h4>
            <p>
              Our Platform gives you access to up <br />
              skills and socialize!
            </p>

            <b-img
              class="learner_img"
              :src="require('@/assets/images/learner.png')"
            ></b-img>
          </div>

          <div class="recommended text-left mb-5">
            <div class="d-flex align-items-center mb-3">
              <h6 class="flex-1">Recommended Courses</h6>
              <span class="fs14" @click="$router.push('/learner/courses')"
                >More <b-icon icon="arrow-right"></b-icon
              ></span>
            </div>
            <div>
              <b-row>
                <b-col
                  sm="4"
                  class="pr-3"
                  v-for="course in courses.slice(0, 3)"
                  :key="course.id"
                >
                  <div
                    class="w-100 h-100 bg-white shadow-wm rounded p-4 d-flex flex-column"
                    @click="$router.push('/learner/courses')"
                  >
                    <div class="flex-1">
                      <b-iconstack font-scale="2.5" class="mr-2 mb-2">
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
                      <div class="course_title mb-1">{{ course.title }}</div>
                      <div class="mb-3">
                        <span class="fs13 overview text-muted">
                          {{ course.description }}</span
                        >
                      </div>
                      <div
                        class="course_fac d-flex align-items-center mb-1 text-capitalize fs13"
                        v-if="sortfacilitators(course).length"
                      >
                        <b-icon
                          icon="display"
                          variant="dark-green"
                          class="text-muted mr-2"
                        ></b-icon>
                        <span class="fs13">
                          {{ sortfacilitators(course).join(" ") }}</span
                        >
                      </div>

                      <div
                        class="course_fac d-flex text-capitalize align-items-center fs13 mb-1"
                      >
                        <b-icon
                          icon="calendar"
                          variant="dark-green"
                          class="text-muted mr-2"
                        ></b-icon>
                        <div class="">
                          <div class="text-capitalize">
                            {{ course.courseoutline.duration }}
                          </div>
                        </div>
                      </div>

                      <div
                        v-if="course"
                        class="course_fac align-items-center fs13"
                      >
                        <b-icon
                          icon="layers"
                          variant="dark-green"
                          class="text-muted mr-1"
                        ></b-icon>
                        <span class="fs13"> {{ sortmodules(course) }}</span>
                        Modules
                      </div>
                    </div>

                    <div class="pt-3">
                      <div class="d-flex justify-content-between fs13">
                        <span>Resources upload</span
                        ><span
                          >{{
                            getProgress(
                              course.courseoutline.modules,
                              course.modules
                            )
                          }}%</span
                        >
                      </div>
                      <b-progress
                        :value="
                          getProgress(
                            course.courseoutline.modules,
                            course.modules
                          )
                        "
                        :max="100"
                        show-value
                        height=".8rem"
                        class="mb-3"
                        variant="dark-green"
                      ></b-progress>
                    </div>
                  </div>
                </b-col>
              </b-row>
            </div>
          </div>

          <div class="discussions">
            <Discussions></Discussions>
          </div>
        </b-col>
        <b-col sm="3" class="text-left">
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
                        <span class="mr-2"> {{ attr.customData.type }} -</span
                        ><span> {{ attr.customData.duration }}</span>
                      </p>
                    </div>
                  </popover-row>
                </template>
              </vc-calendar>
            </div>
            <div class="tob_2 mb-4">
              <Todo user="learner" />
            </div>

            <div class="tob_2 mb-4 p-3">
              <h6 class="mb-3 text-center">Connect with people</h6>

              <div v-if="connections.length">
                <div
                  class="d-flex mb-3"
                  v-for="user in connections.slice(0, 5)"
                  :key="user.id"
                >
                  <div class="d-flex flex-1">
                    <b-avatar
                      size="sm"
                      :src="user.profile"
                      class="mr-2"
                    ></b-avatar>
                    <div>
                      <div class="fs12 font-weight-bold text-capitalize">
                        {{ user.name }}
                      </div>
                      <div style="line-height: 1">
                        <span class="fs11">Lagos,Nigeria</span> <br /><span
                          class="fs11"
                          >{{ user.similar }} similar insights</span
                        >
                      </div>
                    </div>
                  </div>
                  <b-dropdown
                    size="sm"
                    variant="transparent"
                    no-caret
                    class="no-focus drop"
                  >
                    <template #button-content>
                      <b-icon
                        icon="three-dots-vertical"
                        font-scale="1.4"
                      ></b-icon>
                    </template>
                    <b-dropdown-item
                      class="fs12"
                      @click="addconnections(user.id, 'user')"
                      >Connect</b-dropdown-item
                    >
                  </b-dropdown>
                </div>
              </div>
              <div v-else class="text-muted text-center p-3 fs13">
                Unavailable
              </div>
            </div>
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import Todo from "../Todo";
import Discussions from "./minidiscussions";
export default {
  data() {
    return {
      facilitators: [],
      users: [],
      todos: [],
      events: [],
      courses: [],
      schedules: [],
      connections: [],
      masks: {
        weekdays: "WWW",
      },
    };
  },
  components: {
    Todo,
    Discussions,
  },
  watch: {},
  created() {
    this.gettodos();
    this.getfacilitators();
    this.getusers();
    this.getevents();
    this.getcourses();
    this.getschedules();
  },
  mounted() {
    this.getUsersWithInterest();
  },

  computed: {
    newlyfacilitators() {
      return this.facilitators.filter(
        (item) =>
          new Date(item.created_at).getMonth() == new Date().getMonth() &&
          new Date(item.created_at).getFullYear() == new Date().getFullYear()
      ).length;
    },
    newlyusers() {
      return this.users.filter(
        (item) =>
          new Date(item.created_at).getMonth() == new Date().getMonth() &&
          new Date(item.created_at).getFullYear() == new Date().getFullYear()
      ).length;
    },
    myschedule() {
      return this.schedules.map((item, index) => {
        var res = {
          key: index,

          highlight: {
            color: "teal",
            fillMode: "light",
            start: { fillMode: "outline" },
            base: { fillMode: "light" },
            end: { fillMode: "solid" },
          },
          dot: false,
          bar: false,
          content: false,
          popover: true,
          customData: {
            title: item.course.title,
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
            color: "purple",
            fillMode: "light",

            start: { fillMode: "outline" },
            base: { fillMode: "light" },
            end: { fillMode: "solid" },
          },
          dot: false,
          bar: false,
          content: false,
          popover: true,
          customData: {
            title: item.title,
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
      return this.myschedule.concat(this.myevents).map((item, index) => {
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
  },
  methods: {
    sortmodules(data) {
      if (!data.courseoutline) {
        return 0;
      }
      return JSON.parse(data.courseoutline.modules).length;
    },
    sortfacilitators(data) {
      if (!data.courseschedule) {
        return "Unavailable";
      }
      var schedule = data.courseschedule;
      var newArr = schedule.map((val) => {
        if (val.facilitator_id) {
          var fac = this.facilitators.find(
            (item) => item.id == val.facilitator_id
          );
          if (fac) {
            return fac.name;
          }
        }
      });

      return [...new Set(newArr)];
    },
    getUsersWithInterest() {
      this.$http
        .get(
          `${this.$store.getters.url}/identical-learners`,

          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.connections = res.data;
          }
        });
    },
    getProgress(a, b) {
      var count = 0;

      var modules = JSON.parse(a);

      var resources = b;

      modules.forEach((mod) => {
        var val = resources.filter((item) => item.module == mod).length;

        if (val) {
          count++;
        }
      });

      return (count / modules.length) * 100;
    },

    async getschedules() {
      return this.$http
        .get(`${this.$store.getters.url}/courseschedules`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.schedules = res.data.filter(
              (item) =>
                this.$moment().isBefore(item.start_time) &&
                this.$moment().isBefore(item.end_time)
            );
            this.rows = this.schedules.length;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    async getevents() {
      return this.$http
        .get(`${this.$store.getters.url}/events`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.events = res.data.filter((item) => item.status !== "expired");
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    gettodos() {
      this.$http
        .get(`${this.$store.getters.url}/todos`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.todos = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getfacilitators() {
      this.$http
        .get(`${this.$store.getters.url}/user-get-facilitators`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
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
    getusers() {
      this.$http
        .get(`${this.$store.getters.url}/users`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.users = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getcourses() {
      this.$http
        .get(`${this.$store.getters.url}/interest-courses`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
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
    async addconnections(id, type) {
      return this.$http
        .post(
          `${this.$store.getters.url}/connections`,
          { following_id: id, follow_type: type },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Successful");
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
  },
};
</script>
<style scoped lang="scss">
.container {
  padding-top: 30px;
}
.top_banner {
  background-color: rgba($color: #388087, $alpha: 0.2);
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
.box:hover {
  background: linear-gradient(127.24deg, #388087 28.41%, #c2edce 100%);
}
.box:hover > div > div,
.box:hover > div > .h6 {
  color: white !important;
}

.box:hover > div > .new_add > .ic {
  color: white !important;
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
.learner_tab {
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
.learner_img {
  position: absolute;
  top: -30%;
  right: 15%;
}
@media (max-width: 600px) {
  .box {
    margin-bottom: 24px;
  }
  .learner_tab {
    min-height: 200px;
  }
}
</style>

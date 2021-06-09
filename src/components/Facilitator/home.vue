<template>
  <div>
    <b-container>
      <b-row>
        <b-col sm="8">
          <b-row class="mb-5 mb-sm-5">
            <b-col sm="6">
              <div class="box p-3">
                <div
                  class="
                    w-100
                    px-2
                    d-flex
                    justify-content-between
                    align-items-center
                    mb-4
                  "
                >
                  <div class="d-flex align-items-center mb-1">
                    <b-iconstack font-scale="2.5" class="mr-3">
                      <b-icon
                        stacked
                        icon="circle-fill"
                        variant="lighter-green"
                      ></b-icon>
                      <b-icon
                        stacked
                        icon="people-fill"
                        scale="0.5"
                        variant="dark-green"
                      ></b-icon>
                    </b-iconstack>
                    <div class="h6 mb-0 text-dark-green">
                      Total <br />
                      Learners
                    </div>
                  </div>
                  <div class="h2">{{ users.length }}</div>
                </div>
                <div class="w-100 px-2">
                  <div class="new_add d-flex align-items-center">
                    <b-img
                      class="mr-2"
                      :src="require('@/assets/images/profit.svg')"
                      width="24"
                    ></b-img>
                    <span class="mr-2 mt-1 text-dark-green">
                      {{
                        Math.round((newlyusers / users.length) * 100) || 0
                      }}%</span
                    >
                    <span class="mt-1">New Learners this month</span>
                  </div>
                </div>
              </div>
            </b-col>
            <b-col sm="6">
              <div class="box p-3">
                <div
                  class="
                    d-flex
                    w-100
                    justify-content-between
                    align-items-center
                    mb-4
                  "
                >
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
                    <div class="h6 mb-0 text-dark-green">
                      Total <br />
                      Courses
                    </div>
                  </div>
                  <div class="h2">{{ courses.length }}</div>
                </div>

                <div class="w-100 px-2">
                  <div class="new_add d-flex align-items-center">
                    <b-img
                      class="mr-2"
                      :src="require('@/assets/images/profit.svg')"
                      width="24"
                    ></b-img>
                    <span class="mr-2 mt-1 text-dark-green">
                      {{
                        Math.round((newlyCourses / courses.length) * 100) || 0
                      }}%</span
                    >
                    <span class="mt-1">New Courses this month</span>
                  </div>
                </div>
              </div>
            </b-col>
          </b-row>
          <div class="recommended text-left mb-5">
            <div class="d-flex align-items-center mb-3 w-100">
              <div class="d-flex flex-1">
                <h6
                  class="pr-3 border-right cursor-pointer"
                  :class="courseShown == 'toprated' ? '' : 'text-muted'"
                  @click="courseShown = 'toprated'"
                >
                  Top Rated
                </h6>
                <h6
                  class="pl-3 cursor-pointer"
                  :class="courseShown == 'mostenrolled' ? '' : 'text-muted'"
                  @click="courseShown = 'mostenrolled'"
                >
                  Most Enrolled
                </h6>
              </div>
              <span class="fs14" @click="$router.push('/learner/courses')"
                >More <b-icon icon="arrow-right"></b-icon
              ></span>
            </div>
            <div v-if="showEnrolled">
              <div v-if="courseShown == 'mostenrolled'">
                <b-row v-if="mostenrolledcourse.length">
                  <b-col
                    sm="4"
                    class="pr-3"
                    v-for="item in mostenrolledcourse.slice(0, 3)"
                    :key="item.id"
                  >
                    <div
                      class="
                        w-100
                        h-100
                        bg-white
                        shadow
                        rounded
                        p-4
                        d-flex
                        flex-column
                        position-relative
                      "
                      @click="$router.push('/learner/courses')"
                    >
                      <div class="ribbon text-capitalize">
                        <span>{{ item.course.type }}</span>
                      </div>
                      <div class="flex-1">
                        <b-iconstack font-scale="2.5" class="mr-2 mb-2">
                          <b-icon
                            stacked
                            icon="circle-fill"
                            :style="`color:${
                              JSON.parse(
                                item.course.courseoutline.knowledge_areas
                              ).color
                            }`"
                          ></b-icon>
                          <b-icon
                            stacked
                            :icon="
                              JSON.parse(
                                item.course.courseoutline.knowledge_areas
                              ).icon
                            "
                            scale="0.5"
                            variant="light"
                          ></b-icon>
                        </b-iconstack>
                        <div class="course_title mb-1">
                          {{ item.course.title }}
                        </div>
                        <div class="mb-3">
                          <span class="fs13 overview text-muted">
                            {{ item.course.description }}</span
                          >
                        </div>

                        <div
                          class="
                            course_fac
                            d-flex
                            text-capitalize
                            align-items-center
                            fs13
                            mb-1
                          "
                        >
                          <b-icon
                            icon="calendar"
                            variant="dark-green"
                            class="text-muted mr-2"
                          ></b-icon>
                          <div class="">
                            <div class="text-capitalize text-muted">
                              {{ item.course.courseoutline.duration }}
                            </div>
                          </div>
                        </div>

                        <div
                          v-if="item.course"
                          class="course_fac align-items-center fs13 text-muted"
                        >
                          <b-icon
                            icon="layers"
                            variant="dark-green"
                            class="text-muted mr-1"
                          ></b-icon>
                          <span class="fs13">
                            {{ sortmodules(item.course) }}</span
                          >
                          Modules
                        </div>
                      </div>

                      <div class="pt-3">
                        <div class="mb-2 fs12 text-muted">
                          <b-icon
                            icon="people-fill"
                            font-scale="1.5"
                            class="mr-1"
                            variant="dark-green"
                          ></b-icon>
                          {{ item.count }}
                          {{ item.count > 1 ? "students" : "student" }}
                        </div>
                        <div class="d-flex justify-content-between fs13">
                          <span>Resources upload</span
                          ><span
                            >{{
                              Math.floor(
                                getProgress(
                                  item.course.courseoutline.modules,
                                  item.course.modules
                                )
                              ) || 0
                            }}%</span
                          >
                        </div>
                        <b-progress
                          :value="
                            Math.floor(
                              getProgress(
                                item.course.courseoutline.modules,
                                item.course.modules
                              )
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

                <div v-else class="w-100 p-5 text-center text-muted">
                  <h5>No course available</h5>
                </div>
              </div>
              <div v-if="courseShown == 'toprated'">
                <b-row v-if="topratedcourse.length">
                  <b-col
                    sm="4"
                    class="pr-3"
                    v-for="(item, id) in topratedcourse.slice(0, 3)"
                    :key="id"
                  >
                    <div
                      class="
                        w-100
                        h-100
                        bg-white
                        shadow
                        rounded
                        p-4
                        d-flex
                        flex-column
                        position-relative
                      "
                      @click="$router.push('/learner/courses')"
                    >
                      <div class="ribbon text-capitalize">
                        <span>{{ item[1].course.type }}</span>
                      </div>
                      <div class="flex-1">
                        <b-iconstack font-scale="2.5" class="mr-2 mb-2">
                          <b-icon
                            stacked
                            icon="circle-fill"
                            :style="`color:${
                              JSON.parse(
                                item[1].course.courseoutline.knowledge_areas
                              ).color
                            }`"
                          ></b-icon>
                          <b-icon
                            stacked
                            :icon="
                              JSON.parse(
                                item[1].course.courseoutline.knowledge_areas
                              ).icon
                            "
                            scale="0.5"
                            variant="light"
                          ></b-icon>
                        </b-iconstack>
                        <div class="course_title mb-1">
                          {{ item[1].course.title }}
                        </div>
                        <div class="mb-3">
                          <span class="fs13 overview text-muted">
                            {{ item[1].course.description }}</span
                          >
                        </div>

                        <div
                          class="
                            course_fac
                            d-flex
                            text-capitalize
                            align-items-center
                            fs13
                            mb-1
                          "
                        >
                          <b-icon
                            icon="calendar"
                            variant="dark-green"
                            class="text-muted mr-2"
                          ></b-icon>
                          <div class="">
                            <div class="text-capitalize text-muted">
                              {{ item[1].course.courseoutline.duration }}
                            </div>
                          </div>
                        </div>

                        <div
                          class="course_fac align-items-center fs13 text-muted"
                        >
                          <b-icon
                            icon="layers"
                            variant="dark-green"
                            class="text-muted mr-1"
                          ></b-icon>
                          <span class="fs13">
                            {{ sortmodules(item[1].course) }}</span
                          >
                          Modules
                        </div>
                      </div>

                      <div class="pt-3">
                        <star-rating
                          class=""
                          v-model="item[0].total_review"
                          :star-size="15"
                          :read-only="true"
                          :show-rating="false"
                        ></star-rating>

                        <div class="mb-2 fs12 text-muted">
                          {{
                            item[1].course.review.length > 1
                              ? item[1].course.review.length + " reviews"
                              : item[1].course.review.length + " review"
                          }}
                        </div>
                        <div class="d-flex justify-content-between fs13">
                          <span>Resources upload</span
                          ><span
                            >{{
                              Math.floor(
                                getProgress(
                                  item[1].course.courseoutline.modules,
                                  item[1].course.modules
                                )
                              ) || 0
                            }}%</span
                          >
                        </div>
                        <b-progress
                          :value="
                            Math.floor(
                              getProgress(
                                item[1].course.courseoutline.modules,
                                item[1].course.modules
                              )
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

                <div v-else class="w-100 p-5 text-center text-muted">
                  <h5>No course available</h5>
                </div>
              </div>
            </div>
            <b-row v-else>
              <b-col>
                <div class="mb-3"><b-skeleton-img></b-skeleton-img></div>
                <b-skeleton
                  animation="fade"
                  class="mb-2"
                  width="65%"
                ></b-skeleton>
                <b-skeleton
                  animation="fade"
                  class="mb-2"
                  width="55%"
                ></b-skeleton>
                <b-skeleton animation="fade" width="59%"></b-skeleton>
              </b-col>
              <b-col>
                <div class="mb-3"><b-skeleton-img></b-skeleton-img></div>
                <b-skeleton
                  animation="fade"
                  class="mb-2"
                  width="65%"
                ></b-skeleton>
                <b-skeleton
                  animation="fade"
                  class="mb-2"
                  width="55%"
                ></b-skeleton>
                <b-skeleton animation="fade" width="59%"></b-skeleton>
              </b-col>
              <b-col>
                <div class="mb-3"><b-skeleton-img></b-skeleton-img></div>
                <b-skeleton
                  animation="fade"
                  class="mb-2"
                  width="65%"
                ></b-skeleton>
                <b-skeleton
                  animation="fade"
                  class="mb-2"
                  width="55%"
                ></b-skeleton>
                <b-skeleton animation="fade" width="59%"></b-skeleton>
              </b-col>
            </b-row>
          </div>

          <div class="discussions">
            <Discussions></Discussions>
          </div>
        </b-col>
        <b-col sm="4" class="text-left">
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
            <div class="tob_2">
              <Todo user="facilitator" />
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
import StarRating from "vue-star-rating";
export default {
  data() {
    return {
      courses: [],
      users: [],
      todos: [],
      events: [],
      schedules: [],
      showEnrolled: false,
      showConnect: false,
      showDiscussion: false,
      courseShown: "toprated",
      mostenrolledcourse: [],
      topratedcourse: [],
      masks: {
        weekdays: "WWW",
      },
    };
  },
  components: {
    Discussions,
    Todo,
    StarRating,
  },
  watch: {},
  created() {
    this.gettodos();
    this.getusers();
    this.getevents();
    this.getcourses();
    this.getschedules();
    this.mostenrolled();
    this.toprated();
  },

  computed: {
    getenrolledcount() {
      return this.courses.slice().sort((a, b) => {
        return b - a;
      });
    },

    getrating() {
      return this.courses.map((item) => item.review).map((val) => val.score);
      //  .reduce((a, b) => {
      //     return Number(a.score) + Number(b.score);
      //   }, 0)
    },
    newlyCourses() {
      return this.courses.filter(
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
    getstar(val) {
      console.log("🚀 ~ file: home.vue ~ line 639 ~ getstar ~ val", val);
      return Number(val) / 5;
    },
    mostenrolled() {
      this.$http
        .get(
          `${this.$store.getters.url}/mostenrolled`,

          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.mostenrolledcourse = res.data;
          }
        });
    },
    toprated() {
      this.$http
        .get(
          `${this.$store.getters.url}/toprated`,

          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.topratedcourse = res.data;
          }
        });
    },
    sortmodules(data) {
      if (!data.courseoutline) {
        return 0;
      }
      return JSON.parse(data.courseoutline.modules).length;
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
              Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.connections = res.data;
            this.showConnect = true;
          }
        });
    },
    getcourses() {
      this.$http
        .get(`${this.$store.getters.url}/courses`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.courses = res.data;
            this.showEnrolled = true;
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
              Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.getUsersWithInterest();
            this.$toast.success("Successful");
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
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
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
    gettodos() {
      this.$http
        .get(`${this.$store.getters.url}/todos`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
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

    getusers() {
      this.$http
        .get(`${this.$store.getters.url}/facilitator-get-users`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
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
  },
};
</script>
<style scoped lang="scss">
.container {
  padding-top: 30px;
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
  background: linear-gradient(
    127.24deg,
    var(--lighter-green) 28.41%,
    #c2edce 100%
  );
}
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
@media (max-width: 600px) {
  .box {
    margin-bottom: 24px;
  }
  .admin_tab {
    min-height: 200px;
  }
}
</style>

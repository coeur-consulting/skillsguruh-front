<template>
  <div>
    <b-container fluid>
      <b-row class="pt-5">
        <b-col md="8">
          <b-row class="mb-5 mb-sm-5">
            <b-col sm="6">
              <div class="box p-3 shadow-sm">
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
                      Members
                    </div>
                  </div>
                  <div class="h2">{{ users.length }}</div>
                </div>
                <div class="w-100 px-2">
                  <div class="new_add d-flex align-items-center">
                    <activity-icon
                      size="1x"
                      class="custom-class growth"
                    ></activity-icon>
                    <span class="mr-2 mt-1 growth">
                      {{
                        Math.round((newlyusers / users.length) * 100) || 0
                      }}%</span
                    >
                    <span class="mt-1">New Members this month</span>
                  </div>
                </div>
              </div>
            </b-col>
            <b-col sm="6">
              <div class="box p-3 shadow-sm">
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
                    <activity-icon
                      size="1x"
                      class="custom-class growth"
                    ></activity-icon>
                    <span class="mr-2 mt-1 growth">
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
                <div
                  class="pr-3 fs12 font-weight-bold border-right cursor-pointer"
                  :class="courseShown == 'toprated' ? '' : 'text-muted'"
                  @click="courseShown = 'toprated'"
                >
                  Top Rated
                </div>
                <div
                  class="pl-3 fs12 font-weight-bold cursor-pointer"
                  :class="courseShown == 'mostenrolled' ? '' : 'text-muted'"
                  @click="courseShown = 'mostenrolled'"
                >
                  Most Enrolled
                </div>
              </div>
              <span
                class="fs13 cursor-pointer"
                @click="$router.push('/facilitator/courses')"
                >More <b-icon icon="arrow-right"></b-icon
              ></span>
            </div>
            <div v-if="showEnrolled">
              <div v-if="courseShown == 'mostenrolled'">
                <carousel
                  :perPage="2"
                  :scrollPerPage="true"
                  :paginationEnabled="true"
                  :spacePadding="8"
                  :perPageCustom="[
                    [600, 2],
                    [768, 3],
                  ]"
                  v-if="mostenrolledcourse.length"
                >
                  <slide
                    class="pr-3"
                    v-for="item in mostenrolledcourse.slice(0, 6)"
                    :key="item.id"
                  >
                    <div
                      class="course border"
                      @click="
                        $router.push(
                          `/member/courses?course_id=${this.course.id}`
                        )
                      "
                    >
                      <div
                        class="course_img"
                        :style="{
                          backgroundImage: `url(${
                            item.course.cover
                              ? item.course.cover
                              : require('@/assets/images/default.png')
                          })`,
                        }"
                      ></div>
                      <div class="course_text p-2 p-sm-3">
                        <div class="d-flex justify-content-between">
                          <span
                            class="
                              px-2
                              py-1
                              rounded-pill
                              text-white
                              course_badge
                            "
                            :style="{
                              backgroundColor: JSON.parse(
                                item.course.courseoutline.knowledge_areas
                              ).color,
                            }"
                          >
                            <b-icon
                              class="mr-2"
                              :icon="
                                JSON.parse(
                                  item.course.courseoutline.knowledge_areas
                                ).icon
                              "
                            ></b-icon>
                            <span>{{
                              JSON.parse(
                                item.course.courseoutline.knowledge_areas
                              ).value
                            }}</span></span
                          >
                          <span class="text-capitalize fs10">{{
                            item.course.type
                          }}</span>
                        </div>
                        <div class="pt-2 pb-1">
                          <h6
                            class="
                              overview-title
                              text-truncate text-truncate--2
                              mb-0
                            "
                          >
                            {{ item.course.title }}
                          </h6>
                          <div
                            class="
                              text-truncate text-truncate--2
                              course_description
                            "
                          >
                            {{ item.course.description }}
                          </div>
                        </div>
                        <div class="info fs12">
                          <div class="d-flex">
                            <div class="mr-3">
                              <b-icon icon="people" class="mr-1"></b-icon>
                              <span>{{ item.count }}+</span>
                            </div>
                            <div>
                              <b-icon
                                icon="star-fill"
                                style="color: gold"
                                class="mr-1"
                              ></b-icon>
                              <span
                                >{{ item.course.review.length }} reviews</span
                              >
                            </div>
                          </div>

                          <b-avatar
                            size="sm"
                            variant="light"
                            :src="item.course.cover"
                            class="course_avatar"
                          >
                          </b-avatar>
                        </div>
                      </div>
                    </div>
                  </slide>
                </carousel>

                <div v-else class="w-100 p-5 text-center text-muted">
                  <h5>No course available</h5>
                </div>
              </div>
              <div v-if="courseShown == 'toprated'">
                <carousel
                  :scrollPerPage="true"
                  :paginationEnabled="true"
                  :perPage="2"
                  :spacePadding="8"
                  :perPageCustom="[
                    [600, 2],
                    [768, 3],
                  ]"
                  class="px-sm-0"
                  v-if="topratedcourse.length"
                >
                  <slide
                    class="pr-3"
                    v-for="(item, id) in topratedcourse.slice(0, 6)"
                    :key="id"
                  >
                    <div
                      class="course border"
                      @click="$router.push('/member/courses')"
                    >
                      <div
                        class="course_img"
                        :style="{
                          backgroundImage: `url(${
                            item[1].course.cover
                              ? item[1].course.cover
                              : require('@/assets/images/default.png')
                          })`,
                        }"
                      ></div>
                      <div class="course_text p-2 p-sm-3">
                        <div class="d-flex justify-content-between">
                          <span
                            class="
                              px-2
                              py-1
                              rounded-pill
                              text-white
                              course_badge
                            "
                            :style="{
                              backgroundColor: JSON.parse(
                                item[1].course.courseoutline.knowledge_areas
                              ).color,
                            }"
                          >
                            <b-icon
                              class="mr-2"
                              :icon="
                                JSON.parse(
                                  item[1].course.courseoutline.knowledge_areas
                                ).icon
                              "
                            ></b-icon>
                            <span>{{
                              JSON.parse(
                                item[1].course.courseoutline.knowledge_areas
                              ).value
                            }}</span></span
                          >
                          <span class="text-capitalize fs10">{{
                            item[1].course.type
                          }}</span>
                        </div>
                        <div class="pt-2 pb-1">
                          <h6 class="overview-title mb-0">
                            {{ item[1].course.title }}
                          </h6>

                          <div
                            class="
                              text-truncate text-truncate--2
                              course_description
                            "
                          >
                            {{ item[1].course.description }}
                          </div>
                        </div>
                        <div class="info fs12">
                          <div class="d-flex">
                            <div class="mr-2">
                              <b-icon icon="people" class="mr-1"></b-icon>
                              <span
                                >{{
                                  item[1].enroll
                                    ? item[1].course.enroll.count
                                    : 0
                                }}+</span
                              >
                            </div>
                            <div>
                              <span class="mr-2"
                                ><b-icon
                                  icon="star-fill"
                                  style="color: gold"
                                  class="mr-1"
                                ></b-icon>
                                <span>{{ item[0].total_review }}</span></span
                              >
                              <span
                                >{{
                                  item[1].course.review.length
                                }}
                                reviews</span
                              >
                            </div>
                          </div>

                          <b-avatar
                            size="sm"
                            variant="light"
                            :src="item[1].course.cover"
                            class="course_avatar"
                          >
                          </b-avatar>
                        </div>
                      </div>
                    </div>
                  </slide>
                </carousel>

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
        </b-col>
        <b-col md="4">
          <div class="bg-white rounded text-center">
            <div class="mb-4">
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
                      <p class="fs11 mb-0 text-capitalize">
                        <span class="mr-2">
                          {{ attr.customData.type }}
                        </span>
                      </p>
                      <p class="mb-1 text-capitalize">
                        {{ attr.customData.title }}
                      </p>
                    </div>
                  </popover-row>
                </template>
              </vc-calendar>
            </div>
          </div>
          <div class="bg-white rounded p-3 mt-3 todo-card mb-5 mb-sm-2">
            <div class="mb-4">
              <Todo user="facilitator" />
            </div>
          </div>
        </b-col>
      </b-row>
      <b-row>
        <b-col sm="9">
          <div class="discussions">
            <Discussions></Discussions>
          </div>
        </b-col>
        <b-col sm="3">
          <div class="bg-light rounded p-3">
            <h6 class="mb-3 text-center">Connect with others</h6>

            <div v-if="showConnect">
              <div v-if="connections.length">
                <div
                  class="d-flex mb-3 align-items-center"
                  v-for="user in connections.slice(0, 5)"
                  :key="user.id"
                >
                  <div class="d-flex flex-1 align-items-center">
                    <b-avatar
                      size="sm"
                      :src="user.profile"
                      class="mr-2"
                    ></b-avatar>
                    <div class="text-left">
                      <div
                        class="fs13 text-capitalize text-left"
                        v-if="user.qualifications"
                        @click="$router.push(`/member/profile/f/${user.id}`)"
                      >
                        {{ user.name }}
                      </div>
                      <div
                        class="fs13 text-capitalize text-left"
                        v-else
                        @click="$router.push(`/member/profile/f/${user.id}`)"
                      >
                        {{ user.name }}
                      </div>
                    </div>
                  </div>
                  <div>
                    <b-button
                      variant="outline-dark-green"
                      size="sm"
                      class="rounded-pill fs9"
                      style="padding-top: 0.15rem; padding-bottom: 0.15rem"
                      v-if="user.qualifications"
                      @click="addconnections(user.id, 'facilitator')"
                      >Connect</b-button
                    >
                    <b-button
                      variant="outline-dark-green"
                      size="sm"
                      class="rounded-pill fs9 py-1"
                      v-else
                      @click="addconnections(user.id, 'user')"
                      >Connect</b-button
                    >
                  </div>
                </div>
              </div>
              <div v-else class="text-muted text-center p-3 fs13">
                Unavailable
              </div>
            </div>

            <div v-else>
              <div class="d-flex w-100 mb-3">
                <div class="mr-2">
                  <b-skeleton type="avatar"></b-skeleton>
                </div>
                <div class="w-100">
                  <b-skeleton animation="wave" width="85%"></b-skeleton>
                  <b-skeleton animation="wave" width="35%"></b-skeleton>
                </div>
              </div>
              <div class="d-flex w-100">
                <div class="mr-2">
                  <b-skeleton type="avatar"></b-skeleton>
                </div>
                <div class="w-100">
                  <b-skeleton animation="wave" width="85%"></b-skeleton>
                  <b-skeleton animation="wave" width="35%"></b-skeleton>
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
import { ActivityIcon } from "vue-feather-icons";
import Todo from "../Todo";
import Discussions from "./minidiscussions";
import PopoverRow from "v-calendar/lib/components/popover-row.umd.min";

// import StarRating from "vue-star-rating";
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
      connections: [],
      masks: {
        weekdays: "WWW",
      },
    };
  },

  components: {
    Discussions,
    Todo,
    ActivityIcon,
    PopoverRow,
    // StarRating,
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
    this.getsimilarusers();
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
          if (res.status == 201) {
            this.getsimilarusers();
            this.$toast.success("Connected");
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    async getsimilarusers() {
      return this.$http
        .get(`${this.$store.getters.url}/similar/users`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.connections = res.data;
            this.showConnect = true;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

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
          `${this.$store.getters.url}/identical-members`,

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
.todo-card {
  height: 280px;
  overflow-y: scroll;
}
.growth {
  color: #3cc13b;
}
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

  // box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35);
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
.course {
  position: relative;
  background: white;
  border-radius: 8px;
  overflow: hidden;
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
.main_box {
  width: 100%;
}
.rside {
  width: 100%;
  transition: 0.5s;
}
.side_box {
  position: fixed;
  top: 14%;
  right: 1%;
  text-align: left;
  transition: 0.5s;
  width: 5%;
  height: 80vh;
  z-index: 88;
}
.side_box .sided .tools {
  display: none;
}
.side_box:hover {
  width: 20%;
}
.side_box:hover ~ .rside {
  width: 73%;
}

.side_box:hover .sided .tools {
  display: block;
}
.side_box:hover .sided .tools_icons {
  display: none;
}
.sided {
  height: 100%;
  overflow: scroll;
}
@media (max-width: 600px) {
  .box {
    margin-bottom: 24px;
  }
  .admin_tab {
    min-height: 200px;
  }
  .new_add img {
    width: 30px;
  }
  .w-50 {
    width: 70% !important;
  }
  .rside {
    width: 100%;
    padding: 15px;
  }
}
</style>

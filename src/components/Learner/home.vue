<template>
  <div>
    <b-container fluid>
      <b-row class="">
        <b-col md="8">
          <div class="main_box pt-3">
            <div
              class="
                top_banner
                text-left
                p-3 p-sm-5
                rounded
                position-relative
                mb-5
              "
            >
              <h4 class="text-dark-green">
                Hello {{ $store.getters.learner.name }}
              </h4>
              <p class="w-50">
                Remember to meet at least one person, learn at least one new
                thing and teach at least one new person.
              </p>

              <b-img
                class="learner_img"
                :src="require('@/assets/images/learner.png')"
              ></b-img>
            </div>

            <div class="recommended text-left mb-5">
              <div class="d-flex align-items-center mb-3 w-100">
                <div class="d-flex flex-1">
                  <div
                    class="
                      pr-3
                      fs12
                      font-weight-bold
                      border-right
                      cursor-pointer
                    "
                    :class="courseShown == 'enrolled' ? '' : 'text-muted'"
                    @click="courseShown = 'enrolled'"
                  >
                    Enrolled Courses
                  </div>
                  <div
                    class="pl-3 fs12 font-weight-bold cursor-pointer"
                    :class="courseShown == 'recommended' ? '' : 'text-muted'"
                    @click="courseShown = 'recommended'"
                  >
                    Recommended
                  </div>
                </div>
                <span class="fs13" @click="$router.push('/learner/courses')"
                  >More <b-icon icon="arrow-right"></b-icon
                ></span>
              </div>
              <div v-if="showEnrolled">
                <div v-if="courseShown == 'recommended'">
                  <carousel
                    :scrollPerPage="true"
                    :paginationEnabled="true"
                    :perPage="1"
                    :perPageCustom="[
                      [600, 1],
                      [768, 3],
                    ]"
                    v-if="courses.length"
                  >
                    <slide
                      class="pr-sm-2"
                      v-for="item in courses.slice(0, 6)"
                      :key="item.id"
                    >
                      <div
                        class="course border cursor-pointer"
                        @click="
                          $router.push(`/learner/courses?course_id=${item.id}`)
                        "
                      >
                        <div
                          class="course_img"
                          :style="{
                            backgroundImage: `url(${
                              item.cover
                                ? item.cover
                                : require('@/assets/images/default.png')
                            })`,
                          }"
                        ></div>
                        <div class="course_text">
                          <div class="d-flex justify-content-between">
                            <span
                              class="px-2 py-1 rounded-pill text-white fs11"
                              :style="{
                                backgroundColor: JSON.parse(
                                  item.courseoutline.knowledge_areas
                                ).color,
                              }"
                            >
                              <b-icon
                                class="mr-2"
                                :icon="
                                  JSON.parse(item.courseoutline.knowledge_areas)
                                    .icon
                                "
                              ></b-icon>
                              <span>{{
                                JSON.parse(item.courseoutline.knowledge_areas)
                                  .value
                              }}</span></span
                            >
                            <span class="text-capitalize fs10">{{
                              item.type
                            }}</span>
                          </div>
                          <div class="pb-1 pt-3">
                            <h6
                              class="
                                overview-title
                                text-truncate text-truncate--2
                                mb-0
                              "
                            >
                              {{ item.title }}
                            </h6>
                            <div
                              class="fs13 text-truncate text-truncate--2"
                              v-html="item.courseoutline.overview"
                            ></div>
                          </div>
                          <div class="info fs11">
                            <div class="d-flex">
                              <div class="mr-2">
                                <b-icon icon="people" class="mr-1"></b-icon>
                                <span
                                  >{{
                                    item.enroll ? item.enroll.count : 0
                                  }}+</span
                                >
                              </div>
                              <!-- <div class="mr-3">
                              <b-icon icon="eye" class="mr-1"></b-icon>
                              <span>250+</span>
                            </div> -->
                              <div>
                                <b-icon
                                  icon="star-fill"
                                  style="color: gold"
                                  class="mr-1"
                                ></b-icon>
                                <span>{{ item.review.length }} reviews</span>
                              </div>
                            </div>

                            <b-avatar
                              size="sm"
                              variant="light"
                              :src="item.cover"
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
                <div v-if="courseShown == 'enrolled'">
                  <carousel
                    :scrollPerPage="true"
                    :paginationEnabled="true"
                    :perPage="1"
                    :perPageCustom="[
                      [600, 1],
                      [768, 3],
                    ]"
                    v-if="library.length"
                  >
                    <slide
                      class="pr-sm-2"
                      v-for="item in library.slice(0, 6)"
                      :key="item.id"
                    >
                      <b-card
                        :title="item.course.title"
                        :img-src="
                          item.course.cover
                            ? item.course.cover
                            : require('@/assets/images/default.png')
                        "
                        img-alt="Image"
                        img-top
                        tag="article"
                        class="mb-2 border"
                      >
                        <b-card-text
                          class="fs13 text-truncate text-truncate--2"
                        >
                          {{ item.course.description }}
                        </b-card-text>

                        <div class="mt-3">
                          <div class="mb-2 fs12">Your progress</div>
                          <b-progress
                            :max="100"
                            height=".8rem"
                            class="mb-3"
                            variant="dark-green"
                          >
                            <b-progress-bar
                              :value="item.progress"
                              :label="`${Math.round(item.progress)}%`"
                            ></b-progress-bar>
                          </b-progress>
                        </div>

                        <div class="">
                          <b-button
                            @click="
                              $router.push(`/learner/media/${item.course.id}`)
                            "
                            size="sm"
                            variant="lighter-green"
                            >Continue course</b-button
                          >
                        </div>
                      </b-card>
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

            <div class="discussions">
              <Discussions></Discussions>
            </div>
          </div>
        </b-col>
        <b-col md="4">
          <div class="border bg-white rounded p-3 py-5 text-center">
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
                        <span class="mr-2"> {{ attr.customData.type }} </span>
                      </p>
                      <p class="mb-1 text-capitalize">
                        {{ attr.customData.title }}
                      </p>
                    </div>
                  </popover-row>
                </template>
              </vc-calendar>
            </div>
            <div class="mb-4">
              <Todo user="learner" />
            </div>

            <div class="bg-light rounded p-3">
              <h6 class="mb-3 text-center">Connect with people</h6>

              <div v-if="showConnect">
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
                      <div class="text-left">
                        <div
                          class="
                            fs12
                            font-weight-bold
                            text-capitalize text-left
                          "
                        >
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
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import Todo from "../Todo";
import Discussions from "./minidiscussions";
import PopoverRow from "v-calendar/lib/components/popover-row.umd.min";

export default {
  data() {
    return {
      showSide: false,
      courseShown: "enrolled",
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
      library: [],
      showEnrolled: false,
      showConnect: false,
      showDiscussion: false,
    };
  },
  components: {
    Todo,
    Discussions,
    PopoverRow,
  },
  watch: {},
  created() {
    this.gettodos();
    this.getfacilitators();
    this.getusers();
    this.getevents();
    this.getcourses();
    this.getschedules();
    this.getLibrary();
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
          popover: { visibility: "hover" },
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
            this.showConnect = true;
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
    getLibrary() {
      this.$http
        .get(`${this.$store.getters.url}/libraries`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.library = res.data;
            this.showEnrolled = true;
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
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
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
            this.getUsersWithInterest();
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
.card-title {
  margin-bottom: 0.35rem;
  font-size: 0.9rem;
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
.overview {
  font-size: 13px;
  color: rgba($color: #000000, $alpha: 0.54);
  display: -webkit-box;
  line-clamp: 2;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  line-height: 1.3;
}
.card-img,
.card-img-top {
  height: 8rem;
  object-fit: cover;
}
.card-title {
  font-size: 13px;
  display: -webkit-box;
  line-clamp: 1;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  line-height: 1.3;
}
.course {
  height: 350px;
  position: relative;
  background: white;
  border-radius: 8px;
  overflow: hidden;
}
.course_img {
  height: 45%;
  width: 100%;

  border-radius: 8px;
  background-repeat: no-repeat;
  background-size: cover;
}
.course_text {
  height: 55%;
  padding: 10px;
}
.info {
  display: flex;
  justify-content: space-between;
  padding: 10px 0;
}

.main_box {
  width: 100%;
  transition: 0.5s;
}

@media (max-width: 600px) {
  .box {
    margin-bottom: 24px;
  }
  .learner_tab {
    min-height: 200px;
  }
  .learner_img {
    position: absolute;
    top: unset;
    right: 4%;
    width: 100px;
    bottom: 0;
  }
  .w-50 {
    width: 70% !important;
  }
  .main_box {
    width: 100%;
    padding: 15px;
  }
}
</style>

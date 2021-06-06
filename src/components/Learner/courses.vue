<template>
  <div>
    <b-container fluid class="pr-sm-0">
      <b-row v-if="courses.length">
        <b-col sm="8" class="my_courses">
          <div class="d-flex justify-content-between py-4">
            <div class="">
              <h4>Courses</h4>
            </div>
            <div class="text-right">
              <div class="search">
                <b-input-group class="topbar_search bg-white">
                  <b-form-input
                    placeholder="Search course name"
                    class="no-focus border-0"
                    type="search"
                    aria-label="Text input "
                    v-model="search"
                  ></b-form-input>
                  <b-input-group-append is-text>
                    <b-iconstack font-scale="1.4" class="">
                      <b-icon
                        stacked
                        icon="circle-fill"
                        variant="lighter-green"
                      ></b-icon>
                      <b-icon
                        stacked
                        icon="search"
                        scale="0.5"
                        variant="dark-green"
                      ></b-icon>
                    </b-iconstack>
                  </b-input-group-append>
                </b-input-group>
              </div>
            </div>
          </div>
          <b-row>
            <b-col
              sm="4"
              class="mb-3 side_box"
              v-for="(course, index) in courses"
              :key="index"
            >
              <div
                class="shadow-sm p-3 bg-white text-left h-100 cursor-pointer position-relative d-flex flex-column"
                @click="showcourse(course)"
              >
                <div class="ribbon text-capitalize">
                  <span>{{ course.type }}</span>
                </div>
                <div class="flex-1">
                  <!-- <b-dropdown
                    size="sm"
                    variant="transparent"
                    no-caret
                    class="no-focus dots"
                  >
                    <template #button-content>
                      <b-icon
                        icon="three-dots-vertical"
                        class="position-absolute"
                      ></b-icon>
                    </template>

                    <b-dropdown-item class="fs12" @click="edit(course)"
                      >Edit</b-dropdown-item
                    >
                    <b-dropdown-item
                      class="fs12"
                      @click="drop(course.id, index)"
                      >Delete</b-dropdown-item
                    >
                  </b-dropdown> -->

                  <b-iconstack
                    font-scale="2.5"
                    class="mr-2 mb-2"
                    v-if="course.courseoutline"
                  >
                    <b-icon
                      stacked
                      icon="circle-fill"
                      :style="`color:${
                        JSON.parse(course.courseoutline.knowledge_areas).color
                      }`"
                    ></b-icon>
                    <b-icon
                      stacked
                      :icon="
                        JSON.parse(course.courseoutline.knowledge_areas).icon
                      "
                      scale="0.5"
                      variant="light"
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
                    v-if="sortfacilitators(course).length == 1"
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
                    class="course_fac d-flex align-items-center mb-1 text-capitalize fs13"
                    v-else
                  >
                    <b-icon
                      icon="display"
                      variant="dark-green"
                      class="text-muted mr-2"
                    ></b-icon>
                    <span class="fs13"> Multiple Facilitators</span>
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

                  <div v-if="course" class="course_fac align-items-center fs13">
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
                        Math.floor(
                          getProgress(
                            course.courseoutline.modules,
                            course.modules
                          )
                        )
                      }}%</span
                    >
                  </div>
                  <b-progress
                    :value="
                      Math.floor(
                        getProgress(
                          course.courseoutline.modules,
                          course.modules
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
        </b-col>
        <b-col sm="4" class="sidebar">
          <div
            v-if="!course"
            class="h-100 d-flex align-items-center justify-content-center"
          >
            <div class="text-center w-100">
              <b-img
                class="mb-3"
                :src="require('@/assets/images/book.png')"
              ></b-img>
              <br />
              <p class="text-muted">Select a Course to see Details</p>
            </div>
          </div>

          <div class="text-left py-4 p-2 bg-white" v-if="course">
            <div class="d-flex">
              <div class="course_title d-flex mb-3 flex-1">
                <b-iconstack font-scale="2.5" class="mr-2 mb-2">
                  <b-icon
                    stacked
                    icon="circle-fill"
                    :style="`color:${
                      JSON.parse(course.courseoutline.knowledge_areas).color
                    }`"
                  ></b-icon>
                  <b-icon
                    stacked
                    :icon="
                      JSON.parse(course.courseoutline.knowledge_areas).icon
                    "
                    scale="0.5"
                    variant="light"
                  ></b-icon>
                </b-iconstack>
                <div>
                  <span class="title text-capitalize" v-if="course.title">
                    {{ course.title }}</span
                  >
                  <br />
                  <span class="course_time text-capitalize"
                    ><b-icon icon="clock" class="mr-1"></b-icon>
                    {{ course.courseoutline.duration }}</span
                  >
                </div>
              </div>

              <b-img style="width: 80px" fluid :src="course.cover"></b-img>
            </div>
            <span class="mr-2" v-if="course.type == 'free'">
              <b-button
                v-if="!checkLibrary()"
                class="mx-auto"
                size="sm"
                @click="addtolibrary(course.id)"
                variant="dark-green"
                >Add to library</b-button
              >
              <b-button
                size="sm"
                v-else
                disabled
                class="mx-auto"
                variant="dark-green"
                >Added to library</b-button
              ></span
            >
            <span class="mr-2" v-if="course.type == 'paid'">
              <b-button
                v-if="!checkLibrary()"
                class="mx-auto"
                size="sm"
                @click="addtolibrary(course.id)"
                variant="dark-green"
                >Purchase Course</b-button
              >
              <b-button
                size="sm"
                v-else
                disabled
                class="mx-auto"
                variant="dark-green"
                >Purchased</b-button
              ></span
            >

            <span class="mr-2" v-if="course.type == 'community'">
              <b-button
                v-if="checkLibrary()"
                class="mx-auto"
                size="sm"
                disabled
                variant="dark-green"
                >Added to library</b-button
              >
              <span v-else>
                <b-button
                  v-if="!checkCommunity(course.id)"
                  size="sm"
                  class="mx-auto"
                  @click="apply(course.id, course.amount)"
                  variant="dark-green"
                  >Apply for course</b-button
                >
                <b-button
                  size="sm"
                  v-else
                  disabled
                  class="mx-auto"
                  variant="dark-green"
                  >Applied</b-button
                >
              </span>
            </span>
            <div
              class="d-flex justify-content-between p-2 border-bottom mb-2 text-sm"
            >
              <span
                class="cursor-pointer d-flex align-items-center"
                :class="{ 'text-dark-green': toggleCourse == 1 }"
                @click="toggleCourse = 1"
              >
                <b-icon
                  font-scale=".5rem"
                  class="mr-1"
                  icon="circle-fill"
                ></b-icon>
                Info</span
              >
              <span
                class="cursor-pointer d-flex align-items-center"
                @click="toggleCourse = 2"
                :class="{ 'text-dark-green': toggleCourse == 2 }"
              >
                <b-icon
                  font-scale=".5rem"
                  class="mr-1"
                  icon="circle-fill"
                ></b-icon>
                Modules</span
              >
              <span
                class="cursor-pointer d-flex align-items-center"
                @click="toggleCourse = 3"
                :class="{ 'text-dark-green': toggleCourse == 3 }"
              >
                <b-icon
                  font-scale=".5rem"
                  class="mr-1"
                  icon="circle-fill"
                ></b-icon>
                General</span
              >
              <span
                class="cursor-pointer d-flex align-items-center"
                @click="toggleCourse = 4"
                :class="{ 'text-dark-green': toggleCourse == 4 }"
              >
                <b-icon
                  font-scale=".5rem"
                  class="mr-1"
                  icon="circle-fill"
                ></b-icon>
                Schedules</span
              >
            </div>

            <div v-if="toggleCourse == 1">
              <div class="mb-3 px-2">
                <h6 class="fs14">Course Access</h6>
                <p class="fs13 text-capitalize mb-1">Type: {{ course.type }}</p>
                <p class="fs13">Fee: {{ course.amount }} Referrals</p>
              </div>
              <div class="mb-3 px-2">
                <h6 class="fs14">Course Description</h6>
                <p class="fs13">
                  {{ course.description ? course.description : "None" }}
                </p>
              </div>
              <div class="mb-3 px-2">
                <h6 class="fs14 mb-1">Knowledge Area</h6>
                <p class="fs13 text-capitalize">
                  {{
                    course.courseoutline.knowledge_areas
                      ? JSON.parse(course.courseoutline.knowledge_areas).value
                      : "None"
                  }}
                </p>
              </div>

              <div class="mb-3 px-2">
                <div class="" v-if="course.courseschedule">
                  <b-row>
                    <b-col cols="6">
                      <h6 class="fs14 font-weight-bold">Start date</h6>
                      <span class="fs14">{{
                        course.courseschedule[0].start_time
                          | moment("MMM DD, YYYY")
                      }}</span>
                    </b-col>
                    <b-col cols="6">
                      <h6 class="fs14 font-weight-bold">End date</h6>
                      <span class="fs14">{{
                        course.courseschedule[0].end_time
                          | moment("MMM DD, YYYY")
                      }}</span>
                    </b-col>
                  </b-row>
                </div>
              </div>

              <div class="mb-3 px-2">
                <h6 class="fs14">Additional Information</h6>
                <p class="fs13">
                  {{
                    course.courseoutline.additional_info
                      ? course.courseoutline.additional_info
                      : "None"
                  }}
                </p>
              </div>
              <div class="mb-3 px-2">
                <h6 class="fs14">Certification</h6>
                <p class="fs13 text-capitalize">
                  <b-icon
                    :icon="
                      course.courseoutline.certification == 'yes'
                        ? 'check2-circle'
                        : 'x-circle'
                    "
                    variant="light-green"
                  ></b-icon>
                  {{ course.courseoutline.certification }}
                </p>
              </div>
              <div>
                <h6 class="mb-3 fs14 px-2">Course Files</h6>
                <div class="d-flex justify-content-between">
                  <div class="d-flex text-danger">
                    <b-img
                      class="mr-2"
                      fluid-grow
                      :src="require('@/assets/images/video.png')"
                    ></b-img>

                    <span style="line-height: 1.2">
                      <span class="fs13">
                        {{ getmediacount(course.modules, "video") }}</span
                      >
                      <br />
                      <span class="fs13">Videos</span>
                    </span>
                  </div>
                  <div class="d-flex" style="color: #f3994a">
                    <b-img
                      fluid-grow
                      class="mr-2"
                      :src="require('@/assets/images/file.png')"
                    ></b-img>

                    <span style="line-height: 1.2">
                      <span class="fs13">
                        {{ getmediacount(course.modules, "document") }}</span
                      >
                      <br />
                      <span class="fs13">Documents</span>
                    </span>
                  </div>
                  <div class="d-flex text-success">
                    <b-img
                      fluid-grow
                      class="mr-2"
                      :src="require('@/assets/images/zip.png')"
                    ></b-img>

                    <span style="line-height: 1.2">
                      <span class="fs13">
                        {{ getmediacount(course.modules, "audio") }}</span
                      >
                      <br />
                      <span class="fs13">Audios</span>
                    </span>
                  </div>
                </div>
              </div>
            </div>
            <div v-if="toggleCourse == 2" class="h-100">
              <h6 class="fs14">Course Modules</h6>

              <div
                class="accordion"
                role="tablist"
                v-if="course.modules.length"
              >
                <b-card
                  no-body
                  class="mb-4"
                  v-for="(item, id) in course.modules"
                  :key="id"
                >
                  <b-card-header
                    header-tag="header"
                    class="p-1 bg-light"
                    role="tab"
                  >
                    <div v-b-toggle="'module' + id" variant="info">
                      <b-icon
                        icon="check2-circle"
                        variant="light-green"
                      ></b-icon>
                      {{ item.module }}
                    </div>
                  </b-card-header>
                  <b-collapse
                    :id="'module' + id"
                    accordion="my-accordion"
                    role="tabpanel"
                  >
                    <b-card-body
                      v-for="(mod, index) in JSON.parse(item.modules)"
                      :key="index"
                    >
                      <b-card-text class="d-flex text-capitalize"
                        ><span class="flex-1">{{ mod.title }}</span>
                        <span>{{ mod.file_type }}</span></b-card-text
                      >
                      <h6 class="fs12 font-weight-bold mb-2">Overview</h6>
                      <b-card-text class="fs12">{{ mod.overview }}</b-card-text>
                    </b-card-body>
                  </b-collapse>
                </b-card>
              </div>
              <div class="" v-else>
                <div
                  class="text-capitalize fs14 mb-2"
                  v-for="(item, index) in JSON.parse(
                    course.courseoutline.modules
                  )"
                  :key="index"
                >
                  <b-icon icon="check2-circle" variant="light-green"></b-icon>
                  {{ item }}
                </div>
              </div>
            </div>
            <div v-if="toggleCourse == 3" class="h-100 p-2">
              <div class="mb-4">
                <h6 class="fs14 mb-3">Overview</h6>

                <p class="fs13">{{ course.courseoutline.overview }}</p>
              </div>

              <div>
                <h6 class="fs14 mb-3">Faqs</h6>

                <div class="accordion" role="tablist">
                  <b-card
                    no-body
                    class="mb-1"
                    v-for="(item, id) in JSON.parse(course.courseoutline.faqs)"
                    :key="id"
                  >
                    <b-card-header
                      header-tag="header"
                      class="p-1 bg-light"
                      role="tab"
                    >
                      <div v-b-toggle="'file' + id" variant="info" class="fs13">
                        <b-icon
                          icon="question-circle-fill"
                          class="mr-2 text-light-green"
                        ></b-icon>
                        {{ item.question }}
                      </div>
                    </b-card-header>
                    <b-collapse
                      :id="'file' + id"
                      accordion="my-accordion"
                      role="tabpanel"
                    >
                      <b-card-body>
                        <b-card-text class="px-0 fs13">
                          <b-icon
                            icon="check-circle-fill"
                            class="mr-2 text-light-green"
                          ></b-icon>
                          {{ item.answer }}</b-card-text
                        >
                      </b-card-body>
                    </b-collapse>
                  </b-card>
                </div>
              </div>
            </div>
            <div v-if="toggleCourse == 4" class="h-100 p-2">
              <h6 class="fs14 mb-3">Course Schedules</h6>
              <div>
                <b-row>
                  <b-col
                    cols="12"
                    class="mb-3 px-3 border-bottom"
                    v-for="(item, index) in course.courseschedule"
                    :key="index"
                  >
                    <div class="mb-1">
                      <span class="fs14 mr-2">Time: </span>
                      <span class="text-sm font-weight-bold">
                        {{ item.start_time | moment("LT") }}</span
                      >
                    </div>
                    <div class="mb-1">
                      <span class="fs14 mr-2">Date: </span>
                      <span class="text-sm font-weight-bold">
                        {{ item.start_time | moment("MMM DD, YYYY") }}</span
                      >
                    </div>
                    <div class="mb-1">
                      <span class="fs14 mr-2">Venue: </span>
                      <span class="text-sm font-weight-bold">
                        {{ item.venue ? item.venue : "None" }}</span
                      >
                    </div>
                    <div class="mb-1">
                      <span class="fs14 mr-2">Url: </span>
                      <span class="text-sm font-weight-bold">
                        {{ item.url ? item.url : "None" }}</span
                      >
                    </div>
                    <div>
                      <span class="fs14 mr-2">Facilitator: </span>
                      <span
                        class="text-sm font-weight-bold"
                        v-if="item.facilitator_id != null"
                        >{{
                          facilitators.find(
                            (val) => val.id == item.facilitator_id
                          ).name
                        }}</span
                      >
                      <span v-else class="text-sm">Unavailable</span>
                    </div>
                  </b-col>
                </b-row>
              </div>
            </div>
          </div>
        </b-col>
      </b-row>
      <b-row v-else>
        <b-col class="empty rounded p-5 text-center">
          <h2 class="mb-3 px-3 text-muted">No Course Available</h2>
          <b-img
            class="mb-3 px-3"
            :src="require('@/assets/images/creator.svg')"
          ></b-img>
          <p class="mb-3">
            There appears to be no course available <br />
            please create a new course by clicking the button below
          </p>
          <b-button @click="$bvModal.show('addcourse')" variant="dark-green"
            >Create new course</b-button
          >
        </b-col>
      </b-row>
    </b-container>

    <b-modal id="courselink" centered hide-footer hide-header>
      <div class="box p-5 text-center">
        <div class="mb-3 border px-4 py-2 rounded-pill d-flex text-muted">
          <b-icon icon="link45deg" font-scale="1.5rem"></b-icon>
          <b-form-input
            v-model="message"
            readonly
            class="text-align flex-1 rounded-pill no-focus"
          >
          </b-form-input>
        </div>
        <div>
          <b-button
            variant="lighter-green"
            type="button"
            v-clipboard:copy="message"
            v-clipboard:success="onCopy"
            v-clipboard:error="onError"
            class="rounded px-4"
            >Copy link</b-button
          >
        </div>
        <p>You can find your course referral link in your bonus page</p>
      </div>
    </b-modal>
  </div>
</template>
<script>
export default {
  data() {
    return {
      courses: [],
      search: "",
      course: null,
      type: 1,
      newmodule: "",
      facilitators: [],
      toggleCourse: 1,
      library: [],
      communitylink: [],
      course_link: "",
      message: "",
    };
  },
  components: {},
  mounted() {
    this.getcourses();
    this.getfacilitators();
    this.getLibrary();
    this.getCommunity();
  },
  computed: {
    filteredCourse() {
      return this.courses.filter((item) =>
        item.title.toLowerCase().includes(this.search.toLowerCase())
      );
    },
  },
  methods: {
    onCopy: function (e) {
      alert("You just copied the following text to the clipboard: " + e.text);
    },
    onError: function (e) {
      alert("Failed to copy the text to the clipboard");
      console.log(e);
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

    apply(id, amount) {
      if (!this.$store.getters.learner) {
        this.$toast.info("Login to add course");
        return;
      }
      this.$http
        .post(
          `${this.$store.getters.url}/apply-community`,
          {
            amount: amount,
            course_id: id,
          },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 201) {
            this.communitylink.push(res.data);
            this.message = `https://skillsguruh.herokuapp.com/register/?referral_type=community&referral_code=${res.data.code}`;
            this.$toast.info("Course link created");
            this.$bvModal.show("courselink");
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getCommunity() {
      this.$http
        .get(`${this.$store.getters.url}/apply-community`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.communitylink = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    addtolibrary(id) {
      if (!this.$store.getters.learner) {
        this.$toast.info("Login to add course");
        return;
      }
      this.$http
        .post(
          `${this.$store.getters.url}/libraries`,
          {
            course_id: id,
          },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 201) {
            this.library.push(res.data);
            this.$toast.success("Added to library");
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getLibrary() {
      if (!this.$store.getters.learner) {
        this.$toast.info("Login to add course");
        return;
      }

      this.$http
        .get(`${this.$store.getters.url}/libraries`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.library = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    checkCommunity() {
      if (!this.$store.getters.learner) {
        this.$toast.info("Login to add course");
        return;
      }

      var check = this.communitylink.find(
        (item) => item.course_id == this.course.id
      );

      return check;
    },

    checkLibrary() {
      if (!this.$store.getters.learner) {
        this.$toast.info("Login to add course");
        return;
      }
      if (!this.library.length) {
        return false;
      }

      var check = this.library.find(
        (item) =>
          item.user_id == this.$store.getters.learner.id &&
          item.course_id == this.course.id
      );

      return check;
    },

    getmediacount(arr, media) {
      var newarr = [];
      if (!arr.length) {
        return 0;
      }
      arr.forEach((val) => {
        JSON.parse(val.modules).forEach((item) => {
          if (item.file_type.toLowerCase() == media.toLowerCase()) {
            newarr.push(item);
          }
        });
      });

      return newarr.length;
    },
    showcourse(val) {
      this.course = val;
    },
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
    sorttimes(data) {
      if (!data.courseschedule) {
        return "Unavailable";
      }
      var schedule = data.courseschedule;
      return schedule.map((item) => {
        var res = ` ${item.day} ${this.$moment(
          new Date("2021-05-18 " + item.start_time)
        ).format("LT")}`;
        return res;
      });
    },
    getUpload(val) {
      this.detail.general.cover = val;
    },
    addschedule() {
      this.detail.schedule.push({
        day: "",
        url: "",
        start_time: "",
        end_time: "",
        facilitator_id: null,
      });
    },
    addmodule() {
      if (!this.newmodule) {
        this.$toast.info("Cannot be empty!");
        return;
      }
      this.detail.outline.modules.push(this.newmodule);
      this.newmodule = "";
    },

    addfaq() {
      this.detail.outline.faqs.push({
        question: "",
        answer: "",
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
    createcourse() {
      this.$http
        .post(`${this.$store.getters.url}/courses`, this.detail, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.$toast.success("Course created");
            this.courses.unshift(res.data);
            this.$bvModal.hide("addcourse");
            this.detail = {
              general: {
                title: "",
                code: "",
                description: "",
                cover: "",
              },
              outline: {
                overview: "",
                knowledge_area: "",
                duration: "",
                modules: [],
                faqs: [
                  {
                    question: "",
                    answer: "",
                  },
                ],
                certification: null,
                additional_info: "",
              },
              schedule: [
                {
                  type: "course",
                  event_type: "class",
                  url: "",
                  day: "",
                  start_time: "",
                  end_time: "",
                  facilitator_id: null,
                },
              ],
            };
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    edit(val) {
      this.detail = {
        general: {
          title: val.title,
          code: val.code,
          description: val.description,
          cover: val.cover,
        },
        outline: {
          overview: val.courseoutline.overview,
          knowledge_area: val.courseoutline.knowledge_areas,
          duration: val.courseoutline.duration,
          modules: JSON.parse(val.courseoutline.modules),
          faqs: JSON.parse(val.courseoutline.faqs),
          certification: val.courseoutline.certification,
          additional_info: val.courseoutline.additional_info,
        },
        schedule: val.courseschedule,
      };
      this.$bvModal.show("update");
    },
    updatecourse() {
      this.$http
        .put(
          `${this.$store.getters.url}/courses/${this.course.id}`,
          this.detail,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Update successful");
            this.$bvModal.hide("update");
            this.getcourses();
            this.type = 1;
            this.detail = {
              general: {
                title: "",
                code: "",
                description: "",
                cover: "",
              },
              outline: {
                overview: "",
                knowledge_area: "",
                duration: "",
                modules: [],
                faqs: [
                  {
                    question: "",
                    answer: "",
                  },
                ],
                certification: null,
                additional_info: "",
              },
              schedule: [
                {
                  type: "course",
                  event_type: "class",
                  url: "",
                  day: "",
                  start_time: "",
                  end_time: "",
                  facilitator_id: null,
                },
              ],
            };
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    drop(id, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/courses/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success("Removed successfully");
                this.courses.splice(index, 1);
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
.empty {
  min-height: 600px;
}
.ti {
  line-height: 1.2;
}
.sidebar {
  background-color: white;
  height: calc(100vh - 80px);
  position: fixed;
  right: 0;
  width: 25%;
}
.course_title {
  font-weight: 500;
}
.course_fac {
  font-size: 13px;
  color: rgba($color: #000000, $alpha: 0.4);
}
.course_time {
  font-size: 13px;
  color: rgba($color: #000000, $alpha: 0.4);
}
.course_modules {
  font-size: 13px;
  color: rgba($color: #000000, $alpha: 0.4);
}
p {
  color: rgba($color: #000000, $alpha: 0.54);
}
.text-sm {
  font-size: 13px;
  color: rgba($color: #000000, $alpha: 0.5);
}
.my_courses {
  height: 85vh;
  overflow: auto;
}
.addmodule {
  width: 400px;
}
.dots {
  position: absolute;
  top: 20px;
  right: 10px;
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
.search {
  width: 300px;
}
</style>

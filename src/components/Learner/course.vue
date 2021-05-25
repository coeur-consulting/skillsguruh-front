<template>
  <b-container fluid class="p-0 pb-5">
    <b-row class="main bg-white">
      <b-col
        sm="12"
        class="text-left p-4 main-bg h-100 mb-4"
        :style="{ backgroundImage: `url(${course.cover})` }"
      >
        <div
          class="course-overlay d-flex flex-column justify-content-center p-5 text-white"
        >
          <div class="course_content">
            <div class="display-4 mb-3">{{ course.title }}</div>

            <div class="fs14">
              Created {{ course.created_at | moment("ll") }}
            </div>
          </div>
        </div>
      </b-col>
      <b-col class="h-100 p-5">
        <div
          class="bg-white shadow-lg rounded text-left p-4"
          v-if="course.courseoutline"
        >
          <div class="mb-4">
            <h5 class="font-weight-bold">About this course</h5>
            <p>{{ course.description }}</p>
          </div>
          <div class="mb-4">
            <h5 class="font-weight-bold">Knowledge Area</h5>
            <p class="fs15 text-capitalize">
              {{ course.courseoutline.knowledge_areas }}
            </p>
          </div>

          <div class="mb-4">
            <h5 class="font-weight-bold">Modules</h5>
            <div class="accordion" role="tablist">
              <b-card
                no-body
                class="mb-1"
                v-for="(item, id) in course.modules"
                :key="id"
              >
                <b-card-header
                  header-tag="header"
                  class="p-1 bg-light"
                  role="tab"
                >
                  <div v-b-toggle="'module' + id" variant="info">
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
                    <b-card-text>{{ mod.overview }}</b-card-text>
                  </b-card-body>
                </b-collapse>
              </b-card>
            </div>
          </div>

          <div class="mb-4">
            <h5 class="font-weight-bold">Faqs</h5>
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
                  <div v-b-toggle="'file' + id" variant="info">
                    {{ item.question }}
                  </div>
                </b-card-header>
                <b-collapse
                  :id="'file' + id"
                  accordion="my-accordion"
                  role="tabpanel"
                >
                  <b-card-body>
                    <b-card-text>{{ item.answer }}</b-card-text>
                  </b-card-body>
                </b-collapse>
              </b-card>
            </div>
          </div>

          <div class="mb-4">
            <h5 class="font-weight-bold">Certification</h5>
            <p class="fs15 text-capitalize">
              <b-icon
                :icon="
                  course.certification == 'yes' ? 'check2-circle' : 'x-circle'
                "
                variant="light-green"
              ></b-icon>
              {{ course.courseoutline.certification }}
            </p>
          </div>
          <div class="mb-4">
            <h5 class="font-weight-bold">Additional Information</h5>
            <p>{{ course.courseoutline.additional_info }}</p>
          </div>

          <div class="mb-4 review">
            <h5 class="font-weight-bold">Course reviews</h5>
            <div>
              <b-form>
                <b-form-group>
                  <b-form-textarea class="mb-3"></b-form-textarea>
                  <b-button variant="dark-green">Post review</b-button>
                </b-form-group>
              </b-form>
            </div>

            <div class="p-2 bg-light rounded">
              <div class="border-bottom pb-3">
                <p>Great course</p>
                <div class="d-flex justify-content-between">
                  <span
                    ><b-avatar class="mr-2" size="sm"></b-avatar>
                    <span class="fs14">James John</span></span
                  >
                  <span>date</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </b-col>
    </b-row>
    <b-card
      v-if="course.courseoutline"
      :title="course.title"
      :img-src="course.cover"
      img-alt="Image"
      img-top
      tag="article"
      style="min-width: 20rem"
      class="mb-2 side_card text-left"
    >
      <b-card-text class="fs12 text-left">
        <div class="font-weight-bold">Course duration</div>
        {{ course.courseoutline.duration }}
      </b-card-text>
      <b-card-text class="fs12 text-left">
        <div class="font-weight-bold">Course Modules</div>
        <span> {{ course.modules.length }} modules</span>
      </b-card-text>

      <b-button
        v-if="!inLibrary"
        class="mx-auto"
        @click="addtolibrary"
        variant="dark-green"
        >Add to library</b-button
      >
      <b-button v-else class="mx-auto" variant="dark-green"
        >Added to library</b-button
      >
    </b-card>
  </b-container>
</template>

<script>
export default {
  data() {
    return {
      course: {},
      inLibrary: false,
    };
  },
  mounted() {
    this.getcourse();
    if (this.$store.getters.learner) {
      this.checkLibrary();
    }
  },
  methods: {
    getcourse() {
      this.$http
        .get(`${this.$store.getters.url}/get-course/${this.$route.params.id}`)
        .then((res) => {
          if (res.status == 200) {
            this.course = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    addtolibrary() {
      if (!this.$store.getters.learner) {
        this.$toast.info("Login to add course");
        return;
      }
      this.$http
        .get(
          `${this.$store.getters.url}/libraries/`,
          {
            course_id: this.$route.params.id,
          },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 201) {
            this.inLibrary = true;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    checkLibrary() {
      if (!this.$store.getters.learner) {
        this.$toast.info("Login to add course");
        return;
      }
      this.$http
        .get(`${this.$store.getters.url}/libraries/${this.$route.params.id}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            if (res.data) {
              this.inLibrary = true;
            } else {
              this.inLibrary = false;
            }
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
.course_box {
  position: absolute;
  box-shadow: 2px 5px 10px rgba(189, 231, 201, 0.35) !important;
  border-radius: 1px;
  background: white;
  top: 50%;
  transform: translateY(-50%);
  right: 8%;
  z-index: 3;
  width: 300px;
}
.course_text {
  z-index: 2;
  position: relative;
}
.course-overlay {
  position: absolute;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background: rgba(0, 0, 0, 0.5);
  z-index: 1;
}
.course_content {
  width: 50%;
}
.accordion,
.review {
  width: 60%;
}
.side_card {
  position: fixed;
  top: 10%;
  right: 10%;
  z-index: 10;
  width: 200px;
}
</style>

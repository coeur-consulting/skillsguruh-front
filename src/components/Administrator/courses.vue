<template>
  <div>
    <b-container fluid>
      <div v-if="courses.length" class="text-right p-3">
        <b-button size="lg" variant="dark-green">Create new course</b-button>
      </div>

      <b-row v-if="courses.length">
        <b-col sm="8">
          <b-row>
            <b-col sm="4">
              <div class="bg-white shadow-sm p-3 text-left">
                <b-iconstack font-scale="2.5" class="mr-3 mb-2">
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
                <div class="course_title mb-3">English Language</div>
                <div class="course_fac mb-2">
                  <b-icon icon="display" class="text-muted mr-3"></b-icon> John
                  Doe
                </div>
                <div class="course_time mb-2">
                  <b-icon icon="calendar" class="text-muted mr-3"></b-icon>
                  Monday 8:00 am
                </div>
                <div class="course_modules mb-4">
                  <b-icon icon="layers" class="text-muted mr-3"></b-icon> 15
                  Modules
                </div>

                <div class="d-flex justify-content-between">
                  <span>Progress</span><span>50%</span>
                </div>
                <b-progress
                  :value="50"
                  :max="100"
                  show-value
                  height=".8rem"
                  class="mb-3"
                  variant="dark-green"
                ></b-progress>
              </div>
            </b-col>
          </b-row>
        </b-col>
        <b-col sm="4" class="bg-white">
          <div v-if="course" class="sidebar">
            <b-img
              class="mb-3"
              :src="require('@/assets/images/book.png')"
            ></b-img>
            <p class="text-muted">Select a Course to see Details</p>
          </div>

          <div class="text-left py-4 px-3">
            <div class="course_title d-flex mb-3">
              <b-iconstack font-scale="2.5" class="mr-3 mb-2">
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
                <span class="title"> English Languauge</span> <br />
                <span class="course_time"
                  ><b-icon icon="calendar" class="mr-2"></b-icon> Monday</span
                >
              </div>
            </div>
            <div
              class="d-flex justify-content-between p-2 border-bottom mb-2 text-sm"
            >
              <span class="text-dark-green">
                <b-icon font-scale=".5rem" icon="circle-fill"></b-icon>
                Info</span
              >
              <span>Modules</span> <span>General</span>
              <span>Settings</span>
            </div>

            <div class="mb-4">
              <h6 class="fs14">Course Description</h6>
              <p class="fs13">
                Lorem, ipsum dolor sit amet consectetur adipisicing elit. Illo
                nesciunt fugit perspiciatis. Molestias, minus temporibus.
              </p>
            </div>

            <div class="d-flex justify-content-around mb-4">
              <b-col cols="4" class="border-right">
                <span class="fs14">Time</span> <br />
                <span class="text-sm"> 8:00 am</span>
              </b-col>

              <b-col cols="4" class="border-right">
                <span class="fs14">Lecturer</span> <br />
                <span class="text-sm">John Doe</span>
              </b-col>

              <b-col cols="4" class="">
                <span class="fs14">Status</span> <br />
                <span class="text-sm">Active</span>
              </b-col>
            </div>

            <div class="mb-4">
              <h6 class="fs14">Additional Information</h6>
              <p class="fs13">
                Lorem ipsum dolor sit amet consectetur adipisicing elit. Iste,
                quibusdam!
              </p>
            </div>

            <div class="mb-4">
              <div class="d-flex justify-content-between">
                <span class="fs13">Progress</span><span class="fs13">50%</span>
              </div>
              <b-progress
                :value="50"
                :max="100"
                show-value
                height=".8rem"
                class="mb-3"
                variant="dark-green"
              ></b-progress>
            </div>

            <div>
              <h6>Course Files</h6>
              <div class="d-flex justify-content-between">
                <div class="d-flex text-danger">
                  <b-img class="mr-2"></b-img>

                  <span>
                    <span class="fs13"> 10</span> <br />
                    <span class="fs13">Video Files</span>
                  </span>
                </div>
                <div class="d-flex text-info">
                  <b-img class="mr-2"></b-img>

                  <span>
                    <span class="fs13">10</span> <br />
                    <span class="fs13">Documents</span>
                  </span>
                </div>
                <div class="d-flex text-success">
                  <b-img class="mr-2"></b-img>

                  <span>
                    <span class="fs13">10</span> <br />
                    <span class="fs13">Audio Files</span>
                  </span>
                </div>
              </div>
            </div>
          </div>
        </b-col>
      </b-row>
      <b-row v-else>
        <b-col class="empty rounded p-5 text-center">
          <h2 class="mb-4">No Course Available</h2>
          <b-img
            class="mb-4"
            :src="require('@/assets/images/creator.svg')"
          ></b-img>
          <p class="mb-3">
            There appears to be no course available <br />
            please create a new course by clicking the button below
          </p>
          <b-button size="lg" variant="dark-green">Create new course</b-button>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
export default {
  data() {
    return {
      courses: [""],
      course: null,
    };
  },
};
</script>
<style scoped lang="scss">
.empty {
  min-height: 600px;
}
.sidebar {
  background-color: white;
  height: 79vh;
  display: flex;
  align-items: center;
}
.course_title {
  font-weight: 500;
}
.course_fac {
  font-size: 14px;
  color: rgba($color: #000000, $alpha: 0.4);
}
.course_time {
  font-size: 14px;
  color: rgba($color: #000000, $alpha: 0.4);
}
.course_modules {
  font-size: 14px;
  color: rgba($color: #000000, $alpha: 0.4);
}
p {
  color: rgba($color: #000000, $alpha: 0.54);
}
.text-sm {
  font-size: 13px;
  color: rgba($color: #000000, $alpha: 0.5);
}
</style>

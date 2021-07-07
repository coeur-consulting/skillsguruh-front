<template>
  <div>
    <b-container fluid>
      <b-row class="mb-3">
        <b-col class="mybg-white p-3 text-left">
          <h5>Assessments</h5>
        </b-col>
      </b-row>
      <b-row>
        <b-col sm="4" class="mb-4">
          <div
            class="
              shadow
              bg-white
              rounded
              p-3
              position-relative
              text-left
              cursor-pointer
            "
            @click="$router.push('/learner/assessment/assignment')"
          >
            <b-badge class="mybadge" variant="danger">{{ assignment }}</b-badge>
            <b-img
              :src="require('@/assets/images/ass3.png')"
              fluid-grow
              alt="assignments"
              class="mb-3"
            ></b-img>
            <div class="font-weight-bold fs15">Assignment</div>
            <p class="fs15 text-muted">View all assignments here</p>
          </div>
        </b-col>
        <b-col sm="4" class="mb-4">
          <div
            class="
              shadow
              bg-white
              rounded
              p-3
              position-relative
              text-left
              cursor-pointer
            "
            @click="$router.push('/learner/assessment/quiz')"
          >
            <b-badge class="mybadge" variant="danger">{{ quiz }}</b-badge>
            <b-img
              :src="require('@/assets/images/ass2.png')"
              alt="quiz"
              fluid-grow
              class="mb-3"
            ></b-img>
            <div class="font-weight-bold fs15">Quiz</div>
            <p class="fs15 text-muted">View all quizzes here</p>
          </div>
        </b-col>
        <b-col sm="4" class="mb-4">
          <div
            class="
              shadow
              bg-white
              rounded
              p-3
              position-relative
              text-left
              cursor-pointer
            "
            @click="$router.push('/learner/assessment/test')"
          >
            <b-badge class="mybadge" variant="danger">{{ test }}</b-badge>
            <b-img
              :src="require('@/assets/images/ass1.png')"
              alt="test"
              fluid-grow
              class="mb-3"
            ></b-img>
            <div class="font-weight-bold fs15">Test</div>
            <p class="fs15 text-muted">View all tests here</p>
          </div>
        </b-col>
        <b-col sm="4" class="mb-4">
          <div
            class="
              shadow
              bg-white
              rounded
              p-3
              position-relative
              text-left
              cursor-pointer
            "
            @click="$router.push('/learner/assessment/worksheet')"
          >
            <div class="mybadge">
              <div>
                <b-badge variant="dark-green"
                  >Submitted {{ submittedtemplate }}
                </b-badge>
              </div>

              <div>
                <b-badge variant="warning">Draft {{ drafttemplate }} </b-badge>
              </div>
            </div>

            <b-img
              :src="require('@/assets/images/ass1.png')"
              alt="templates"
              fluid-grow
              class="mb-3"
            ></b-img>
            <div class="font-weight-bold fs15">Worksheets</div>
            <p class="fs15 text-muted">View all workshets here</p>
          </div>
        </b-col>
        <b-col sm="4" class="mb-4">
          <div
            class="
              shadow
              bg-white
              rounded
              p-3
              position-relative
              text-left
              cursor-pointer
            "
            @click="$router.push('/learner/assessment/questionnaire')"
          >
            <b-badge class="mybadge" variant="danger">{{
              questionnaire
            }}</b-badge>
            <b-img
              :src="require('@/assets/images/ass2.png')"
              alt="quiz"
              fluid-grow
              class="mb-3"
            ></b-img>
            <div class="font-weight-bold fs15">Questionnaire</div>
            <p class="fs15 text-muted">View all questionnaire here</p>
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
export default {
  data() {
    return {
      assessments: [],
      myquestionnaire: [],
    };
  },
  mounted() {
    this.getLibrary();
    this.addAssessments();
    this.getQuestionnaire();
  },
  computed: {
    quiz() {
      return this.assessments.filter((item) => item.type == "quiz").length;
    },
    questionnaire() {
      return this.assessments.filter((item) => item.type == "questionnaire")
        .length;
    },
    assignment() {
      return this.assessments.filter((item) => item.type == "assignment")
        .length;
    },
    test() {
      return this.assessments.filter((item) => item.type == "test").length;
    },
    submittedtemplate() {
      return this.myquestionnaire.filter((item) => item.status == "submitted")
        .length;
    },
    drafttemplate() {
      return this.myquestionnaire.filter((item) => item.status == "draft")
        .length;
    },
  },
  methods: {
    getQuestionnaire() {
      this.$http
        .get(`${this.$store.getters.url}/answer-questionnaires`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.myquestionnaire = res.data;
          }
        });
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
            this.assessments = res.data
              .map((item) => {
                if (item.assessment) {
                  return item.assessment;
                }
              })
              .filter((item) => item);
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    addAssessments() {
      this.$http
        .get(`${this.$store.getters.url}/add/assessment`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.assessments = res.data;
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
.mybadge {
  position: absolute;
  top: 13px;
  right: 13px;
}
</style>

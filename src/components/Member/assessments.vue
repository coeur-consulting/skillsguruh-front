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
              bg-white
              rounded
              p-3
              position-relative
              text-left
              cursor-pointer
            "
            @click="$router.push('/member/assessment/quiz')"
          >
            <b-badge class="mybadge font-weight-normal fs11" variant="danger">{{
              quiz.length
            }}</b-badge>
            <b-img
              :src="require('@/assets/images/ass2.png')"
              alt="quiz"
              fluid-grow
              class="mb-3"
            ></b-img>
            <div class="font-weight-bold fs15">Quiz</div>
            <p class="fs15 text-muted">View all quizzes here</p>
            <div class="d-flex justify-content-end">
              <!-- <b-badge variant="success" class="mr-2"
                >New {{ drafttemplate }}
              </b-badge> -->

              <b-badge variant="warning" class="mr-2 font-weight-normal fs11"
                >Pending {{ activeQuiz.length - submittedQuiz }}
              </b-badge>
              <b-badge variant="dark-green" class="font-weight-normal fs11"
                >Submitted {{ submittedQuiz }}
              </b-badge>
            </div>
          </div>
        </b-col>
        <b-col sm="4" class="mb-4">
          <div
            class="
              bg-white
              rounded
              p-3
              position-relative
              text-left
              cursor-pointer
            "
            @click="$router.push('/member/assessment/test')"
          >
            <b-badge class="mybadge font-weight-normal fs11" variant="danger">{{
              test.length
            }}</b-badge>
            <b-img
              :src="require('@/assets/images/ass3.png')"
              alt="test"
              fluid-grow
              class="mb-3"
            ></b-img>
            <div class="font-weight-bold fs15">Test</div>
            <p class="fs15 text-muted">View all tests here</p>
            <div class="d-flex justify-content-end">
              <!-- <b-badge variant="success" class="mr-2"
                >New {{ worksheet }}
              </b-badge> -->

              <b-badge variant="warning" class="mr-2 font-weight-normal fs11"
                >Pending {{ activeTest.length - submittedTest }}
              </b-badge>
              <b-badge variant="dark-green" class="font-weight-normal fs11"
                >Submitted {{ submittedTest }}
              </b-badge>
            </div>
          </div>
        </b-col>
        <b-col sm="4" class="mb-4">
          <div
            class="
              bg-white
              rounded
              p-3
              position-relative
              text-left
              cursor-pointer
            "
            @click="$router.push('/member/assessment/worksheet')"
          >
            <b-badge class="mybadge font-weight-normal fs11" variant="danger">{{
              worksheet.length
            }}</b-badge>
            <b-img
              :src="require('@/assets/images/ass1.png')"
              alt="templates"
              fluid-grow
              class="mb-3"
            ></b-img>
            <div class="font-weight-bold fs15">Worksheets</div>
            <p class="fs15 text-muted">View all workshets here</p>
            <div class="d-flex justify-content-end">
              <b-badge variant="warning" class="mr-2 font-weight-normal fs11"
                >Draft {{ drafttemplate }}
              </b-badge>
              <b-badge variant="dark-green" class="font-weight-normal fs11"
                >Submitted {{ submittedtemplate }}
              </b-badge>
            </div>
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
      responses: [],
    };
  },
  mounted() {
    // this.getLibrary();
    this.addAssessments();
    this.getQuestionnaire();
    this.getResponses();
  },
  computed: {
    quiz() {
      return this.assessments.filter((item) => item.type == "quiz");
    },
    worksheet() {
      return this.assessments.filter((item) => item.type == "worksheet");
    },
    expiredQuiz() {
      return this.quiz.filter((item) =>
        this.$moment().isAfter(this.$moment(item.end))
      ).length;
    },
    activeQuiz() {
      return this.quiz.filter((item) =>
        this.$moment().isBetween(
          this.$moment(item.start),
          this.$moment(item.end)
        )
      );
    },
    submittedQuiz() {
      return this.activeQuiz.filter((item) => {
        return this.responses.map((val) => val.assessment_id).includes(item.id);
      }).length;
    },

    questionnaire() {
      return this.assessments.filter((item) => item.type == "questionnaire");
    },
    expiredQuestionnaire() {
      return this.questionnaire.filter((item) =>
        this.$moment().isAfter(this.$moment(item.end))
      ).length;
    },
    activeQuestionnaire() {
      return this.questionnaire.filter((item) =>
        this.$moment().isBetween(
          this.$moment(item.start),
          this.$moment(item.end)
        )
      );
    },
    submittedQuest() {
      return this.activeQuestionnaire.filter((item) => {
        return this.responses.map((val) => val.assessment_id).includes(item.id);
      }).length;
    },

    assignment() {
      return this.assessments.filter((item) => item.type == "assignment");
    },

    expiredAssigment() {
      return this.assignment.filter((item) =>
        this.$moment().isAfter(this.$moment(item.end))
      ).length;
    },
    activeAssignment() {
      return this.assignment.filter((item) =>
        this.$moment().isBetween(
          this.$moment(item.start),
          this.$moment(item.end)
        )
      );
    },
    submittedAssignment() {
      return this.activeAssignment.filter((item) => {
        return this.responses.map((val) => val.assessment_id).includes(item.id);
      }).length;
    },

    test() {
      return this.assessments.filter((item) => item.type == "test");
    },
    expiredTest() {
      return this.test.filter((item) =>
        this.$moment().isAfter(this.$moment(item.end))
      ).length;
    },
    activeTest() {
      return this.test.filter((item) =>
        this.$moment().isBetween(
          this.$moment(item.start),
          this.$moment(item.end)
        )
      );
    },
    submittedTest() {
      return this.activeTest.filter((item) => {
        return this.responses.map((val) => val.assessment_id).includes(item.id);
      }).length;
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
    getResponses() {
      this.$http
        .get(`${this.$store.getters.url}/assessment/responses`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.responses = res.data;
          }
        });
    },
    getQuestionnaire() {
      this.$http
        .get(`${this.$store.getters.url}/answer-questionnaires`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
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
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
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
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
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

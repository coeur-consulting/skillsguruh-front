<template>
  <div>
    <b-container fluid>
      <b-row class="mb-3">
        <b-col class="bg-white p-3 text-left">
          <h5>Assessments</h5>
        </b-col>
      </b-row>
      <b-row>
        <b-col sm="4" class="mb-5">
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
            @click="$router.push('/facilitator/assessment/quiz')"
          >
            <b-badge class="badge" variant="danger">{{ quiz }}</b-badge>
            <b-img
              :src="require('@/assets/images/ass2.png')"
              alt="quiz"
              fluid-grow
              class="mb-3"
            ></b-img>
            <div class="font-weight-bold fs15">Quiz</div>
            <p class="fs15 text-muted">Create,view and mark quizzes here</p>
          </div>
        </b-col>
        <b-col sm="4" class="mb-5">
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
            @click="$router.push('/facilitator/assessment/test')"
          >
            <b-badge class="badge" variant="danger">{{ test }}</b-badge>
            <b-img
              :src="require('@/assets/images/ass1.png')"
              alt="test"
              fluid-grow
              class="mb-3"
            ></b-img>
            <div class="font-weight-bold fs15">Test</div>
            <p class="fs15 text-muted">Create,view and mark tests here</p>
          </div>
        </b-col>

        <b-col sm="4" class="mb-5">
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
            @click="$router.push('/facilitator/assessment/worksheet')"
          >
            <b-badge class="badge" variant="danger">{{
              questionnaire
            }}</b-badge>
            <b-img
              :src="require('@/assets/images/ass3.png')"
              alt="test"
              fluid-grow
              class="mb-3"
            ></b-img>
            <div class="font-weight-bold fs15">Worksheets</div>
            <p class="fs15 text-muted">Create,view and mark worksheets here</p>
          </div>
        </b-col>
        <!-- <b-col sm="4" class="mb-5">
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
            @click="$router.push('/facilitator/assessment/template')"
          >
            <b-badge class="badge" variant="danger">{{ template }}</b-badge>
            <b-img
              :src="require('@/assets/images/ass3.png')"
              fluid-grow
              alt="assignments"
              class="mb-3"
            ></b-img>
            <div class="font-weight-bold fs15">Templates</div>
            <p class="fs15 text-muted">Create,view and mark templates here</p>
          </div>
        </b-col> -->
      </b-row>
    </b-container>
  </div>
</template>
<script>
export default {
  data() {
    return {
      assessments: [],
    };
  },
  mounted() {
    this.getAssessments();
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
    worksheet() {
      return this.assessments.filter((item) => item.type == "worksheet").length;
    },
  },
  methods: {
    getAssessments() {
      this.$http
        .get(`${this.$store.getters.url}/assessments`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.assessments = res.data;
            this.rows = res.data.length;
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
.badge {
  position: absolute;
  top: 13px;
  right: 13px;
}
</style>

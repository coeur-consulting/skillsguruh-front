<template>
  <div class="p-3 bg-white">
    <b-form @submit.prevent="submit">
      <b-container class="py-3 px-0 text-left" v-if="questionnaire.sections">
        <div class="text-left">
          <h5 class="mb-4 text-center">{{ questionnaire.title }}</h5>
        </div>
        <div>
          <div class="mb-4 border-bottom">
            <div
              class="
                bg-white
                shadow
                rounded
                mb-5
                section-box
                position-relative
                p-4
              "
            >
              <h5
                class="section-anchor px-3 py-1 bg-dark-green text-white fs12"
              >
                Section {{ section + 1 }} of
                {{ questionnaire.sections.length }}
              </h5>

              <div class="font-weight-bold mb-2 mt-2">
                {{ questionnaire.sections[section].title }}
              </div>
              <div
                v-if="questionnaire.sections[section].description"
                v-html="questionnaire.sections[section].description"
              ></div>
            </div>

            <div
              class="
                bg-white
                shadow
                rounded
                mb-4
                section-box
                position-relative
                p-4
              "
              v-for="(question, index) in questionnaire.sections[section]
                .questions"
              :key="question.title"
            >
              <div class="d-flex">
                <span class="mr-2">{{ index + 1 }}.</span>
                <b-form-group :label="question.question" class="flex-1">
                  <div class="mb-3" v-if="question.hint">
                    <em class="text-dark-green fs12"
                      ><b-icon icon="info-circle-fill"></b-icon>
                      {{ question.hint }}</em
                    >
                  </div>
                  <div class="d-flex justify-content-between">
                    <div>
                      <h6 class="mb-2">Your response</h6>
                      <div v-if="question.response">
                        <p class="text-capitalize">{{ question.response }}</p>
                      </div>

                      <div v-if="question.responses.length">
                        <ul v-for="(ite, id) in question.responses" :key="id">
                          <li class="text-capitalize">{{ item.title }}</li>
                        </ul>
                      </div>
                    </div>
                    <div>
                      <div v-if="question.asAnswer" class="mb-2">
                        <small>Correct answer</small> <br />
                        <span class="text-capitalize">{{
                          question.answer
                        }}</span>
                      </div>
                      <div v-if="question.asScore">
                        <small>Total score</small> <br />
                        <span>{{ question.score }}</span>
                      </div>
                    </div>
                  </div>
                </b-form-group>
              </div>
            </div>

            <div class="d-flex justify-content-between mt-5 my-4">
              <b-button
                size="sm"
                type="button"
                variant="outline-secondary"
                v-show="section > 0"
                @click="section--"
                >Previous Section</b-button
              >
              <b-button
                size="sm"
                type="button"
                class="ml-auto"
                variant="outline-dark-green"
                v-show="section < questionnaire.sections.length - 1"
                @click="section++"
                >Next Section</b-button
              >
              <span class="ml-auto">
                <b-button
                  size="sm"
                  class="mr-3"
                  variant="lighter-green"
                  v-show="questionnaire.sections.length - 1 == section"
                  @click="saveforlater"
                  >Save for later</b-button
                >

                <b-button
                  size="sm"
                  class=""
                  variant="dark-green"
                  v-show="questionnaire.sections.length - 1 == section"
                  type="submit"
                  >Submit</b-button
                >
              </span>
            </div>
          </div>
        </div>
      </b-container>
    </b-form>
  </div>
</template>
<script>
export default {
  props: ["id", "course_id", "module_id", "myquestionnaire"],
  data() {
    return {
      questionnaire: {
        id: null,
        module_id: null,
        module_name: "",
        course_id: null,
        course_title: null,
        title: "",
        showFeedback: false,
        feedback: "",
        showScores: false,
        sections: [
          {
            title: "",
            questions: [
              {
                fixed: false,
                question: "",
                response: "",
                responses: [],
                result: "",
                type: "short",
                limit: 2,
                options: [
                  {
                    title: "",
                  },
                ],
                showAnswer: false,
                answer: "",
                answers: [
                  {
                    title: "",
                  },
                ],
                placeholder: "",
                hint: "",
                asScore: false,
                score: 0,
              },
            ],
          },
        ],
      },
      section: 0,
      responses: [],
      score: 0,
    };
  },
  mounted() {
    this.getQuestionnaire();
  },
  watch: {
    id: "getQuestionnaire",
  },
  computed: {
    myquest() {
      return this.$props.myquestionnaire;
    },
    totalscore() {
      var arr = [];
      this.questionnaire.sections.forEach((item) => {
        arr.push(item.questions);
      });

      var newarr = arr.reduce((a, b) => {
        return a.concat(b);
      });

      var score = newarr.map((item) => {
        if (item.asAnswer) {
          return item.score;
        }
      });

      return score.reduce((a, b) => {
        return a + b;
      }, 0);
    },
  },
  methods: {
    getQuestionnaire() {
      if (this.myquest) {
        var myquest = JSON.parse(this.$props.myquestionnaire.content);

        this.questionnaire.id = myquest.id;
        this.questionnaire.module_id = this.$props.myquestionnaire.module_id;
        // this.questionnaire.module_name = myquest.module_name;
        this.questionnaire.course_id = this.$props.myquestionnaire.course_id;
        this.questionnaire.course_title = myquest.course_title;
        this.questionnaire.title = myquest.title;
        this.questionnaire.showFeedback = myquest.showFeedback;
        this.questionnaire.feedback = myquest.feedback;
        this.questionnaire.showScores = myquest.showScores;
        this.questionnaire.sections = myquest.sections;
      }
    },
    handleResponse() {
      var arr = [];
      var answers = [];
      var responses = [];
      var correct = 0;
      this.questionnaire.sections.forEach((item) => {
        arr.push(item.questions);
      });

      var newarr = arr.reduce((a, b) => {
        return a.concat(b);
      });

      var score = newarr.map((item) => {
        if (item.asAnswer) {
          if (item.type !== "checkbox" && item.type !== "multiple") {
            if (item.response == item.answer) {
              return item.score;
            }
            return 0;
          }
          if (item.type == "checkbox" || item.type == "multiple") {
            answers = item.answers.map((item) => item.title).sort();
            responses = item.responses
              .map((val) => item.options[val])
              .map((item) => item.title)
              .sort();

            correct = answers.filter((x) => responses.indexOf(x) !== -1).length;
            let score = (correct / answers.length) * item.score;
            return Math.round(score);
          }
          return 0;
        }
      });

      this.current_score = score.reduce((a, b) => {
        return a + b;
      }, 0);
    },

    addoption(index) {
      this.questionnaire.sections[this.section].questions[index].options.push({
        title: null,
      });
    },
    submit() {
      this.$bvModal.msgBoxConfirm("Are you sure?").then((response) => {
        if (response) {
          var data = {
            module_id: this.$props.module_id,
            course_id: this.$props.course_id,
            content: this.questionnaire,
            questionnaire_id: this.$props.id,
            response: this.questionnaire,
            template_id: this.$props.id,
            your_score: this.current_score,
            total_score: this.totalscore,
            status: "submitted",
          };
          this.$http
            .post(`${this.$store.getters.url}/answer-questionnaires`, data, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 201) {
                this.$emit("handleCheck");
                // this.$bvModal
                //   .msgBoxOk(
                //     "Submitted successfully, Thank you for your feedback",
                //     {
                //       noCloseOnBackdrop: true,
                //       size: "sm",
                //       buttonSize: "sm",
                //       okVariant: "dark-green",
                //       headerClass: "p-2 border-bottom-0",
                //       footerClass: "p-2 border-top-0",
                //       centered: true
                //     }
                //   )
                //   .then(() => {});
              }
            });
        }
      });
    },
    saveforlater() {
      this.$bvModal.msgBoxConfirm("Are you sure?").then((response) => {
        if (response) {
          var data = {
            module_id: this.$props.module_id,
            course_id: this.$props.course_id,
            content: this.questionnaire,
            questionnaire_id: this.$props.id,
            response: this.questionnaire,
            template_id: this.$props.id,
            your_score: this.current_score,
            total_score: this.totalscore,
            status: "draft",
          };
          this.$http
            .post(`${this.$store.getters.url}/answer-questionnaires`, data, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 201) {
                this.$emit("handleCheck");
                // this.$bvModal
                //   .msgBoxOk("Saved successfully", {
                //     noCloseOnBackdrop: true,
                //     size: "sm",
                //     buttonSize: "sm",
                //     okVariant: "dark-green",
                //     headerClass: "p-2 border-bottom-0",
                //     footerClass: "p-2 border-top-0",
                //     centered: true,
                //   })
                //   .then(() => {});
              }
            });
        }
      });
    },
  },
};
</script>
<style scoped>
.content {
  min-height: 400px;
  overflow-y: auto;
}
.section-anchor {
  position: absolute;
  top: 0;
  left: 0;
}
.section-box {
  border-left: 4px solid var(--dark-green);
  overflow: hidden;
}
.ber {
  overflow-y: auto;
  max-height: 90vh;
}
</style>

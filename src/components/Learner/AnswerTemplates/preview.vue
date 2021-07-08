<template>
  <div>
    <b-container
      class="py-3 px-0 text-left"
      v-if="questionnaire.sections.length"
    >
      <div class="d-flex justify-content-between">
        <h5 class="mb-4 text-center">{{ questionnaire.title }}</h5>
        <div>
          <p class="mb-1 text-muted fs12">Your Score : {{ your_score }}</p>
          <p class="text-muted fs12">Total Score : {{ total_score }}</p>
        </div>
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
            <h5 class="section-anchor px-3 py-1 bg-dark-green text-white fs12">
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
                <div
                  class="d-flex justify-content-between align-items-start fs14"
                >
                  <b-col cols="8">
                    <h6 class="mb-2 fs13">Your response</h6>
                    <div v-if="question.response">
                      <p class="text-capitalize">{{ question.response }}</p>
                    </div>

                    <div v-if="question.responses.length">
                      <ul class="">
                        <li
                          class="text-capitalize"
                          v-for="(ite, id) in question.responses"
                          :key="id"
                        >
                          {{ question.options[ite].value }}
                        </li>
                      </ul>
                    </div>
                    <div v-if="question.score" class="text-muted fs13">
                      <small>Your score</small> <br />
                      <span>{{ question.result }}</span>
                    </div>
                    <div v-if="question.addSubQuestion">
                      <div
                        v-for="(subquest, subId) in question.subQuestion"
                        :key="subId"
                      >
                        <b-form-group :label="subquest.question" class="flex-1">
                          <div
                            class="
                              d-flex
                              justify-content-between
                              align-items-start
                              fs14
                            "
                          >
                            <b-col cols="8">
                              <h6 class="mb-2 fs13">Your response</h6>
                              <div v-if="subquest.response">
                                <p class="text-capitalize">
                                  {{ subquest.response }}
                                </p>
                              </div>

                              <div v-if="subquest.responses.length">
                                <ul class="">
                                  <li
                                    class="text-capitalize"
                                    v-for="(ite, id) in subquest.responses"
                                    :key="id"
                                  >
                                    {{ subquest.options[ite].value }}
                                  </li>
                                </ul>
                              </div>
                              <div
                                v-if="subquest.score"
                                class="text-muted fs13"
                              >
                                <small>Your score</small> <br />
                                <span>{{ subquest.result }}</span>
                              </div>
                            </b-col>
                            <b-col cols="4">
                              <div
                                v-if="
                                  question.type == 'single' ||
                                  question.type == 'checkbox'
                                "
                                class="mb-2"
                              >
                                <div class="text-muted fs13">
                                  <span>Correct answer</span> <br />
                                  <ul class="pl-0 ml-0">
                                    <li
                                      class="text-capitalize"
                                      v-for="(ite, id) in subquest.answers"
                                      :key="id"
                                    >
                                      {{ ite.value }}
                                    </li>
                                  </ul>
                                </div>
                              </div>
                              <div
                                v-if="question.score"
                                class="text-muted fs13"
                              >
                                <small>Total score</small> <br />
                                <span>{{ question.score }}</span>
                              </div>
                            </b-col>
                          </div>
                        </b-form-group>
                      </div>
                    </div>
                  </b-col>
                  <b-col cols="4">
                    <div
                      v-if="
                        question.type == 'single' || question.type == 'checkbox'
                      "
                      class="mb-2"
                    >
                      <div class="text-muted fs13">
                        <span>Correct answer</span> <br />
                        <ul class="pl-0 ml-0">
                          <li
                            class="text-capitalize"
                            v-for="(ite, id) in question.answers"
                            :key="id"
                          >
                            {{ ite.value }}
                          </li>
                        </ul>
                      </div>
                    </div>
                    <div v-if="question.score" class="text-muted fs13">
                      <small>Total score</small> <br />
                      <span>{{ question.score }}</span>
                    </div>
                  </b-col>
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
              <!-- <b-button
                  size="sm"
                  class="mr-3"
                  variant="lighter-green"
                  v-show="questionnaire.sections.length - 1 == section"
                  @click="saveforlater"
                  >Save for later</b-button
                > -->

              <!-- <b-button
                  size="sm"
                  class=""
                  variant="dark-green"
                  v-show="questionnaire.sections.length - 1 == section"
                  type="submit"
                  >Submit</b-button
                > -->
            </span>
          </div>
        </div>
      </div>
    </b-container>
  </div>
</template>
<script>
export default {
  props: ["questionnaire", "total_score", "your_score"],
  data() {
    return {
      showcalc: false,
      section: 0,
      responses: [],
      score: 0,
      question_num: 0,
      current_score: 0,
    };
  },

  computed: {
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
    startCallBack: function (x) {
      console.log(x);
    },
    endCallBack: function (x) {
      console.log(x);
    },
    warning() {
      this.$toast.error("Do not reload");
      return "";
    },
    changeSection() {
      this.question_num = 0;
      this.section++;
    },
    getQuestionnaire() {
      this.$http
        .get(
          `${this.$store.getters.url}/assessment/responses/${this.$route.params.id}`,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.questionnaire.id = res.data.id;
            this.questionnaire.module_id = res.data.module_id;
            this.questionnaire.module_name = res.data.module_name;
            this.questionnaire.course_id = res.data.course_id;
            this.questionnaire.course_title = res.data.course_title;
            this.questionnaire.title = res.data.title;
            this.questionnaire.showFeedback = res.data.showFeedback;
            this.questionnaire.feedback = res.data.feedback;
            this.questionnaire.showScores = res.data.showScores;
            this.questionnaire.sections = JSON.parse(res.data.sections);
          }
        });
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
          if (item.type !== "checkbox") {
            if (item.response == item.answer) {
              return item.score;
            }
            return 0;
          }
          if (item.type == "checkbox") {
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
            response: this.questionnaire,
            template_id: this.$route.params.id,
            your_score: this.current_score,
            total_score: this.totalscore,
          };
          this.$http
            .post(`${this.$store.getters.url}/question/responses`, data, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 201) {
                this.$emit("handleCheck");
                this.$bvModal
                  .msgBoxOk(
                    "Questionnaire was submitted successfully, Thank you for your feedback",
                    {
                      noCloseOnBackdrop: true,
                      size: "sm",
                      buttonSize: "sm",
                      okVariant: "dark-green",
                      headerClass: "p-2 border-bottom-0",
                      footerClass: "p-2 border-top-0",
                      centered: true,
                    }
                  )
                  .then(() => {});
              }
            });
        }
      });
    },
  },
};
</script>

<style scoped>
.calc {
  position: fixed;
  bottom: 0;
  right: 20px;
  z-index: 99;
}
.arrow_directions {
  position: absolute;
  right: 10px;
  bottom: 10px;
}
.score {
  font-size: 20px;
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

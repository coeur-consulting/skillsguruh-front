<template>
  <div>
    <b-form @submit.prevent="submit" id="form">
      <b-container
        class="py-3 px-0 text-left"
        v-if="questionnaire.sections.length"
      >
        <h5 class="mb-4 text-capitalize">{{ questionnaire.title }}</h5>
        <b-row>
          <b-col sm="10">
            <div class="mb-4 border-bottom">
              <div class="shadow rounded bg-white section-box mb-5 p-3">
                <h6 class="font-weight-bold mb-3">
                  {{ questionnaire.sections[section].title }}
                </h6>
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
                  p-4
                  position-relative
                  border-left-green
                "
              >
                <b-form-group
                  :label="
                    questionnaire.sections[section].questions[question_num]
                      .question
                  "
                >
                  <div
                    class="mb-3"
                    v-if="
                      questionnaire.sections[section].questions[question_num]
                        .hint
                    "
                  >
                    <em class="text-dark-green fs12"
                      ><b-icon icon="info-circle-fill"></b-icon>
                      {{
                        questionnaire.sections[section].questions[question_num]
                          .hint
                      }}</em
                    >
                  </div>
                  <div
                    v-if="
                      questionnaire.sections[section].questions[question_num]
                        .type == 'short'
                    "
                  >
                    <b-form-input
                      @change="handleResponse()"
                      v-model="
                        questionnaire.sections[section].questions[question_num]
                          .response
                      "
                      :placeholder="
                        questionnaire.sections[section].questions[question_num]
                          .placeholder
                      "
                    ></b-form-input>
                  </div>
                  <div
                    v-if="
                      questionnaire.sections[section].questions[question_num]
                        .type == 'long'
                    "
                  >
                    <b-form-textarea
                      @change="handleResponse()"
                      v-model="
                        questionnaire.sections[section].questions[question_num]
                          .response
                      "
                      :placeholder="
                        questionnaire.sections[section].questions[question_num]
                          .placeholder
                      "
                    ></b-form-textarea>
                  </div>

                  <div
                    v-if="
                      questionnaire.sections[section].questions[question_num]
                        .type == 'single'
                    "
                  >
                    <b-form-row>
                      <b-col
                        sm="5"
                        v-for="(item, indx) in questionnaire.sections[section]
                          .questions[question_num].options"
                        :key="indx"
                      >
                        <b-form-radio
                          :disabled="
                            questionnaire.sections[section].questions[
                              question_num
                            ].response != null
                          "
                          class="text-capitalize mb-2"
                          size="sm"
                          v-model="
                            questionnaire.sections[section].questions[
                              question_num
                            ].response
                          "
                          @change="handleResponse()"
                          :value="item.value"
                          >{{ item.value }}
                          <b-icon
                            v-if="
                              questionnaire.sections[section].questions[
                                question_num
                              ].response
                            "
                            :icon="
                              questionnaire.sections[section].questions[
                                question_num
                              ].answers
                                .map((t) => t.value.toLowerCase())
                                .includes(item.value.toLowerCase())
                                ? 'check2-circle'
                                : 'x'
                            "
                            :class="
                              questionnaire.sections[section].questions[
                                question_num
                              ].answers
                                .map((t) => t.value.toLowerCase())
                                .includes(item.value.toLowerCase())
                                ? 'text-dark-green'
                                : 'text-danger'
                            "
                          ></b-icon
                        ></b-form-radio>
                      </b-col>
                    </b-form-row>
                  </div>
                  <div
                    v-if="
                      questionnaire.sections[section].questions[question_num]
                        .type == 'multiple'
                    "
                  >
                    <div
                      v-for="(item, id) in questionnaire.sections[section]
                        .questions[question_num].options"
                      :key="id"
                      class="d-flex align-items-center mb-1"
                    >
                      <b-form-input
                        v-model="item.value"
                        :placeholder="
                          questionnaire.sections[section].questions[
                            question_num
                          ].placeholder
                        "
                      ></b-form-input>
                      <b-button-group>
                        <b-button
                          v-if="
                            questionnaire.sections[section].questions[index]
                              .options.length > 1
                          "
                          @click="
                            questionnaire.sections[section].questions[
                              index
                            ].options.splice(id, 1)
                          "
                        >
                          <b-icon icon="x"></b-icon
                        ></b-button>
                        <b-button
                          variant="lighter-green"
                          @click="addoption(index)"
                        >
                          <b-icon icon="plus"></b-icon
                        ></b-button>
                      </b-button-group>
                    </div>
                  </div>
                  <div
                    v-if="
                      questionnaire.sections[section].questions[question_num]
                        .type == 'checkbox'
                    "
                  >
                    <div>
                      <b-form-row>
                        <b-col
                          sm="5"
                          v-for="(item, indx) in questionnaire.sections[section]
                            .questions[question_num].options"
                          :key="indx"
                        >
                          <b-form-checkbox
                            class="text-capitalize mb-2"
                            size="sm"
                            v-model="
                              questionnaire.sections[section].questions[
                                question_num
                              ].responses
                            "
                            @change="handleResponse()"
                            :value="item.value"
                            >{{ item.value }}</b-form-checkbox
                          >
                        </b-col>
                      </b-form-row>
                    </div>
                  </div>

                  <div
                    v-if="
                      questionnaire.sections[section].questions[question_num]
                        .type == 'boolean'
                    "
                  >
                    <b-form-radio
                      @change="handleResponse()"
                      v-model="
                        questionnaire.sections[section].questions[question_num]
                          .response
                      "
                      value="true"
                      >True</b-form-radio
                    >
                    <b-form-radio
                      @change="handleResponse()"
                      v-model="
                        questionnaire.sections[section].questions[question_num]
                          .response
                      "
                      value="false"
                      >False</b-form-radio
                    >
                  </div>
                </b-form-group>

                <div class="arrow_directions">
                  <b-button-group size="sm">
                    <b-button
                      :disabled="question_num == 0"
                      @click="question_num--"
                      ><b-icon icon="arrow-left"></b-icon> Prev</b-button
                    >
                    <b-button
                      :disabled="
                        question_num + 1 ==
                        questionnaire.sections[section].questions.length
                      "
                      variant="lighter-green"
                      @click="question_num++"
                      >Next <b-icon icon="arrow-right"></b-icon
                    ></b-button>
                  </b-button-group>
                </div>
              </div>

              <div
                class="d-flex justify-content-between my-4"
                v-if="
                  questionnaire.sections.length > 1 &&
                  question_num + 1 ==
                    questionnaire.sections[section].questions.length
                "
              >
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
                  @click="changeSection"
                  >Next Section</b-button
                >
                <b-button
                  size="sm"
                  class="ml-auto"
                  variant="dark-green"
                  v-show="questionnaire.sections.length - 1 == section"
                  type="submit"
                  >Submit</b-button
                >
              </div>
            </div>
          </b-col>
          <b-col sm="2">
            <div class="text-center p-3 bg-white shadow rounded">
              <vue-countdown-timer
                class="mb-4"
                @start_callback="startCallBack('event started')"
                @end_callback="endCallBack('event ended')"
                :start-time="'2018-10-10 00:00:00'"
                :end-time="1481450115"
                :interval="1000"
                :start-label="'Until start:'"
                :end-label="'Until end:'"
                label-position="begin"
                :end-text="'Event ended!'"
                :day-txt="'days'"
                :hour-txt="'hours'"
                :minutes-txt="'minutes'"
                :seconds-txt="'seconds'"
              >
              </vue-countdown-timer>

              <div class="text-dark-green score">
                <span class="text-muted fs14">Your score </span> <br />
                {{ current_score }} / {{ totalscore }}
              </div>
            </div>
          </b-col>
        </b-row>
      </b-container>
    </b-form>
  </div>
</template>
<script>
export default {
  data() {
    return {
      showcalc: false,
      assessment: {},
      questionnaire: {
        id: null,
        sections: [],
        title: null,
        course_id: null,
        course_title: null,
      },
      section: 0,
      responses: [],
      score: 0,
      question_num: 0,
      current_score: 0,
    };
  },
  components: {},
  mounted() {
    this.getQuestionnaire();
    // window.addEventListener("beforeunload", this.warning);
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
        return item.score;
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
          `${this.$store.getters.url}/assessments/${this.$route.params.id}`,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.assessment = res.data;
            this.questionnaire.id = res.data.questiontemplate.id;
            this.questionnaire.module_id = res.data.questiontemplate.module_id;
            this.questionnaire.course_id = res.data.questiontemplate.course_id;
            this.questionnaire.course_title =
              res.data.questiontemplate.course_title;
            this.questionnaire.title = res.data.questiontemplate.title;
            this.questionnaire.sections = JSON.parse(
              res.data.questiontemplate.sections
            );
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
        if (item.type == "single") {
          answers = item.answers.map((item) => item.value.toLowerCase()).sort();
          console.log(answers);
          if (answers.includes(item.response.toLowerCase())) {
            item.result = item.score;
            return item.result;
          }
          return 0;
        }
        if (item.type == "checkbox") {
          answers = item.answers.map((item) => item.value).sort();
          responses = item.responses
            .map((val) => item.options[val])
            .map((item) => item.value)
            .sort();

          correct = answers.filter((x) => responses.indexOf(x) !== -1).length;
          let score = (correct / answers.length) * item.score;
          item.result = Math.round(score);
          return item.result;
        }
        return 0;
      });
      console.log(score);
      this.current_score = score.reduce((a, b) => {
        return a + b;
      }, 0);
    },
    addoption(index) {
      this.questionnaire.sections[this.section].questions[index].options.push({
        value: null,
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
            .post(`${this.$store.getters.url}/assessment/responses`, data, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 201) {
                this.$emit("handleCheck");
                this.$bvModal
                  .msgBoxOk("Assessment was submitted successfully", {
                    noCloseOnBackdrop: true,
                    size: "sm",
                    buttonSize: "sm",
                    okVariant: "dark-green",
                    headerClass: "p-2 border-bottom-0",
                    footerClass: "p-2 border-top-0",
                    centered: true,
                  })
                  .then(() => {
                    this.$router.go("-1");
                  });
              }
            });
        }
      });
    },
  },
};
</script>

<style scoped>
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
</style>

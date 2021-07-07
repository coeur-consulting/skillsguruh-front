<template>
  <div class="bg-light">
    <b-form @submit.prevent="submit">
      <b-container
        class="py-3 px-0 text-left"
        v-if="questionnaire.sections.length"
      >
        <b-row>
          <b-col sm="10" class="ber">
            <div class="text-center">
              <h5 class="mb-4 text-capitalize">{{ questionnaire.title }}</h5>
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
                    class="
                      section-anchor
                      px-3
                      py-1
                      bg-dark-green
                      text-white
                      fs12
                    "
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
                      <div
                        v-if="
                          (question.type == 'short' ||
                            question.type == 'long') &&
                          !question.addSubQuestion
                        "
                      >
                        <div
                          v-for="(place, idp) in question.placeholders"
                          :key="idp"
                        >
                          <b-form-input
                            v-if="question.type == 'short'"
                            @change="handleResponse"
                            v-model="place.response"
                            class="mb-1"
                            size="sm"
                            :placeholder="place.placeholder"
                          ></b-form-input>
                          <b-form-textarea
                            @change="handleResponse"
                            v-model="place.response"
                            v-if="question.type == 'long'"
                            class="mb-1"
                            :placeholder="place.placeholder"
                          ></b-form-textarea>
                        </div>
                      </div>

                      <div v-if="question.type == 'single'">
                        <b-form-radio-group
                          v-model="question.response"
                          @change="handleResponse"
                          size="sm"
                          v-if="question.options[0].value"
                          :options="question.options"
                          value-field="value"
                          text-field="value"
                        ></b-form-radio-group>
                      </div>

                      <div v-if="question.type == 'checkbox'">
                        <div v-if="question.options[0].value">
                          <b-form-checkbox
                            @change="handleResponse"
                            v-model="question.responses"
                            size="sm"
                            v-for="(item, index) in question.options"
                            :key="index"
                            :value="index"
                            :disabled="
                              question.responses.length > question.limit - 1 &&
                              question.responses.indexOf(index) === -1
                            "
                            inline
                          >
                            {{ item.value }}
                          </b-form-checkbox>
                        </div>
                      </div>

                      <div v-if="question.type == 'dropdown'">
                        <b-form-select
                          v-model="question.response"
                          @change="handleResponse"
                          v-if="question.options[0].value"
                        >
                          <b-form-select-option
                            v-for="option in question.options"
                            :key="option.value"
                            :value="option.value"
                            >{{ option.value }}</b-form-select-option
                          >
                        </b-form-select>
                      </div>

                      <div v-if="question.type == 'range'">
                        <b-form-input
                          v-model="question.response"
                          @change="handleResponse"
                          type="range"
                          min="0"
                          max="10"
                        ></b-form-input>
                      </div>
                      <div v-if="question.type == 'email'">
                        <b-form-input
                          v-model="question.response"
                          @change="handleResponse"
                          type="email"
                        ></b-form-input>
                      </div>
                      <div v-if="question.type == 'number'">
                        <b-form-input
                          v-model="question.response"
                          @change="handleResponse"
                          type="number"
                        ></b-form-input>
                      </div>
                      <div v-if="question.type == 'time'">
                        <b-form-input
                          v-model="question.response"
                          @change="handleResponse"
                          type="time"
                        ></b-form-input>
                      </div>
                      <div v-if="question.type == 'date'">
                        <b-form-input
                          v-model="question.response"
                          @change="handleResponse"
                          type="date"
                        ></b-form-input>
                      </div>
                      <div v-if="question.type == 'color'">
                        <b-form-input
                          v-model="question.response"
                          @change="handleResponse"
                          type="color"
                        ></b-form-input>
                      </div>

                      <div v-if="question.addSubQuestion" class="mt-2">
                        <ol class="subquest">
                          <li
                            v-for="(subquest, subId) in question.subQuestion"
                            :key="subId"
                          >
                            <b-form-group :label="subquest.question">
                              <div
                                v-if="
                                  question.type == 'short' ||
                                  question.type == 'long'
                                "
                              >
                                <div
                                  v-for="(place, idp) in subquest.placeholders"
                                  :key="idp"
                                >
                                  <b-form-input
                                    v-model="place.response"
                                    @change="handleResponse"
                                    v-if="question.type == 'short'"
                                    class="mb-1"
                                    size="sm"
                                    :placeholder="place.placeholder"
                                  ></b-form-input>
                                  <b-form-textarea
                                    v-model="place.responses"
                                    @change="handleResponse"
                                    v-if="question.type == 'long'"
                                    class="mb-1"
                                    :placeholder="place.placeholder"
                                  ></b-form-textarea>
                                </div>
                              </div>

                              <div v-if="question.type == 'single'">
                                <b-form-radio-group
                                  @change="handleResponse"
                                  v-if="subquest.options[0].value"
                                  size="sm"
                                  v-model="subquest.response"
                                  :options="subquest.options"
                                  value-field="value"
                                  text-field="value"
                                ></b-form-radio-group>
                              </div>

                              <div v-if="question.type == 'checkbox'">
                                <div v-if="subquest.options[0].value">
                                  <b-form-checkbox
                                    @change="handleResponse"
                                    v-model="subquest.responses"
                                    size="sm"
                                    v-for="(item, index) in subquest.options"
                                    :key="index"
                                    :value="index"
                                    :disabled="
                                      subquest.responses.length >
                                        subquest.limit - 1 &&
                                      subquest.responses.indexOf(index) === -1
                                    "
                                    inline
                                  >
                                    {{ item.value }}
                                  </b-form-checkbox>
                                </div>
                              </div>

                              <div v-if="question.type == 'dropdown'">
                                <b-form-select
                                  v-model="subquest.response"
                                  @change="handleResponse"
                                  v-if="subquest.options[0].value"
                                >
                                  <b-form-select-option
                                    v-for="option in subquest.options"
                                    :key="option.value"
                                    :value="option.value"
                                    >{{ option.value }}</b-form-select-option
                                  >
                                </b-form-select>
                              </div>

                              <div v-if="question.type == 'range'">
                                <b-form-input
                                  v-model="subquest.response"
                                  @change="handleResponse"
                                  type="range"
                                  min="0"
                                  max="10"
                                ></b-form-input>
                              </div>
                              <div v-if="question.type == 'email'">
                                <b-form-input
                                  v-model="subquest.response"
                                  @change="handleResponse"
                                  type="email"
                                ></b-form-input>
                              </div>
                              <div v-if="question.type == 'number'">
                                <b-form-input
                                  v-model="subquest.response"
                                  @change="handleResponse"
                                  type="number"
                                ></b-form-input>
                              </div>
                              <div v-if="question.type == 'time'">
                                <b-form-input
                                  v-model="subquest.response"
                                  @change="handleResponse"
                                  type="time"
                                ></b-form-input>
                              </div>
                              <div v-if="question.type == 'date'">
                                <b-form-input
                                  v-model="subquest.response"
                                  @change="handleResponse"
                                  type="date"
                                ></b-form-input>
                              </div>
                              <div v-if="question.type == 'color'">
                                <b-form-input
                                  v-model="subquest.response"
                                  @change="handleResponse"
                                  type="color"
                                ></b-form-input>
                              </div>
                            </b-form-group>
                          </li>
                        </ol>
                      </div>
                    </b-form-group>
                  </div>
                </div>

                <div class="d-flex justify-content-between my-4">
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
                  <b-button
                    size="sm"
                    class="ml-auto"
                    variant="outline-dark-green"
                    v-show="questionnaire.sections.length - 1 == section"
                    type="submit"
                    >Submit</b-button
                  >
                </div>
              </div>
            </div>
          </b-col>
          <b-col sm="2">
            <div class="mt-5 bg-white shadow p-3 rounded text-center">
              <div class="fs12 mb-3" v-if="assessment.duration">
                <span>Time remaining</span> <br />
                <vue-countdown-timer
                  class="mb-4 fs13"
                  @start_callback="startCallBack('event started')"
                  @end_callback="endCallBack('event ended')"
                  :start-time="$moment()"
                  :end-time="$moment().add(assessment.duration, 'minutes')"
                  :interval="1000"
                  label-position=""
                  :end-text="'Event ended!'"
                  :day-text="null"
                  :hour-txt="':'"
                  :minutes-txt="':'"
                  :seconds-txt="''"
                >
                </vue-countdown-timer>
              </div>
              <div class="mb-3" v-if="assessment.showcalc">
                <b-icon
                  class="cursor-pointer"
                  @click="showcalc = !showcalc"
                  icon="calculator-fill"
                  font-scale="1.4"
                ></b-icon>
              </div>
              <!-- <div class="mb-3">
                <b-icon
                  font-scale="1.4"
                  class="cursor-pointer"
                  icon="clipboard"
                ></b-icon>
              </div> -->
              <Calculator
                v-show="showcalc"
                class="calc animate__animated animate__slideInUp"
              />
            </div>
          </b-col>
        </b-row>
      </b-container>
    </b-form>
  </div>
</template>
<script>
import Calculator from "@/components/Calculator/calculator";
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
  components: {
    Calculator,
  },
  created() {
    this.getQuestionnaire();
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

      return (
        score.reduce((a, b) => {
          return a + b;
        }, 0) || 0
      );
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
      console.log(newarr);
      var score = newarr.map((item) => {
        if (item.type !== "checkbox") {
          if (item.response == item.answer) {
            item.result = item.score;
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
          item.result = Math.round(score);
          return Math.round(score);
        }
        return 0;
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
            assessment_id: this.$route.params.id,
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
                  .msgBoxOk("Submitted successfullY", {
                    noCloseOnBackdrop: true,
                    size: "sm",
                    buttonSize: "sm",
                    okVariant: "dark-green",
                    headerClass: "p-2 border-bottom-0",
                    footerClass: "p-2 border-top-0",
                    centered: true,
                  })
                  .then(() => {
                    this.$router.push("/learner/assessments");
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

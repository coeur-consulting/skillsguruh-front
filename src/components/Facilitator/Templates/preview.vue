<template>
  <div>
    <b-container class="py-3 px-0 text-left" v-if="questionnaire.sections">
      <b-row>
        <b-col class="ber">
          <div class="text-left">
            <h5 class="mb-4">{{ questionnaire.title }}</h5>
            <div>
              <em class="text-lighter-green fs11">{{ questionnaire.hint }}</em>
            </div>
          </div>
          <div>
            <div class="mb-4 border-bottom">
              <div
                class="
                  bg-white
                  shadow-sm
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
                  shadow-sm
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
                    <div v-if="question.type == 'short'">
                      <b-form-input
                        v-model="question.response"
                        :placeholder="question.placeholder"
                      ></b-form-input>
                    </div>
                    <div v-if="question.type == 'long'">
                      <b-form-textarea
                        v-model="question.response"
                        :placeholder="question.placeholder"
                      ></b-form-textarea>
                    </div>

                    <div v-if="question.type == 'single'">
                      <b-form-radio-group
                        size="sm"
                        v-model="question.response"
                        :options="question.options"
                        value-field="title"
                        text-field="title"
                      ></b-form-radio-group>
                    </div>
                    <div v-if="question.type == 'multiple'">
                      <div
                        v-for="(item, id) in question.options"
                        :key="id"
                        class="d-flex align-items-center mb-1"
                      >
                        <b-form-input
                          v-model="item.title"
                          :placeholder="question.placeholder"
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
                    <div v-if="question.type == 'checkbox'">
                      <div>
                        <b-form-checkbox
                          size="sm"
                          v-for="(item, index) in question.options"
                          :key="index"
                          :value="index"
                          v-model="question.responses"
                          :disabled="
                            question.responses.length > question.limit &&
                            question.responses.indexOf(index) === -1
                          "
                          inline
                        >
                          {{ item.title }}
                        </b-form-checkbox>
                      </div>
                    </div>

                    <div v-if="question.type == 'boolean'">
                      <b-form-radio
                        size="sm"
                        v-model="question.response"
                        value="true"
                        >True</b-form-radio
                      >
                      <b-form-radio
                        size="sm"
                        v-model="question.response"
                        value="false"
                        >False</b-form-radio
                      >
                    </div>

                    <div v-if="question.type == 'dropdown'">
                      <b-form-select v-model="question.response">
                        <b-form-select-option
                          v-for="option in question.options"
                          :key="option.title"
                          :value="option.title"
                          >{{ option.title }}</b-form-select-option
                        >
                      </b-form-select>
                    </div>

                    <div v-if="question.type == 'range'">
                      <b-form-input
                        type="range"
                        v-model="question.response"
                        min="0"
                        max="10"
                      ></b-form-input>
                    </div>
                    <div v-if="question.type == 'email'">
                      <b-form-input
                        v-model="question.response"
                        type="email"
                      ></b-form-input>
                    </div>
                    <div v-if="question.type == 'number'">
                      <b-form-input
                        v-model="question.response"
                        type="number"
                      ></b-form-input>
                    </div>
                    <div v-if="question.type == 'time'">
                      <b-form-input
                        v-model="question.response"
                        type="time"
                      ></b-form-input>
                    </div>
                    <div v-if="question.type == 'date'">
                      <b-form-input
                        v-model="question.response"
                        type="date"
                      ></b-form-input>
                    </div>
                    <div v-if="question.type == 'color'">
                      <b-form-input
                        v-model="question.response"
                        type="color"
                      ></b-form-input>
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
              </div>
            </div>
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
export default {
  props: ["questionnaire"],
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

<template>
  <div class="p-3 bg-white">
    <b-form @submit.prevent="submit">
      <b-container class="py-3 px-0 text-left" v-if="questionnaire.sections">
        <div class="text-left d-flex justify-content-between mb-4">
          <h5 class="mb-4 text-capitalize">{{ questionnaire.title }}</h5>

          <div v-if="your_score" class="p-3 text-center">
            Your score <br />
            <span class="fs16 text-dark-green font-weight-bold"
              >{{ your_score }} / {{ total_score }}</span
            >
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
              <h5
                class="section-anchor px-3 py-1 bg-dark-green text-white fs12"
              >
                Section {{ section + 1 }} of {{ questionnaire.sections.length }}
              </h5>

              <div class="font-weight-bold my-2">
                <span>{{ questionnaire.sections[section].title }}</span>
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
                <div class="d-flex justify-content-between flex-1">
                  <b-form-group :label="question.question" class="flex-1">
                    <div class="mb-3" v-if="question.hint">
                      <em class="text-dark-green fs12"
                        ><b-icon icon="info-circle-fill"></b-icon>
                        {{ question.hint }}</em
                      >
                    </div>
                    <div v-if="question.type == 'short'">
                      <b-form-input
                        :disabled="type != 'template'"
                        @change="handleResponse"
                        v-model="question.response"
                        :placeholder="question.placeholder"
                      ></b-form-input>
                    </div>
                    <div v-if="question.type == 'long'">
                      <b-form-textarea
                        :disabled="type != 'template'"
                        @change="handleResponse"
                        v-model="question.response"
                        :placeholder="question.placeholder"
                      ></b-form-textarea>
                    </div>

                    <div v-if="question.type == 'single'">
                      <b-form-radio-group
                        size="sm"
                        :disabled="type != 'template'"
                        @change="handleResponse"
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
                          :disabled="type != 'template'"
                          v-model="item.title"
                          :placeholder="question.placeholder"
                        ></b-form-input>
                        <b-button-group>
                          <b-button
                            :disabled="type != 'template'"
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
                            :disabled="type != 'template'"
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
                          @change="handleResponse"
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
                        :disabled="type != 'template'"
                        @change="handleResponse"
                        v-model="question.response"
                        value="true"
                        >True</b-form-radio
                      >
                      <b-form-radio
                        size="sm"
                        :disabled="type != 'template'"
                        @change="handleResponse"
                        v-model="question.response"
                        value="false"
                        >False</b-form-radio
                      >
                    </div>

                    <div v-if="question.type == 'dropdown'">
                      <b-form-select
                        @change="handleResponse"
                        v-model="question.response"
                        :disabled="type != 'template'"
                      >
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
                        :disabled="type != 'template'"
                        @change="handleResponse"
                        type="range"
                        v-model="question.response"
                        min="0"
                        max="10"
                      ></b-form-input>
                    </div>
                    <div v-if="question.type == 'email'">
                      <b-form-input
                        :disabled="type != 'template'"
                        @change="handleResponse"
                        v-model="question.response"
                        type="email"
                      ></b-form-input>
                    </div>
                    <div v-if="question.type == 'number'">
                      <b-form-input
                        :disabled="type != 'template'"
                        @change="handleResponse"
                        v-model="question.response"
                        type="number"
                      ></b-form-input>
                    </div>
                    <div v-if="question.type == 'time'">
                      <b-form-input
                        :disabled="type != 'template'"
                        @change="handleResponse"
                        v-model="question.response"
                        type="time"
                      ></b-form-input>
                    </div>
                    <div v-if="question.type == 'date'">
                      <b-form-input
                        :disabled="type != 'template'"
                        @change="handleResponse"
                        v-model="question.response"
                        type="date"
                      ></b-form-input>
                    </div>
                    <div v-if="question.type == 'color'">
                      <b-form-input
                        :disabled="type != 'template'"
                        @change="handleResponse"
                        v-model="question.response"
                        type="color"
                      ></b-form-input>
                    </div>
                  </b-form-group>
                  <div class="p-2 px-3">
                    <span>Correct answer</span> <br />
                    <span class="text-capitalize" v-if="question.answer">{{
                      question.answer
                    }}</span>
                    <span v-if="question.answers.length > 1">
                      <ul>
                        <li
                          class="text-capitalize"
                          v-for="(v, i) in question.answers"
                          :key="i"
                        >
                          {{ v.title }}
                        </li>
                      </ul>
                    </span>
                  </div>
                </div>
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
              <span class="ml-auto" v-if="type == 'template'">
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
  props: [
    "id",
    "course_id",
    "module_id",
    "myquestionnaire",
    "type",
    "total_score",
    "your_score",
  ],
  data() {
    return {
      disable: false,
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
                limit: 1,
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
    type: "toggleDisable",
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
    toggleDisable() {
      if (this.$props.type == "template") {
        this.disable == false;
      } else {
        this.disable == true;
      }
    },
    getQuestionnaire() {
      this.questionnaire.id = this.$props.myquestionnaire.id;
      this.questionnaire.module_id = this.$props.myquestionnaire.module_id;
      // this.questionnaire.module_name = myquest.module_name;
      this.questionnaire.course_id = this.$props.myquestionnaire.course_id;
      this.questionnaire.course_title =
        this.$props.myquestionnaire.course_title;
      this.questionnaire.title = this.$props.myquestionnaire.title;
      this.questionnaire.showFeedback =
        this.$props.myquestionnaire.showFeedback;
      this.questionnaire.feedback = this.$props.myquestionnaire.feedback;
      this.questionnaire.showScores = this.$props.myquestionnaire.showScores;
      this.questionnaire.sections = this.$props.myquestionnaire.sections;
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
            .then(() => {
              this.$emit("handleCheck");
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

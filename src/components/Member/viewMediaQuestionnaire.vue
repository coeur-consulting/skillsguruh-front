<template>
  <div class="p-3 bg-white">
    <b-form @submit.prevent="submit">
      <b-container class="py-3 px-0 text-left" v-if="questionnaire.sections">
        <div class="text-left d-flex justify-content-between">
          <h5 class="mb-4 text-capitalize">{{ questionnaire.title }}</h5>
          <span @click="$bvModal.show('preview')"
            >Preview <b-icon icon="eye"></b-icon
          ></span>
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
                Section {{ section + 1 }} of {{ questionnaire.sections.length }}
              </h5>

              <div class="font-weight-bold my-2">
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
                  <div
                    v-if="
                      (question.type == 'short' || question.type == 'long') &&
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

    <b-modal id="preview" size="xl" centered hide-footer>
      <Preview :questionnaire="questionnaire" />
    </b-modal>
  </div>
</template>
<script>
import Preview from "./AnswerTemplates/preview.vue";
export default {
  props: ["id", "course_id", "module_id", "myquestionnaire"],
  data() {
    return {
      questionnaire: {
        id: null,
        module_id: null,
        totalscore: 0,
        module_name: "",
        course_id: null,
        course_title: null,
        title: "",
        type: "",
        showFeedback: false,
        feedback: "",
        showScores: false,
        sections: [
          {
            title: "",
            description: "",
            showSection: true,
            questions: [
              {
                fixed: false,
                showQuestion: true,
                question: "",
                addSubQuestion: false,
                subQuestion: [
                  {
                    question: "",
                    placeholder: "",
                    responses: [
                      {
                        response: "",
                      },
                    ],
                    response_count: "",
                  },
                ],
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
                asPlaceholders: false,
                placeholders: [
                  {
                    placeholder: "",
                    response: "",
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
  components: {
    Preview,
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
      } else {
        this.$http
          .get(
            `${this.$store.getters.url}/question/templates/${this.$props.id}`,
            {
              headers: {
                Authorization: `Bearer ${this.$store.getters.member.access_token}`,
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
        if (item.type == "single") {
          if (item.response == item.answer) {
            item.result = item.score;
            return item.score;
          }
          item.result = 0;
          return 0;
        }
        if (item.type == "checkbox") {
          answers = item.answers.map((item) => item).sort();
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
                Authorization: `Bearer ${this.$store.getters.member.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 201 || res.status == 200) {
                this.$emit("handleCheck");
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
                Authorization: `Bearer ${this.$store.getters.member.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 201 || res.status == 200) {
                this.$emit("handleCheck");
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

<template>
  <div class="p-3 bg-white">
    <b-form @submit.prevent="submit">
      <b-container class="py-3 px-0 text-center" v-if="questionnaire.sections">
        <div class="mb-3">
          <span @click="$router.go(-1)"
            ><b-icon icon="arrow-left"></b-icon> Back</span
          >
        </div>
        <div class="text-left d-flex justify-content-between">
          <h5 class="mb-4 text-capitalize text-center">
            {{ questionnaire.title }}
          </h5>
          <span @click="$bvModal.show('preview')"
            >Preview <b-icon icon="eye"></b-icon
          ></span>
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
                      question.type == 'short' &&
                      !question.asPlaceholders &&
                      !question.addSubQuestion
                    "
                  >
                    <b-form-input
                      @change="handleResponse"
                      v-model="question.response"
                      :placeholder="question.placeholder"
                    ></b-form-input>
                  </div>
                  <div
                    v-if="
                      question.type == 'long' &&
                      !question.asPlaceholders &&
                      !question.addSubQuestion
                    "
                  >
                    <b-form-textarea
                      @change="handleResponse"
                      v-model="question.response"
                      :placeholder="question.placeholder"
                    ></b-form-textarea>
                  </div>
                  <!-- <div v-if="question.type == 'multiple'">
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
                    </div> -->

                  <div v-if="question.type == 'multiple'">
                    <div
                      v-for="(place, idp) in question.placeholders"
                      :key="idp"
                    >
                      <b-form-input
                        class="mb-1"
                        @change="handleResponse"
                        size="sm"
                        v-model="place.response"
                        :placeholder="place.placeholder"
                      ></b-form-input>
                      <!-- <b-form-textarea
                          v-if="question.type == 'long'"
                          class="mb-1"
                          @change="handleResponse"
                          v-model="place.response"
                          :placeholder="place.placeholder"
                        ></b-form-textarea> -->
                    </div>
                  </div>

                  <div v-if="question.addSubQuestion">
                    <div
                      v-for="(subquest, subId) in question.subQuestion"
                      :key="subId"
                    >
                      <b-form-group :label="subquest.question">
                        <div
                          v-for="(res, resId) in subquest.responses"
                          :key="resId"
                        >
                          <b-form-input
                            class="mb-1"
                            v-if="question.type == 'short'"
                            @change="handleResponse"
                            size="sm"
                            v-model="res.response"
                            :placeholder="subquest.placeholder"
                          ></b-form-input>
                          <b-form-textarea
                            v-if="question.type == 'long'"
                            class="mb-1"
                            @change="handleResponse"
                            v-model="res.response"
                            :placeholder="subquest.placeholder"
                          ></b-form-textarea>
                        </div>
                      </b-form-group>
                    </div>
                  </div>

                  <div v-if="question.type == 'single'">
                    <b-form-radio-group
                      size="sm"
                      @change="handleResponse"
                      v-model="question.response"
                      :options="question.options"
                      value-field="title"
                      text-field="title"
                    ></b-form-radio-group>
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
                          question.responses.length > question.limit - 1 &&
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
                      @change="handleResponse"
                      v-model="question.response"
                      value="true"
                      >True</b-form-radio
                    >
                    <b-form-radio
                      size="sm"
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
                      @change="handleResponse"
                      type="range"
                      v-model="question.response"
                      min="0"
                      max="10"
                    ></b-form-input>
                  </div>
                  <div v-if="question.type == 'email'">
                    <b-form-input
                      @change="handleResponse"
                      v-model="question.response"
                      type="email"
                    ></b-form-input>
                  </div>
                  <div v-if="question.type == 'number'">
                    <b-form-input
                      @change="handleResponse"
                      v-model="question.response"
                      type="number"
                    ></b-form-input>
                  </div>
                  <div v-if="question.type == 'time'">
                    <b-form-input
                      @change="handleResponse"
                      v-model="question.response"
                      type="time"
                    ></b-form-input>
                  </div>
                  <div v-if="question.type == 'date'">
                    <b-form-input
                      @change="handleResponse"
                      v-model="question.response"
                      type="date"
                    ></b-form-input>
                  </div>
                  <div v-if="question.type == 'color'">
                    <b-form-input
                      @change="handleResponse"
                      v-model="question.response"
                      type="color"
                    ></b-form-input>
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
      getLibrary: [],
      section: 0,
      responses: [],
      score: 0,
    };
  },
  components: {
    Preview,
  },
  mounted() {
    this.getAnswers();
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
    getAnswers() {
      this.$http
        .get(`${this.$store.getters.url}/answer-questionnaires`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.myquestionnaire = res.data;
            if (res.data.length) {
              var check = res.data.find(
                (item) =>
                  item.question_template_id == this.$route.params.id &&
                  item.course_id == this.$route.params.course_id &&
                  item.module_id == this.$route.params.module_id
              );
            } else {
              this.getQuestionnaire();
            }
          }
          var sections = JSON.parse(check.content);

          if (check) {
            this.questionnaire.id = check.question_template_id;
            this.questionnaire.module_id = check.module_id;
            this.questionnaire.module_name = check.module_name;
            this.questionnaire.course_id = check.course_id;
            this.questionnaire.course_title = check.course.title;
            this.questionnaire.title = sections.title;
            this.questionnaire.showFeedback = sections.showFeedback;
            this.questionnaire.feedback = sections.feedback;
            this.questionnaire.showScores = sections.showScores;
            this.questionnaire.sections = sections.sections;
          } else {
            this.getQuestionnaire();
          }
        });
    },
    getQuestionnaire() {
      this.$http
        .get(
          `${this.$store.getters.url}/question/templates/${this.$route.params.id}`,
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
            module_id: this.$route.params.module_id,
            course_id: this.$route.params.course_id,
            content: this.questionnaire,
            questionnaire_id: this.$route.params.id,
            response: this.questionnaire,
            template_id: this.$route.params.id,
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
              if (res.status == 201 || res.status == 200) {
                this.$router.go(-1);
                this.$toast.success("Submitted Successfully");
              }
            });
        }
      });
    },
    saveforlater() {
      this.$bvModal.msgBoxConfirm("Are you sure?").then((response) => {
        if (response) {
          var data = {
            module_id: this.$route.params.module_id,
            course_id: this.$route.params.course_id,
            content: this.questionnaire,
            questionnaire_id: this.$route.params.id,
            response: this.questionnaire,
            template_id: this.$route.params.id,
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
              if (res.status == 201 || res.status == 200) {
                this.$router.go(-1);
                this.$toast.success("Saved in Drafts ");
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

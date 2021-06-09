<template>
  <div>
    <b-form @submit.prevent="submit">
      <b-container class="py-3 px-0 text-left" v-if="questionnaire.sections">
        <div class="text-left">
          <h5 class="mb-4">{{ questionnaire.title }}</h5>
          <div>
            <em class="text-lighter-green fs12">{{ questionnaire.hint }}</em>
          </div>
        </div>
        <div>
          <div class="mb-4 border-bottom">
            <h6 class="font-weight-bold mb-3">
              {{ questionnaire.sections[section].title }}
            </h6>

            <div
              v-for="(question, index) in questionnaire.sections[section]
                .questions"
              :key="question.title"
            >
              <b-form-group :label="question.question">
                <div class="mb-3" v-if="question.hint">
                  <em class="text-dark-green fs12"
                    ><b-icon icon="info-circle-fill"></b-icon>
                    {{ question.hint }}</em
                  >
                </div>
                <div v-if="question.type == 'short'">
                  <b-form-input
                    @change="handleResponse(question, index)"
                    v-model="question.response"
                    :placeholder="question.placeholder"
                  ></b-form-input>
                </div>
                <div v-if="question.type == 'long'">
                  <b-form-textarea
                    @change="handleResponse(question, index)"
                    v-model="question.response"
                    :placeholder="question.placeholder"
                  ></b-form-textarea>
                </div>

                <div v-if="question.type == 'single'">
                  <b-form-radio-group
                    @change="handleResponse(question, index)"
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
                  {{ question.limit }}
                  <div>
                    <b-form-checkbox
                      v-for="(item, index) in question.options"
                      :key="index"
                      :value="index"
                      v-model="question.responses"
                      :disabled="
                        question.responses.length > 1 &&
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
                    @change="handleResponse(question, index)"
                    v-model="question.response"
                    value="true"
                    >True</b-form-radio
                  >
                  <b-form-radio
                    @change="handleResponse(question, index)"
                    v-model="question.response"
                    value="false"
                    >False</b-form-radio
                  >
                </div>

                <div v-if="question.type == 'dropdown'">
                  <b-form-select
                    @change="handleResponse(question, index)"
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
                    @change="handleResponse(question, index)"
                    type="range"
                    v-model="question.response"
                    min="0"
                    max="10"
                  ></b-form-input>
                </div>
                <div v-if="question.type == 'email'">
                  <b-form-input
                    @change="handleResponse(question, index)"
                    v-model="question.response"
                    type="email"
                  ></b-form-input>
                </div>
                <div v-if="question.type == 'number'">
                  <b-form-input
                    @change="handleResponse(question, index)"
                    v-model="question.response"
                    type="number"
                  ></b-form-input>
                </div>
                <div v-if="question.type == 'time'">
                  <b-form-input
                    @change="handleResponse(question, index)"
                    v-model="question.response"
                    type="time"
                  ></b-form-input>
                </div>
                <div v-if="question.type == 'date'">
                  <b-form-input
                    @change="handleResponse(question, index)"
                    v-model="question.response"
                    type="date"
                  ></b-form-input>
                </div>
                <div v-if="question.type == 'color'">
                  <b-form-input
                    @change="handleResponse(question, index)"
                    v-model="question.response"
                    type="color"
                  ></b-form-input>
                </div>
              </b-form-group>
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
      </b-container>
    </b-form>
  </div>
</template>
<script>
export default {
  props: ["id", "course_id"],
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
      section: 0,
      responses: [],
      score: 0,
      totalscore: 0,
    };
  },
  mounted() {
    this.getQuestionnaire();
  },
  methods: {
    getQuestionnaire() {
      this.$http
        .get(`${this.$store.getters.url}/questionnaires/${this.$props.id}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
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
            this.questionnaire.sections = JSON.parse(res.data.content);
          }
        });
    },
    handleResponse(question, index) {
      var correct = 0;

      if (question.asAnswer) {
        if (question.type !== "multiple" && question.type !== "checkbox") {
          question.response.toLowerCase() == question.answer.toLowerCase()
            ? (question.result = true)
            : (question.result = false);
        } else {
          var answers = question.answers.map((item) => item.title).sort();
          var response = question.responses.sort();
          for (let i = 0; i < answers.length; i++) {
            if (answers[i] == response[i]) {
              correct++;
            }
          }
          if (correct == answers.length) {
            question.result = true;
          } else {
            question.result = false;
          }
        }

        this.questionnaire.sections[this.section].questions[index].responses =
          question.responses;
        this.questionnaire.sections[this.section].questions[index].response =
          question.response;
      }
    },
    addoption(index) {
      this.questionnaire.sections[this.section].questions[index].options.push({
        title: null,
      });
    },
    submit() {
      this.$bvModal.msgBoxConfirm("Are you sure?").then((response) => {
        if (response) {
          this.score = 0;

          var score = 0;
          var totalscore = 0;

          this.questionnaire.sections.forEach((item) => {
            item.questions.forEach((val) => {
              if (val.asScore) {
                totalscore = totalscore + val.score;
              }
              if (val.result) {
                score = score + val.score;
              }
            });
          });
          this.totalscore = totalscore;

          this.score = score;

          var data = {
            module_id: this.questionnaire.module_id,
            course_id: this.$props.course_id,
            content: this.questionnaire,
            questionnaire_id: this.$props.id,
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

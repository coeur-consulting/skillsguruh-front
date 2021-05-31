<template>
  <div>
    <b-form @submit.prevent="submit">
      <b-container class="p-5 text-left" v-if="questionnaire.sections">
        <div class="text-center">
          <h3 class="mb-4">{{ questionnaire.title }}</h3>
        </div>
        <div>
          <div class="mb-4 border-bottom">
            <h5 class="font-weight-bold mb-3">
              {{ questionnaire.sections[section].title }}
            </h5>

            <div
              v-for="(question, index) in questionnaire.sections[section]
                .questions"
              :key="question.title"
            >
              <b-form-group :label="question.question">
                <div v-if="question.type == 'short'">
                  <b-form-input
                    @change="handleResponse(index)"
                    v-model="question.response"
                    :placeholder="question.placeholder"
                  ></b-form-input>
                </div>
                <div v-if="question.type == 'long'">
                  <b-form-textarea
                    @change="handleResponse(index)"
                    v-model="question.response"
                    :placeholder="question.placeholder"
                  ></b-form-textarea>
                </div>

                <div v-if="question.type == 'single'">
                  <b-form-radio-group
                    @change="handleResponse(index)"
                    v-model="question.response"
                    :options="question.options"
                    value-field="title"
                    text-field="title"
                  ></b-form-radio-group>
                </div>
                <div v-if="question.type == 'multiple'">
                  <b-form-checkbox-group
                    @change="handleResponse(index)"
                    v-model="question.responses"
                    :options="question.options"
                    value-field="title"
                    text-field="title"
                    :disabled="
                      question.responses.length >= question.answers.length
                    "
                  ></b-form-checkbox-group>
                </div>
                {{ question.responses }} <br />
                {{ question.response }}
                <div v-if="question.type == 'checkbox'">
                  <b-form-checkbox-group
                    @change="handleResponse(index)"
                    v-model="question.responses"
                    :options="question.options"
                    value-field="title"
                    text-field="title"
                    :disabled="
                      question.responses.length >= question.answers.length
                    "
                  ></b-form-checkbox-group>
                </div>

                <div v-if="question.type == 'boolean'">
                  <b-form-radio
                    @change="handleResponse(index)"
                    v-model="question.response"
                    value="true"
                    >True</b-form-radio
                  >
                  <b-form-radio
                    @change="handleResponse(index)"
                    v-model="question.response"
                    value="false"
                    >False</b-form-radio
                  >
                </div>

                <div v-if="question.type == 'dropdown'">
                  <b-form-select
                    @change="handleResponse(index)"
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
                    @change="handleResponse(index)"
                    type="range"
                    v-model="question.response"
                    min="0"
                    max="10"
                  ></b-form-input>
                </div>
                <div v-if="question.type == 'email'">
                  <b-form-input
                    @change="handleResponse(index)"
                    v-model="question.response"
                    type="email"
                  ></b-form-input>
                </div>
                <div v-if="question.type == 'number'">
                  <b-form-input
                    @change="handleResponse(index)"
                    v-model="question.response"
                    type="number"
                  ></b-form-input>
                </div>
                <div v-if="question.type == 'time'">
                  <b-form-input
                    @change="handleResponse(index)"
                    v-model="question.response"
                    type="time"
                  ></b-form-input>
                </div>
                <div v-if="question.type == 'date'">
                  <b-form-input
                    @change="handleResponse(index)"
                    v-model="question.response"
                    type="date"
                  ></b-form-input>
                </div>
                <div v-if="question.type == 'color'">
                  <b-form-input
                    @change="handleResponse(index)"
                    v-model="question.response"
                    type="color"
                  ></b-form-input>
                </div>
              </b-form-group>
            </div>

            <div class="d-flex justify-content-between my-4">
              <b-button
                size="sm"
                variant="outline-secondary"
                v-if="section > 0"
                @click="section--"
                >Previous Section</b-button
              >
              <b-button
                size="sm"
                class="ml-auto"
                variant="outline-dark-green"
                v-if="section < questionnaire.sections.length - 1"
                @click="section++"
                >Next Section</b-button
              >
              <b-button
                size="sm"
                class="ml-auto"
                variant="outline-dark-green"
                v-if="questionnaire.sections.length - 1 == section"
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
  data() {
    return {
      questionnaire: [],
      section: 0,
      responses: [],
      score: null,
    };
  },
  mounted() {
    this.getQuestionnaire();
  },
  methods: {
    getQuestionnaire() {
      this.$http
        .get(
          `${this.$store.getters.url}/questionnaires/${this.$route.params.id}`,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.questionnaire = res.data;
            this.questionnaire.sections = JSON.parse(res.data.content);
          }
        });
    },
    handleResponse(index) {
      var correct = 0;

      if (this.questionnaire.sections[this.section].questions[index].asAnswer) {
        if (
          this.questionnaire.sections[this.section].questions[index].type !==
            "multiple" &&
          this.questionnaire.sections[this.section].questions[index].type !==
            "checkbox"
        ) {
          this.questionnaire.sections[this.section].questions[
            index
          ].response.toLowerCase() ==
          this.questionnaire.sections[this.section].questions[
            index
          ].answer.toLowerCase()
            ? (this.questionnaire.sections[this.section].questions[
                index
              ].result = true)
            : (this.questionnaire.sections[this.section].questions[
                index
              ].result = false);
        } else {
          var answers = this.questionnaire.sections[this.section].questions[
            index
          ].answers
            .map((item) => item.title)
            .sort();
          var response = this.questionnaire.sections[this.section].questions[
            index
          ].responses.sort();
          for (let i = 0; i < answers.length; i++) {
            if (answers[i] == response[i]) {
              correct++;
            }
          }
          if (correct == answers.length) {
            this.questionnaire.sections[this.section].questions[
              index
            ].result = true;
          } else {
            this.questionnaire.sections[this.section].questions[
              index
            ].result = false;
          }
        }
      }
    },
    submit() {
      this.$http
        .post(`${this.$store.getters.url}/questionnaires`, this.questionnaire, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.questionnaire = res.data;
            this.questionnaire.sections = JSON.parse(res.data.content);
          }
        });
    },
  },
};
</script>

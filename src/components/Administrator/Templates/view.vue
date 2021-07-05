<template>
  <div>
    <b-container class="py-3 px-0 text-left" v-if="questionnaire.sections">
      <div class="mb-4">
        <span class="cursor-pointer" @click="$router.go(-1)"
          ><b-icon icon="arrow-left"></b-icon> Back</span
        >
      </div>
      <b-row class="justify-content-center">
        <b-col sm="10" class="ber">
          <div class="text-left">
            <h5 class="mb-4 text-capitalize">{{ questionnaire.title }}</h5>
            <div>
              <em class="text-lighter-green fs11">{{ questionnaire.hint }}</em>
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

                    <div v-if="question.asPlaceholders">
                      <div
                        v-for="(place, idp) in question.placeholders"
                        :key="idp"
                      >
                        <b-form-input
                          class="mb-1"
                          v-if="question.type == 'short'"
                          @change="handleResponse"
                          size="sm"
                          v-model="place.response"
                          :placeholder="place.placeholder"
                        ></b-form-input>
                        <b-form-textarea
                          v-if="question.type == 'long'"
                          class="mb-1"
                          @change="handleResponse"
                          v-model="place.response"
                          :placeholder="place.placeholder"
                        ></b-form-textarea>
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
  data() {
    return {
      questionnaire: [],
      section: 0,
      responses: [],
      score: 0,
      question_num: 0,
      current_score: 0,
    };
  },
  mounted() {
    this.getQuestionnaire();
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
    getQuestionnaire() {
      this.$http
        .get(
          `${this.$store.getters.url}/question/templates/${this.$route.params.id}`,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.questionnaire = res.data;
            this.questionnaire.sections = JSON.parse(res.data.sections);
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

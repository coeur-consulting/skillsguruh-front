<template>
  <div>
    <b-container fluid class="p-5">
      <b-row>
        <b-col md="9" class="left_box text-left">
          <b-form>
            <b-form-row class="mb-2 py-3 justify-content-end">
              <b-col sm="8">
                <b-form-group label="Template title">
                  <b-form-input
                    placeholder="Give a title"
                    v-model="questionnaire.title"
                  ></b-form-input>
                </b-form-group>
              </b-col>
              <b-col sm="4">
                <b-form-group label="Template type">
                  <b-form-select v-model="questionnaire.type">
                    <b-form-select-option disabled value=""
                      >Choose type</b-form-select-option
                    >
                    <b-form-select-option value="quiz"
                      >Quiz</b-form-select-option
                    >
                    <b-form-select-option value="questionnaire"
                      >Questionnaire</b-form-select-option
                    >
                    <b-form-select-option value="assessment"
                      >Assessment</b-form-select-option
                    >
                  </b-form-select>
                </b-form-group>
              </b-col>
            </b-form-row>

            <div v-for="(section, idx) in questionnaire.sections" :key="idx">
              <b-form-row class="mb-2 py-3">
                <b-col cols="8">
                  <b-form-group label="Section title">
                    <div class="d-flex">
                      <b-form-input
                        placeholder="Give a section title"
                        v-model="section.title"
                      ></b-form-input>
                    </div>
                  </b-form-group>
                </b-col>
                <b-col cols="4" class="text-right">
                  <b-button
                    size="sm"
                    class="mr-2"
                    @click="questionnaire.sections.splice(idx, 1)"
                    v-if="questionnaire.sections.length > idx"
                    ><b-icon icon="trash-fill"></b-icon
                  ></b-button>

                  <b-button
                    size="sm"
                    variant="dark-green"
                    @click="addsection"
                    v-if="questionnaire.sections.length == idx + 1"
                    ><b-icon icon="plus"></b-icon> Add section</b-button
                  >
                </b-col>
              </b-form-row>
              <draggable
                v-model="section.questions"
                v-bind="dragOptions"
                :move="onMove"
                @start="isDragging = true"
                @end="isDragging = false"
              >
                <transition-group type="transition" :name="'flip-list'">
                  <div
                    class="shadow rounded p-3 mb-3"
                    v-for="(question, index) in section.questions"
                    :key="index + 1"
                  >
                    <div
                      class="
                        d-flex
                        justify-content-between
                        align-items-center
                        py-3
                      "
                    >
                      <span
                        ><b-icon
                          icon="grid3x2-gap"
                          rotate="90"
                          class="mr-2 grab"
                        ></b-icon>
                        <span>
                          <span class="mr-2"> Q{{ index + 1 }}.</span>
                          {{ question.question }}
                        </span></span
                      >
                      <span>
                        <b-button
                          class="mr-3"
                          size="sm"
                          @click="
                            questionnaire.sections[idx].questions.splice(
                              index,
                              1
                            )
                          "
                          v-if="
                            questionnaire.sections[idx].questions.length > index
                          "
                          ><b-icon icon="trash-fill"></b-icon
                        ></b-button>
                        <b-button
                          size="sm"
                          class="mr-2"
                          variant="lighter-green"
                          @click="addquestion(idx)"
                          v-if="
                            questionnaire.sections[idx].questions.length ==
                            index + 1
                          "
                          ><b-icon icon="plus"></b-icon> Add question</b-button
                        >
                        <b-icon
                          v-if="current_question == index"
                          @click="current_question = null"
                          icon="caret-down-fill"
                        ></b-icon>
                        <b-icon
                          v-else
                          @click="current_question = index"
                          icon="caret-up-fill"
                        ></b-icon
                      ></span>
                    </div>

                    <div v-if="current_question == index">
                      <b-form-row class="mb-3">
                        <b-col sm="6">
                          <b-form-group label="Question type">
                            <div class="d-flex">
                              <b-form-select v-model="question.type">
                                <b-form-select-option value="short"
                                  >Short Answer</b-form-select-option
                                >
                                <b-form-select-option value="single"
                                  >Single Answer</b-form-select-option
                                >
                                <b-form-select-option value="multiple"
                                  >Multiple Answer</b-form-select-option
                                >
                                <b-form-select-option value="long"
                                  >Long Answer</b-form-select-option
                                >
                                <b-form-select-option value="paragraph"
                                  >Paragraph</b-form-select-option
                                >
                                <b-form-select-option value="dropdown"
                                  >Dropdown</b-form-select-option
                                >
                                <b-form-select-option value="checkbox"
                                  >Checkbox</b-form-select-option
                                >
                                <b-form-select-option value="boolean"
                                  >True/False</b-form-select-option
                                >
                                <b-form-select-option value="email"
                                  >Email</b-form-select-option
                                >
                                <b-form-select-option value="number"
                                  >Number</b-form-select-option
                                >
                                <b-form-select-option value="time"
                                  >Time</b-form-select-option
                                >
                                <b-form-select-option value="date"
                                  >Date</b-form-select-option
                                >
                                <b-form-select-option value="color"
                                  >Color</b-form-select-option
                                >
                                <b-form-select-option value="range"
                                  >Range</b-form-select-option
                                >
                              </b-form-select>
                            </div>
                          </b-form-group>
                        </b-col>
                      </b-form-row>

                      <b-form-row class="mb-3">
                        <b-col sm="12">
                          <b-form-group
                            label="Question"
                            v-if="question.type !== 'paragraph'"
                          >
                            <b-form-input
                              v-model="question.question"
                              placeholder="Provide a question"
                            >
                            </b-form-input>
                          </b-form-group>
                          <b-form-group label="Question" v-else>
                            <b-form-textarea
                              v-model="question.question"
                              placeholder="Provide a question"
                            >
                            </b-form-textarea>
                          </b-form-group>
                        </b-col>
                      </b-form-row>
                      <b-form-row
                        class="mb-3"
                        v-if="
                          question.type !== 'short' &&
                          question.type !== 'long' &&
                          question.type !== 'boolean'
                        "
                      >
                        <b-col sm="12">
                          <b-form-group label="Options ">
                            <b-input-group
                              v-for="(option, id) in question.options"
                              :key="id"
                            >
                              <b-form-input
                                v-model="option.title"
                                placeholder="Provide an option"
                              >
                              </b-form-input>
                              <b-input-group-append>
                                <b-button-group size="sm">
                                  <b-button
                                    size="sm"
                                    @click="
                                      questionnaire.sections[idx].questions[
                                        index
                                      ].options.splice(id, 1)
                                    "
                                    v-if="
                                      questionnaire.sections[idx].questions[
                                        index
                                      ].options.length > id
                                    "
                                    ><b-icon icon="x"></b-icon
                                  ></b-button>
                                  <b-button
                                    size="sm"
                                    variant="lighter-green"
                                    @click="addoption(idx, index)"
                                    v-if="
                                      questionnaire.sections[idx].questions[
                                        index
                                      ].options.length ==
                                      id + 1
                                    "
                                    ><b-icon icon="plus"></b-icon> Add
                                    option</b-button
                                  >
                                </b-button-group>
                              </b-input-group-append>
                            </b-input-group>
                          </b-form-group>
                        </b-col>
                      </b-form-row>

                      <b-form-row class="mb-3">
                        <b-col sm="12">
                          <b-form-checkbox
                            size="sm"
                            v-model="question.showAnswer"
                            >Provide answer</b-form-checkbox
                          >

                          <b-form-group
                            label="Answer"
                            v-if="
                              question.showAnswer &&
                              question.type !== 'multiple'
                            "
                          >
                            <b-form-input
                              v-model="question.answer"
                              placeholder="Provide the answer"
                            >
                            </b-form-input>
                          </b-form-group>
                        </b-col>
                      </b-form-row>
                      <b-form-row
                        class="mb-3"
                        v-if="
                          question.showAnswer && question.type == 'multiple'
                        "
                      >
                        <b-col sm="12">
                          <b-form-row label="Answers">
                            <b-input-group
                              v-for="(answer, id) in question.answers"
                              :key="id"
                            >
                              <b-form-input
                                v-model="answer.title"
                                placeholder="Provide the answers"
                              >
                              </b-form-input>
                              <b-input-group-append>
                                <b-button-group size="sm">
                                  <b-button
                                    size="sm"
                                    @click="
                                      questionnaire.sections[idx].questions[
                                        index
                                      ].answers.splice(id, 1)
                                    "
                                    v-if="
                                      questionnaire.sections[idx].questions[
                                        index
                                      ].answers.length > id
                                    "
                                    ><b-icon icon="x"></b-icon
                                  ></b-button>
                                  <b-button
                                    size="sm"
                                    variant="lighter-green"
                                    @click="addanswer(idx, index)"
                                    v-if="
                                      questionnaire.sections[idx].questions[
                                        index
                                      ].answers.length ==
                                      id + 1
                                    "
                                    ><b-icon icon="plus"></b-icon> Add
                                    answer</b-button
                                  >
                                </b-button-group>
                              </b-input-group-append>
                            </b-input-group>
                          </b-form-row>
                        </b-col>
                      </b-form-row>
                      <b-form-row class="mb-3">
                        <b-col sm="12">
                          <b-form-group label="Placeholder (optional)">
                            <b-form-input
                              v-model="question.placeholder"
                              placeholder="Provide a placeholder"
                            >
                            </b-form-input>
                          </b-form-group>
                        </b-col>
                      </b-form-row>
                      <b-form-row class="mb-3">
                        <b-col sm="12">
                          <b-form-group label="Hint (optional)">
                            <b-form-input
                              v-model="question.hint"
                              placeholder="Provide a hint"
                            >
                            </b-form-input>
                          </b-form-group>
                        </b-col>
                      </b-form-row>
                      <b-form-row class="mb-3">
                        <b-col sm="5">
                          <b-form-checkbox size="sm" v-model="question.asAnswer"
                            >Add score</b-form-checkbox
                          >
                          <b-form-group label="Score" v-if="question.asAnswer">
                            <b-form-select v-model="question.score">
                              <b-form-select-option disabled :value="null"
                                >Choose question score</b-form-select-option
                              >
                              <b-form-select-option
                                v-for="item in score"
                                :key="item"
                                :value="item"
                                >{{ item }}</b-form-select-option
                              >
                            </b-form-select>
                          </b-form-group>
                        </b-col>
                      </b-form-row>
                    </div>
                  </div>
                </transition-group>
              </draggable>
            </div>
          </b-form>
        </b-col>
        <b-col md="3" class="bg-white right_box p-3 text-center">
          <div class="mb-3">
            <b-button variant="dark-green" block size="lg" @click="preview"
              >Preview</b-button
            >
          </div>
          <div>
            <b-button variant="outline-dark-green" @click="save" block size="lg"
              >Save Questionnaire</b-button
            >
          </div>
        </b-col>
      </b-row>
    </b-container>
    <b-modal
      no-close-on-backdrop
      hide-footer
      hide-header
      id="preview"
      size="lg"
      centered
    >
      <Preview :questionnaire="questionnaire"></Preview>
    </b-modal>
  </div>
</template>

<script>
import draggable from "vuedraggable";
import Preview from "./preview";
export default {
  components: {
    draggable,
    Preview,
  },
  data() {
    return {
      score: 20,
      current_question: 0,
      answer: false,
      questionnaire: {
        title: "",
        type: "",
        sections: [
          {
            title: "",
            questions: [
              {
                fixed: false,
                question: "",
                response: "",
                responses: [],
                type: "short",
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
      editable: true,
      isDragging: false,
      delayedDragging: false,
    };
  },
  computed: {
    dragOptions() {
      return {
        animation: 0,
        group: "description",
        disabled: !this.editable,
        ghostClass: "ghost",
      };
    },
  },
  watch: {
    isDragging(newValue) {
      if (newValue) {
        this.delayedDragging = true;
        return;
      }
      this.$nextTick(() => {
        this.delayedDragging = false;
      });
    },
  },
  methods: {
    onMove({ relatedContext, draggedContext }) {
      const relatedElement = relatedContext.element;
      const draggedElement = draggedContext.element;
      return (
        (!relatedElement || !relatedElement.fixed) && !draggedElement.fixed
      );
    },
    addsection() {
      this.questionnaire.sections.push({
        title: "",
        questions: [
          {
            fixed: false,
            question: "",
            type: "short",
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
      });
    },
    addquestion(idx) {
      this.questionnaire.sections[idx].questions.push({
        question: "",
        type: "short",
        options: [
          {
            title: "",
          },
        ],
        answer: "",
        answers: [
          {
            title: "",
          },
        ],
        placeholder: "",
        hint: "",
      });
    },
    addoption(idx, index) {
      this.questionnaire.sections[idx].questions[index].options.push({
        title: "",
      });
    },
    addanswer(idx, index) {
      this.questionnaire.sections[idx].questions[index].answers.push({
        title: "",
      });
    },
    save() {
      this.$http
        .post(`${this.$store.getters.url}/questionnaire`, this.questionnaire, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            console.log(res);
          }
        });
    },
    preview() {
      this.$bvModal.show("preview");
    },
  },
};
</script>

<style scoped>
.container-fluid {
  height: 100%;
}
.left_box {
  overflow: scroll;
  height: calc(100vh - 80px);
}
.flip-list-move {
  transition: transform 0.5s;
}
.no-move {
  transition: transform 0s;
}
.ghost {
  opacity: 0.5;
  background: #c8ebfb;
}
.list-group {
  min-height: 20px;
}
.list-group-item {
  cursor: move;
}
.list-group-item i {
  cursor: pointer;
}
</style>

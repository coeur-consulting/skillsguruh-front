<template>
  <div>
    <b-container fluid class="p-5">
      <!-- <div class="text-left">
        <span class="mb-3" @click="$router.go(-1)"
          ><b-icon icon="arrow-left"></b-icon> Go back</span
        >
      </div> -->
      <b-row>
        <b-col md="9">
          <div id="form_box" class="left_box text-left p-3 rounded">
            <b-form>
              <b-form-row class="mb-2 py-3 justify-content-end">
                <b-col sm="8">
                  <b-form-group label="Template title">
                    <b-form-input
                      size="sm"
                      placeholder="Give a title"
                      v-model="questionnaire.title"
                    ></b-form-input>
                  </b-form-group>
                </b-col>
                <b-col sm="4">
                  <b-form-group label="Template type">
                    <b-form-select size="sm" v-model="questionnaire.type">
                      <b-form-select-option disabled value=""
                        >Choose type</b-form-select-option
                      >
                      <b-form-select-option value="template"
                        >Template</b-form-select-option
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

              <div
                v-for="(section, idx) in questionnaire.sections"
                :key="idx"
                class="
                  border-bottom
                  bg-light
                  rounded
                  p-3
                  mb-3
                  position-relative
                  overflow-hidden
                "
                :id="`section${idx}`"
              >
                <span class="sect_box">Section {{ idx + 1 }}</span>
                <div class="text-right">
                  <b-icon
                    class="mr-2 cursor-pointer"
                    @click="questionnaire.sections.splice(idx, 1)"
                    v-if="questionnaire.sections.length > idx"
                    icon="trash2-fill"
                    variant="danger"
                    font-scale=".8"
                  ></b-icon>
                  <b-icon
                    class="cursor-pointer"
                    @click="section.showSection = !section.showSection"
                    :icon="!section.showSection ? 'chevron-down' : 'chevron-up'"
                    variant=""
                    font-scale=".8"
                  ></b-icon>
                </div>
                <div v-if="!section.showSection" class="text-left">
                  <h6 class="text-capitalize fs14 text-center">
                    {{ section.title }}
                  </h6>
                  <p v-html="section.description" class="fs13"></p>
                  <div
                    class="mb-2 fs13"
                    v-for="(question, index) in section.questions"
                    :key="index"
                  >
                    <div class="d-flex justify-content-start">
                      <span class="mr-2"
                        >Q<span class="fs12">{{ index + 1 }}</span
                        >.</span
                      >
                      <span class="px-0">{{ question.question }}</span>
                    </div>
                  </div>
                </div>
                <div v-else>
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
                    <b-col cols="4" class="text-right"> </b-col>
                    <b-col cols="12">
                      <b-form-group>
                        <editor
                          api-key="0faxd6jp8vlrnoj74njdtskkywu2nqvbuta5scv42arkdczq"
                          v-model="section.description"
                          :init="{
                            height: 150,
                            menubar: false,
                            plugins: [
                              'advlist autolink lists link image charmap print preview anchor',
                              'searchreplace visualblocks code fullscreen',
                              'insertdatetime media table paste code help wordcount',
                            ],
                            toolbar:
                              'undo redo | formatselect | bold italic backcolor | \
           alignleft aligncenter alignright alignjustify | \
           bullist numlist outdent indent | removeformat | help',
                          }"
                        />
                      </b-form-group>
                    </b-col>
                  </b-form-row>
                  <draggable
                    v-model="section.questions"
                    v-bind="dragOptions"
                    :move="onMove"
                    @start="isDragging = true"
                    @end="isDragging = false"
                    class=""
                  >
                    <transition-group type="transition" :name="'flip-list'">
                      <div
                        class="shadow-sm bg-white rounded p-3 mb-3"
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
                              <span class="mr-2"
                                >Q<span class="fs12"
                                  >{{ index + 1 }}.</span
                                ></span
                              >
                              {{ question.question }}
                            </span></span
                          >
                          <span class="d-flex align-items-center">
                            <b-button
                              size="sm"
                              class="mr-2 py-1 fs12"
                              variant="lighter-green"
                              @click="addquestion(idx)"
                              v-if="
                                questionnaire.sections[idx].questions.length ==
                                index + 1
                              "
                              ><b-icon icon="plus"></b-icon> New
                              question</b-button
                            >

                            <b-icon
                              icon="trash2-fill"
                              class="mr-2 cursor-pointer"
                              variant="danger"
                              font-scale=".8"
                              @click="
                                questionnaire.sections[idx].questions.splice(
                                  index,
                                  1
                                )
                              "
                              v-if="
                                questionnaire.sections[idx].questions.length >
                                index
                              "
                            ></b-icon>

                            <b-icon
                              @click="
                                question.showQuestion = !question.showQuestion
                              "
                              :icon="
                                question.showQuestion
                                  ? 'caret-up-fill'
                                  : 'caret-down-fill'
                              "
                            ></b-icon>
                          </span>
                        </div>

                        <div v-if="question.showQuestion">
                          <b-form-row class="mb-3 align-items-center">
                            <b-col sm="3">
                              <b-form-group label="Question type">
                                <div class="d-flex">
                                  <b-form-select
                                    size="sm"
                                    v-model="question.type"
                                  >
                                    <b-form-select-option value="single"
                                      >Radio</b-form-select-option
                                    >
                                    <b-form-select-option value="checkbox"
                                      >Checkbox</b-form-select-option
                                    >

                                    <b-form-select-option value="short"
                                      >Short Answer</b-form-select-option
                                    >

                                    <b-form-select-option value="long"
                                      >Long Answer</b-form-select-option
                                    >
                                    <b-form-select-option value="multiple"
                                      >Multiple Answer</b-form-select-option
                                    >
                                    <b-form-select-option value="dropdown"
                                      >Dropdown</b-form-select-option
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
                            <b-col
                              sm="9"
                              class="
                                text-right
                                d-flex
                                align-items-center
                                justify-content-end
                              "
                            >
                              <b-form-checkbox
                                class="mr-3"
                                size="sm"
                                v-model="question.asAnswer"
                                >Provide Score</b-form-checkbox
                              >
                              <b-form-checkbox
                                v-if="
                                  question.type == 'short' ||
                                  question.type == 'long'
                                "
                                class="mr-2"
                                size="sm"
                                v-model="question.addSubQuestion"
                                >Sub-Question</b-form-checkbox
                              >
                            </b-col>
                          </b-form-row>

                          <b-form-row class="">
                            <b-col sm="12">
                              <b-form-group label="Question">
                                <b-form-textarea
                                  size="sm"
                                  v-model="question.question"
                                  placeholder="Provide a question"
                                >
                                </b-form-textarea>
                              </b-form-group>
                            </b-col>
                          </b-form-row>

                          <b-form-row
                            class="p-2"
                            v-if="question.addSubQuestion"
                          >
                            <b-col
                              class="border-left bg-light rounded p-2"
                              sm="12"
                            >
                              <div
                                v-for="(val, subId) in question.subQuestion"
                                :key="subId"
                                class="mb-2"
                              >
                                <b-row class="align-items-center">
                                  <b-col cols="11">
                                    <b-form-group
                                      :label="`Sub Question ${subId + 1}`"
                                    >
                                      <b-form-input
                                        size="sm"
                                        v-model="val.question"
                                        :placeholder="`Provide question ${
                                          subId + 1
                                        }`"
                                      >
                                      </b-form-input>
                                    </b-form-group>
                                    <b-row>
                                      <b-col cols="8">
                                        <b-form-group>
                                          <b-form-input
                                            size="sm"
                                            v-model="val.placeholder"
                                            :placeholder="`Provide placeholder ${
                                              subId + 1
                                            }`"
                                          >
                                          </b-form-input>
                                        </b-form-group>
                                      </b-col>
                                      <b-col cols="4">
                                        <b-form-select
                                          size="sm"
                                          @change="
                                            handleSubQuestion(
                                              idx,
                                              index,
                                              subId,
                                              val.response_count
                                            )
                                          "
                                          v-model="val.response_count"
                                        >
                                          <b-form-select-option
                                            disabled
                                            value=""
                                            >No of
                                            Response</b-form-select-option
                                          >
                                          <b-form-select-option
                                            v-for="n in 50"
                                            :key="n"
                                            :value="n"
                                            >{{ n }}</b-form-select-option
                                          >
                                        </b-form-select>
                                      </b-col>
                                    </b-row>
                                  </b-col>
                                  <b-col cols="1">
                                    <div class="text-right">
                                      <b-icon
                                        @click="
                                          questionnaire.sections[idx].questions[
                                            index
                                          ].subQuestion.splice(id, 1)
                                        "
                                        v-if="
                                          questionnaire.sections[idx].questions[
                                            index
                                          ].subQuestion.length > 1
                                        "
                                        icon="x-circle-fill"
                                      ></b-icon>
                                    </div>
                                  </b-col>
                                </b-row>
                              </div>
                              <div class="text-center">
                                <b-icon
                                  font-scale="1.3"
                                  class="cursor-pointer"
                                  variant="dark-green"
                                  icon="plus-circle-fill"
                                  @click="addSubQuest(idx, index)"
                                ></b-icon>
                              </div>
                            </b-col>
                          </b-form-row>

                          <b-form-row
                            class=""
                            v-if="
                              question.type !== 'short' &&
                              question.type !== 'long' &&
                              question.type !== 'multiple' &&
                              question.type !== 'boolean'
                            "
                          >
                            <b-col sm="12">
                              <b-form-group label="Options ">
                                <b-input-group
                                  size="sm"
                                  v-for="(option, id) in question.options"
                                  :key="id"
                                  class="mb-1"
                                >
                                  <b-form-input
                                    size="sm"
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
                                          ].options.length > 1
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
                                        ><b-icon
                                          icon="plus-circle-fill"
                                        ></b-icon>
                                      </b-button>
                                    </b-button-group>
                                  </b-input-group-append>
                                </b-input-group>
                              </b-form-group>
                            </b-col>
                          </b-form-row>

                          <b-form-row
                            class=""
                            v-if="
                              question.type == 'single' ||
                              question.type == 'checkbox' ||
                              question.type == 'boolean'
                            "
                          >
                            <b-col sm="12">
                              <b-form-group label="Corect Answer">
                                <b-form-input
                                  size="sm"
                                  v-model="question.answer"
                                  placeholder="Provide the correct answer"
                                >
                                </b-form-input>
                              </b-form-group>
                            </b-col>
                          </b-form-row>
                          <b-form-row
                            class=""
                            v-if="
                              question.showAnswer &&
                              (question.type == 'multiple' ||
                                question.type == 'checkbox')
                            "
                          >
                            <b-col sm="12">
                              <b-form-row label="Answers">
                                <b-input-group
                                  size="sm"
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
                          <b-form-row
                            class=""
                            v-if="
                              question.type == 'short' ||
                              question.type == 'long' ||
                              question.type == 'paragraph' ||
                              question.type == 'email' ||
                              question.type == 'number'
                            "
                          >
                            <b-col sm="12" v-if="!question.addSubQuestion">
                              <b-form-group label="Placeholder (optional)">
                                <b-form-input
                                  size="sm"
                                  v-model="question.placeholder"
                                  placeholder="Provide a placeholder"
                                >
                                </b-form-input>
                              </b-form-group>
                            </b-col>
                          </b-form-row>
                          <b-form-row
                            class=""
                            v-if="question.type == 'multiple'"
                          >
                            <b-col sm="12" v-if="!question.addSubQuestion">
                              <b-form-group label="Placeholder (optional)">
                                <b-input-group
                                  size="sm"
                                  v-for="(val, idp) in question.placeholders"
                                  :key="idp"
                                  class="mb-1"
                                >
                                  <b-form-input
                                    size="sm"
                                    v-model="val.placeholder"
                                    placeholder="Provide a placeholder"
                                  >
                                  </b-form-input>
                                  <b-input-group-append>
                                    <b-button-group size="sm">
                                      <b-button
                                        size="sm"
                                        @click="
                                          questionnaire.sections[idx].questions[
                                            index
                                          ].placeholders.splice(id, 1)
                                        "
                                        v-if="
                                          questionnaire.sections[idx].questions[
                                            index
                                          ].placeholders.length > 1
                                        "
                                        ><b-icon icon="x"></b-icon
                                      ></b-button>
                                      <b-button
                                        size="sm"
                                        variant="lighter-green"
                                        @click="addplaceholder(idx, index)"
                                        v-if="
                                          questionnaire.sections[idx].questions[
                                            index
                                          ].placeholders.length ==
                                          idp + 1
                                        "
                                        ><b-icon
                                          icon="plus-circle-fill"
                                        ></b-icon>
                                      </b-button>
                                    </b-button-group>
                                  </b-input-group-append>
                                </b-input-group>
                              </b-form-group>
                            </b-col>
                          </b-form-row>

                          <b-form-row class="">
                            <b-col sm="12">
                              <b-form-group label="Hint (optional)">
                                <b-form-input
                                  size="sm"
                                  v-model="question.hint"
                                  placeholder="Provide a hint"
                                >
                                </b-form-input>
                              </b-form-group>
                            </b-col>
                          </b-form-row>
                          <b-form-row
                            class=""
                            v-if="question.type == 'checkbox'"
                          >
                            <b-col sm="4">
                              <b-form-group label="Choose response limit">
                                <b-form-select
                                  size="sm"
                                  v-model="question.limit"
                                >
                                  <b-form-select-option disabled :value="null"
                                    >Choose response limit</b-form-select-option
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
                          <b-form-row class="">
                            <b-col sm="3">
                              <b-form-group
                                label="Score"
                                v-if="question.asAnswer"
                              >
                                <b-form-select
                                  size="sm"
                                  v-model="question.score"
                                >
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
              </div>
            </b-form>
          </div>
          <div class="mb-5 px-3 text-center">
            <b-button
              size="sm"
              variant="outline-secondary"
              @click="addsection"
              block
              ><b-icon icon="plus"></b-icon> Add section</b-button
            >
          </div>
        </b-col>
        <b-col md="3" class="bg-white right_box py-4 text-center">
          <span @click="preview" class="cursor-pointer"
            >Preview <b-icon icon="eye"></b-icon
          ></span>
          <hr />
          <div class="p-3">
            <div class="mb-4">
              <div class="mb-3">
                <b-button
                  variant="outline-dark-green"
                  block
                  size="lg"
                  @click="savedraft"
                  >Save to draft</b-button
                >
              </div>
              <div>
                <b-button variant="dark-green" @click="update" block size="lg"
                  >Update Template</b-button
                >
              </div>
            </div>
          </div>
          <div class="text-left">
            <h6 class="fs15">SECTIONS</h6>
            <ul>
              <li
                v-for="(section, idx) in questionnaire.sections"
                :key="idx"
                class="text-capitalize fs14 mb-1"
              >
                {{ section.title }}
              </li>
            </ul>
          </div>
        </b-col>
      </b-row>
    </b-container>
    <b-modal hide-footer id="preview" size="xl" centered>
      <Preview :questionnaire="questionnaire"></Preview>
    </b-modal>
  </div>
</template>

<script>
import draggable from "vuedraggable";
import Preview from "./preview";
import Editor from "@tinymce/tinymce-vue";
export default {
  components: {
    draggable,
    Preview,
    editor: Editor,
  },
  data() {
    return {
      score: 20,
      current_question: 0,
      answer: false,
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
      editable: true,
      isDragging: false,
      delayedDragging: false,
    };
  },
  mounted() {
    this.getQuestionnaire();
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
    handleSubQuestion(idx, index, subId, count) {
      this.questionnaire.sections[idx].questions[index].subQuestion[
        subId
      ].responses = [];
      for (let i = 0; i < count; i++) {
        this.questionnaire.sections[idx].questions[index].subQuestion[
          subId
        ].responses.push({ response: "" });
      }
    },
    addsection() {
      this.questionnaire.sections[
        this.questionnaire.sections.length - 1
      ].showSection = false;
      this.questionnaire.sections.push({
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
      });
    },
    addquestion(idx) {
      this.questionnaire.sections[idx].questions[
        this.questionnaire.sections[idx].questions.length - 1
      ].showQuestion = false;
      this.questionnaire.sections[idx].questions.push({
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
      });
    },
    addoption(idx, index) {
      this.questionnaire.sections[idx].questions[index].options.push({
        title: "",
      });
    },
    addplaceholder(idx, index) {
      this.questionnaire.sections[idx].questions[index].placeholders.push({
        placeholder: "",
        response: "",
      });
    },
    addSubQuest(idx, index) {
      this.questionnaire.sections[idx].questions[index].subQuestion.push({
        question: "",
        placeholder: "",
        response: "",
      });
    },
    addanswer(idx, index) {
      this.questionnaire.sections[idx].questions[index].answers.push({
        title: "",
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
            this.questionnaire.id = res.data.id;
            this.questionnaire.title = res.data.title;
            this.questionnaire.type = res.data.type;
            this.questionnaire.module_id = res.data.module_id;
            this.questionnaire.course_id = res.data.course_id;
            this.questionnaire.sections = JSON.parse(res.data.sections).slice();
          }
        });
    },
    update() {
      this.questionnaire.totalscore = this.totalscore;
      this.$http
        .put(
          `${this.$store.getters.url}/question/templates/${this.questionnaire.id}`,
          this.questionnaire,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Questionnaire updated successfully");

            this.$router.go(-1);
          }
        })
        .catch(() => {
          this.$toast.error("Soemthing went wrong");
        });
    },
    savedraft() {
      this.questionnaire.totalscore = this.totalscore;
      this.$http
        .put(
          `${this.$store.getters.url}/question/drafts/${this.questionnaire.id}`,
          this.questionnaire,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Draft updated successfully");

            this.$router.go(-1);
          }
        })
        .catch(() => {
          this.$toast.error("Soemthing went wrong");
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
  max-height: calc(100vh - 80px);
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
.sect_box {
  padding: 3px 8px;
  position: absolute;
  background: var(--dark-green);
  top: 0;
  left: 0;
  font-size: 11px;
  color: white;
  border-bottom-right-radius: 10px;
}
</style>

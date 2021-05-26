<template>
  <div>
    <b-container fluid class="p-5 text-left">
      <div class="text-center">
        <h3 class="mb-4">{{ questionnaire.title }}</h3>
      </div>
      <div>
        <div
          v-for="section in questionnaire.sections"
          :key="section.title"
          class="mb-4 border-bottom"
        >
          <h5 class="font-weight-bold mb-3">{{ section.title }}</h5>

          <div v-for="question in section.questions" :key="question.title">
            <b-form-group :label="question.question">
              <div v-if="question.type == 'short'">
                <b-form-input
                  :placeholder="question.placeholder"
                ></b-form-input>
              </div>
              <div v-if="question.type == 'long'">
                <b-form-textarea
                  :placeholder="question.placeholder"
                ></b-form-textarea>
              </div>

              <div v-if="question.type == 'single'">
                <b-form-radio
                  v-for="option in question.options"
                  :key="option.title"
                  :value="option.title"
                  >{{ option.title }}</b-form-radio
                >
              </div>
              <div
                v-if="question.type == 'multiple'"
                class="d-flex align-items-center"
              >
                <b-form-input
                  :placeholder="question.placeholder"
                ></b-form-input>
                <b-button> <b-icon icon="x"></b-icon></b-button>
                <b-button variant="lighter-green">
                  <b-icon icon="plus"></b-icon
                ></b-button>
              </div>
              <div v-if="question.type == 'checkbox'">
                <b-form-checkbox
                  v-for="option in question.options"
                  :key="option.title"
                  :value="option.title"
                  >{{ option.title }}</b-form-checkbox
                >
              </div>

              <div v-if="question.type == 'boolean'">
                <b-form-radio value="true">True</b-form-radio>
                <b-form-radio value="false">False</b-form-radio>
              </div>

              <div v-if="question.type == 'dropdown'">
                <b-form-select>
                  <b-form-select-option
                    v-for="option in question.options"
                    :key="option.title"
                    :value="option.title"
                    >{{ option.title }}</b-form-select-option
                  >
                </b-form-select>
              </div>

              <div v-if="question.type == 'range'">
                <b-form-input type="range" min="0" max="10"></b-form-input>
              </div>
              <div v-if="question.type == 'email'">
                <b-form-input type="email"></b-form-input>
              </div>
              <div v-if="question.type == 'number'">
                <b-form-input type="number"></b-form-input>
              </div>
              <div v-if="question.type == 'time'">
                <b-form-input type="time"></b-form-input>
              </div>
              <div v-if="question.type == 'date'">
                <b-form-input type="date"></b-form-input>
              </div>
              <div v-if="question.type == 'color'">
                <b-form-input type="color"></b-form-input>
              </div>
            </b-form-group>
          </div>
        </div>
      </div>
    </b-container>
  </div>
</template>
<script>
export default {
  props: ["questionnaire"],
};
</script>

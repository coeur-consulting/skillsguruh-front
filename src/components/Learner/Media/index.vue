<template>
  <div>
    <b-container>
      <b-row>
        <b-col sm="8" class="px-0">
          <div class="main_cont">
            <div>
              <AudioMedia v-if="type == 'audio'" :media="media" />
              <VideoMedia v-if="type == 'video'" :media="media" />
              <PdfMedia v-if="type == 'document'" :media="media" />
              <div v-if="type == 'template'" class="pr-sm-3">
                <div
                  v-if="
                    myquestionnaire.find(
                      (item) => item.question_template_id == media.template.id
                    ) &&
                    myquestionnaire.find(
                      (item) => item.question_template_id == media.template.id
                    ).status !== 'edit'
                  "
                  style="height: 500px"
                  class="
                    d-flex
                    align-items-center
                    justify-content-center
                    bg-white
                  "
                >
                  <div
                    v-if="
                      myquestionnaire.find(
                        (item) => item.question_template_id == media.template.id
                      ) &&
                      myquestionnaire.find(
                        (item) => item.question_template_id == media.template.id
                      ).status == 'draft'
                    "
                  >
                    <h3 class="mb-4">Saved for later</h3>

                    <div>
                      <b-icon
                        icon="check2-circle"
                        variant="dark-green"
                        font-scale="5"
                        class="mb-4"
                      ></b-icon>
                    </div>
                    <b-button
                      variant="lighter-green"
                      @click="
                        editresponse(
                          myquestionnaire.find(
                            (item) =>
                              item.question_template_id == media.template.id
                          ).id
                        )
                      "
                      >Edit response</b-button
                    >
                  </div>
                  <div
                    class="text-center"
                    v-if="
                      myquestionnaire.find(
                        (item) => item.question_template_id == media.template.id
                      ) &&
                      myquestionnaire.find(
                        (item) => item.question_template_id == media.template.id
                      ).status == 'submitted'
                    "
                  >
                    <h3 class="mb-4">Submitted</h3>

                    <div>
                      <b-icon
                        icon="check2-circle"
                        variant="dark-green"
                        font-scale="5"
                        class="mb-4"
                      ></b-icon>
                    </div>
                    <b-button
                      variant="lighter-green"
                      @click="$router.push('/learner/assessments')"
                      >View response</b-button
                    >
                  </div>
                </div>
                <Questionnaire
                  v-else
                  :myquestionnaire="
                    myquestionnaire.find(
                      (item) => item.question_template_id == media.template.id
                    )
                  "
                  @handleCheck="handleCheck"
                  :module_id="module_id"
                  :id="media.template.id"
                  :course_id="$route.params.id"
                />
              </div>
            </div>
            <div class="text-left py-3 pr-sm-3">
              <div class="d-flex align-items-center mb-1 px-3">
                <h6
                  class="
                    text-capitalize
                    font-weight-bold
                    text-left
                    pr-sm-3
                    border-right
                  "
                >
                  {{ course.title }}
                </h6>

                <h6 class="text-capitalize ml-3">
                  {{ media.title }}
                </h6>
              </div>

              <p class="px-3">{{ media.overview }}</p>

              <div class="">
                <div no-body class="library-card">
                  <b-tabs card class="library">
                    <b-tab title="Overview" active>
                      <div>
                        <h6 class="font-weight-bold">About this course</h6>

                        <b-card-text>{{ course.description }}</b-card-text>
                      </div>
                    </b-tab>
                    <b-tab class="d-block d-sm-none" title="Modules">
                      <div>
                        <h6>Modules</h6>

                        <div
                          class="accordion"
                          role="tablist"
                          v-if="course.modules && course.modules.length"
                        >
                          <b-card
                            no-body
                            class="mb-1"
                            v-for="(item, id) in course.modules"
                            :key="id"
                          >
                            <b-card-header
                              header-tag="header"
                              class="p-1 bg-light rounded"
                              role="tab"
                              v-b-toggle="'module' + id"
                              @click="
                                updateProgress(id + 1, course.modules.length)
                              "
                            >
                              <b-form-checkbox
                                :disabled="id + 1 <= Number(current)"
                                :checked="id + 1 <= Number(current)"
                              >
                                <div variant="info">
                                  <b-icon
                                    icon="check2-circle"
                                    class="mr-2"
                                    variant="light-green"
                                  ></b-icon>
                                  {{ item.module }}
                                </div>
                              </b-form-checkbox>
                            </b-card-header>
                            <b-collapse
                              :id="'module' + id"
                              accordion="my-accordion"
                              role="tabpanel"
                            >
                              <b-card-body
                                class="py-1 mb-4"
                                :class="{
                                  'border-bottom':
                                    JSON.parse(item.modules).length > 1,
                                }"
                                v-for="(mod, index) in JSON.parse(
                                  item.modules
                                ).filter(
                                  (item) => item.file_type !== 'template'
                                )"
                                :key="index"
                              >
                                <b-card-text
                                  class="
                                    d-flex
                                    text-capitalize
                                    align-items-center
                                    mb-2
                                  "
                                >
                                  <div>
                                    <div class="flex-1 fs14">
                                      {{ mod.title }}
                                    </div>

                                    <div class="fs10 text-dark-green mr-3">
                                      {{ mod.file_type }}
                                    </div>
                                  </div>
                                  <b-button
                                    class="my-2 ml-auto fs12"
                                    @click="
                                      play(
                                        mod,

                                        item.id
                                      )
                                    "
                                    size="sm"
                                    variant="dark-green"
                                    ><b-icon icon="play-fill"></b-icon>
                                    {{
                                      mod.file_type == "document" ||
                                      mod.file_type == "template"
                                        ? "View"
                                        : "Play"
                                    }}</b-button
                                  >
                                </b-card-text>
                              </b-card-body>

                              <b-card-body
                                v-if="
                                  JSON.parse(item.modules).filter(
                                    (item) => item.file_type == 'template'
                                  ) &&
                                  JSON.parse(item.modules).filter(
                                    (item) => item.file_type == 'template'
                                  ).length
                                "
                              >
                                <h6>Worksheet</h6>
                                <b-card-body
                                  class="py-1 px-0"
                                  v-for="(mod, index) in JSON.parse(
                                    item.modules
                                  ).filter(
                                    (item) => item.file_type == 'template'
                                  )"
                                  :key="index"
                                >
                                  <b-card-text
                                    class="
                                      d-flex
                                      text-capitalize
                                      align-items-center
                                      mb-2
                                    "
                                  >
                                    <div
                                      class="flex-1 fs14"
                                      @click="
                                        play(
                                          mod,

                                          item.id
                                        )
                                      "
                                    >
                                      {{ mod.title }}
                                    </div>

                                    <!-- <div class="fs10 text-dark-green mr-3">
                          {{ mod.template.type }}
                        </div> -->

                                    <b-icon
                                      v-b-popover.hover.top="'Submitted'"
                                      v-if="
                                        myquestionnaire.find(
                                          (item) =>
                                            item.question_template_id ==
                                            mod.template.id
                                        ) &&
                                        myquestionnaire.find(
                                          (item) =>
                                            item.question_template_id ==
                                            mod.template.id
                                        ).status == 'submitted'
                                      "
                                      variant="dark-green"
                                      icon="check-circle-fill"
                                    ></b-icon>
                                    <b-icon
                                      v-b-popover.hover.top="'Draft'"
                                      v-if="
                                        myquestionnaire.find(
                                          (item) =>
                                            item.question_template_id ==
                                            mod.template.id
                                        ) &&
                                        myquestionnaire.find(
                                          (item) =>
                                            item.question_template_id ==
                                            mod.template.id
                                        ).status == 'draft'
                                      "
                                      variant="warning"
                                      icon="stop-circle-fill"
                                    ></b-icon>
                                    <b-icon
                                      v-b-popover.hover.top="'Begin'"
                                      v-if="
                                        !myquestionnaire.find(
                                          (item) =>
                                            item.question_template_id ==
                                            mod.template.id
                                        )
                                      "
                                      icon="play-circle-fill"
                                    ></b-icon>

                                    <!-- <b-button
                        class="my-2 ml-auto fs12"

                        size="sm"
                        variant="dark-green"
                        ><b-icon icon="play-fill"></b-icon>
                        {{ "View" }}</b-button
                      > -->
                                  </b-card-text>
                                </b-card-body>
                              </b-card-body>
                            </b-collapse>
                          </b-card>
                        </div>

                        <div v-else>
                          <div
                            class="accordion"
                            role="tablist"
                            v-if="course.courseoutline"
                          >
                            <b-card
                              no-body
                              class="mb-1"
                              v-for="(item, id) in JSON.parse(
                                course.courseoutline.modules
                              )"
                              :key="id"
                            >
                              <b-card-header
                                header-tag="header"
                                class="p-1 bg-light rounded"
                                role="tab"
                              >
                                <div v-b-toggle="'module' + id" variant="info">
                                  <b-icon
                                    icon="check2-circle"
                                    variant="light-green"
                                  ></b-icon>
                                  {{ item }}
                                </div>
                              </b-card-header>
                              <b-collapse
                                :id="'module' + id"
                                accordion="my-accordion"
                                role="tabpanel"
                              >
                                <b-card-body>
                                  <b-card-text>Unavailable</b-card-text>
                                </b-card-body>
                              </b-collapse>
                            </b-card>
                          </div>
                        </div>
                      </div>
                    </b-tab>

                    <b-tab title="Faqs">
                      <div
                        class="mb-4 bg-light rounded border"
                        v-for="(item, id) in faqs"
                        :key="id"
                      >
                        <div class="p-2 bg-light rounded">
                          <div class="fs13">
                            <b-icon
                              icon="question-circle-fill"
                              class="mr-2 text-light-green"
                            ></b-icon>
                            {{ item.question }}
                          </div>
                        </div>
                        <div :id="'file' + id" class="p-2 bg-white">
                          <p class="fs13">
                            <b-icon
                              icon="check-circle-fill"
                              class="mr-2 text-light-green"
                            ></b-icon>
                            {{ item.answer }}
                          </p>
                        </div>
                      </div>
                    </b-tab>
                    <b-tab title="Reviews">
                      <div class="p-3 mb-3">
                        <b-form @submit.prevent="postReview">
                          <b-form-group>
                            <b-form-textarea v-model="review"></b-form-textarea>
                          </b-form-group>
                          <b-form-group class="mb-3">
                            <star-rating
                              v-model="score"
                              :star-size="20"
                              :show-rating="false"
                            ></star-rating>
                          </b-form-group>
                          <b-button size="sm" type="submit"
                            >Leave a review</b-button
                          >
                        </b-form>
                      </div>

                      <div
                        v-for="review in reviews"
                        :key="review.id"
                        class="d-flex mb-3 align-items-start"
                      >
                        <b-avatar
                          class="mr-2"
                          :src="review.user.profile"
                          size="2rem"
                        ></b-avatar>
                        <div>
                          <span class="fs12 font-weight-bold">{{
                            review.user.name
                          }}</span>
                          <p class="fs15 mb-1">{{ review.review }}</p>
                          <star-rating
                            v-model="review.score"
                            :star-size="16"
                            :read-only="true"
                            :show-rating="false"
                          ></star-rating>
                        </div>
                      </div>
                    </b-tab>
                    <b-tab title="Notes">
                      <b-card-text>{{ notes }}</b-card-text>
                    </b-tab>
                  </b-tabs>
                </div>
              </div>
            </div>
          </div>
        </b-col>
        <b-col
          sm="4"
          class="bg-white text-left p-3 d-none d-sm-block"
          v-if="course.modules"
        >
          <h6>Modules</h6>

          <div
            class="accordion"
            role="tablist"
            v-if="course.modules && course.modules.length"
          >
            <b-card
              no-body
              class="mb-1"
              v-for="(item, id) in course.modules"
              :key="id"
            >
              <b-card-header
                header-tag="header"
                class="p-1 bg-light rounded"
                role="tab"
                v-b-toggle="'module' + id"
                @click="updateProgress(id + 1, course.modules.length)"
              >
                <b-form-checkbox
                  :disabled="id + 1 <= Number(current)"
                  :checked="id + 1 <= Number(current)"
                >
                  <div variant="info">
                    <b-icon
                      icon="check2-circle"
                      class="mr-2"
                      variant="light-green"
                    ></b-icon>
                    {{ item.module }}
                  </div>
                </b-form-checkbox>
              </b-card-header>
              <b-collapse
                :id="'module' + id"
                accordion="my-accordion"
                role="tabpanel"
              >
                <b-card-body
                  class="py-1 mb-4"
                  :class="{
                    'border-bottom': JSON.parse(item.modules).length > 1,
                  }"
                  v-for="(mod, index) in JSON.parse(item.modules).filter(
                    (item) => item.file_type !== 'template'
                  )"
                  :key="index"
                >
                  <b-card-text
                    class="d-flex text-capitalize align-items-center mb-2"
                  >
                    <div>
                      <div class="flex-1 fs14">{{ mod.title }}</div>

                      <div class="fs10 text-dark-green mr-3">
                        {{ mod.file_type }}
                      </div>
                    </div>
                    <b-button
                      class="my-2 ml-auto fs12"
                      @click="
                        play(
                          mod,

                          item.id
                        )
                      "
                      size="sm"
                      variant="dark-green"
                      ><b-icon icon="play-fill"></b-icon>
                      {{
                        mod.file_type == "document" ||
                        mod.file_type == "template"
                          ? "View"
                          : "Play"
                      }}</b-button
                    >
                  </b-card-text>
                </b-card-body>

                <b-card-body
                  v-if="
                    JSON.parse(item.modules).filter(
                      (item) => item.file_type == 'template'
                    ) &&
                    JSON.parse(item.modules).filter(
                      (item) => item.file_type == 'template'
                    ).length
                  "
                >
                  <h6>Worksheet</h6>
                  <b-card-body
                    class="py-1 px-0"
                    v-for="(mod, index) in JSON.parse(item.modules).filter(
                      (item) => item.file_type == 'template'
                    )"
                    :key="index"
                  >
                    <b-card-text
                      class="d-flex text-capitalize align-items-center mb-2"
                    >
                      <div
                        class="flex-1 fs14"
                        @click="
                          play(
                            mod,

                            item.id
                          )
                        "
                      >
                        {{ mod.title }}
                      </div>

                      <!-- <div class="fs10 text-dark-green mr-3">
                          {{ mod.template.type }}
                        </div> -->

                      <b-icon
                        v-b-popover.hover.top="'Submitted'"
                        v-if="
                          myquestionnaire.find(
                            (item) =>
                              item.question_template_id == mod.template.id
                          ) &&
                          myquestionnaire.find(
                            (item) =>
                              item.question_template_id == mod.template.id
                          ).status == 'submitted'
                        "
                        variant="dark-green"
                        icon="check-circle-fill"
                      ></b-icon>
                      <b-icon
                        v-b-popover.hover.top="'Draft'"
                        v-if="
                          myquestionnaire.find(
                            (item) =>
                              item.question_template_id == mod.template.id
                          ) &&
                          myquestionnaire.find(
                            (item) =>
                              item.question_template_id == mod.template.id
                          ).status == 'draft'
                        "
                        variant="warning"
                        icon="stop-circle-fill"
                      ></b-icon>
                      <b-icon
                        v-b-popover.hover.top="'Begin'"
                        v-if="
                          !myquestionnaire.find(
                            (item) =>
                              item.question_template_id == mod.template.id
                          )
                        "
                        icon="play-circle-fill"
                      ></b-icon>
                      <!-- <b-button
                        class="my-2 ml-auto fs12"

                        size="sm"
                        variant="dark-green"
                        ><b-icon icon="play-fill"></b-icon>
                        {{ "View" }}</b-button
                      > -->
                    </b-card-text>
                  </b-card-body>
                </b-card-body>
              </b-collapse>
            </b-card>
          </div>

          <div v-else>
            <div class="accordion" role="tablist" v-if="course.courseoutline">
              <b-card
                no-body
                class="mb-1"
                v-for="(item, id) in JSON.parse(course.courseoutline.modules)"
                :key="id"
              >
                <b-card-header
                  header-tag="header"
                  class="p-1 bg-light rounded"
                  role="tab"
                >
                  <div v-b-toggle="'module' + id" variant="info">
                    <b-icon icon="check2-circle" variant="light-green"></b-icon>
                    {{ item }}
                  </div>
                </b-card-header>
                <b-collapse
                  :id="'module' + id"
                  accordion="my-accordion"
                  role="tabpanel"
                >
                  <b-card-body>
                    <b-card-text>Unavailable</b-card-text>
                  </b-card-body>
                </b-collapse>
              </b-card>
            </div>
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import AudioMedia from "./audio";
import VideoMedia from "./video";
import PdfMedia from "./pdf";
import Questionnaire from "../viewMediaQuestionnaire";
import StarRating from "vue-star-rating";
export default {
  data() {
    return {
      type: "video",
      media: {},
      faqs: [],
      notes: "",
      course: {},
      questionnaire_id: null,
      module_id: null,
      myquestionnaire: [],
      checked: {},
      current: null,
      review: null,
      score: null,
      reviews: [],
    };
  },
  components: {
    AudioMedia,
    VideoMedia,
    PdfMedia,
    Questionnaire,
    StarRating,
  },
  mounted() {
    this.getQuestionnaire();
  },
  methods: {
    editresponse(id) {
      this.$http
        .get(`${this.$store.getters.url}/edit/response/${id}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.getQuestionnaire();
          }
        });
    },
    handleCheck() {
      this.getQuestionnaire();
    },
    postReview() {
      var data = {
        id: this.$route.params.id,
        review: this.review,
        score: this.score,
      };
      this.$http
        .post(`${this.$store.getters.url}/reviews`, data, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.reviews.unshift(res.data);
          }
        });
    },
    updateProgress(current, total) {
      var data = {
        id: this.$route.params.id,
        total_modules: total,
        current_module: current,
      };
      this.$http
        .post(`${this.$store.getters.url}/update/progress`, data, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then();
    },
    getQuestionnaire() {
      this.$http
        .get(
          `${this.$store.getters.url}/answer-questionnaires/${this.$route.params.id}`,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.myquestionnaire = res.data;
            this.getLibrary();
          }
        });
    },
    getLibrary() {
      this.$http
        .get(`${this.$store.getters.url}/libraries/${this.$route.params.id}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.reviews = res.data.course.review;
            this.current = res.data.current_module;
            this.course = res.data.course;
            this.faqs = JSON.parse(res.data.course.courseoutline.faqs);
            this.notes = res.data.course.courseoutline.additional_info;
            if (this.course.modules.length) {
              this.media = JSON.parse(this.course.modules[0].modules)[0];
              this.module_id = this.course.modules[0].id;
              if (this.course.modules[0].questionnaire) {
                this.questionnaire_id = this.course.modules[0].questionnaire.id;
              }

              this.type = JSON.parse(
                this.course.modules[0].modules
              )[0].file_type;
            }
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    play(mod, module_id) {
      this.media = mod;
      this.type = mod.file_type.toLowerCase();
      this.module_id = module_id;
    },

    viewquestion(id) {
      this.$http
        .get(`${this.$store.getters.url}/answer-questionnaires/${id}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            if (!res.data) {
              this.questionnaire_id = id;
              this.$bvModal.show("questionnaire");
              return;
            }
            console.log("addes");
            this.$toast.info("Already submitted");
          }
        });
    },
  },
};
</script>

<style scoped>
.main_cont {
  max-height: calc(100vh - 80px);
  overflow-y: auto;
  -ms-overflow-style: none; /* IE and Edge */
  scrollbar-width: none; /* Firefox */
}

.main_cont::-webkit-scrollbar {
  display: none;
}
</style>

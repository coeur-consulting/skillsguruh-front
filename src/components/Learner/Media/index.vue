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
            </div>
            <div class="text-left py-3 pr-3">
              <h5 class="font-weight-bold text-capitalize">
                {{ media.title }}
              </h5>

              <div>
                <div no-body class="library-card">
                  <b-tabs card class="library">
                    <b-tab title="Overview" active>
                      <div>
                        <h6 class="font-weight-bold">About</h6>
                        <b-card-text>{{ media.overview }}</b-card-text>
                      </div>
                    </b-tab>
                    <b-tab title="Questionnaire">
                      <div class="text-center py-3" v-if="checked">
                        <p class="text-muted mb-3 fs16">Already Submitted</p>
                        <b-icon
                          icon="check2-circle"
                          font-scale="5rem"
                          variant="dark-green"
                        ></b-icon>
                      </div>
                      <div v-else>
                        <Questionnaire
                          @handleCheck="handleCheck"
                          :id="questionnaire_id"
                          v-if="questionnaire_id"
                          :course_id="$route.params.id"
                        />
                        <b-card-text v-else>None Available</b-card-text>
                      </div>
                    </b-tab>
                    <b-tab title="Faqs">
                      <div
                        class="mb-4 bg-light border"
                        v-for="(item, id) in faqs"
                        :key="id"
                      >
                        <div class="p-2 bg-light">
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
                    <b-tab title="Notes">
                      <b-card-text>{{ notes }}</b-card-text>
                    </b-tab>
                  </b-tabs>
                </div>
              </div>
            </div>
          </div>
        </b-col>
        <b-col sm="4" class="bg-white text-left p-3" v-if="course.modules">
          <h6>Modules</h6>
          <div class="accordion" role="tablist" v-if="course.modules.length">
            <b-card
              no-body
              class="mb-1"
              v-for="(item, id) in course.modules"
              :key="id"
            >
              <b-card-header
                header-tag="header"
                class="p-1 bg-light"
                role="tab"
              >
                <div v-b-toggle="'module' + id" variant="info">
                  <b-icon icon="check2-circle" variant="light-green"></b-icon>
                  {{ item.module }}
                </div>
              </b-card-header>
              <b-collapse
                :id="'module' + id"
                accordion="my-accordion"
                role="tabpanel"
              >
                <b-card-body
                  class="py-1 border-bottom"
                  v-for="(mod, index) in JSON.parse(item.modules)"
                  :key="index"
                >
                  <b-card-text class="d-flex text-capitalize align-items-center"
                    ><span class="flex-1">{{ mod.title }}</span>
                    <span>
                      <span class="fs11 mr-3">{{ mod.file_type }}</span>
                      <b-button
                        class="my-2 ml-auto"
                        @click="
                          play(
                            mod,
                            item.questionnaire ? item.questionnaire.id : null,
                            item.id
                          )
                        "
                        size="sm"
                        variant="dark-green"
                        ><b-icon icon="play-fill"></b-icon>
                        {{
                          mod.file_type == "document" ? "View" : "Play"
                        }}</b-button
                      >
                    </span>
                  </b-card-text>
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
                  class="p-1 bg-light"
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
    };
  },
  components: {
    AudioMedia,
    VideoMedia,
    PdfMedia,
    Questionnaire,
  },
  created() {
    this.getLibrary();
  },
  methods: {
    handleCheck() {
      this.getLibrary();
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
            this.checkQuestionnnaire();
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
            this.getQuestionnaire();
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    play(mod, id, module_id) {
      this.media = mod;
      this.type = mod.file_type.toLowerCase();
      this.module_id = module_id;
      if (id) {
        this.questionnaire_id = id;
      } else {
        this.questionnaire_id = null;
      }
      this.checkQuestionnnaire();
    },
    checkQuestionnnaire() {
      this.checked = this.myquestionnaire.find(
        (item) =>
          item.module_id == this.module_id &&
          item.questionnaire_id == this.questionnaire_id
      );
    },
    viewquestion(id) {
      this.id = id;
      this.$bvModal.show("questionnaire");
    },
  },
};
</script>

<style scoped>
.main_cont {
  max-height: calc(100vh - 80px);
  overflow-y: auto;
}
</style>

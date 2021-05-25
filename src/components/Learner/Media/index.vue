<template>
  <div>
    <b-container>
      <b-row>
        <b-col sm="8">
          <div>
            <AudioMedia v-if="type == 'audio'" :media="media" />
            <VideoMedia v-if="type == 'video'" :media="media" />
            <PdfMedia v-if="type == 'document'" :media="media" />
          </div>
          <div class="text-left py-5">
            <h5 class="font-weight-bold mb-2 text-capitalize">
              {{ media.title }}
            </h5>
            <p>{{ media.overview }}</p>
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
                  v-for="(mod, index) in JSON.parse(item.modules)"
                  :key="index"
                >
                  <b-card-text class="d-flex text-capitalize"
                    ><span class="flex-1">{{ mod.title }}</span>
                    <span>{{ mod.file_type }}</span></b-card-text
                  >
                  <div class="text-right">
                    <b-button
                      class="my-2 ml-auto"
                      @click="play(mod)"
                      size="sm"
                      variant="dark-green"
                      ><b-icon icon="play-fill"></b-icon> Play</b-button
                    >
                  </div>
                  <h6 class="fs12 font-weight-bold mb-2">Overview</h6>
                  <b-card-text class="fs12">{{ mod.overview }}</b-card-text>
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
export default {
  data() {
    return {
      type: "video",
      media: {},
      course: {},
    };
  },
  components: {
    AudioMedia,
    VideoMedia,
    PdfMedia,
  },
  created() {
    this.getLibrary();
  },
  methods: {
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
            if (this.course.modules.length) {
              this.media = JSON.parse(this.course.modules[0].modules)[0];
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
    play(mod) {
      this.media = mod;
      this.type = mod.file_type.toLowerCase();
    },
  },
};
</script>

<style scoped></style>

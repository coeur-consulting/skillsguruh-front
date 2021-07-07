<template>
  <div>
    <b-container fluid>
      <b-row class="mb-3">
        <b-col
          class="
            bg-white
            p-3
            text-left
            d-flex
            justify-content-between
            align-items-center
          "
        >
          <div>
            <div
              class="text-muted fs13 cursor-pointer mb-2"
              @click="$router.go(-1)"
            >
              <b-icon icon="arrow-left"></b-icon> Back
            </div>
            <h5 class="text-capitalize">{{ $route.params.type }}</h5>
          </div>
          <div>
            <b-button
              @click="$bvModal.show('addassessment')"
              variant="lighter-green"
              ><b-icon icon="plus"></b-icon> New</b-button
            >
          </div>
        </b-col>
      </b-row>
      <div v-if="filter.length">
        <b-row>
          <b-col sm="4" v-for="(item, index) in filter" :key="index">
            <div
              class="
                shadow
                bg-white
                rounded
                p-3
                position-relative
                text-left
                border-left-green
              "
            >
              <div class="badge">
                <b-icon
                  icon="stop-circle-fill"
                  scale="1rem"
                  class="mr-1"
                  :class="{
                    'text-danger': $moment().isBefore($moment(item.start)),
                    'text-dark-green': $moment().isBetween(
                      $moment(item.start),
                      $moment(item.end)
                    ),
                    'text-warning': $moment().isAfter($moment(item.end)),
                  }"
                ></b-icon>
                <span
                  class="text-muted fs12 text-capitalize"
                  v-if="
                    $moment().isBetween($moment(item.start), $moment(item.end))
                  "
                  >Active</span
                >
                <span
                  class="text-muted fs12 text-capitalize"
                  v-if="$moment().isBefore($moment(item.start))"
                  >Pending</span
                >
                <span
                  class="text-muted fs12 text-capitalize"
                  v-if="$moment().isAfter($moment(item.end))"
                  >Expired</span
                >
              </div>

              <div class="font-weight-bold fs15 mb-2 text-capitalize">
                {{ item.questiontemplate.title }}
              </div>
              <h6 class="fs12 text-muted mb-2 text-capitalize">
                Course: {{ item.course.title }}
              </h6>
              <div class="fs14 text-muted mb-2">
                <span>Total score: </span>
                <span>{{
                  item.questiontemplate.totalscore
                    ? item.questiontemplate.totalscore
                    : "N/A"
                }}</span>
              </div>

              <div class="fs12 text-muted mb-2">
                <span>Duration: </span> <span>{{ item.duration }} minutes</span>
              </div>
              <div class="fs12 text-muted mb-2">
                <span>Start date: </span>
                <span>{{ item.start | moment("ll") }}</span>
              </div>
              <div class="fs12 text-muted mb-3">
                <span>Expiry date: </span>
                <span>{{ item.end | moment("ll") }}</span>
              </div>
              <div
                class="
                  fs12
                  text-muted
                  d-flex
                  justify-content-between
                  text-right
                "
              >
                <span class="fs12">
                  <span>Submitted: </span>
                  <span>{{ item.assessmentresponse.length }}</span></span
                >
                <span
                  class="text-dark-green cursor-pointer"
                  @click="viewlist(item)"
                  >View list</span
                >
              </div>
            </div>
          </b-col>
        </b-row>
        <div
          class="p-3 d-flex justify-content-between"
          v-if="assessments.length > 10"
        >
          <div class="fs12 text-muted">
            Showing {{ perPage * currentPage - perPage + 1 }}-{{
              perPage * currentPage
            }}
            of {{ assessments.length }} items
          </div>
          <b-pagination
            pills
            size="sm"
            variant="dark-green"
            align="right"
            v-model="currentPage"
            :total-rows="rows"
            :per-page="perPage"
          ></b-pagination>
        </div>
      </div>
      <b-row v-else>
        <b-col class="empty rounded p-5 text-center">
          <h2 class="mb-3 px-2 text-muted">
            No {{ $route.params.type }} Available
          </h2>
          <b-img
            class="mb-3 px-2"
            :src="require('@/assets/images/creator.svg')"
          ></b-img>
          <p class="mb-3 text-muted">
            There appears to be no {{ $route.params.type }} available <br />
            create a new one by clicking the button below
          </p>
          <b-button
            @click="$bvModal.show('addassessment')"
            variant="lighter-green"
            >Add {{ $route.params.type }}</b-button
          >
        </b-col>
      </b-row>
    </b-container>
    <b-modal no-close-on-backdrop id="addassessment" hide-footer centered>
      <b-form @submit.prevent="create">
        <b-form-group label="Choose template">
          <model-list-select
            :list="
              templates.filter((val) =>
                val.type.toLowerCase().includes($route.params.type)
              )
            "
            v-model="assessment.template"
            option-value="id"
            option-text="title"
            placeholder="select item"
          >
          </model-list-select>
        </b-form-group>
        <b-form-group label="Choose course">
          <model-list-select
            :list="courses"
            v-model="assessment.course"
            option-value="id"
            option-text="title"
            placeholder="select item"
          >
          </model-list-select>
        </b-form-group>
        <b-form-row>
          <b-col sm="6">
            <b-form-group label="Start date">
              <vc-date-picker
                placeholder="Choose start time"
                mode="dateTime"
                v-model="assessment.start"
                :is24hr="false"
              >
                <template v-slot="{ inputValue, inputEvents }">
                  <input
                    class="
                      px-2
                      py-1
                      border
                      rounded
                      focus:outline-none
                      focus:border-blue-300
                    "
                    :value="inputValue"
                    v-on="inputEvents"
                  />
                </template>
              </vc-date-picker>
            </b-form-group>
          </b-col>
          <b-col sm="6">
            <b-form-group label="End date">
              <vc-date-picker
                placeholder="Choose start time"
                mode="dateTime"
                :is24hr="false"
                v-model="assessment.end"
              >
                <template v-slot="{ inputValue, inputEvents }">
                  <input
                    class="
                      px-2
                      py-1
                      border
                      rounded
                      focus:outline-none
                      focus:border-blue-300
                    "
                    :value="inputValue"
                    v-on="inputEvents"
                  />
                </template>
              </vc-date-picker>
            </b-form-group>
          </b-col>
        </b-form-row>

        <b-row>
          <b-col cols="6">
            <b-form-group label="Duration">
              <b-input-group append="minutes">
                <b-form-input
                  v-model="assessment.duration"
                  type="number"
                ></b-form-input>
              </b-input-group>
            </b-form-group>
          </b-col>
          <b-col cols="6">
            <b-form-group label="Tools">
              <b-form-checkbox value="calculator" v-model="assessment.tools"
                >Calculator</b-form-checkbox
              >
            </b-form-group>
          </b-col>
        </b-row>
        <b-row>
          <b-col cols="12">
            <b-form-group label="Feedback">
              <b-form-textarea v-model="assessment.feedback"></b-form-textarea>
            </b-form-group>
          </b-col>
        </b-row>

        <div class="text-center mt-3">
          <b-button variant="dark-green" type="submit" class="px-4"
            >Create</b-button
          >
        </div>
      </b-form>
    </b-modal>
  </div>
</template>
<script>
import { ModelListSelect } from "vue-search-select";
export default {
  components: {
    ModelListSelect,
  },
  data() {
    return {
      search: "",
      currentPage: 1,
      rows: null,
      perPage: 10,
      assessments: [],
      solvedAssessments: [],
      template: {},
      templates: [],
      courses: [],
      assessment: {
        course: {},
        template: {},
        duration: "",
        start: new Date(),
        end: new Date(),
        feedback: "",
        tools: [],
        type: this.$route.params.type,
      },
    };
  },
  mounted() {
    this.getTemplates();
    this.getAssessments();
    this.getcourses();
  },
  computed: {
    filter() {
      return this.assessments
        .filter((item) =>
          item.questiontemplate.title
            .toLowerCase()
            .includes(this.search.toLowerCase())
        )
        .filter(
          (item) =>
            item.type.toLowerCase() == this.$route.params.type.toLowerCase()
        )
        .slice(
          this.perPage * this.currentPage - this.perPage,
          this.perPage * this.currentPage
        );
    },
  },
  methods: {
    getcourses() {
      this.$http
        .get(`${this.$store.getters.url}/courses`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.courses = res.data;
          }
        })
        .catch(() => {
          this.$toast.error("Something went wrong");
        });
    },
    create() {
      this.$http
        .post(`${this.$store.getters.url}/assessments`, this.assessment, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.assessments.unshift(res.data);
            this.$bvModal.hide("addassessment");

            this.assessment = {
              course: {},
              template: {},
              duration: "",
              start: new Date(),
              end: new Date(),
              feedback: "",
              tools: [],
              type: this.$route.params.type,
            };
          }
        })
        .catch(() => {
          this.$toast.error("Something went wrong, check all fields");
        });
    },
    drop(id, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/assessments/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success("Removed successfully");
                this.assessments.splice(index, 1);
              }
            })
            .catch(() => {
              this.$toast.error("Something went wrong, check all fields");
            });
        }
      });
    },
    async getTemplates() {
      return this.$http
        .get(`${this.$store.getters.url}/question/templates`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.templates = res.data.filter((item) => item.status == "active");
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    viewlist(item) {
      this.$router.push(`/facilitator/assessment/list/${item.id}`);
    },
    getAssessments() {
      this.$http
        .get(`${this.$store.getters.url}/assessments`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.assessments = res.data;
            this.rows = res.data.length;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getSolvedAssessments() {
      this.$http
        .get(`${this.$store.getters.url}/solved/assessments`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.assessments = res.data;
            this.rows = res.data.length;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
  },
};
</script>
<style scoped>
.badge {
  position: absolute;
  top: 13px;
  right: 13px;
}
</style>

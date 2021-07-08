<template>
  <div>
    <b-container>
      <b-row>
        <b-col class="mb-5 mb-sm-0">
          <div
            class="
              d-flex
              flex-column flex-sm-row
              justify-content-between
              align-items-center
              mb-4
            "
          >
            <div class="text-left">
              <h4 class="mb-3 mb-sm-0 text-capitalize">{{ course }}</h4>
              <h6 class="mb-sm-0 text-capitalize text-muted">
                {{ title }}
              </h6>
            </div>

            <div>
              <b-form-input
                placeholder="Search name"
                size="sm"
                type="search"
                class="search bg-white"
                v-model="search"
              ></b-form-input>
            </div>
          </div>

          <div class="border rounded bg-white">
            <div
              v-if="assessments.length"
              class="d-flex justify-content-between align-items-center p-3 e"
            >
              <b-icon icon="funnel"></b-icon>
              <div></div>
            </div>

            <div class="" v-if="assessments.length">
              <b-table-simple class="org_home_table text-left" responsive="sm">
                <b-thead>
                  <b-tr class="text-left">
                    <b-th class="text-muted">Name</b-th>
                    <b-th class="text-muted">Student score</b-th>
                    <b-th class="text-muted">Total score</b-th>

                    <b-th class="text-muted">Action</b-th>
                  </b-tr></b-thead
                >
                <b-tbody>
                  <b-tr v-for="item in filter" :key="item.id">
                    <b-td>
                      <div class="d-flex">
                        <b-avatar
                          :src="item.profile"
                          size="sm"
                          class="mr-2"
                        ></b-avatar>
                        <div class="text-left">
                          <span class="text-capitalize">{{
                            item.user.name
                          }}</span>
                        </div>
                      </div>
                    </b-td>

                    <b-td class="text-capitalize">
                      {{ item.your_score }}
                    </b-td>
                    <b-td class="text-left">{{ item.total_score }}</b-td>

                    <b-td
                      ><b-button-group size="sm">
                        <b-button
                          variant="light"
                          @click="viewsheet(item)"
                          class="fs12 text-muted px-2"
                          >View response</b-button
                        >
                        <b-button variant="lighter-green">
                          <b-icon
                            icon="three-dots"
                            class="cursor-pointer"
                            :id="item.id.toString() + item.name"
                          ></b-icon>
                        </b-button>
                      </b-button-group>

                      <b-popover
                        :target="item.id.toString() + item.name"
                        triggers="hover"
                        placement="bottom"
                      >
                        <div class=""></div>
                      </b-popover>
                    </b-td>
                  </b-tr>
                </b-tbody>
              </b-table-simple>
              <div class="p-3 d-flex justify-content-between" v-if="rows > 10">
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
            <div v-else class="text-center admin_tab p-3 p-sm-5">
              <div>
                <b-img :src="require('@/assets/images/creator.svg')"></b-img>
                <h6 class="text-muted my-3 fs14">Nothing available</h6>
              </div>
            </div>
          </div>
        </b-col>
      </b-row>
    </b-container>

    <b-modal
      no-close-on-backdrop
      id="viewsheet"
      hide-footer
      centered
      size="lg"
      v-if="result"
    >
      <Approved :myquestionnaire="result" />
    </b-modal>
  </div>
</template>
<script>
import Approved from "./approveAssessment.vue";
export default {
  data() {
    return {
      id: null,
      course: null,
      search: "",
      currentPage: 1,
      rows: null,
      perPage: 10,
      assessments: [],
      title: "",
      result: {},
      myquestionnaire: null,
    };
  },
  computed: {
    filter() {
      return this.assessments
        .filter((item) =>
          item.user.name.toLowerCase().includes(this.search.toLowerCase())
        )
        .slice(
          this.perPage * this.currentPage - this.perPage,
          this.perPage * this.currentPage
        );
    },
  },
  components: {
    Approved,
  },
  mounted() {
    this.getassessments();
  },
  methods: {
    getassessments() {
      this.$http
        .get(
          `${this.$store.getters.url}/assessments/${this.$route.params.id}`,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.course = res.data.course.title;
            this.title = res.data.questiontemplate.title;
            this.assessments = res.data.assessmentresponse;
            this.rows = res.data.assessmentresponse.length;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    viewsheet(value) {
      this.result = value;

      this.$bvModal.show("viewsheet");
    },
    update() {
      this.$http
        .put(
          `${this.$store.getters.url}/facilitator-update-user/${this.user.id}`,
          this.user,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Update successful");
            this.$bvModal.hide("edit");
            this.user = {
              name: "",
              email: "",
              phone: "",
              password: "",
            };
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
  },
};
</script>
<style scoped lang="scss">
.container {
  padding-top: 30px;
}
.shadow {
  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
  border-radius: 8px;
}
.search.form-control {
  width: 250px;
  border: 1px solid rgba($color: #000000, $alpha: 0.07) !important;
}
.search::placeholder {
  color: rgba($color: #000000, $alpha: 0.2);
}
.admin_tab {
  min-height: 350px;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>

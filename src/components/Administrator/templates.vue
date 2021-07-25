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
            <h6 class="mb-3 mb-sm-0">Templates</h6>
            <div>
              <b-form-input
                placeholder="Search"
                size="sm"
                type="search"
                class="search"
                v-model="search"
              ></b-form-input>
            </div>
          </div>

          <div class="border rounded bg-white">
            <div
              class="d-flex justify-content-between align-items-center p-3 e"
            >
              <b-icon icon="funnel"></b-icon>
              <div class="d-flex align-items-center">
                <div class="mr-4">
                  <b-form-checkbox
                    v-model="team"
                    size="sm"
                    name="check-button"
                    switch
                  >
                    View Drafts
                  </b-form-checkbox>
                </div>
                <b-button
                  size="sm"
                  variant="lighter-green"
                  class="fs12"
                  @click="$bvModal.show('options')"
                >
                  <b-icon icon="plus" font-scale=""></b-icon>
                </b-button>
              </div>
            </div>

            <div class="" v-if="filter.length">
              <b-table-simple class="org_home_table text-left" responsive="sm">
                <b-thead>
                  <b-tr class="text-left">
                    <b-th class="text-muted">Title</b-th>
                    <b-th class="text-muted">Type</b-th>
                    <b-th class="text-muted">Status</b-th>
                    <b-th class="text-muted">Created</b-th>
                    <b-th class="text-muted"> Updated</b-th>
                    <b-th></b-th> </b-tr
                ></b-thead>
                <b-tbody class="text-left">
                  <b-tr v-for="(item, index) in filter" :key="item.id">
                    <b-td>
                      <div class="d-flex">
                        <div class="text-left">
                          <span class="text-capitalize">
                            {{ item.title }}
                          </span>
                        </div>
                      </div>
                    </b-td>
                    <b-td>
                      <div class="d-flex">
                        <div class="text-left">
                          <span class="text-capitalize">
                            {{ item.type }}
                          </span>
                        </div>
                      </div>
                    </b-td>
                    <b-td>
                      <div class="d-flex">
                        <div class="text-left">
                          <span class="text-capitalize text-dark-green">
                            {{ item.status }}
                          </span>
                        </div>
                      </div>
                    </b-td>

                    <b-td class="text-left">
                      {{ item.created_at | moment("ll") }}</b-td
                    >

                    <b-td>{{ item.updated_at | moment("ll") }}</b-td>
                    <b-td class="text-right">
                      <b-button-group size="sm">
                        <b-button
                          variant="light"
                          @click="view(item.id)"
                          class="fs12 px-2 text-muted"
                          >View</b-button
                        >
                        <b-button variant="lighter-green">
                          <b-icon
                            icon="three-dots"
                            class="cursor-pointer"
                            :id="item.id.toString() + item.title"
                          ></b-icon>
                        </b-button>
                      </b-button-group>

                      <b-popover
                        :target="item.id.toString() + item.title"
                        triggers="hover"
                        placement="bottom"
                      >
                        <div class="">
                          <small
                            @click="edit(item.id)"
                            class="px-0 text-left cursor-pointer"
                          >
                            <b-icon class="mr-2" icon="eye"></b-icon
                            ><span>Edit</span>
                          </small>
                          <br />

                          <hr class="my-1" />
                          <small
                            class="px-0 cursor-pointer"
                            @click="drop(item.id, index)"
                          >
                            <b-icon class="mr-2" icon="trash"></b-icon
                            ><span>Drop</span>
                          </small>
                        </div>
                      </b-popover>
                    </b-td>
                  </b-tr>
                </b-tbody>
              </b-table-simple>
              <div class="p-3 d-flex justify-content-between" v-if="rows > 10">
                <div class="fs12 text-muted">
                  Showing 1-10 of {{ filter.length }} items
                </div>
                <b-pagination
                  pills
                  size="sm"
                  variant="dark-green"
                  align="right"
                  v-model="currentPage"
                  :total-rows="filter"
                  :per-page="perPage"
                ></b-pagination>
              </div>
            </div>
            <div v-else class="text-center admin_tab p-3 p-sm-5">
              <div>
                <b-img :src="require('@/assets/images/creator.svg')"></b-img>
                <h6 class="text-muted my-3 fs14">
                  It appears you havent added any template yet,
                  <br class="d-none d-sm-block" />
                  Create your first template now!
                </h6>
                <b-button
                  @click="$bvModal.show('create')"
                  variant="dark-green"
                  size="lg"
                  >Create Template</b-button
                >
              </div>
            </div>
          </div>
        </b-col>
      </b-row>
    </b-container>
    <b-modal no-close-on-backdrop size="xl" id="create" centered hide-footer>
      <CreateQuestion
        @close="close"
        @addtemplate="addtemplate"
        :options="options"
      />
    </b-modal>
    <b-modal id="options" size="sm" hide-header centered hide-footer>
      <div class="">
        <h5 class="mb-4">Choose options</h5>

        <b-form-group>
          <b-form-checkbox v-model="options.grading">Grading</b-form-checkbox>
        </b-form-group>
        <b-form-group>
          <b-form-checkbox v-model="options.time">Timed</b-form-checkbox>
        </b-form-group>
        <!-- <b-form-group>
          <b-form-checkbox v-model="options.correct_answer"
            >Correct answer</b-form-checkbox
          >
        </b-form-group> -->
        <b-form-group class="text-center mt-2">
          <b-button @click="save">Save and continue</b-button>
        </b-form-group>
      </div>
    </b-modal>
  </div>
</template>
<script>
import CreateQuestion from "./Templates/create.vue";
export default {
  data() {
    return {
      id: null,
      search: "",
      currentPage: 1,
      rows: null,
      perPage: 10,
      questionnaires: [],
      title: "",
      template: {},
      team: false,
      options: {
        grading: false,
        correct_answer: false,
        time: false,
      },
    };
  },
  components: {
    CreateQuestion,
  },
  computed: {
    filter() {
      var questions = this.questionnaires
        .filter((item) =>
          item.title.toLowerCase().includes(this.search.toLowerCase())
        )
        .slice(
          this.perPage * this.currentPage - this.perPage,
          this.perPage * this.currentPage
        );
      return this.team
        ? questions.filter((item) => item.status == "draft")
        : questions.filter((item) => item.status == "active");
    },
  },
  mounted() {
    this.getquestionnaires();
    if (this.$route.query.showing) {
      this.search = this.$route.query.showing;
    }
  },
  methods: {
    save() {
      this.$bvModal.hide("options");
      this.$bvModal.show("create");
    },
    addtemplate() {
      this.getquestionnaires();
    },
    close() {
      this.$bvModal.hide("create");
      this.getquestionnaires();
    },
    async getquestionnaires() {
      return this.$http
        .get(`${this.$store.getters.url}/question/templates`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.questionnaires = res.data;
            this.rows = res.data.length;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    async getquestions() {
      return this.$http
        .get(`${this.$store.getters.url}/question/drafts`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.drafts = res.data;
            this.rows = res.data.length;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    edit(id) {
      this.$router.push(`/administrator/question/template/edit/${id}`);
    },
    view(id) {
      this.$router.push(`/administrator/question/template/${id}`);
    },

    drop(id) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/question/templates/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success("Removed successfully");
                this.getquestionnaires();
              }
            })
            .catch((err) => {
              this.$toast.error(err.response.data.message);
            });
        }
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
</style>

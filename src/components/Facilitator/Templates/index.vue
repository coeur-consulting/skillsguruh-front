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
            <h6 class="mb-3 mb-sm-0">Questionnaires</h6>
            <div>
              <b-form-input
                placeholder="Search"
                readonly
                size="sm"
                type="search"
                class="search"
                v-model="search"
              ></b-form-input>
            </div>
          </div>

          <div class="shadow bg-white">
            <div
              class="d-flex justify-content-between align-items-center p-3 e"
            >
              <b-icon icon="funnel"></b-icon>
              <div></div>
            </div>

            <div class="">
              <b-table-simple class="org_home_table text-left" responsive="sm">
                <b-thead>
                  <b-tr class="text-left">
                    <b-th class="text-muted">Module/Course</b-th>
                    <b-th class="text-muted">title</b-th>

                    <b-th class="text-muted">Created</b-th>
                    <b-th class="text-muted"> Updated</b-th>
                    <b-th></b-th> </b-tr
                ></b-thead>
                <b-tbody class="text-left">
                  <b-tr v-for="(item, index) in filter" :key="item.id">
                    <b-td class="text-left">
                      <span>{{ item.module }} </span>
                    </b-td>
                    <b-td>
                      <div class="d-flex">
                        <div class="text-left">
                          <span class="text-capitalize">
                            {{ item.title }}
                          </span>
                        </div>
                      </div>
                    </b-td>

                    <b-td class="text-left">
                      {{ item.created_at | moment("ll") }}</b-td
                    >

                    <b-td>{{ item.updated_at | moment("ll") }}</b-td>
                    <b-td
                      ><b-icon
                        icon="chevron-down"
                        class="cursor-pointer"
                        :id="item.id.toString() + item.title"
                      ></b-icon>
                      <b-popover
                        :target="item.id.toString() + item.title"
                        triggers="hover"
                        placement="bottom"
                      >
                        <div class="">
                          <small
                            @click="view(item.id)"
                            class="px-0 text-left cursor-pointer"
                          >
                            <b-icon class="mr-2" icon="eye"></b-icon
                            ><span>View</span>
                          </small>
                          <br />
                          <hr class="my-1" />
                          <small
                            class="px-0 text-left cursor-pointer"
                            @click="edit(item.id)"
                          >
                            <b-icon class="mr-2" icon="pencil"></b-icon
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
              <div class="p-3 d-flex justify-content-between">
                <div class="fs12 text-muted">
                  Showing 1-10 of {{ filter.length }} items
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
      id: null,
      search: "",
      currentPage: 1,
      rows: null,
      perPage: 10,
      questionnaires: [],

      title: "",
    };
  },
  components: {},
  computed: {
    filter() {
      return this.questionnaires
        .filter((item) =>
          item.module.toLowerCase().includes(this.search.toLowerCase())
        )
        .slice(
          this.perPage * this.currentPage - this.perPage,
          this.perPage * this.currentPage
        );
    },
  },
  mounted() {
    this.getquestionnaires();
    if (this.$route.query.showing) {
      this.search = this.$route.query.showing;
    }
  },
  methods: {
    async getquestionnaires() {
      return this.$http
        .get(`${this.$store.getters.url}/questionnaires`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
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

    edit(id) {
      this.$router.push(`/facilitatoristrator/questionnaire/edit/${id}`);
    },
    view(id) {
      this.$router.push(`/facilitatoristrator/questionnaire/view/${id}`);
    },

    drop(id) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/questionnaires/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
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

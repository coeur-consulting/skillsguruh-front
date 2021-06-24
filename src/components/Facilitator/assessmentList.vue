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
            <h6 class="mb-3 mb-sm-0">List</h6>
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
              v-if="users.length"
              class="d-flex justify-content-between align-items-center p-3 e"
            >
              <b-icon icon="funnel"></b-icon>
              <div>
                <b-button variant="dark-green" size="sm">
                  <b-icon
                    icon="plus"
                    @click="$bvModal.show('add')"
                    font-scale="1.5"
                  ></b-icon
                ></b-button>
              </div>
            </div>

            <div class="" v-if="users.length">
              <b-table-simple class="org_home_table text-left" responsive="sm">
                <b-thead>
                  <b-tr class="text-left">
                    <b-th class="text-muted">Name</b-th>
                    <b-th class="text-muted">Submitted</b-th>
                    <b-th class="text-muted">Score</b-th>
                    <b-th class="text-muted">Status</b-th>
                    <b-th></b-th> </b-tr
                ></b-thead>
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
                          <span class="text-capitalize">{{ item.name }}</span>
                          <br />
                          <span class="text-muted">{{ item.email }}</span>
                        </div>
                      </div>
                    </b-td>
                    <b-td>
                      <div class="text-left" v-if="item.loginhistory.length">
                        <span v-if="item.loginhistory.length">{{
                          item.loginhistory[item.loginhistory.length - 1].record
                            | moment("ll")
                        }}</span>
                        <br />
                        <span
                          class="text-muted"
                          v-if="item.loginhistory.length"
                          >{{
                            $moment(
                              item.loginhistory[item.loginhistory.length - 1]
                                .record
                            ).fromNow()
                          }}</span
                        >
                      </div>
                      <div class="text-left" v-else>Not available</div>
                    </b-td>
                    <b-td class="text-capitalize"> {{ item.phone }} </b-td>
                    <b-td
                      class="text-left"
                      :class="{
                        'text-success': item.verification,
                        'text-danger': !item.verification,
                      }"
                      >{{ item.verification ? "Active" : "Inactive" }}</b-td
                    >
                    <b-td
                      ><b-button-group size="sm">
                        <b-button
                          variant="light"
                          @click="viewsheet(item)"
                          class="fs12 text-muted px-2"
                          >View</b-button
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
              <div class="p-3 d-flex justify-content-between">
                <div class="fs12 text-muted">
                  Showing {{ perPage * currentPage - perPage + 1 }}-{{
                    perPage * currentPage
                  }}
                  of {{ users.length }} items
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
                <h6 class="text-muted my-3 fs14">
                  It appears you havent added any Learner yet,
                  <br class="d-none d-sm-block" />
                  Add your first Learner now!
                </h6>
                <b-button
                  @click="$bvModal.show('add')"
                  variant="dark-green"
                  size="lg"
                  >Add Learner</b-button
                >
              </div>
            </div>
          </div>
        </b-col>
      </b-row>
    </b-container>

    <b-modal no-close-on-backdrop id="viewsheet" hide-footer centered size="lg">
      <b-form @submit.prevent="updatesheet"> </b-form>
    </b-modal>
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
      users: [],
      user: {
        name: "",
        email: "",
        phone: "",
        password: "",
      },
      result: [],
    };
  },
  computed: {
    filter() {
      return this.users
        .filter((item) =>
          item.name.toLowerCase().includes(this.search.toLowerCase())
        )
        .slice(
          this.perPage * this.currentPage - this.perPage,
          this.perPage * this.currentPage
        );
    },
  },
  mounted() {
    this.getusers();
  },
  methods: {
    getusers() {
      this.$http
        .get(`${this.$store.getters.url}/facilitator-get-users`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.users = res.data;
            this.rows = res.data.length;
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

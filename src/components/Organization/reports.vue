<template>
  <div>
    <b-container>
      <b-row>
        <b-col class="mb-5 mb-sm-0">
          <div class="shadow-sm bg-white">
            <div
              v-if="reports.length"
              class="d-flex justify-content-between align-items-center p-3 e"
            >
              <b-icon icon="funnel"></b-icon>
              <div></div>
            </div>

            <div class="" v-if="reports.length">
              <b-table-simple class="org_home_table text-left" responsive="sm">
                <b-thead>
                  <b-tr class="text-left">
                    <b-th class="text-muted">Name</b-th>
                    <b-th class="text-muted">Type</b-th>
                    <b-th class="text-muted">Message</b-th>

                    <b-th class="text-muted">Status</b-th>
                    <b-th class="text-muted">Action</b-th>
                    <b-th></b-th> </b-tr
                ></b-thead>
                <b-tbody>
                  <b-tr v-for="(item, index) in reports" :key="item.id">
                    <b-td>
                      <div class="d-flex">
                        <b-avatar
                          :src="item.user.profile"
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
                    <b-td>{{ item.type.replace("&#47;", "") }}</b-td>
                    <b-td>
                      <span class="">{{ item.message }}</span></b-td
                    >

                    <b-td class="text-left">{{ item.status }}</b-td>
                    <b-td> <b-button size="sm">View</b-button></b-td>
                  </b-tr>
                </b-tbody>
              </b-table-simple>
              <div class="p-3 d-flex justify-content-between" v-if="rows > 10">
                <div class="fs12 text-muted">
                  Showing 1-10 of {{ reports.length }} items
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
      reports: [],
      user: {
        name: "",
        email: "",
        phone: "",
        password: "",
      },
    };
  },
  computed: {},
  mounted() {
    this.getreports();
  },
  methods: {
    // handleType(val) {

    // },
    getreports() {
      this.$http
        .get(`${this.$store.getters.url}/get/organization/reports`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.reports = res.data.data;
            this.rows = res.data.total;
            this.perPage = res.data.per_page;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    drop(id, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(
              `${this.$store.getters.url}/get/organization/reports/${id}`,
              {
                headers: {
                  Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
                },
              }
            )
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success("Removed successfully");
                this.users.splice(index, 1);
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
.admin_tab {
  min-height: 350px;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>

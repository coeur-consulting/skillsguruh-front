<template>
  <div>
    <b-container>
      <b-row>
        <b-col class="mb-5 mb-sm-0">
          <div class="text-right mb-3">
            <b-button-group size="sm">
              <b-button
                @click="in_view = ''"
                class="px-3"
                :disabled="in_view == ''"
                >All</b-button
              >
              <b-button
                @click="in_view = 'in review'"
                :disabled="in_view == 'in review'"
                >Pending</b-button
              >
              <b-button @click="in_view = 'okay'" :disabled="in_view == 'okay'"
                >Reviewed</b-button
              >
            </b-button-group>
          </div>
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
                  <b-tr v-for="(item, index) in filteredreports" :key="item.id">
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
                    <b-td>
                      <span class="text-capitalize">{{ item.type }}</span></b-td
                    >
                    <b-td>
                      <span class="">{{ item.message }}</span></b-td
                    >

                    <b-td class="text-left text-capitalize">{{
                      item.status
                    }}</b-td>
                    <b-td>
                      <b-button
                        size="sm"
                        @click="getreport(item.id, item.type, index,item.status)"
                        >View</b-button
                      ></b-td
                    >
                  </b-tr>
                </b-tbody>
              </b-table-simple>
              <div class="p-3 d-flex justify-content-between" v-if="rows > 10">
                <div class="fs12 text-muted">
                  Showing 1-10 of {{ reports.length }} items
                </div>
                <div>
                  <b-icon
                    icon="arrow-left"
                    v-if="currentPage > 1"
                    @click="currentPage++"
                    class="mr-4"
                  ></b-icon>
                  <b-icon
                    icon="arrow-right"
                    v-if="currentPage < last_page"
                    @click="currentPage--"
                  ></b-icon>
                </div>
              </div>
            </div>
          </div>
        </b-col>
      </b-row>
    </b-container>
    <b-modal id="report" centered hide-footer>
      <div class="p-3">
        <b-table-simple bordered class="mb-5">
          <b-tbody>
            <b-tr>
              <b-td>Type</b-td>
              <b-td class="text-capitalize">{{ report_type }}</b-td>
            </b-tr>
            <b-tr v-if="report.name">
              <b-td>Title</b-td>
              <b-td v-html="report.name"></b-td>
            </b-tr>
            <b-tr v-if="report.message">
              <b-td>Message</b-td>
              <b-td v-html="report.message"></b-td>
            </b-tr>
            <b-tr v-if="report.media">
              <b-td>Media</b-td>
              <b-td>
                <b-carousel
                  v-if="report.mediaType === 'image'"
                  id="carousel-fade"
                  style="text-shadow: 0px 0px 2px #000"
                  indicators
                  :interval="0"
                  class="w-100"
                >
                  <b-carousel-slide
                    v-for="(item, id) in report.media"
                    :key="id"
                    background="#fff"
                  >
                    <template #img>
                      <img class="w-100" height="420" :src="item" alt="image" />
                    </template>
                  </b-carousel-slide>
                </b-carousel>
                <video
                  v-if="report.mediaType === 'video'"
                  controls
                  width="100%"
                  height="420"
                  :src="report.media[0]"
                ></video>
              </b-td>
            </b-tr>
            <b-tr v-if="report.user">
              <b-td>Owner</b-td>
              <b-td class="text-capitalize">{{ report.user.name }}</b-td>
            </b-tr>
             <b-tr v-if="report.user">
              <b-td>Status</b-td>
              <b-td class="text-capitalize">{{ report_status }}</b-td>
            </b-tr>

            <!-- <b-tr>
          <b-td>Owner</b-td>
           <b-td>Message</b-td>
        </b-tr> -->
          </b-tbody>
        </b-table-simple>

        <div
          class="d-flex justify-content-center"
          v-if="report.status === 'in review'"
        >
          <b-button
            size="sm"
            class="mr-4"
            variant="danger"
            @click="deletepost(report.id)"
            >Delete</b-button
          >
          <b-button size="sm" variant="success" @click="markpost(report.id)"
            >Mark as safe</b-button
          >
        </div>
      </div>
    </b-modal>
  </div>
</template>
<script>
export default {
  data() {
    return {
      id: null,
      index: null,
      search: "",
      currentPage: 1,
      rows: null,
      perPage: 10,
      reports: [],
      last_page: null,
      report_type: null,
      report_id: null,
      report_status:null,
      user: {
        name: "",
        email: "",
        phone: "",
        password: "",
      },
      report: {},
      in_view: "",
    };
  },
  computed: {
    filteredreports() {
      if (this.in_view === "") {
        return this.reports;
      }
      return this.reports.filter((item) => item.status === this.in_view);
    },
  },
  mounted() {
    this.getreports();
  },
  watch: {
    currentPage: "getreports",
  },
  methods: {
    deletepost(id) {
      var data = {
        type: this.report_type,
        id: id,
        report_id: this.report_id,
        user_id: this.report.user.id,
      };
      this.$http
        .post(`${this.$store.getters.url}/delete/report`, data, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
          },
        })
        .then((res) => {
          this.reports[this.index].status = res.data.status;
          this.$toast.success("Resolved successfully");
          this.$bvModal.hide("report");
        });
    },
    markpost(id) {
      var data = {
        type: this.report_type,
        id: id,
        report_id: this.report_id,
      };
      this.$http
        .post(`${this.$store.getters.url}/mark/report`, data, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
          },
        })
        .then((res) => {
          this.reports[this.index].status = res.data.status;
          this.$toast.success("Resolved successfully");
          this.$bvModal.hide("report");
        });
    },
    getreport(id, type, index,status) {
      this.report_type = type;
      this.report_id = id;
      this.index = index;
      this.report_status = status
      this.$http
        .get(`${this.$store.getters.url}/get/organization/reports/${id}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
          },
        })
        .then((res) => {
          this.report = res.data;
          this.$bvModal.show("report");
        });
    },
    getreports() {
      this.$http
        .get(
          `${this.$store.getters.url}/get/organization/reports?page=${this.currentPage}`,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.reports = res.data.data;
            this.rows = res.data.total;
            this.perPage = res.data.per_page;
            this.last_page = res.data.last_page;
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

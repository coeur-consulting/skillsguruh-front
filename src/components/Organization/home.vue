<template>
  <div>
    <b-container>
      <b-row class="mb-5">
        <b-col sm="4">
          <div class="box shadow-sm" style="border-right: 5px solid #377f87">
            <div
              class="
                d-flex
                align-items-center
                mb-3
                w-100
                justify-content-between
              "
            >
              <b-iconstack font-scale="2.5" class="mr-3">
                <b-icon
                  stacked
                  icon="circle-fill"
                  variant="lighter-green"
                ></b-icon>
                <b-icon
                  stacked
                  icon="chat-left-quote-fill"
                  scale="0.5"
                  variant="dark-green"
                  class="ic"
                ></b-icon>
              </b-iconstack>
              <div class="h5 mb-0 text-dark-green">Discussions</div>
            </div>

            <!-- <div class="d-flex justify-content-between mb-2 w-100">
              <div class="new_add">New This Month</div>
              <div>{{ newlyadmins }}</div>
            </div> -->
            <div class="d-flex justify-content-between w-100">
              <div class="new_add">Total Discussions</div>
              <div>{{ totaldiscussions }}</div>
            </div>
          </div>
        </b-col>
        <b-col sm="4">
          <div class="box shadow-sm" style="border-right: 5px solid #3d96a5">
            <div
              class="
                d-flex
                align-items-center
                justify-content-between
                w-100
                mb-3
              "
            >
              <b-iconstack font-scale="2.5" class="mr-3">
                <b-icon
                  stacked
                  icon="circle-fill"
                  variant="lighter-green"
                ></b-icon>
                <b-icon
                  stacked
                  icon="bookmark-fill"
                  scale="0.5"
                  variant="dark-green"
                ></b-icon>
              </b-iconstack>
              <div class="h5 mb-0 text-dark-green">Tribes</div>
            </div>

            <!-- <div class="d-flex justify-content-between mb-2 w-100">
              <div class="new_add">New This Month</div>
              <div>{{ newlyfacilitators }}</div>
            </div> -->
            <div class="d-flex justify-content-between w-100">
              <div class="new_add">Total Tribes</div>
              <div>{{ totaltribes }}</div>
            </div>
          </div>
        </b-col>
        <b-col sm="4">
          <div class="box shadow-sm" style="border-right: 5px solid #6beed1">
            <div
              class="
                d-flex
                align-items-center
                justify-content-between
                w-100
                mb-3
              "
            >
              <b-iconstack font-scale="2.5" class="mr-3">
                <b-icon
                  stacked
                  icon="circle-fill"
                  variant="lighter-green"
                ></b-icon>
                <b-icon
                  stacked
                  icon="people-fill"
                  scale="0.5"
                  variant="dark-green"
                ></b-icon>
              </b-iconstack>
              <div class="h5 mb-0 text-dark-green">Members</div>
            </div>

            <!-- <div class="d-flex justify-content-between mb-2 w-100">
              <div class="new_add">New This Month</div>
              <div>{{ newlyusers }}</div>
            </div> -->
            <div class="d-flex justify-content-between w-100">
              <div class="new_add">Total Members</div>
              <div>{{ totalusers }}</div>
            </div>
          </div>
        </b-col>
      </b-row>
      <b-row>
        <b-col sm="8" class="mb-5 mb-sm-0">
          <AdminTab />
        </b-col>
        <b-col sm="4" class="text-left">
          <h5 class="mb-4">Chart</h5>

          <div class="turn_over_box">
            <div class="tob_1 mb-4 border">
              <div id="chart" class="text-center" v-if="initPieseries.length">
                <apexchart
                  class="text-center"
                  type="pie"
                  :options="chartOptions"
                  :series="initPieseries"
                  width="100%"
                  height="150"
                ></apexchart>
              </div>
            </div>
            <div class="tob_2 border" v-if="initLineseries.length">
              <div id="chart1">
                <apexchart
                  type="bar"
                  height="200"
                  :options="chartOptions1"
                  :series="initLineseries"
                ></apexchart>
              </div>
            </div>
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import AdminTab from "./admins";
export default {
  data() {
    return {
      tribes: [],
      discussions: [],
      users: [],

      chartOptions: {
        chart: {
          type: "pie",
          toolbar: true,
        },
        colors: ["#377f87", "#3d96a5", "#6beed1"],
        labels: ["Discussions", "Tribes", "Members"],
        responsive: [
          {
            breakpoint: 480,
            options: {
              chart: {},
              legend: {
                position: "bottom",
              },
            },
          },
        ],
      },

      chartOptions1: {
        chart: {
          height: 350,
          type: "bar",
        },
        colors: ["#377f87"],
        plotOptions: {
          bar: {
            borderRadius: 10,
            dataLabels: {
              position: "top", // top, center, bottom
            },
          },
        },
        dataLabels: {
          enabled: true,
          formatter: function (val) {
            return val + "%";
          },
          offsetY: -20,
          style: {
            fontSize: "12px",
            colors: ["#304758"],
          },
        },

        xaxis: {
          categories: ["Discussions", "Tribes", "Members"],
          position: "top",
          axisBorder: {
            show: false,
          },
          axisTicks: {
            show: false,
          },
          crosshairs: {
            fill: {
              type: "gradient",
              gradient: {
                colorFrom: "#D8E3F0",
                colorTo: "#BED1E6",
                stops: [0, 100],
                opacityFrom: 0.4,
                opacityTo: 0.5,
              },
            },
          },
          tooltip: {
            enabled: true,
          },
        },
        yaxis: {
          axisBorder: {
            show: false,
          },
          axisTicks: {
            show: false,
          },
          labels: {
            show: false,
            formatter: function (val) {
              return val + "%";
            },
          },
        },
      },
    };
  },
  components: {
    AdminTab,
  },
  watch: {},
  mounted() {
    this.getdiscussions();
    this.gettribes();
    this.getusers();
  },

  computed: {
    totaltribes() {
      return this.tribes.total;
    },
    totalusers() {
      return this.users.total;
    },
    totaldiscussions() {
      return this.discussions.total;
    },
    initPieseries() {
      return [
        this.totaldiscussions | 0,
        this.totaltribes | 0,
        this.totalusers | 0,
      ];
    },
    initLineseries() {
      return [
        {
          name: "Total %",
          data: [
            this.totaldiscussions | 0,
            this.totaltribes | 0,
            this.totalusers | 0,
          ],
        },
      ];
    },
  },
  methods: {
    getusers() {
      this.$http
        .get(`${this.$store.getters.url}/get/organization/users`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.users = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getdiscussions() {
      this.$http
        .get(`${this.$store.getters.url}/get/organization/discussions`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.discussions = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    gettribes() {
      this.$http
        .get(`${this.$store.getters.url}/get/organization/tribes`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.tribes = res.data;
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
.box {
  height: 130px;
  display: flex;
  align-items: flex-start;
  flex-direction: column;
  justify-content: center;
  text-align: left;
  padding: 15px;

  border-radius: 8px;
  background: white;
}
.new_add {
  color: rgba(0, 0, 0, 0.44);
  font-size: 14px;
}
.box:hover {
  background: linear-gradient(
    127.24deg,
    var(--lighter-green) 28.41%,
    #c2edce 100%
  );
}
// .box:hover > div > div,
// .box:hover > div > .h5 {
//   color: white !important;
// }

// .box:hover > div > .b-iconstack > g > .ic {
//   color: white !important;
// }
.shadow {
  border-radius: 8px;
}
.search.form-control {
  width: 250px;
  border: 1px solid rgba($color: #000000, $alpha: 0.07) !important;
}
.search::placeholder {
  color: rgba($color: #000000, $alpha: 0.2);
}
.turn_over_box {
  height: 100%;
}
.tob_1 {
  min-height: 200px;

  border-radius: 8px;
  padding: 20px;
  background: white;
}
.tob_2 {
  min-height: 200px;

  border-radius: 8px;
  padding: 20px;
  background: white;
}
.admin_tab {
  min-height: 400px;
}
@media (max-width: 600px) {
  .box {
    margin-bottom: 24px;
  }
  .admin_tab {
    min-height: 200px;
  }
}
</style>

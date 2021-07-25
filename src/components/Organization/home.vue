<template>
  <div>
    <b-container>
      <b-row class="mb-5">
        <b-col sm="4">
          <div class="box">
            <div class="d-flex align-items-center mb-3">
              <b-iconstack font-scale="2.5" class="mr-3">
                <b-icon
                  stacked
                  icon="circle-fill"
                  variant="lighter-green"
                ></b-icon>
                <b-icon
                  stacked
                  icon="shield-fill-check"
                  scale="0.5"
                  variant="dark-green"
                  class="ic"
                ></b-icon>
              </b-iconstack>
              <div class="h6 mb-0 text-dark-green">Administrators</div>
            </div>

            <div class="d-flex justify-content-between mb-2 w-100">
              <div class="new_add">New This Month</div>
              <div>{{ newlyadmins }}</div>
            </div>
            <div class="d-flex justify-content-between w-100">
              <div class="new_add">Total Number</div>
              <div>{{ admins.length }}</div>
            </div>
          </div>
        </b-col>
        <b-col sm="4">
          <div class="box">
            <div class="d-flex align-items-center mb-3">
              <b-iconstack font-scale="2.5" class="mr-3">
                <b-icon
                  stacked
                  icon="circle-fill"
                  variant="lighter-green"
                ></b-icon>
                <b-icon
                  stacked
                  icon="person-badge-fill"
                  scale="0.5"
                  variant="dark-green"
                ></b-icon>
              </b-iconstack>
              <div class="h6 mb-0 text-dark-green">Facilitators</div>
            </div>

            <div class="d-flex justify-content-between mb-2 w-100">
              <div class="new_add">New This Month</div>
              <div>{{ newlyfacilitators }}</div>
            </div>
            <div class="d-flex justify-content-between w-100">
              <div class="new_add">Total Number</div>
              <div>{{ facilitators.length }}</div>
            </div>
          </div>
        </b-col>
        <b-col sm="4">
          <div class="box">
            <div class="d-flex align-items-center mb-3">
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
              <div class="h6 mb-0 text-dark-green">Learners</div>
            </div>

            <div class="d-flex justify-content-between mb-2 w-100">
              <div class="new_add">New This Month</div>
              <div>{{ newlyusers }}</div>
            </div>
            <div class="d-flex justify-content-between w-100">
              <div class="new_add">Total Number</div>
              <div>{{ users.length }}</div>
            </div>
          </div>
        </b-col>
      </b-row>
      <b-row>
        <b-col sm="8" class="mb-5 mb-sm-0">
          <AdminTab />
        </b-col>
        <b-col sm="4" class="text-left">
          <h6 class="mb-4">Team Chart</h6>

          <div class="turn_over_box">
            <div class="tob_1 mb-4">
              <div id="chart" class="text-center">
                <apexchart
                  class="text-center"
                  type="pie"
                  :options="chartOptions"
                  :series="series"
                  width="100%"
                ></apexchart>
              </div>
            </div>
            <div class="tob_2">
              <div id="chart1">
                <apexchart
                  type="bar"
                  height="200"
                  :options="chartOptions1"
                  :series="series1"
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
      admins: [],
      facilitators: [],
      users: [],
      series: [33, 33, 33],
      chartOptions: {
        chart: {
          type: "pie",
        },
        colors: ["#377f87", "#3d96a5", "#6beed1"],
        labels: ["Learners", "Facilitators", "Administrators"],
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

      series1: [
        {
          name: "Inflation",
          data: [2.3, 3.1, 4.0, 10.1, 4.0, 3.6, 3.2],
        },
      ],
      chartOptions1: {
        chart: {
          height: 350,
          type: "bar",
          toolbar: false,
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
          categories: ["Learners", "Facilitators", "Administrators"],
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
        title: {
          text: "Monthly Inflation in Argentina, 2002",
          floating: true,
          offsetY: 330,
          align: "center",
          style: {
            color: "#444",
          },
        },
      },
    };
  },
  components: {
    AdminTab,
  },
  watch: {
    users: "initPie",
    admins: "initPie",
    facilitators: "initPie",
  },
  mounted() {
    this.getadmins();
    this.getfacilitators();
    this.getusers();
  },
  computed: {
    newlyadmins() {
      return this.admins.filter(
        (item) =>
          new Date(item.created_at).getMonth() == new Date().getMonth() &&
          new Date(item.created_at).getFullYear() == new Date().getFullYear()
      ).length;
    },
    newlyfacilitators() {
      return this.facilitators.filter(
        (item) =>
          new Date(item.created_at).getMonth() == new Date().getMonth() &&
          new Date(item.created_at).getFullYear() == new Date().getFullYear()
      ).length;
    },
    newlyusers() {
      return this.users.filter(
        (item) =>
          new Date(item.created_at).getMonth() == new Date().getMonth() &&
          new Date(item.created_at).getFullYear() == new Date().getFullYear()
      ).length;
    },
  },
  methods: {
    getadmins() {
      this.$http
        .get(`${this.$store.getters.url}/get-admins`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.admins = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getfacilitators() {
      this.$http
        .get(`${this.$store.getters.url}/get-facilitators`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.facilitators = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getusers() {
      this.$http
        .get(`${this.$store.getters.url}/get-users`, {
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
    initPie() {
      this.series = [
        this.users.length,
        this.facilitators.length,
        this.admins.length,
      ];
      this.chartOptions = {
        chart: {
          type: "pie",
        },
        colors: ["#377f87", "#3d96a5", "#6beed1"],
        labels: ["Learners", "Facilitators", "Administrators"],
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
      };
      this.initLine();
    },
    initLine() {
      this.series1 = [
        {
          name: "Team",
          data: [
            this.users.length,
            this.facilitators.length,
            this.admins.length,
          ],
        },
      ];
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
  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35);
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
// .box:hover > div > .h6 {
//   color: white !important;
// }

// .box:hover > div > .b-iconstack > g > .ic {
//   color: white !important;
// }
.shadow {
  box-shadow: 0 0.125rem 0.25rem rgba(189, 231, 201, 0.35) !important;
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
  box-shadow: 0 0.125rem 0.25rem rgba(189, 231, 201, 0.35) !important;
  border-radius: 8px;
  padding: 20px;
  background: white;
}
.tob_2 {
  min-height: 200px;
  box-shadow: 0 0.125rem 0.25rem rgba(189, 231, 201, 0.35) !important;
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

<template>
  <b-container class="py-4 text-left">
    <div class="d-flex justify-content-between align-items-end mb-4">
      <div>
        <h5 class="font-weight-bold">Analytics</h5>
        <div class="d-flex align-items-center">
          <span class="mr-2 text-muted">Want to see about </span>
          <span
            ><b-form-select size="sm" v-model="about">
              <b-form-select-option value="audience"
                >Audience</b-form-select-option
              >
              <b-form-select-option value="facilitators"
                >Facilitators</b-form-select-option
              >
              <b-form-select-option value="courses"
                >Courses</b-form-select-option
              >
              <b-form-select-option value="revenue"
                >Revenue</b-form-select-option
              >
            </b-form-select></span
          >
        </div>
      </div>
      <div class="d-flex align-items-center">
        <b-button-group class="mr-4">
          <b-button variant="outline-secondary" size="sm">A week</b-button>
          <b-button variant="outline-secondary" size="sm">One month</b-button>
          <b-button variant="outline-secondary" size="sm">3 months</b-button>
        </b-button-group>

        <span class="d-flex align-items-center">
          <b-datepicker size="sm" class=""></b-datepicker>
          <span class="px-2">-</span>
          <b-datepicker size="sm"></b-datepicker>
        </span>
      </div>
    </div>
    <div v-if="about == 'audience'">
      <b-row class="mb-4">
        <b-col class="bg-white border rounded p-4">
          <div>
            <div class="mb-4 d-flex justify-content-between align-items-center">
              <h6 class="font-weight-bold">Demographic Audience</h6>
              <span
                ><b-form-select size="sm" v-model="gender">
                  <b-form-select-option value="">
                    <b-icon
                      icon="dot"
                      font-scale="2rem"
                      variant="dark-green"
                    ></b-icon>
                    All gender</b-form-select-option
                  >
                  <b-form-select-option value="male"
                    ><b-icon
                      icon="dot"
                      font-scale="2rem"
                      variant="dark-green"
                    ></b-icon>
                    Male</b-form-select-option
                  >
                  <b-form-select-option value="female"
                    ><b-icon
                      icon="dot"
                      font-scale="2rem"
                      variant="dark-green"
                    ></b-icon>
                    Female</b-form-select-option
                  >
                </b-form-select></span
              >
            </div>
            <div class="demo">
              <MapChart
                :countryData="countryData"
                highColor="#377f87"
                lowColor="#c2eece"
                countryStrokeColor="#909090"
                defaultCountryFillColor="#efefef"
                :showEmptyValue="false"
                :currencyAdd="false"
              />
            </div></div
        ></b-col>
      </b-row>

      <b-row>
        <b-col sm="4" class="p-4 bg-white border rounded">
          <div>
            <div class="mb-3">
              <h5 class="font-weight-bold">Statistics by Gender</h5>
              <span class="text-muted fs12">Jan 23 - Jun 22</span>
            </div>
            <apexchart
              class="text-center"
              type="pie"
              :options="chartOptions"
              :series="series"
              width="100%"
            ></apexchart>
          </div>
        </b-col>
        <b-col sm="1"></b-col>
        <b-col sm="7" class="p-4 bg-white border rounded">
          <div>
            <div class="mb-3">
              <h5 class="font-weight-bold">Audience Online Activities</h5>
              <span class="text-muted fs12">Jan 23 - Jun 22</span>
            </div>
            <div id="chart">
              <apexchart
                type="heatmap"
                height="200"
                :options="chartOptions1"
                :series="series1.slice().reverse()"
              ></apexchart>
            </div>
          </div>
        </b-col>
      </b-row>
    </div>

    <div v-if="about == 'courses'">
      <b-row class="mb-4">
        <b-col class="bg-white border rounded p-4">
          <div>
            <div class="mb-4 d-flex justify-content-between align-items-center">
              <h6 class="font-weight-bold">Enrollment Activities</h6>
              <span
                ><b-form-select size="sm" v-model="gender">
                  <b-form-select-option value="">
                    <b-icon
                      icon="dot"
                      font-scale="2rem"
                      variant="dark-green"
                    ></b-icon>
                    All gender</b-form-select-option
                  >
                </b-form-select></span
              >
            </div>

            <div id="chart">
              <apexchart
                type="bar"
                height="350"
                :options="courseOptions"
                :series="courseSeries"
              ></apexchart>
            </div></div
        ></b-col>
      </b-row>
      <b-row class="mb-3">
        <b-col sm="4" class="pl-sm-0">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Total Courses</h6>
            </div>
            <div class="display-2 text-center text-dark-green">8</div>
            <br />
            <div class="text-muted text-center fs13">+2 This week</div>
          </div>
        </b-col>
        <b-col sm="4">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Total Views</h6>
            </div>

            <div class="display-2 text-center text-dark-green">8</div>
            <br />
            <div class="text-muted text-center fs13">+2 This week</div>
          </div>
        </b-col>
        <b-col sm="4" class="pr-sm-0">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Total Interactions</h6>
            </div>
            <div class="display-2 text-center text-dark-green">8</div>
            <br />
            <div class="text-muted text-center fs13">+2 This week</div>
          </div>
        </b-col>
      </b-row>

      <b-row class="mb-3">
        <b-col sm="4" class="pl-sm-0">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Most Viewed</h6>
            </div>
            <div class="display-2 text-center text-dark-green">8</div>
            <br />
            <div class="text-muted text-center fs13">+2 This week</div>
          </div>
        </b-col>
        <b-col sm="4">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Mosted Enrolled</h6>
            </div>

            <div class="display-2 text-center text-dark-green">8</div>
            <br />
            <div class="text-muted text-center fs13">+2 This week</div>
          </div>
        </b-col>
        <b-col sm="4" class="pr-sm-0">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Most Interactions</h6>
            </div>
            <div class="display-2 text-center text-dark-green">8</div>
            <br />
            <div class="text-muted text-center fs13">+2 This week</div>
          </div>
        </b-col>
      </b-row>
      <b-row>
        <b-col sm="4" class="pl-sm-0">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Total Paid Courses</h6>
            </div>
            <div class="display-2 text-center text-dark-green">8</div>
            <br />
            <div class="text-muted text-center fs13">+2 This week</div>
          </div>
        </b-col>
        <b-col sm="4">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Total Group Courses</h6>
            </div>

            <div class="display-2 text-center text-dark-green">8</div>
            <br />
            <div class="text-muted text-center fs13">+2 This week</div>
          </div>
        </b-col>
      </b-row>
    </div>
    <div v-if="about == 'facilitators'">
      <b-row class="mb-4">
        <b-col class="bg-white border rounded p-4">
          <div>
            <div class="mb-4 d-flex justify-content-between align-items-center">
              <h6 class="font-weight-bold">
                Facilitators Enrollment Activities
              </h6>
              <span
                ><b-form-select size="sm" v-model="gender">
                  <b-form-select-option value="">
                    <b-icon
                      icon="dot"
                      font-scale="2rem"
                      variant="dark-green"
                    ></b-icon>
                    All gender</b-form-select-option
                  >
                </b-form-select></span
              >
            </div>

            <div id="chart">
              <apexchart
                type="bar"
                height="350"
                :options="facilitatorOptions"
                :series="facilitatorSeries"
              ></apexchart>
            </div></div
        ></b-col>
      </b-row>
      <b-row>
        <b-col sm="4" class="pl-sm-0">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Count</h6>
            </div>
            <div class="display-2 text-center text-dark-green">8</div>
            <br />
            <div class="text-muted text-center fs13">+2 This week</div>
          </div>
        </b-col>
        <b-col sm="4">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Views</h6>
            </div>

            <div class="display-2 text-center text-dark-green">8</div>
            <br />
            <div class="text-muted text-center fs13">+2 This week</div>
          </div>
        </b-col>
        <b-col sm="4" class="pr-sm-0">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Interactions</h6>
            </div>
            <div class="display-2 text-center text-dark-green">8</div>
            <br />
            <div class="text-muted text-center fs13">+2 This week</div>
          </div>
        </b-col>
      </b-row>
    </div>
    <div v-if="about == 'revenue'">
      <b-row class="mb-4">
        <b-col class="bg-white border rounded p-4">
          <div>
            <div class="mb-4 d-flex justify-content-between align-items-center">
              <h6 class="font-weight-bold">Revenue Chart</h6>
            </div>

            <div id="chart-months">
              <apexchart
                type="area"
                height="400"
                :options="revenueOptions"
                :series="revenueSeries"
              ></apexchart>
            </div></div
        ></b-col>
      </b-row>
      <b-row class="mb-3">
        <b-col sm="4" class="pl-sm-0">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Total revenue</h6>
            </div>
            <div class="display-2 text-center text-dark-green">8</div>
            <br />
            <div class="text-muted text-center fs13">+2 This week</div>
          </div>
        </b-col>
        <b-col sm="4">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">This Year</h6>
            </div>

            <div class="display-2 text-center text-dark-green">8</div>
            <br />
            <div class="text-muted text-center fs13">+2 This week</div>
          </div>
        </b-col>
        <b-col sm="4" class="pr-sm-0">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">This Month</h6>
            </div>
            <div class="display-2 text-center text-dark-green">8</div>
            <br />
            <div class="text-muted text-center fs13">+2 This week</div>
          </div>
        </b-col>
      </b-row>

      <b-row>
        <b-col sm="4" class="pl-sm-0">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Highest Earning Course</h6>
            </div>
            <div class="display-2 text-center text-dark-green">8</div>
            <br />
            <div class="text-muted text-center fs13">+2 This week</div>
          </div>
        </b-col>
      </b-row>
    </div>
  </b-container>
</template>

<script>
import MapChart from "vue-chart-map";
export default {
  data() {
    return {
      learners: [],
      courses: [],
      gender: "",
      about: "audience",
      countryData: { US: 0, CA: 0, GB: 0, IE: 0, ES: 0, NG: 0 },
      series: [33.3, 33.3, 33.3],
      chartOptions: {
        chart: {
          type: "pie",
        },
        colors: ["#377f87", "#3d96a5", "#6beed1"],
        labels: ["Males", "Females", "Others"],
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
          name: "Monday",
          data: [
            {
              x: "8:00am",
              y: 12,
            },
            {
              x: "9:00am",
              y: 9,
            },
            {
              x: "10:00am",
              y: 13,
            },
            {
              x: "11:00am",
              y: 16,
            },
            {
              x: "12:00pm",
              y: 21,
            },
            {
              x: "01:00pm",
              y: 7,
            },
            {
              x: "02:00pm",
              y: 29,
            },
            {
              x: "03:00pm",
              y: 19,
            },
            {
              x: "04:00pm",
              y: 20,
            },
          ],
        },
        {
          name: "Tuesday",
          data: [
            {
              x: "8:00am",
              y: 12,
            },
            {
              x: "9:00am",
              y: 29,
            },
            {
              x: "10:00am",
              y: 13,
            },
            {
              x: "11:00am",
              y: 26,
            },
            {
              x: "12:00pm",
              y: 2,
            },
            {
              x: "01:00pm",
              y: 17,
            },
            {
              x: "02:00pm",
              y: 29,
            },
            {
              x: "03:00pm",
              y: 29,
            },
            {
              x: "04:00pm",
              y: 29,
            },
          ],
        },
        {
          name: "Wednessday",
          data: [
            {
              x: "8:00am",
              y: 12,
            },
            {
              x: "9:00am",
              y: 29,
            },
            {
              x: "10:00am",
              y: 13,
            },
            {
              x: "11:00am",
              y: 26,
            },
            {
              x: "12:00pm",
              y: 2,
            },
            {
              x: "01:00pm",
              y: 17,
            },
            {
              x: "02:00pm",
              y: 29,
            },
            {
              x: "03:00pm",
              y: 29,
            },
            {
              x: "04:00pm",
              y: 29,
            },
          ],
        },
        {
          name: "Thursday",
          data: [
            {
              x: "8:00am",
              y: 12,
            },
            {
              x: "9:00am",
              y: 29,
            },
            {
              x: "10:00am",
              y: 13,
            },
            {
              x: "11:00am",
              y: 26,
            },
            {
              x: "12:00pm",
              y: 2,
            },
            {
              x: "01:00pm",
              y: 17,
            },
            {
              x: "02:00pm",
              y: 29,
            },
            {
              x: "03:00pm",
              y: 29,
            },
            {
              x: "04:00pm",
              y: 29,
            },
          ],
        },
        {
          name: "Friday",
          data: [
            {
              x: "8:00am",
              y: 12,
            },
            {
              x: "9:00am",
              y: 29,
            },
            {
              x: "10:00am",
              y: 13,
            },
            {
              x: "11:00am",
              y: 26,
            },
            {
              x: "12:00pm",
              y: 2,
            },
            {
              x: "01:00pm",
              y: 17,
            },
            {
              x: "02:00pm",
              y: 29,
            },
            {
              x: "03:00pm",
              y: 29,
            },
            {
              x: "04:00pm",
              y: 29,
            },
          ],
        },
        {
          name: "Saturday",
          data: [
            {
              x: "8:00am",
              y: 12,
            },
            {
              x: "9:00am",
              y: 29,
            },
            {
              x: "10:00am",
              y: 13,
            },
            {
              x: "11:00am",
              y: 26,
            },
            {
              x: "12:00pm",
              y: 2,
            },
            {
              x: "01:00pm",
              y: 17,
            },
            {
              x: "02:00pm",
              y: 29,
            },
            {
              x: "03:00pm",
              y: 29,
            },
            {
              x: "04:00pm",
              y: 29,
            },
          ],
        },
      ],
      chartOptions1: {
        chart: {
          height: 200,
          type: "heatmap",
        },
        dataLabels: {
          enabled: false,
        },
        colors: ["#377f87"],
      },
      courseSeries: [
        {
          name: "Male",
          data: [44, 55, 57, 56, 61, 58, 63, 60, 66],
        },
        {
          name: "Females",
          data: [76, 85, 101, 98, 87, 105, 91, 114, 94],
        },
        {
          name: "Others",
          data: [35, 41, 36, 26, 45, 48, 52, 53, 41],
        },
      ],
      courseOptions: {
        chart: {
          type: "bar",
          height: 400,
        },
        plotOptions: {
          bar: {
            horizontal: false,
            columnWidth: "55%",
            endingShape: "rounded",
          },
        },
        dataLabels: {
          enabled: false,
        },
        colors: ["#377f87", "#88b6bf", "#6beed1"],
        stroke: {
          show: true,
          width: 2,
          colors: ["transparent"],
        },
        xaxis: {
          categories: [
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
          ],
        },
        yaxis: {
          title: {
            text: "Learners",
          },
        },
        fill: {
          opacity: 1,
        },
        tooltip: {
          y: {
            formatter: function (val) {
              return val + " learners";
            },
          },
        },
      },
      facilitatorSeries: [
        {
          name: "Male",
          data: [44, 55, 57, 56, 61, 58, 63, 60, 66],
        },
        {
          name: "Females",
          data: [76, 85, 101, 98, 87, 105, 91, 114, 94],
        },
        {
          name: "Others",
          data: [35, 41, 36, 26, 45, 48, 52, 53, 41],
        },
      ],
      facilitatorOptions: {
        chart: {
          type: "bar",
          height: 400,
        },
        plotOptions: {
          bar: {
            horizontal: false,
            columnWidth: "55%",
            endingShape: "rounded",
          },
        },
        dataLabels: {
          enabled: false,
        },
        colors: ["#377f87", "#88b6bf", "#6beed1"],
        stroke: {
          show: true,
          width: 2,
          colors: ["transparent"],
        },
        xaxis: {
          categories: [
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
          ],
        },
        yaxis: {
          title: {
            text: "Facilitators",
          },
        },
        fill: {
          opacity: 1,
        },
        tooltip: {
          y: {
            formatter: function (val) {
              return val + " facilitators";
            },
          },
        },
      },

      revenueSeries: [
        {
          name: "Revenue",
          data: [31, 40, 28, 51, 42, 109, 100],
        },
      ],
      revenueOptions: {
        chart: {
          height: 350,
          type: "area",
        },
        dataLabels: {
          enabled: false,
        },
        colors: ["#377f87"],
        stroke: {
          curve: "smooth",
        },
        xaxis: {
          categories: [
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
          ],
        },
        // tooltip: {
        //   x: {
        //    formatter: function (val) {
        //       return val + " facilitators";
        //     },
        //   },
        // },
      },
    };
  },
  components: {
    MapChart,
  },
  mounted() {
    this.getlearners();
  },
  watch: {
    learners: "getGender",
  },
  computed: {
    male() {
      return this.learners.filter((item) => item.gender == "male").length;
    },
    female() {
      return this.learners.filter((item) => item.gender == "male").length;
    },
    others() {
      return this.learners.filter(
        (item) => item.gender !== "male" && item.gender !== "female"
      ).length;
    },
    countries() {
      return this.learners.map((item) => item.country);
    },
    uniqueCountries() {
      var count = [...new Set(this.countries)];

      return count;
    },
    setCountries() {
      return this.uniqueCountries.map((element) => {
        var data = {
          element: this.countries.filter((item) => item.includes(element)),
        };

        return data;
      });
    },
    states() {
      return this.learners.map((item) => item.state);
    },
  },
  methods: {
    // setCountries() {
    //   this.uniqueCountries.map((element) => {
    //     var data = {
    //       element: this.countries.filter((item) => item.includes(element)),
    //     };

    //     return data;
    //   });
    // },
    getGender() {
      this.series = [this.male, this.female, this.others];
    },
    getlearners() {
      this.$http
        .get(`${this.$store.getters.url}/admin-get-users`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.learners = res.data;
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
.demo {
  height: 500px;
}
</style>

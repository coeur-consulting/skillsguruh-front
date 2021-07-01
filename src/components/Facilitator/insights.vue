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
        <!-- <b-button-group class="mr-4">
          <b-button variant="outline-secondary" size="sm">A week</b-button>
          <b-button variant="outline-secondary" size="sm">One month</b-button>
          <b-button variant="outline-secondary" size="sm">3 months</b-button>
        </b-button-group> -->

        <span class="d-flex align-items-center mr-4">
          <b-datepicker size="sm" class="" v-model="start"></b-datepicker>
          <span class="px-2">-</span>
          <b-datepicker size="sm" v-model="end"></b-datepicker>
        </span>

        <span @click="reset" class="fs13"
          >Reset <b-icon icon="arrow-repeat"></b-icon
        ></span>
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
                  <!-- <b-form-select-option value="male"
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
                  > -->
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

      <b-row class="mb-4">
        <b-col sm="6" class="pl-sm-0">
          <div class="w-100 h-100 p-4 bg-white border rounded 0">
            <div class="mb-3">
              <h5 class="font-weight-bold">Statistics by State</h5>
              <!-- <span class="text-muted fs12">Jan 23 - Jun 22</span> -->
            </div>
            <apexchart
              type="bar"
              :options="stateOptions"
              :series="stateSeries"
              :height="300"
            ></apexchart>
          </div>
        </b-col>
        <b-col sm="6" class="pr-sm-0">
          <div class="w-100 h-100 p-4 bg-white border rounded pr-sm-3">
            <div class="mb-3">
              <h5 class="font-weight-bold">Statistics by Age</h5>
              <!-- <span class="text-muted fs12">Jan 23 - Jun 22</span> -->
            </div>
            <apexchart
              type="bar"
              :options="ageOptions"
              :series="ageSeries"
              :height="300"
            ></apexchart>
          </div>
        </b-col>
      </b-row>
      <b-row>
        <b-col sm="4" class="pl-sm-0">
          <div class="w-100 h-100 p-4 bg-white border rounded">
            <div class="mb-3">
              <h5 class="font-weight-bold">Statistics by Gender</h5>
              <!-- <span class="text-muted fs12">Jan 23 - Jun 22</span> -->
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
        <b-col sm="8" class="p-4 bg-white border rounded">
          <div>
            <div class="mb-3">
              <h5 class="font-weight-bold">Login Activity</h5>
              <!-- <span class="text-muted fs12">Jan 23 - Jun 22</span> -->
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
              <h6 class="font-weight-bold">Course Activities</h6>
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
            <div class="h2 text-center text-dark-green">
              {{ courses.length }}
            </div>
            <br />
            <div class="text-muted text-center fs13">
              +{{ thisweekcourses || 0 }} This week
            </div>
          </div>
        </b-col>
        <b-col sm="4">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Total Views</h6>
            </div>

            <div class="h2 text-center text-dark-green">
              {{ courseviews || 0 }}
            </div>
            <br />
            <div class="text-muted text-center fs13">
              +{{ courseviewsthisweek || 0 }} This week
            </div>
          </div>
        </b-col>
        <b-col sm="4" class="pr-sm-0">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Total Enrollments</h6>
            </div>
            <div class="h2 text-center text-dark-green">
              {{ totalenrollment || 0 }}
            </div>
            <br />
            <div class="text-muted text-center fs13">
              +{{ totalenrollmentthisweek || 0 }} This week
            </div>
          </div>
        </b-col>
      </b-row>

      <b-row class="mb-3">
        <b-col sm="4" class="pl-sm-0">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Most Enrolled</h6>
            </div>
            <div class="h5 text-center text-dark-green text-capitalize">
              {{ mostenrolled.length ? mostenrolled[0].title : "N/A" }}
            </div>
            <br />
            <div class="text-muted text-center fs13">
              +{{ mostenrolled.length ? mostenrolled[0].enroll.count : 0 }}
              Enrolls
            </div>
          </div>
        </b-col>
        <b-col sm="4">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Most Viewed</h6>
            </div>

            <div class="h5 text-center text-dark-green text-capitalize">
              {{ mostviewed.length ? mostviewed[0].title : "N/A" }}
            </div>
            <br />
            <div class="text-muted text-center fs13">
              +{{ mostviewed.length ? mostviewed[0].viewcount.count : 0 }} Views
            </div>
          </div>
        </b-col>

        <b-col sm="4" class="pr-sm-0">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Most Interactions</h6>
            </div>
            <div class="h5 text-center text-dark-green text-capitalize">
              {{ mostinteracted.length ? mostinteracted[0].title : "N/A" }}
            </div>
            <br />
            <div class="text-muted text-center fs13">
              +{{ mostinteracted.length ? mostinteracted[0].count : 0 }}
              Interactions
            </div>
          </div>
        </b-col>
      </b-row>
      <b-row>
        <b-col sm="4" class="pl-sm-0">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Total Interactions</h6>
            </div>
            <div class="h2 text-center text-dark-green">
              {{ totalenrollment + courseviews || 0 }}
            </div>
            <br />
            <div class="text-muted text-center fs13">
              +{{ totalenrollmentthisweek + courseviewsthisweek || 0 }} This
              week
            </div>
          </div>
        </b-col>
        <b-col sm="4" class="pl-sm-0">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Total Paid Courses</h6>
            </div>
            <div class="h2 text-center text-dark-green">
              {{ totalpaid || 0 }}
            </div>
            <br />
            <div class="text-muted text-center fs13">
              +{{ totalpaidthisweek || 0 }} This week
            </div>
          </div>
        </b-col>
        <b-col sm="4">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Total Group Courses</h6>
            </div>

            <div class="h2 text-center text-dark-green">
              {{ totalgroup || 0 }}
            </div>
            <br />
            <div class="text-muted text-center fs13">
              +{{ totalgroupthisweek || 0 }} This week
            </div>
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
      <b-row class="mb-4">
        <b-col sm="4" class="pl-sm-0">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Total Facilitators</h6>
            </div>
            <div class="h2 text-center text-dark-green">
              {{ facilitators.length }}
            </div>
            <br />
            <div class="text-muted text-center fs13">
              +{{ thisweekfacilitators || 0 }} This week
            </div>
          </div>
        </b-col>
        <b-col sm="4">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div>
              <div class="mb-3">
                <h6 class="font-weight-bold">Statistics by Gender</h6>
                <!-- <span class="text-muted fs12">Jan 23 - Jun 22</span> -->
              </div>
              <apexchart
                class="text-center"
                type="pie"
                :options="facilitatorPieOptions"
                :series="facilitatorPieSeries"
                width="100%"
              ></apexchart>
            </div>
          </div>
        </b-col>
        <b-col sm="4" class="pr-sm-0">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Facilitators This Week</h6>
            </div>
            <div class="d-flex justify-content-between">
              <div class="h3 text-center text-dark-green">
                <p class="fs14 text-muted mb-2">Females</p>
                {{ femalefacilitatorsthisweek || 0 }}
              </div>
              <div class="h3 text-center text-dark-green">
                <p class="fs14 text-muted mb-2">Males</p>
                {{ malefacilitatorsthisweek || 0 }}
              </div>
            </div>
            <div class="h3 text-center text-dark-green">
              <p class="fs14 text-muted mb-2">Others</p>
              {{ otherfacilitatorsthisweek || 0 }}
            </div>
          </div>
        </b-col>
      </b-row>
      <b-row>
        <b-col sm="12" class="p-4 bg-white border rounded">
          <div>
            <div class="mb-3">
              <h5 class="font-weight-bold">Login Activity</h5>
              <!-- <span class="text-muted fs12">Jan 23 - Jun 22</span> -->
            </div>
            <div id="chart">
              <apexchart
                type="heatmap"
                height="200"
                :options="facilitatorLoginOptions"
                :series="facilitatorLoginSeries.slice().reverse()"
              ></apexchart>
            </div>
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
            <div class="h4 text-center text-dark-green">
              {{ (totalRevenue || 0) | currencyFormat }}
            </div>
            <br />
            <div class="text-muted text-center fs13">
              +{{ totalRevenueThisWeek | 0 | currencyFormat }} This week
            </div>
          </div>
        </b-col>
        <b-col sm="4">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Revenue This Year</h6>
            </div>

            <div class="h4 text-center text-dark-green">
              + {{ (totalRevenueThisYear || 0) | currencyFormat }}
            </div>
          </div>
        </b-col>
        <b-col sm="4" class="pr-sm-0">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Revenue This Month</h6>
            </div>
            <div class="h4 text-center text-dark-green">
              + {{ totalRevenueThisMonth || 0 | currencyFormat }}
            </div>
          </div>
        </b-col>
      </b-row>

      <b-row>
        <b-col sm="4" class="pl-sm-0">
          <div class="p-4 bg-white border rounded h-100 w-100">
            <div class="mb-3">
              <h6 class="font-weight-bold">Highest Earning Course</h6>
            </div>
            <div class="h5 text-center text-dark-green">
              {{ highestrevenue ? highestrevenue.course.title : "N/A" }}
            </div>
            <br />
            <div class="text-muted text-center h4">
              + {{ highestrevenue.revenue || 0 | currencyFormat }}
            </div>
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
      modules: [],
      start: "",
      end: "",
      highestrevenue: {},
      revenues: [],
      time: [
        "8:00",

        "9:00",
        "10:00",
        "11:00",
        "12:00",
        "13:00",
        "14:00",
        "15:00",
        "16:00",
      ],
      learners: [],
      facilitators: [],
      courses: [],
      gender: "",
      about: "audience",

      series: ["33", "33", "33"],
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

      facilitatorPieSeries: [],
      facilitatorPieOptions: {
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
      facilitatorLoginSeries: [
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
      facilitatorLoginOptions: {
        chart: {
          height: 200,
          type: "heatmap",
        },
        dataLabels: {
          enabled: false,
        },
        colors: ["#377f87"],
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
          name: "Courses",
          data: [],
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
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
          ],
        },
        yaxis: {
          title: {
            text: "Courses",
          },
        },
        fill: {
          opacity: 1,
        },
        tooltip: {
          y: {
            formatter: function (val) {
              return val + " courses";
            },
          },
        },
      },
      ageSeries: [
        {
          name: "Learners",
          data: [],
        },
      ],
      ageOptions: {
        chart: {
          type: "bar",
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
            "0 - 12 years",
            "13 -17 years",
            "18 -22 years",
            "23 - 40 years",
            "40years - above ",
          ],
        },
        yaxis: {
          title: {
            text: "Learners ",
          },
        },
        fill: {
          opacity: 1,
        },
        tooltip: {
          y: {
            formatter: function (val) {
              return val;
            },
          },
        },
      },
      stateSeries: [
        {
          name: "Learners",
          data: [],
        },
      ],
      stateOptions: {
        chart: {
          type: "bar",
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
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
          ],
        },
        yaxis: {
          title: {
            text: "Courses",
          },
        },
        fill: {
          opacity: 1,
        },
        tooltip: {
          y: {
            formatter: function (val) {
              return val + " courses";
            },
          },
        },
      },
      facilitatorSeries: [],
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
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
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
          data: [],
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
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
          ],
        },
        tooltip: {
          y: {
            formatter: function (val) {
              return (
                "₦ " + val.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,")
              );
            },
          },
        },
      },
    };
  },
  components: {
    MapChart,
  },
  created() {
    this.getlearners();
    this.getCourses();
    this.getFacilitators();
    this.getRevenue();
    this.highestrevenuecourse();
    this.mymodules();
  },
  watch: {
    states: "handleStateSeries",
    loginHistory: "handleTimeSeries",
    facilitatorLoginHistory: "handleFacilitatorTimeSeries",
    sortLearner: "getGender",
  },
  computed: {
    mycourses() {
      return this.modules.map((item) => {
        return item.course;
      });
    },
    sortCourse() {
      if (this.$store.getters.facilitator.facilitator_role == "creator") {
        if (this.start && this.end) {
          return this.courses.filter((item) => {
            return this.$moment(item.created_at).isBetween(
              this.$moment(this.start),
              this.$moment(this.end)
            );
          });
        }
        return this.courses;
      } else {
        if (this.start && this.end) {
          return this.mycourses.filter((item) => {
            return this.$moment(item.created_at).isBetween(
              this.$moment(this.start),
              this.$moment(this.end)
            );
          });
        }
        return this.mycourses;
      }
    },
    sortRevenue() {
      if (this.start && this.end) {
        return this.revenues.filter((item) => {
          return this.$moment(item.created_at).isBetween(
            this.$moment(this.start),
            this.$moment(this.end)
          );
        });
      }
      return this.revenues;
    },
    sortLearner() {
      if (this.start && this.end) {
        return this.learners.filter((item) => {
          return this.$moment(item.created_at).isBetween(
            this.$moment(this.start),
            this.$moment(this.end)
          );
        });
      }
      return this.learners;
    },
    sortFacilitator() {
      if (this.start && this.end) {
        return this.facilitators.filter((item) => {
          return this.$moment(item.created_at).isBetween(
            this.$moment(this.start),
            this.$moment(this.end)
          );
        });
      }
      return this.facilitators;
    },
    totalRevenue() {
      return this.sortRevenue
        .map((item) => item.revenue)
        .reduce((a, b) => {
          return Number(a) + Number(b);
        }, 0);
    },
    totalRevenueThisWeek() {
      return this.sortRevenue
        .filter(
          (item) =>
            this.$moment(item.created_at).week() == this.$moment().week()
        )
        .map((item) => item.revenue)
        .reduce((a, b) => {
          return Number(a) + Number(b);
        }, 0);
    },
    totalRevenueThisMonth() {
      return this.sortRevenue
        .filter(
          (item) =>
            this.$moment(item.created_at).format("MMMM") ==
            this.$moment().format("MMMM")
        )
        .map((item) => item.revenue)
        .reduce((a, b) => {
          return Number(a) + Number(b);
        }, 0);
    },
    totalRevenueThisYear() {
      return this.sortRevenue
        .filter(
          (item) =>
            this.$moment(item.created_at).format("YYYY") ==
            this.$moment().format("YYYY")
        )
        .map((item) => item.revenue)
        .reduce((a, b) => {
          return Number(a) + Number(b);
        }, 0);
    },
    male() {
      return this.sortLearner.filter((item) => item.gender == "male").length;
    },
    female() {
      return this.sortLearner.filter((item) => item.gender == "male").length;
    },
    others() {
      return this.sortLearner.filter(
        (item) => item.gender !== "male" && item.gender !== "female"
      ).length;
    },
    countries() {
      return this.sortLearner.map((item) => item.country);
    },
    uniqueCountries() {
      var count = [...new Set(this.countries)];

      return count;
    },
    countryData() {
      if (this.uniqueCountrie.length) {
        var arr = this.uniqueCountries.map((element) => {
          var data = {};
          data[element] = this.countries.filter((item) =>
            item.includes(element)
          ).length;
          return data;
        });
        return Object.assign({}, ...arr);
      }
      return {};
    },
    states() {
      var state = this.learners.map(
        (item) => item.state.slice(0, 1).toUpperCase() + item.state.slice(1)
      );
      return [...new Set(state)];
    },
    loginHistory() {
      var arr = this.sortLearner.map((item) => item.loginhistory);
      return arr.flat();
    },
    facilitatorLoginHistory() {
      var arr = this.sortFacilitator.map((item) => item.loginhistory);
      return arr.flat();
    },
    thisweekcourses() {
      return this.sortCourse.filter(
        (item) => this.$moment(item.created_at).week() == this.$moment().week()
      ).length;
    },
    courseviews() {
      var count = this.sortCourse.map((item) => {
        if (item.viewcount) {
          return item.viewcount.count;
        }
        return 0;
      });
      return count.reduce((a, b) => {
        return a + b;
      }, 0);
    },
    courseviewsthisweek() {
      var count = this.sortCourse
        .filter(
          (item) =>
            this.$moment(item.created_at).week() == this.$moment().week()
        )
        .map((item) => {
          if (item.viewcount) {
            return item.viewcount.count;
          }
          return 0;
        });
      return count.reduce((a, b) => {
        return a + b;
      }, 0);
    },
    totalpaid() {
      return this.sortCourse.filter((item) => item.type == "paid").length;
    },
    totalgroup() {
      return this.sortCourse.filter((item) => item.type == "group").length;
    },
    totalenrollment() {
      var count = this.sortCourse.map((item) => {
        if (item.enroll) {
          return item.enroll.count;
        }
        return 0;
      });
      return count.reduce((a, b) => {
        return a + b;
      }, 0);
    },
    totalenrollmentthisweek() {
      var count = this.sortCourse
        .filter(
          (item) =>
            this.$moment(item.created_at).week() == this.$moment().week()
        )
        .map((item) => {
          if (item.enroll) {
            return item.enroll.count;
          }
          return 0;
        });
      return count.reduce((a, b) => {
        return a + b;
      }, 0);
    },
    totalgroupthisweek() {
      return this.sortCourse
        .filter(
          (item) =>
            this.$moment(item.created_at).week() == this.$moment().week()
        )
        .filter((item) => item.type == "group").length;
    },
    totalpaidthisweek() {
      return this.sortCourse
        .filter(
          (item) =>
            this.$moment(item.created_at).week() == this.$moment().week()
        )
        .filter((item) => item.type == "paid").length;
    },
    mostenrolled() {
      return this.sortCourse
        .filter((item) => item.enroll)
        .sort((a, b) => {
          return b.enroll.count - a.enroll.count;
        })
        .slice(0, 1);
    },
    mostviewed() {
      return this.sortCourse
        .filter((item) => item.viewcount)
        .sort((a, b) => {
          return b.viewcount.count - a.viewcount.count;
        })
        .slice(0, 1);
    },
    mostinteracted() {
      return this.sortCourse
        .filter((item) => item.viewcount && item.enroll)
        .map((val) => {
          let data = {};
          data.title = val.title;
          data.count = val.viewcount.count + val.enroll.count;
          return data;
        })
        .sort((a, b) => {
          return b.count - a.count;
        })
        .slice(0, 1);
    },
    thisweekfacilitators() {
      return this.sortFacilitator.filter(
        (item) => this.$moment(item.created_at).week() == this.$moment().week()
      ).length;
    },
    malefacilitators() {
      return this.sortFacilitator.filter((item) => item.gender == "male")
        .length;
    },
    femalefacilitators() {
      return this.sortFacilitator.filter((item) => item.gender == "male")
        .length;
    },
    femalefacilitatorsthisweek() {
      return this.sortFacilitator
        .filter(
          (item) =>
            this.$moment(item.created_at).week() == this.$moment().week()
        )
        .filter((item) => item.gender == "female").length;
    },
    malefacilitatorsthisweek() {
      return this.sortFacilitator
        .filter(
          (item) =>
            this.$moment(item.created_at).week() == this.$moment().week()
        )
        .filter((item) => item.gender == "male").length;
    },
    otherfacilitators() {
      return this.sortFacilitator.filter(
        (item) => item.gender !== "male" && item.gender !== "female"
      ).length;
    },
    otherfacilitatorsthisweek() {
      return this.sortFacilitator
        .filter(
          (item) =>
            this.$moment(item.created_at).week() == this.$moment().week()
        )
        .filter((item) => item.gender !== "male" && item.gender !== "female")
        .length;
    },
  },
  methods: {
    mymodules() {
      this.$http
        .get(`${this.$store.getters.url}/facilitator/modules`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.modules = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    sortDays(day) {
      var res = this.loginHistory.filter(
        (item) =>
          this.$moment(item.record).format("dddd").toLowerCase() ==
          day.toLowerCase()
      );

      return res;
    },
    sortFacilitatorDays(day) {
      var res = this.facilitatorLoginHistory.filter(
        (item) =>
          this.$moment(item.record).format("dddd").toLowerCase() ==
          day.toLowerCase()
      );

      return res;
    },
    sortAge(a, b) {
      var res = this.sortLearner.filter(
        (item) => item.age >= a && item.age < b
      ).length;

      return res;
    },
    sortState(state) {
      var res = this.sortLearner.filter(
        (item) => item.state.toLowerCase() == state.toLowerCase()
      ).length;

      return res;
    },
    reset() {
      this.start = "";
      this.end = "";
    },
    highestrevenuecourse() {
      this.$http
        .get(`${this.$store.getters.url}/highest/revenue/course`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.highestrevenue = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    sortCourses(month) {
      var res = [];
      if (this.$store.getters.facilitator.facilitator_role == "creator") {
        res = this.courses.filter(
          (item) =>
            this.$moment(item.created_at).format("MMM").toLowerCase() == month
        );
        return res.length;
      } else {
        res = this.mycourses.filter(
          (item) =>
            this.$moment(item.created_at).format("MMM").toLowerCase() == month
        );
        return res.length;
      }
    },
    sortFacilitators(month) {
      var res = this.facilitators.filter(
        (item) =>
          this.$moment(item.created_at).format("MMM").toLowerCase() == month
      );
      return res.length;
    },
    sortRevenues(month) {
      var first = this.revenues.filter(
        (item) =>
          this.$moment(item.created_at).format("MMM").toLowerCase() == month
      );
      if (!first.length) {
        return 0;
      }

      var second = first.map((val) => val.revenue || 0);

      var result = second.reduce((a, b) => {
        return Number(a) + Number(b);
      }, 0);
      return result;
    },

    getGender() {
      this.series = [this.male, this.female, this.others];
      this.chartOptions = {
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
      };
    },
    getGenderFacilitator() {
      this.facilitatorPieSeries = [
        this.malefacilitators,
        this.femalefacilitators,
        this.otherfacilitators,
      ];
    },
    getRevenue() {
      if (this.$store.getters.facilitator.facilitator_role == "creator") {
        this.$http
          .get(`${this.$store.getters.url}/revenue`, {
            headers: {
              Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
            },
          })
          .then((res) => {
            if (res.status == 200) {
              this.revenues = res.data;
              this.handleRevenueSeries();
            }
          })
          .catch((err) => {
            this.$toast.error(err.response.data.message);
          });
      } else {
        this.$http
          .get(`${this.$store.getters.url}/facilitator/revenue`, {
            headers: {
              Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
            },
          })
          .then((res) => {
            if (res.status == 200) {
              this.revenues = res.data;
              this.handleRevenueSeries();
            }
          })
          .catch((err) => {
            this.$toast.error(err.response.data.message);
          });
      }
    },
    getlearners() {
      this.$http
        .get(`${this.$store.getters.url}/facilitator-get-users`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.learners = res.data;
            this.handleAgeSeries();
            this.getGender();
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    handleCourseSeries() {
      this.courseSeries = [
        {
          name: "Courses",
          data: [
            this.sortCourses("jan"),
            this.sortCourses("feb"),
            this.sortCourses("mar"),
            this.sortCourses("apr"),
            this.sortCourses("may"),
            this.sortCourses("jun"),
            this.sortCourses("jul"),
            this.sortCourses("aug"),
            this.sortCourses("sep"),
            this.sortCourses("oct"),
            this.sortCourses("nov"),
            this.sortCourses("dec"),
          ],
        },
      ];
    },
    handleFacilitatorSeries() {
      this.facilitatorSeries = [
        {
          name: "Facilitators",
          data: [
            this.sortFacilitators("jan"),
            this.sortFacilitators("feb"),
            this.sortFacilitators("mar"),
            this.sortFacilitators("apr"),
            this.sortFacilitators("may"),
            this.sortFacilitators("jun"),
            this.sortFacilitators("jul"),
            this.sortFacilitators("aug"),
            this.sortFacilitators("sep"),
            this.sortFacilitators("oct"),
            this.sortFacilitators("nov"),
            this.sortFacilitators("dec"),
          ],
        },
      ];
    },
    handleRevenueSeries() {
      this.revenueSeries = [
        {
          name: "Revenue",
          data: [
            this.sortRevenues("jan"),
            this.sortRevenues("feb"),
            this.sortRevenues("mar"),
            this.sortRevenues("apr"),
            this.sortRevenues("may"),
            this.sortRevenues("jun"),
            this.sortRevenues("jul"),
            this.sortRevenues("aug"),
            this.sortRevenues("sep"),
            this.sortRevenues("oct"),
            this.sortRevenues("nov"),
            this.sortRevenues("dec"),
          ],
        },
      ];
    },
    handleAgeSeries() {
      this.ageSeries = [
        {
          name: "Learners",
          data: [
            this.sortAge(0, 12),
            this.sortAge(13, 17),
            this.sortAge(18, 24),
            this.sortAge(25, 40),
            this.sortAge(41, 1000),
          ],
        },
      ];
    },
    handleStateSeries() {
      var states = this.states.map((item) => {
        return this.sortState(item);
      });

      this.stateSeries = [
        {
          name: "Learners ",
          data: states,
        },
      ];
      this.stateOptions = {
        chart: {
          type: "bar",
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
          categories: this.states,
        },
        yaxis: {
          title: {
            text: "Learners ",
          },
        },
        fill: {
          opacity: 1,
        },
        tooltip: {
          y: {
            formatter: function (val) {
              return val;
            },
          },
        },
      };
    },
    handleTimeSeries() {
      this.series1 = [
        {
          name: "Monday",
          data: [
            {
              x: "8:00am",
              y: this.handleDayTime(this.sortDays("monday"), "08:00", "09:00"),
            },
            {
              x: "9:00am",
              y: this.handleDayTime(this.sortDays("monday"), "09:00", "10:00"),
            },
            {
              x: "10:00am",
              y: this.handleDayTime(this.sortDays("monday"), "10:00", "11:00"),
            },
            {
              x: "11:00am",
              y: this.handleDayTime(this.sortDays("monday"), "11:00", "12:00"),
            },
            {
              x: "12:00pm",
              y: this.handleDayTime(this.sortDays("monday"), "12:00", "13:00"),
            },
            {
              x: "01:00pm",
              y: this.handleDayTime(this.sortDays("monday"), "13:00", "14:00"),
            },
            {
              x: "02:00pm",
              y: this.handleDayTime(this.sortDays("monday"), "14:00", "15:00"),
            },
            {
              x: "03:00pm",
              y: this.handleDayTime(this.sortDays("monday"), "15:00", "16:00"),
            },
            {
              x: "04:00pm",
              y: this.handleDayTime(this.sortDays("monday"), "16:00", "17:00"),
            },
          ],
        },
        {
          name: "Tuesday",
          data: [
            {
              x: "8:00am",
              y: this.handleDayTime(this.sortDays("tuesday"), "08:00", "09:00"),
            },
            {
              x: "9:00am",
              y: this.handleDayTime(this.sortDays("tuesday"), "09:00", "10:00"),
            },
            {
              x: "10:00am",
              y: this.handleDayTime(this.sortDays("tuesday"), "10:00", "11:00"),
            },
            {
              x: "11:00am",
              y: this.handleDayTime(this.sortDays("tuesday"), "11:00", "12:00"),
            },
            {
              x: "12:00pm",
              y: this.handleDayTime(this.sortDays("tuesday"), "12:00", "13:00"),
            },
            {
              x: "01:00pm",
              y: this.handleDayTime(this.sortDays("monday"), "13:00", "14:00"),
            },
            {
              x: "02:00pm",
              y: this.handleDayTime(this.sortDays("tuesday"), "14:00", "15:00"),
            },
            {
              x: "03:00pm",
              y: this.handleDayTime(this.sortDays("tuesday"), "15:00", "16:00"),
            },
            {
              x: "04:00pm",
              y: this.handleDayTime(this.sortDays("tuesday"), "16:00", "17:00"),
            },
          ],
        },
        {
          name: "Wednessday",
          data: [
            {
              x: "8:00am",
              y: this.handleDayTime(
                this.sortDays("wednessday"),
                "08:00",
                "09:00"
              ),
            },
            {
              x: "9:00am",
              y: this.handleDayTime(
                this.sortDays("wednessday"),
                "09:00",
                "10:00"
              ),
            },
            {
              x: "10:00am",
              y: this.handleDayTime(
                this.sortDays("wednessday"),
                "10:00",
                "11:00"
              ),
            },
            {
              x: "11:00am",
              y: this.handleDayTime(
                this.sortDays("wednessday"),
                "11:00",
                "12:00"
              ),
            },
            {
              x: "12:00pm",
              y: this.handleDayTime(
                this.sortDays("wednessday"),
                "12:00",
                "13:00"
              ),
            },
            {
              x: "01:00pm",
              y: this.handleDayTime(
                this.sortDays("wednessday"),
                "13:00",
                "14:00"
              ),
            },
            {
              x: "02:00pm",
              y: this.handleDayTime(
                this.sortDays("wednessday"),
                "14:00",
                "15:00"
              ),
            },
            {
              x: "03:00pm",
              y: this.handleDayTime(
                this.sortDays("wednessday"),
                "15:00",
                "16:00"
              ),
            },
            {
              x: "04:00pm",
              y: this.handleDayTime(
                this.sortDays("wednessday"),
                "16:00",
                "17:00"
              ),
            },
          ],
        },
        {
          name: "Thursday",
          data: [
            {
              x: "8:00am",
              y: this.handleDayTime(
                this.sortDays("thursday"),
                "08:00",
                "09:00"
              ),
            },
            {
              x: "9:00am",
              y: this.handleDayTime(
                this.sortDays("thursday"),
                "09:00",
                "10:00"
              ),
            },
            {
              x: "10:00am",
              y: this.handleDayTime(
                this.sortDays("thursday"),
                "10:00",
                "11:00"
              ),
            },
            {
              x: "11:00am",
              y: this.handleDayTime(
                this.sortDays("thursday"),
                "11:00",
                "12:00"
              ),
            },
            {
              x: "12:00pm",
              y: this.handleDayTime(
                this.sortDays("thursday"),
                "12:00",
                "13:00"
              ),
            },
            {
              x: "01:00pm",
              y: this.handleDayTime(
                this.sortDays("thursday"),
                "13:00",
                "14:00"
              ),
            },
            {
              x: "02:00pm",
              y: this.handleDayTime(
                this.sortDays("thursday"),
                "14:00",
                "15:00"
              ),
            },
            {
              x: "03:00pm",
              y: this.handleDayTime(
                this.sortDays("thursday"),
                "15:00",
                "16:00"
              ),
            },
            {
              x: "04:00pm",
              y: this.handleDayTime(
                this.sortDays("thursday"),
                "16:00",
                "17:00"
              ),
            },
          ],
        },
        {
          name: "Friday",
          data: [
            {
              x: "8:00am",
              y: this.handleDayTime(this.sortDays("friday"), "08:00", "09:00"),
            },
            {
              x: "9:00am",
              y: this.handleDayTime(this.sortDays("friday"), "09:00", "10:00"),
            },
            {
              x: "10:00am",
              y: this.handleDayTime(this.sortDays("friday"), "10:00", "11:00"),
            },
            {
              x: "11:00am",
              y: this.handleDayTime(this.sortDays("friday"), "11:00", "12:00"),
            },
            {
              x: "12:00pm",
              y: this.handleDayTime(this.sortDays("friday"), "12:00", "13:00"),
            },
            {
              x: "01:00pm",
              y: this.handleDayTime(this.sortDays("friday"), "13:00", "14:00"),
            },
            {
              x: "02:00pm",
              y: this.handleDayTime(this.sortDays("friday"), "14:00", "15:00"),
            },
            {
              x: "03:00pm",
              y: this.handleDayTime(this.sortDays("friday"), "15:00", "16:00"),
            },
            {
              x: "04:00pm",
              y: this.handleDayTime(this.sortDays("friday"), "16:00", "17:00"),
            },
          ],
        },
        {
          name: "Saturday",
          data: [
            {
              x: "8:00am",
              y: this.handleDayTime(
                this.sortDays("saturday"),
                "08:00",
                "09:00"
              ),
            },
            {
              x: "9:00am",
              y: this.handleDayTime(
                this.sortDays("saturday"),
                "09:00",
                "10:00"
              ),
            },
            {
              x: "10:00am",
              y: this.handleDayTime(
                this.sortDays("saturday"),
                "10:00",
                "11:00"
              ),
            },
            {
              x: "11:00am",
              y: this.handleDayTime(
                this.sortDays("saturday"),
                "11:00",
                "12:00"
              ),
            },
            {
              x: "12:00pm",
              y: this.handleDayTime(
                this.sortDays("saturday"),
                "12:00",
                "13:00"
              ),
            },
            {
              x: "01:00pm",
              y: this.handleDayTime(
                this.sortDays("saturday"),
                "13:00",
                "14:00"
              ),
            },
            {
              x: "02:00pm",
              y: this.handleDayTime(
                this.sortDays("saturday"),
                "14:00",
                "15:00"
              ),
            },
            {
              x: "03:00pm",
              y: this.handleDayTime(
                this.sortDays("saturday"),
                "15:00",
                "16:00"
              ),
            },
            {
              x: "04:00pm",
              y: this.handleDayTime(
                this.sortDays("saturday"),
                "16:00",
                "17:00"
              ),
            },
          ],
        },
      ];
    },
    handleFacilitatorTimeSeries() {
      this.facilitatorLoginSeries = [
        {
          name: "Monday",
          data: [
            {
              x: "8:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("monday"),
                "08:00",
                "09:00"
              ),
            },
            {
              x: "9:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("monday"),
                "09:00",
                "10:00"
              ),
            },
            {
              x: "10:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("monday"),
                "10:00",
                "11:00"
              ),
            },
            {
              x: "11:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("monday"),
                "11:00",
                "12:00"
              ),
            },
            {
              x: "12:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("monday"),
                "12:00",
                "13:00"
              ),
            },
            {
              x: "01:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("monday"),
                "13:00",
                "14:00"
              ),
            },
            {
              x: "02:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("monday"),
                "14:00",
                "15:00"
              ),
            },
            {
              x: "03:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("monday"),
                "15:00",
                "16:00"
              ),
            },
            {
              x: "04:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("monday"),
                "16:00",
                "17:00"
              ),
            },
          ],
        },
        {
          name: "Tuesday",
          data: [
            {
              x: "8:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("tuesday"),
                "08:00",
                "09:00"
              ),
            },
            {
              x: "9:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("tuesday"),
                "09:00",
                "10:00"
              ),
            },
            {
              x: "10:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("tuesday"),
                "10:00",
                "11:00"
              ),
            },
            {
              x: "11:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("tuesday"),
                "11:00",
                "12:00"
              ),
            },
            {
              x: "12:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("tuesday"),
                "12:00",
                "13:00"
              ),
            },
            {
              x: "01:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("monday"),
                "13:00",
                "14:00"
              ),
            },
            {
              x: "02:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("tuesday"),
                "14:00",
                "15:00"
              ),
            },
            {
              x: "03:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("tuesday"),
                "15:00",
                "16:00"
              ),
            },
            {
              x: "04:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("tuesday"),
                "16:00",
                "17:00"
              ),
            },
          ],
        },
        {
          name: "Wednessday",
          data: [
            {
              x: "8:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("wednessday"),
                "08:00",
                "09:00"
              ),
            },
            {
              x: "9:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("wednessday"),
                "09:00",
                "10:00"
              ),
            },
            {
              x: "10:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("wednessday"),
                "10:00",
                "11:00"
              ),
            },
            {
              x: "11:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("wednessday"),
                "11:00",
                "12:00"
              ),
            },
            {
              x: "12:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("wednessday"),
                "12:00",
                "13:00"
              ),
            },
            {
              x: "01:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("wednessday"),
                "13:00",
                "14:00"
              ),
            },
            {
              x: "02:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("wednessday"),
                "14:00",
                "15:00"
              ),
            },
            {
              x: "03:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("wednessday"),
                "15:00",
                "16:00"
              ),
            },
            {
              x: "04:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("wednessday"),
                "16:00",
                "17:00"
              ),
            },
          ],
        },
        {
          name: "Thursday",
          data: [
            {
              x: "8:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("thursday"),
                "08:00",
                "09:00"
              ),
            },
            {
              x: "9:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("thursday"),
                "09:00",
                "10:00"
              ),
            },
            {
              x: "10:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("thursday"),
                "10:00",
                "11:00"
              ),
            },
            {
              x: "11:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("thursday"),
                "11:00",
                "12:00"
              ),
            },
            {
              x: "12:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("thursday"),
                "12:00",
                "13:00"
              ),
            },
            {
              x: "01:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("thursday"),
                "13:00",
                "14:00"
              ),
            },
            {
              x: "02:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("thursday"),
                "14:00",
                "15:00"
              ),
            },
            {
              x: "03:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("thursday"),
                "15:00",
                "16:00"
              ),
            },
            {
              x: "04:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("thursday"),
                "16:00",
                "17:00"
              ),
            },
          ],
        },
        {
          name: "Friday",
          data: [
            {
              x: "8:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("friday"),
                "08:00",
                "09:00"
              ),
            },
            {
              x: "9:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("friday"),
                "09:00",
                "10:00"
              ),
            },
            {
              x: "10:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("friday"),
                "10:00",
                "11:00"
              ),
            },
            {
              x: "11:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("friday"),
                "11:00",
                "12:00"
              ),
            },
            {
              x: "12:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("friday"),
                "12:00",
                "13:00"
              ),
            },
            {
              x: "01:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("friday"),
                "13:00",
                "14:00"
              ),
            },
            {
              x: "02:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("friday"),
                "14:00",
                "15:00"
              ),
            },
            {
              x: "03:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("friday"),
                "15:00",
                "16:00"
              ),
            },
            {
              x: "04:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("friday"),
                "16:00",
                "17:00"
              ),
            },
          ],
        },
        {
          name: "Saturday",
          data: [
            {
              x: "8:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("saturday"),
                "08:00",
                "09:00"
              ),
            },
            {
              x: "9:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("saturday"),
                "09:00",
                "10:00"
              ),
            },
            {
              x: "10:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("saturday"),
                "10:00",
                "11:00"
              ),
            },
            {
              x: "11:00am",
              y: this.handleDayTime(
                this.sortFacilitatorDays("saturday"),
                "11:00",
                "12:00"
              ),
            },
            {
              x: "12:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("saturday"),
                "12:00",
                "13:00"
              ),
            },
            {
              x: "01:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("saturday"),
                "13:00",
                "14:00"
              ),
            },
            {
              x: "02:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("saturday"),
                "14:00",
                "15:00"
              ),
            },
            {
              x: "03:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("saturday"),
                "15:00",
                "16:00"
              ),
            },
            {
              x: "04:00pm",
              y: this.handleDayTime(
                this.sortFacilitatorDays("saturday"),
                "16:00",
                "17:00"
              ),
            },
          ],
        },
      ];
    },
    handleDayTime(arr, a, b) {
      var result = arr.filter((val) => {
        return this.$moment(val.record).isBetween(
          this.$moment(this.$moment(val.record).format("YYYY-MM-DD") + " " + a),
          this.$moment(this.$moment(val.record).format("YYYY-MM-DD") + " " + b)
        );
      });

      return result.length;
    },

    getCourses() {
      this.$http
        .get(`${this.$store.getters.url}/courses`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.courses = res.data;
            this.handleCourseSeries();
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    getFacilitators() {
      this.$http
        .get(`${this.$store.getters.url}/facilitators`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.facilitators = res.data;
            this.handleFacilitatorSeries();
            this.getGenderFacilitator();
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

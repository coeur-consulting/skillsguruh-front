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
    <b-row class="mb-4">
      <b-col class="bg-white shadow rounded p-4">
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
              :countryData="{ US: 4, CA: 7, GB: 8, IE: 14, ES: 21, NG: 87 }"
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
      <b-col sm="4" class="p-4 bg-white shadow rounded">
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
      <b-col sm="7" class="p-4 bg-white shadow rounded">
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
              :series="series1.reverse()"
            ></apexchart>
          </div>
        </div>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import MapChart from "vue-chart-map";
export default {
  data() {
    return {
      gender: "",
      about: "audience",
      series: [33, 33, 33],
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
          toolbar: false,
        },
        dataLabels: {
          enabled: false,
        },
        colors: ["#377f87"],
      },
    };
  },
  components: {
    MapChart,
  },
  methods: {
    initPie() {
      this.series = [this.males, this.females, this.others];
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
    },
  },
};
</script>
<style scoped>
.demo {
  height: 500px;
}
</style>

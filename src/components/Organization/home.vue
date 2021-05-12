<template>
  <div>
    <b-container>
      <b-row class="mb-5">
        <b-col sm="3">
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
                  icon="bell-fill"
                  scale="0.5"
                  variant="dark-green"
                  class="ic"
                ></b-icon>
              </b-iconstack>
              <div class="h6 mb-0 text-dark-green">Administrators</div>
            </div>

            <div class="d-flex justify-content-between mb-2 w-100">
              <div class="new_add">Newly Added</div>
              <div>4</div>
            </div>
            <div class="d-flex justify-content-between w-100">
              <div class="new_add">Total Number</div>
              <div>4</div>
            </div>
          </div>
        </b-col>
        <b-col sm="3">
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
                  icon="bell-fill"
                  scale="0.5"
                  variant="dark-green"
                ></b-icon>
              </b-iconstack>
              <div class="h6 mb-0 text-dark-green">Facilitators</div>
            </div>

            <div class="d-flex justify-content-between mb-2 w-100">
              <div class="new_add">Newly Added</div>
              <div>4</div>
            </div>
            <div class="d-flex justify-content-between w-100">
              <div class="new_add">Total Number</div>
              <div>4</div>
            </div>
          </div>
        </b-col>
        <b-col sm="3">
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
                  icon="bell-fill"
                  scale="0.5"
                  variant="dark-green"
                ></b-icon>
              </b-iconstack>
              <div class="h6 mb-0 text-dark-green">Learners</div>
            </div>

            <div class="d-flex justify-content-between mb-2 w-100">
              <div class="new_add">Newly Added</div>
              <div>4</div>
            </div>
            <div class="d-flex justify-content-between w-100">
              <div class="new_add">Total Number</div>
              <div>4</div>
            </div>
          </div>
        </b-col>
      </b-row>
      <b-row>
        <b-col sm="8" class="mb-5 mb-sm-0">
          <div
            class="d-flex flex-column flex-sm-row justify-content-between align-items-center mb-4"
          >
            <h6 class="mb-3 mb-sm-0">Administrators</h6>
            <div>
              <b-form-input
                placeholder="Search"
                size="sm"
                type="search"
                class="search"
              ></b-form-input>
            </div>
          </div>

          <div class="shadow bg-white">
            <div
              class="d-flex justify-content-between align-items-center p-3 e"
            >
              <b-icon icon="filter"></b-icon>
              <div>
                <b-button variant="dark-green" size="sm">
                  <b-icon icon="plus" font-scale="1.5"></b-icon
                ></b-button>
              </div>
            </div>

            <div class="admin_tab">
              <b-table-simple class="org_home_table text-left" responsive="sm">
                <b-thead>
                  <b-tr class="text-left">
                    <b-th class="text-muted">Name</b-th>
                    <b-th class="text-muted">Last login</b-th>
                    <b-th class="text-muted">Department</b-th>
                    <b-th class="text-muted">Status</b-th>
                    <b-th></b-th> </b-tr
                ></b-thead>
                <b-tbody>
                  <b-tr>
                    <b-td>
                      <div class="d-flex">
                        <b-avatar size="sm" class="mr-2"></b-avatar>
                        <div class="text-left">
                          <span>John Doe</span> <br />
                          <span class="text-muted">jdoe@gmail.com</span>
                        </div>
                      </div>
                    </b-td>
                    <b-td>
                      <div class="text-left">
                        <span>September 11, 2021</span> <br />
                        <span class="text-muted">2 days ago</span>
                      </div>
                    </b-td>
                    <b-td> Accounting </b-td>
                    <b-td class="text-success text-left">Active</b-td>
                    <b-td><b-icon icon="chevron-down"></b-icon> </b-td>
                  </b-tr>
                  <b-tr>
                    <b-td>
                      <div class="d-flex">
                        <b-avatar size="sm" class="mr-2"></b-avatar>
                        <div class="text-left">
                          <span>John Doe</span> <br />
                          <span class="text-muted">jdoe@gmail.com</span>
                        </div>
                      </div>
                    </b-td>
                    <b-td>
                      <div class="text-left">
                        <span>September 11, 2021</span> <br />
                        <span class="text-muted">2 days ago</span>
                      </div>
                    </b-td>
                    <b-td> Accounting </b-td>
                    <b-td class="text-success text-left">Active</b-td>
                    <b-td><b-icon icon="chevron-down"></b-icon> </b-td>
                  </b-tr>
                  <b-tr>
                    <b-td>
                      <div class="d-flex">
                        <b-avatar size="sm" class="mr-2"></b-avatar>
                        <div class="text-left">
                          <span>John Doe</span> <br />
                          <span class="text-muted">jdoe@gmail.com</span>
                        </div>
                      </div>
                    </b-td>
                    <b-td>
                      <div class="text-left">
                        <span>September 11, 2021</span> <br />
                        <span class="text-muted">2 days ago</span>
                      </div>
                    </b-td>
                    <b-td> Accounting </b-td>
                    <b-td class="text-success text-left">Active</b-td>
                    <b-td><b-icon icon="chevron-down"></b-icon> </b-td>
                  </b-tr>
                </b-tbody>
              </b-table-simple>
            </div>
          </div>
        </b-col>
        <b-col sm="4" class="text-left">
          <h6 class="mb-4">Turn Over</h6>

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
export default {
  data() {
    return {
      series: [44, 55, 13],
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
          categories: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul"],
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
}
.new_add {
  color: rgba(0, 0, 0, 0.44);
  font-size: 14px;
}
.box:hover {
  background: linear-gradient(127.24deg, #388087 28.41%, #c2edce 100%);
}
.box:hover > div > div,
.box:hover > div > .h6 {
  color: white !important;
}

.box:hover > div > .b-iconstack > g > .ic {
  color: white !important;
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
.turn_over_box {
  height: 100%;
}
.tob_1 {
  min-height: 200px;
  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
  border-radius: 8px;
  padding: 20px;
  background: white;
}
.tob_2 {
  min-height: 200px;
  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
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

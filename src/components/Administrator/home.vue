<template>
  <div>
    <b-container fluid>
      <b-row class="pt-5">
        <b-col md="8">
          <b-row class="mb-5 mb-sm-5">
            <b-col sm="6">
              <div class="box p-3 shadow">
                <div
                  class="
                    w-100
                    px-2
                    d-flex
                    justify-content-between
                    align-items-center
                    mb-4
                  "
                >
                  <div class="d-flex align-items-center mb-1">
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
                    <div class="h6 mb-0 text-dark-green">
                      Total <br />
                      Learners
                    </div>
                  </div>
                  <div class="h2">{{ users.length }}</div>
                </div>
                <div class="w-100 px-2">
                  <div class="new_add d-flex align-items-center">
                    <activity-icon
                      size="1x"
                      class="custom-class growth"
                    ></activity-icon>
                    <span class="mr-2 mt-1 growth">
                      {{
                        Math.round((newlyusers / users.length) * 100) || 0
                      }}%</span
                    >
                    <span class="mt-1">New Learners this month</span>
                  </div>
                </div>
              </div>
            </b-col>
            <b-col sm="6">
              <div class="box p-3 shadow">
                <div
                  class="
                    d-flex
                    w-100
                    justify-content-between
                    align-items-center
                    mb-4
                  "
                >
                  <div class="d-flex align-items-center mb-1">
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
                    <div class="h6 mb-0 text-dark-green">
                      Total <br />
                      Facilitator
                    </div>
                  </div>
                  <div class="h2">{{ facilitators.length }}</div>
                </div>

                <div class="w-100 px-2">
                  <div class="new_add d-flex align-items-center">
                    <activity-icon
                      size="1x"
                      class="custom-class growth"
                    ></activity-icon>
                    <span class="mr-2 mt-1 growth">
                      {{
                        Math.round(
                          (newlyfacilitators / facilitators.length) * 100
                        ) || 0
                      }}%</span
                    >
                    <span class="mt-1">New facilitator this month</span>
                  </div>
                </div>
              </div>
            </b-col>
          </b-row>
          <FacilitatorTab />
        </b-col>
        <b-col md="4">
          <div class="bg-white rounded text-center">
            <div class="mb-4">
              <vc-calendar
                class="custom-calendar max-w-full"
                :masks="masks"
                :attributes="attributes"
                disable-page-swipe
                is-expanded
                title-position="left"
              >
                <template #day-popover="{ dayTitle, attributes }">
                  <div class="text-xs text-gray-300 font-semibold text-center">
                    {{ dayTitle }}
                  </div>
                  <popover-row
                    v-for="attr in attributes"
                    :key="attr.key"
                    :attribute="attr"
                    class="border-bottom pb-2"
                  >
                    <div>
                      <p class="fs11 mb-0 text-capitalize">
                        <span class="mr-2">
                          {{ attr.customData.type }}
                        </span>
                      </p>
                      <p class="mb-1 text-capitalize">
                        {{ attr.customData.title }}
                      </p>
                    </div>
                  </popover-row>
                </template>
              </vc-calendar>
            </div>
          </div>
          <div class="bg-white rounded p-3 mt-3 todo-card">
            <div class="mb-4">
              <Todo user="admin" />
            </div>
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import { ActivityIcon } from "vue-feather-icons";
import FacilitatorTab from "./facilitators";
import Todo from "../Todo";
export default {
  data() {
    return {
      facilitators: [],
      users: [],
      todos: [],
      events: [],
      schedules: [],
      masks: {
        weekdays: "WWW"
      },
      showLearner: false,
      showFacilitator: false,
      showTable: false
    };
  },
  components: {
    FacilitatorTab,
    Todo,
    ActivityIcon
  },
  watch: {},
  created() {
    this.gettodos();
    this.getfacilitators();
    this.getusers();
    this.getevents();
    this.getschedules();
  },

  computed: {
    newlyfacilitators() {
      return this.facilitators.filter(
        item =>
          new Date(item.created_at).getMonth() == new Date().getMonth() &&
          new Date(item.created_at).getFullYear() == new Date().getFullYear()
      ).length;
    },
    newlyusers() {
      return this.users.filter(
        item =>
          new Date(item.created_at).getMonth() == new Date().getMonth() &&
          new Date(item.created_at).getFullYear() == new Date().getFullYear()
      ).length;
    },
    myschedule() {
      return this.schedules.map((item, index) => {
        var res = {
          key: index,

          highlight: {
            start: { color: "teal", fillMode: "outline" },
            base: { color: "teal", fillMode: "light" },
            end: { color: "teal", fillMode: "solid" }
          },
          dot: false,
          bar: false,
          content: false,
          popover: true,
          customData: {
            title: item.course.title,
            duration:
              this.$moment(item.start_time).diff(
                this.$moment(item.end_time),
                "weeks"
              ) + "weeks",
            type: "Course",
            class: "bg-red-600 text-white"
          },
          dates: {
            start: new Date(item.start_time),
            end: new Date(item.end_time)
          }
        };
        return res;
      });
    },
    myevents() {
      return this.events.map((item, index) => {
        var res = {
          key: index,

          highlight: {
            start: { color: "green", fillMode: "outline" },
            base: { color: "green", fillMode: "light" },
            end: { color: "green", fillMode: "solid" }
          },
          dot: false,
          bar: false,
          content: false,
          popover: true,
          customData: {
            title: item.title,
            duration: item.schedule,
            type: item.type,
            class: "bg-red-600 text-white"
          },
          dates: { start: new Date(item.start), end: new Date(item.end) }
        };
        return res;
      });
    },
    attributes() {
      return this.myschedule.concat(this.myevents).map((item, index) => {
        var res = {
          key: index,
          highlight: item.highlight,
          popover: true,
          customData: item.customData,
          dates: item.dates
        };
        return res;
      });
    }
  },
  methods: {
    async getevents() {
      return this.$http
        .get(`${this.$store.getters.url}/events`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`
          }
        })
        .then(res => {
          if (res.status == 200) {
            this.events = res.data.filter(item => item.status !== "expired");
          }
        })
        .catch(err => {
          this.$toast.error(err.response.data.message);
        });
    },
    async getschedules() {
      return this.$http
        .get(`${this.$store.getters.url}/courseschedules`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`
          }
        })
        .then(res => {
          if (res.status == 200) {
            this.schedules = res.data;
            this.rows = res.data.length;
          }
        })
        .catch(err => {
          this.$toast.error(err.response.data.message);
        });
    },
    gettodos() {
      this.$http
        .get(`${this.$store.getters.url}/todos`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`
          }
        })
        .then(res => {
          if (res.status == 200) {
            this.todos = res.data;
          }
        })
        .catch(err => {
          this.$toast.error(err.response.data.message);
        });
    },
    getfacilitators() {
      this.$http
        .get(`${this.$store.getters.url}/admin-get-facilitators`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`
          }
        })
        .then(res => {
          if (res.status == 200) {
            this.facilitators = res.data;
            this.showFacilitator = true;
          }
        })
        .catch(err => {
          this.$toast.error(err.response.data.message);
        });
    },
    getusers() {
      this.$http
        .get(`${this.$store.getters.url}/admin-get-users`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`
          }
        })
        .then(res => {
          if (res.status == 200) {
            this.users = res.data;
            this.showLearner = true;
          }
        })
        .catch(err => {
          this.$toast.error(err.response.data.message);
        });
    }
  }
};
</script>
<style scoped lang="scss">
.container {
  padding-top: 30px;
}
.box {
  min-height: 130px;
  display: flex;
  align-items: flex-start;
  flex-direction: column;
  justify-content: center;
  text-align: left;

  // box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35);
  border-radius: 8px;
  background: white;
}
.growth {
  color: #3cc13b;
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

// .box:hover > div > .new_add > .ic {
//   color: white !important;
// }
.shadow {
  // box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
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
  // box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
  border-radius: 8px;
  text-align: center;
  background: white;
}
.tob_2 {
  min-height: 200px;
  // box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
  border-radius: 8px;
  padding: 0;
  background: white;
}
.admin_tab {
  min-height: 400px;
}
.todos {
  padding: 10px;
  height: 200px;
  overflow: auto;
}
.todo {
  background: var(--skills-grey);
  border-radius: 5px;
}
.text-sm {
  font-size: 0.7rem;
}
.main_box {
  width: 100%;
}
.rside {
  width: 100%;
  transition: 0.5s;
}
.side_box {
  position: fixed;
  top: 14%;
  right: 1%;
  text-align: left;
  transition: 0.5s;
  width: 5%;
  height: 80vh;
  z-index: 88;
}
.side_box .sided .tools {
  display: none;
}
.side_box:hover {
  width: 20%;
}
.side_box:hover ~ .rside {
  width: 73%;
}

.side_box:hover .sided .tools {
  display: block;
}
.side_box:hover .sided .tools_icons {
  display: none;
}
.sided {
  height: 100%;
  overflow: scroll;
}

@media (max-width: 600px) {
  .box {
    margin-bottom: 24px;
  }
  .admin_tab {
    min-height: 200px;
  }
  .new_add img {
    width: 30px;
  }
  .w-50 {
    width: 70% !important;
  }
  .rside {
    width: 100%;
    padding: 15px;
  }
}
</style>

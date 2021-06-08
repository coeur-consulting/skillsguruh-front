<template>
  <div>
    <b-container>
      <b-row>
        <b-col sm="8">
          <b-row class="mb-4 mb-sm-4">
            <b-col sm="6">
              <div class="box p-3" v-if="showFacilitator">
                <div
                  class="
                    d-flex
                    justify-content-between
                    w-100
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
                      Facilitators
                    </div>
                  </div>
                  <div class="h2">{{ facilitators.length }}</div>
                </div>

                <div class="w-100 px-2">
                  <div class="new_add d-flex align-items-center">
                    <b-img
                      class="mr-2"
                      :src="require('@/assets/images/profit.svg')"
                      width="24"
                    ></b-img>
                    <span class="mr-2 mt-1 text-dark-green">
                      {{
                        Math.round(
                          (newlyfacilitators / facilitators.length) * 100
                        ) || 0
                      }}%</span
                    >
                    <span class="mt-1">New Facilitators this month</span>
                  </div>
                </div>
              </div>

              <div class="box p-3" v-else>
                <div class="d-flex w-100 mb-3">
                  <div class="mr-2">
                    <b-skeleton type="avatar"></b-skeleton>
                  </div>
                  <div class="w-100">
                    <b-skeleton animation="wave" width="85%"></b-skeleton>
                    <b-skeleton animation="wave" width="35%"></b-skeleton>
                  </div>
                </div>
                <div class="w-100">
                  <b-skeleton animation="wave" width="100%"></b-skeleton>
                </div>
              </div>
            </b-col>
            <b-col sm="6">
              <div class="box p-3" v-if="showLearner">
                <div
                  class="
                    d-flex
                    justify-content-between
                    align-items-center
                    w-100
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
                    <b-img
                      class="mr-2"
                      :src="require('@/assets/images/profit.svg')"
                      width="24"
                    ></b-img>
                    <span class="mr-2 mt-1 text-dark-green">
                      {{
                        Math.round((newlyusers / users.length) * 100) || 0
                      }}%</span
                    >
                    <span class="mt-1">New Learners this month</span>
                  </div>
                </div>
              </div>
              <div class="box p-3" v-else>
                <div class="d-flex w-100 mb-3">
                  <div class="mr-2">
                    <b-skeleton type="avatar"></b-skeleton>
                  </div>
                  <div class="w-100">
                    <b-skeleton animation="wave" width="85%"></b-skeleton>
                    <b-skeleton animation="wave" width="35%"></b-skeleton>
                  </div>
                </div>
                <div class="w-100">
                  <b-skeleton animation="wave" width="100%"></b-skeleton>
                </div>
              </div>
            </b-col>
          </b-row>
          <FacilitatorTab />
        </b-col>
        <b-col sm="4" class="text-left">
          <div class="turn_over_box">
            <div class="tob_1 mb-4">
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
                      <p class="mb-1 text-capitalize">
                        {{ attr.customData.title }}
                      </p>
                      <p class="fs11 mb-0 text-capitalize">
                        <span class="mr-2"> {{ attr.customData.type }} -</span
                        ><span> {{ attr.customData.duration }}</span>
                      </p>
                    </div>
                  </popover-row>
                </template>
              </vc-calendar>
            </div>
            <div class="tob_2">
              <Todo user="admin" />
            </div>
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
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
        weekdays: "WWW",
      },
      showLearner: false,
      showFacilitator: false,
      showTable: false,
    };
  },
  components: {
    FacilitatorTab,
    Todo,
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
    myschedule() {
      return this.schedules.map((item, index) => {
        var res = {
          key: index,

          highlight: {
            color: "teal",
            fillMode: "light",
            start: { fillMode: "outline" },
            base: { fillMode: "light" },
            end: { fillMode: "solid" },
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
            class: "bg-red-600 text-white",
          },
          dates: {
            start: new Date(item.start_time),
            end: new Date(item.end_time),
          },
        };
        return res;
      });
    },
    myevents() {
      return this.events.map((item, index) => {
        var res = {
          key: index,

          highlight: {
            color: "purple",
            fillMode: "light",

            start: { fillMode: "outline" },
            base: { fillMode: "light" },
            end: { fillMode: "solid" },
          },
          dot: false,
          bar: false,
          content: false,
          popover: true,
          customData: {
            title: item.title,
            duration: item.schedule,
            type: item.type,
            class: "bg-red-600 text-white",
          },
          dates: { start: new Date(item.start), end: new Date(item.end) },
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
          dates: item.dates,
        };
        return res;
      });
    },
  },
  methods: {
    async getevents() {
      return this.$http
        .get(`${this.$store.getters.url}/events`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.events = res.data.filter((item) => item.status !== "expired");
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    async getschedules() {
      return this.$http
        .get(`${this.$store.getters.url}/courseschedules`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.schedules = res.data;
            this.rows = res.data.length;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    gettodos() {
      this.$http
        .get(`${this.$store.getters.url}/todos`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.todos = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getfacilitators() {
      this.$http
        .get(`${this.$store.getters.url}/admin-get-facilitators`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.facilitators = res.data;
            this.showFacilitator = true;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getusers() {
      this.$http
        .get(`${this.$store.getters.url}/admin-get-users`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.users = res.data;
            this.showLearner = true;
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
  min-height: 130px;
  display: flex;
  align-items: flex-start;
  flex-direction: column;
  justify-content: center;
  text-align: left;

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

// .box:hover > div > .new_add > .ic {
//   color: white !important;
// }
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
  text-align: center;
  background: white;
}
.tob_2 {
  min-height: 200px;
  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
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
@media (max-width: 600px) {
  .box {
    margin-bottom: 24px;
  }
  .admin_tab {
    min-height: 200px;
  }
}
</style>

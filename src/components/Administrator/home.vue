<template>
  <div>
    <b-container>
      <b-row>
        <b-col sm="8">
          <b-row class="mb-4 mb-sm-5">
            <b-col sm="6">
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
                  <div class="h6 mb-0 text-dark-green">Total Facilitators</div>
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
            <b-col sm="6">
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
                  <div class="h6 mb-0 text-dark-green">Total Learners</div>
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
          <FacilitatorTab />
        </b-col>
        <b-col sm="4" class="text-left">
          <div class="turn_over_box">
            <div class="tob_1 mb-4 p-3">
              <vc-calendar></vc-calendar>
            </div>
            <div class="tob_2">
              <Todo />
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
    };
  },
  components: {
    FacilitatorTab,
    Todo,
  },
  watch: {},
  mounted() {
    this.gettodos();
    // this.getfacilitators();
    // this.getusers();
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
  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35);
  border-radius: 8px;
  background: white;
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

// .box:hover > div > .b-iconstack > g > .ic {
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

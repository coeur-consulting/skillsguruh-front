<template>
  <div id="chart1" style="overflow: hidden" class="p-1 rounded">
    <h6>To do List</h6>
    <b-row class="p-2 p-sm-3">
      <b-col sm="12">
        <b-form @submit.prevent="register">
          <b-input-group size="sm">
            <b-form-input
              autocomplete="off"
              :autofocus="false"
              placeholder="Add a new todo"
              required
              v-model="todo"
            ></b-form-input>
            <b-input-group-append>
              <b-button size="sm" type="submit" class="" variant="dark-green"
                ><b-icon icon="plus" font-scale="1.5"></b-icon
              ></b-button>
            </b-input-group-append>
          </b-input-group> </b-form
      ></b-col>
    </b-row>

    <div v-if="showTodo">
      <div v-if="todos.length">
        <div class="todos d-flex flex-column">
          <div class="mb-2" v-for="(item, index) in todos" :key="index">
            <div class="todo d-flex align-items-center w-100 py-2 px-1 rounded">
              <div class="flex-1 px-2">
                <b-form-checkbox
                  class="w-100 text-left"
                  :checked="item.status ? true : false"
                  @change="update(index, item.id, item.todo, item.status)"
                  size="sm"
                  ><div class="text-left">
                    <span :class="{ strike: item.status }"
                      >{{ item.todo }} </span
                    ><br />
                    <span class="text-muted fs11 mr-5">{{
                      item.created_at | moment("LL")
                    }}</span>
                    <span
                      class="text-sm"
                      :class="{
                        'text-success': item.status,
                        'text-danger': !item.status
                      }"
                      >{{ item.status ? "Completed" : "Incomplete" }}</span
                    >
                  </div>
                </b-form-checkbox>
              </div>
              <b-icon @click="drop(item.id, index)" icon="trash"></b-icon>
            </div>
          </div>
        </div>

        <div class="text-right p-3" v-if="todos.length">
          <small class="text-dark-green" @click="dropall"
            >Clear <b-icon icon=" x-circle-fill"></b-icon
          ></small>
        </div>
      </div>

      <div class="text-center p-3" v-else>
        <h6 class="text-muted fs12">No active To do</h6>
      </div>
    </div>
    <div class="p-3" v-else>
      <div class="p-1">
        <b-skeleton animation="wave" width="100%"></b-skeleton>
        <b-skeleton animation="wave" width="25%"></b-skeleton>
      </div>
      <div class="p-1">
        <b-skeleton animation="wave" width="100%"></b-skeleton>
        <b-skeleton animation="wave" width="25%"></b-skeleton>
      </div>
      <div class="p-1">
        <b-skeleton animation="wave" width="100%"></b-skeleton>
        <b-skeleton animation="wave" width="25%"></b-skeleton>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "todo-component",
  props: ["user"],
  data() {
    return {
      todos: [],
      todo: "",
      showTodo: false
    };
  },

  mounted() {
    this.gettodos();
  },
  computed: {
    useraccess() {
      var token = null;
      if (this.$props.user == "admin") {
        return this.$store.getters.admin;
      }
      if (this.$props.user == "facilitator") {
        return this.$store.getters.facilitator;
      }
      if (this.$props.user == "learner") {
        return this.$store.getters.learner;
      }
      return token;
    }
  },

  methods: {
    gettodos() {
      this.$http
        .get(`${this.$store.getters.url}/todos`, {
          headers: {
            Authorization: `Bearer ${this.useraccess.access_token}`
          }
        })
        .then(res => {
          if (res.status == 200) {
            this.todos = res.data;
            this.showTodo = true;
          }
        })
        .catch(err => {
          this.$toast.error(err.response.data.message);
        });
    },
    register() {
      this.$http
        .post(
          `${this.$store.getters.url}/todos`,
          { todo: this.todo },
          {
            headers: {
              Authorization: `Bearer ${this.useraccess.access_token}`
            }
          }
        )
        .then(res => {
          if (res.status == 201) {
            this.$toast.success("Added successfully");

            this.todos.unshift(res.data);
            this.todo = "";
          }
        })
        .catch(err => {
          this.$toast.error(err.response.data.message);
        });
    },

    update(index, id, data, status) {
      this.$http
        .put(
          `${this.$store.getters.url}/todos/${id}`,
          { todo: data, status: status },
          {
            headers: {
              Authorization: `Bearer ${this.useraccess.access_token}`
            }
          }
        )
        .then(res => {
          if (res.status == 200) {
            this.$toast.success("Todo Updated ");
            this.todos.splice(index, 1, res.data);
          }
        })
        .catch(err => {
          this.$toast.error(err.response.data.message);
        });
    },
    drop(id, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then(val => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/todos/${id}`, {
              headers: {
                Authorization: `Bearer ${this.useraccess.access_token}`
              }
            })
            .then(res => {
              if (res.status == 200) {
                this.$toast.success("Removed successfully");
                this.todos.splice(index, 1);
              }
            })
            .catch(err => {
              this.$toast.error(err.response.data.message);
            });
        }
      });
    },
    dropall() {
      this.$http
        .get(`${this.$store.getters.url}/todos-destroy`, {
          headers: {
            Authorization: `Bearer ${this.useraccess.access_token}`
          }
        })
        .then(res => {
          if (res.status == 200) {
            this.$toast.success("All cleared");
            this.todos = [];
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
  max-height: 400px;
}
.todos {
  padding: 10px;
  max-height: 400px;
  overflow: auto;
}
.todo {
  background: #fbfbfb;
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

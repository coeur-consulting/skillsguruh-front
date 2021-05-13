<template>
  <div id="chart1">
    <div
      class="d-flex justify-content-between align-items-center border-bottom p-3"
    >
      <h6>Todo List</h6>
      <b-form @submit.prevent="register">
        <b-input-group size="sm">
          <b-form-input
            placeholder="Add todo"
            required
            v-model="todo"
          ></b-form-input>
          <b-input-group-append>
            <b-button size="sm" type="submit" variant="dark-green"
              ><b-icon icon="plus" font-scale="1.5"></b-icon
            ></b-button>
          </b-input-group-append>
        </b-input-group>
      </b-form>
    </div>

    <div>
      <div class="todos d-flex flex-column">
        <div class="flex-1" v-for="(item, index) in todos" :key="index">
          <div class="todo d-flex align-items-center w-100 p-2 rounded mb-2">
            <div class="flex-1">
              <b-form-checkbox
                v-model="item.status"
                @change="update(item.id, item.todo)"
                size="sm"
                ><span :class="{ strike: item.status }">{{ item.todo }} </span
                ><br />
                <span class="text-muted text-sm">{{
                  item.created_at | moment("LL")
                }}</span></b-form-checkbox
              >
            </div>
            <b-icon @click="drop(item.id, index)" icon="trash"></b-icon>
          </div>
        </div>
      </div>

      <div class="text-right p-3">
        <small class="text-dark-green"
          >Clear <b-icon icon=" x-circle-fill"></b-icon
        ></small>
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
    };
  },

  mounted() {
    this.gettodos();
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
    register() {
      this.$http
        .post(
          `${this.$store.getters.url}/todos`,
          { todo: this.todo },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 201) {
            this.$toast.success("Added successfully");

            this.todos.unshift(res.data);
            this.todo = "";
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    update(id, data) {
      this.$http
        .put(
          `${this.$store.getters.url}/todos/${id}`,
          { todo: data },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Update successful");

            this.todo = "";
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    drop(id, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/todos/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success("Removed successfully");
                this.todos.splice(index, 1);
              }
            })
            .catch((err) => {
              this.$toast.error(err.response.data.message);
            });
        }
      });
    },
  },
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

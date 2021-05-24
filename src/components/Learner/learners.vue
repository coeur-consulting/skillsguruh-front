<template>
  <div>
    <b-container>
      <b-row>
        <b-col class="mb-5 mb-sm-0">
          <div
            class="d-flex flex-column flex-sm-row justify-content-between align-items-center mb-4"
          >
            <h6 class="mb-3 mb-sm-0">Learners</h6>
            <div>
              <b-form-input
                placeholder="Search"
                size="sm"
                type="search"
                class="search"
                v-model="search"
              ></b-form-input>
            </div>
          </div>

          <div class="shadow bg-white">
            <div
              v-if="users.length"
              class="d-flex justify-content-between align-items-center p-3 e"
            >
              <b-icon icon="funnel"></b-icon>
              <div>
                <b-button variant="dark-green" size="sm">
                  <b-icon
                    icon="plus"
                    @click="$bvModal.show('add')"
                    font-scale="1.5"
                  ></b-icon
                ></b-button>
              </div>
            </div>

            <div class="" v-if="users.length">
              <b-table-simple class="org_home_table text-left" responsive="sm">
                <b-thead>
                  <b-tr class="text-left">
                    <b-th class="text-muted">Name</b-th>
                    <b-th class="text-muted">Last login</b-th>
                    <b-th class="text-muted">Phone number</b-th>
                    <b-th class="text-muted">Status</b-th>
                    <b-th></b-th> </b-tr
                ></b-thead>
                <b-tbody>
                  <b-tr v-for="(item, index) in filter" :key="item.id">
                    <b-td>
                      <div class="d-flex">
                        <b-avatar
                          :src="item.profile"
                          size="sm"
                          class="mr-2"
                        ></b-avatar>
                        <div class="text-left">
                          <span class="text-capitalize">{{ item.name }}</span>
                          <br />
                          <span class="text-muted">{{ item.email }}</span>
                        </div>
                      </div>
                    </b-td>
                    <b-td>
                      <div class="text-left" v-if="item.loginhistory.length">
                        <span v-if="item.loginhistory.length">{{
                          item.loginhistory[item.loginhistory.length - 1].record
                            | moment("ll")
                        }}</span>
                        <br />
                        <span
                          class="text-muted"
                          v-if="item.loginhistory.length"
                          >{{
                            item.loginhistory[item.loginhistory.length - 1]
                              .record | duration("humanize", true)
                          }}</span
                        >
                      </div>
                      <div class="text-left" v-else>Not available</div>
                    </b-td>
                    <b-td class="text-capitalize"> {{ item.phone }} </b-td>
                    <b-td
                      class="text-left"
                      :class="{
                        'text-success': item.verification,
                        'text-danger': !item.verification,
                      }"
                      >{{ item.verification ? "Active" : "Inactive" }}</b-td
                    >
                    <b-td
                      ><b-icon
                        icon="chevron-down"
                        class="cursor-pointer"
                        :id="item.id.toString() + item.name"
                      ></b-icon>
                      <b-popover
                        :target="item.id.toString() + item.name"
                        triggers="hover"
                        placement="bottom"
                      >
                        <div class="">
                          <small
                            class="px-0 text-left cursor-pointer"
                            @click="
                              $router.push(
                                `/administrator/view/learner/${item.id}`
                              )
                            "
                          >
                            <b-icon class="mr-2" icon="eye"></b-icon
                            ><span>View</span>
                          </small>
                          <br />
                          <hr class="my-1" />
                          <small
                            class="px-0 text-left cursor-pointer"
                            @click="edit(item)"
                          >
                            <b-icon class="mr-2" icon="pencil"></b-icon
                            ><span>Edit</span>
                          </small>
                          <br />
                          <hr class="my-1" />
                          <small
                            class="px-0 cursor-pointer"
                            @click="drop(item.id, index)"
                          >
                            <b-icon class="mr-2" icon="trash"></b-icon
                            ><span>Drop</span>
                          </small>
                        </div>
                      </b-popover>
                    </b-td>
                  </b-tr>
                </b-tbody>
              </b-table-simple>
              <div class="p-3 d-flex justify-content-between">
                <div class="fs12 text-muted">
                  Showing 1-10 of {{ users.length }} items
                </div>
                <b-pagination
                  pills
                  size="sm"
                  variant="dark-green"
                  align="right"
                  v-model="currentPage"
                  :total-rows="rows"
                  :per-page="perPage"
                ></b-pagination>
              </div>
            </div>
            <div v-else class="text-center admin_tab p-3 p-sm-5">
              <div>
                <b-img :src="require('@/assets/images/creator.svg')"></b-img>
                <h6 class="text-muted my-3 fs14">
                  It appears you havent added any Learner yet,
                  <br class="d-none d-sm-block" />
                  Add your first Learner now!
                </h6>
                <b-button
                  @click="$bvModal.show('add')"
                  variant="dark-green"
                  size="lg"
                  >Add Learner</b-button
                >
              </div>
            </div>
          </div>
        </b-col>
      </b-row>
    </b-container>

    <b-modal id="add" hide-footer centered size="lg" title="Add Learner">
      <b-form @submit.prevent="register" class="user">
        <div>
          <b-form-row class="mb-2">
            <b-col sm="6" class="pr-sm-3">
              <b-form-group label="Full name">
                <b-form-input
                  size="lg"
                  v-model="user.name"
                  required
                  placeholder="Enter full name"
                ></b-form-input>
              </b-form-group>
            </b-col>
            <b-col sm="6" class="pr-sm-3">
              <b-form-group label="Email">
                <b-form-input
                  size="lg"
                  required
                  v-model="user.email"
                  type="email"
                  placeholder="Enter email address"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-form-row>
          <b-form-row class="mb-2">
            <b-col cols="6" class="pr-sm-3">
              <b-form-group label="Phone">
                <b-form-input
                  size="lg"
                  required
                  v-model="user.phone"
                  type="tel"
                  placeholder="Enter phone number"
                ></b-form-input>
              </b-form-group>
            </b-col>
            <b-col cols="6" class="pr-sm-3">
              <b-form-group label="Password">
                <b-form-input
                  size="lg"
                  required
                  v-model="user.password"
                  type="password"
                  placeholder="Enter password"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-form-row>

          <b-form-group>
            <div class="mb-3">
              <b-button
                type="submit"
                variant="dark-green"
                size="lg"
                class="px-5 d-none d-sm-block"
                >Register</b-button
              >
              <b-button
                type="submit"
                variant="dark-green"
                size="lg"
                block
                class="px-5 d-sm-none"
                >Register</b-button
              >
            </div>
          </b-form-group>
        </div>
      </b-form>
    </b-modal>
    <b-modal id="edit" hide-footer centered size="lg" title="Edit Learner">
      <b-form @submit.prevent="update" class="user">
        <div>
          <b-form-row class="mb-2">
            <b-col sm="6" class="pr-sm-3">
              <b-form-group label="Full name">
                <b-form-input
                  size="lg"
                  v-model="user.name"
                  required
                  placeholder="Enter full name"
                ></b-form-input>
              </b-form-group>
            </b-col>
            <b-col sm="6" class="pr-sm-3">
              <b-form-group label="Email">
                <b-form-input
                  size="lg"
                  required
                  v-model="user.email"
                  type="email"
                  placeholder="Enter email address"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-form-row>
          <b-form-row class="mb-2">
            <b-col cols="6" class="pr-sm-3">
              <b-form-group label="Phone">
                <b-form-input
                  size="lg"
                  required
                  v-model="user.phone"
                  type="tel"
                  placeholder="Enter phone number"
                ></b-form-input>
              </b-form-group>
            </b-col>
            <b-col cols="6" class="pr-sm-3">
              <b-form-group label="Password">
                <b-form-input
                  readonly
                  size="lg"
                  required
                  v-model="user.password"
                  type="password"
                  placeholder="Enter password"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-form-row>

          <b-form-group>
            <div class="mb-3">
              <b-button
                type="submit"
                variant="dark-green"
                size="lg"
                class="px-5 d-none d-sm-block"
                >Update</b-button
              >
              <b-button
                type="submit"
                variant="dark-green"
                size="lg"
                block
                class="px-5 d-sm-none"
                >Update</b-button
              >
            </div>
          </b-form-group>
        </div>
      </b-form>
    </b-modal>
  </div>
</template>
<script>
export default {
  data() {
    return {
      id: null,
      search: "",
      currentPage: 1,
      rows: null,
      perPage: 10,
      users: [],
      user: {
        name: "",
        email: "",
        phone: "",
        password: "",
      },
    };
  },
  computed: {
    filter() {
      return this.users
        .filter((item) =>
          item.name.toLowerCase().includes(this.search.toLowerCase())
        )
        .slice(
          this.perPage * this.currentPage - this.perPage,
          this.perPage * this.currentPage
        );
    },
  },
  mounted() {
    this.getusers();
  },
  methods: {
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
            this.rows = res.data.length;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    register() {
      this.$http
        .post(`${this.$store.getters.url}/admin-register-user`, this.user, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.$toast.success("Added successfully");
            this.$bvModal.hide("add");
            this.users.unshift(res.data);
            this.user = {
              name: "",
              email: "",
              phone: "",
              password: "",
            };
          }
        })
        .catch((err) => {
          if (err.response.data.errors.email[0]) {
            this.$toast.error(err.response.data.errors.email[0]);
          }
          if (err.response.data.errors.phone[0]) {
            this.$toast.error(err.response.data.errors.phone[0]);
          }
          if (err.response.data.errors.name[0]) {
            this.$toast.error(err.response.data.errors.name[0]);
          }
          if (err.response.data.errors.password[0]) {
            this.$toast.error(err.response.data.errors.password[0]);
          }
        });
    },
    edit(data) {
      this.$bvModal.show("edit");
      this.user = data;
    },
    update() {
      this.$http
        .put(
          `${this.$store.getters.url}/admin-update-user/${this.user.id}`,
          this.user,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Update successful");
            this.$bvModal.hide("edit");
            this.user = {
              name: "",
              email: "",
              phone: "",
              password: "",
            };
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
            .delete(`${this.$store.getters.url}/admin-delete-user/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success("Removed successfully");
                this.users.splice(index, 1);
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
.container {
  padding-top: 30px;
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
.admin_tab {
  min-height: 350px;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>

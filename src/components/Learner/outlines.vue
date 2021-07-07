<template>
  <div>
    <b-container>
      <b-row>
        <b-col class="mb-5 mb-sm-0">
          <div
            class="
              d-flex
              flex-column flex-sm-row
              justify-content-between
              align-items-center
              mb-4
            "
          >
            <h6 class="mb-3 mb-sm-0">Course Outline</h6>
            <div>
              <b-form-input
                placeholder="Search"
                readonly
                size="sm"
                type="search"
                class="search"
                v-model="search"
              ></b-form-input>
            </div>
          </div>

          <div class="shadow bg-white">
            <div
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

            <div class="">
              <b-table-simple class="org_home_table text-left" responsive="sm">
                <b-thead>
                  <b-tr class="text-left">
                    <b-th class="text-muted">Course</b-th>
                    <b-th class="text-muted">Added Modules</b-th>
                    <b-th class="text-muted">Facilitator(s)</b-th>
                    <b-th class="text-muted">Last Added</b-th>
                    <b-th></b-th> </b-tr
                ></b-thead>
                <b-tbody>
                  <b-tr v-for="(item, index) in filter" :key="item.id">
                    <b-td>
                      <div class="d-flex">
                        <div class="text-left">
                          <span class="text-capitalize">{{ item.title }}</span>
                        </div>
                      </div>
                    </b-td>
                    <b-td v-if="item.modules">{{}}</b-td>
                    <b-td v-else>Not Available</b-td>
                    <b-td class="text-capitalize">
                      {{ sortfacilitators(item).join(", ") }}
                    </b-td>

                    <b-td>Not Available</b-td>
                    <b-td
                      ><b-icon
                        icon="chevron-down"
                        class="cursor-pointer"
                        :id="item.id.toString() + item.title"
                      ></b-icon>
                      <b-popover
                        :target="item.id.toString() + item.title"
                        triggers="hover"
                        placement="bottom"
                      >
                        <div class="">
                          <small
                            class="px-0 text-left cursor-pointer"
                            @click="
                              $router.push(
                                `/administrator/outline/${item.courseoutline.id}`
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
              <div
                class="p-3 d-flex justify-content-between"
                v-if="filter.length > 10"
              >
                <div class="fs12 text-muted">
                  Showing 1-10 of {{ filter.length }} items
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
          </div>
        </b-col>
      </b-row>
    </b-container>

    <b-modal
      no-close-on-backdrop
      id="add"
      hide-footer
      centered
      size="lg"
      title="Add Course Outline"
    >
      <b-form @submit.prevent="register" class="user">
        <div>
          <b-container>
            <b-form-row>
              <b-col sm="5" class="px-3">
                <b-form-group label="Course">
                  <b-form-select v-model="detail.course_id">
                    <b-form-select-option value=""
                      >Choose Course</b-form-select-option
                    >
                    <b-form-select-option
                      :value="item.id"
                      v-for="(item, id) in outlines"
                      :key="id"
                      >{{ item.title }}</b-form-select-option
                    ></b-form-select
                  >
                </b-form-group>
              </b-col>
            </b-form-row>
            <b-form-row class="px-1">
              <b-col class="mb-2 px-3">
                <b-form-group label="Overview">
                  <b-textarea rows="3" v-model="detail.overview"></b-textarea>
                </b-form-group>
              </b-col>
            </b-form-row>
            <b-form-row class="px-1">
              <b-col sm="6" class="mb-3 px-3">
                <b-form-group label="Knowledge area">
                  <b-form-select v-model="detail.knowledge_area">
                    <b-form-select-option value="primary"
                      >Primary</b-form-select-option
                    >
                  </b-form-select>
                </b-form-group>
              </b-col>
              <b-col sm="6" class="mb-3 px-3">
                <b-form-group label="Duration">
                  <b-form-input
                    v-model="detail.duration"
                    placeholder="Enter course duration"
                  ></b-form-input>
                </b-form-group>
              </b-col>
            </b-form-row>
            <div>
              <div class="mb-3 px-3">
                <div class="border rounded p-2">
                  <b-form-group label="Modules">
                    <b-input-group class="addmodule mb-3">
                      <b-form-input v-model="newmodule"></b-form-input>
                      <b-input-group-append>
                        <b-button variant="dark-green" @click="addmodule"
                          >Add module</b-button
                        >
                      </b-input-group-append>
                    </b-input-group>

                    <div>
                      <b-row>
                        <b-col
                          v-for="(item, id) in detail.modules"
                          :key="id"
                          sm="6"
                        >
                          <div
                            class="
                              border
                              rounded
                              bg-lighter-green
                              px-5
                              py-2
                              mb-2
                            "
                          >
                            <span class="mr-4 text-capitalize">{{ item }}</span>
                            <b-icon
                              icon="x"
                              @click="detail.modules.splice(id, 1)"
                            ></b-icon>
                          </div>
                        </b-col>
                      </b-row>
                    </div>
                  </b-form-group>
                </div>
              </div>
            </div>

            <div class="px-3 mb-3">
              <div class="p-2 border rounded">
                <label class="d-flex justify-content-between">
                  <span>Faqs</span>
                  <div>
                    <b-button size="sm" @click="addfaq">Add</b-button>
                  </div>
                </label>
                <b-form-row>
                  <b-col
                    sm="6"
                    v-for="(item, id) in detail.faqs"
                    :key="id"
                    class="d-flex"
                  >
                    <b-form-group class="flex-1">
                      <div class="mb-1">
                        <b-form-input
                          placeholder="Enter question"
                          v-model="item.question"
                        ></b-form-input>
                      </div>
                      <div>
                        <b-form-input
                          placeholder="Enter answer"
                          v-model="item.answer"
                        ></b-form-input>
                      </div>
                    </b-form-group>
                    <div class="ml-1">
                      <b-button size="sm" @click="detail.faqs.splice(id, 1)"
                        ><b-icon icon="x"></b-icon
                      ></b-button>
                    </div>
                    <div></div>
                  </b-col>
                </b-form-row>
              </div>
            </div>

            <b-form-row class="px-1">
              <b-col sm="6" class="mb-3 px-3">
                <b-form-group label="Certification">
                  <b-form-row>
                    <b-col sm="3">
                      <b-form-radio
                        size="sm"
                        value="yes"
                        v-model="detail.certification"
                        >Yes</b-form-radio
                      >
                    </b-col>
                    <b-col>
                      <b-form-radio
                        size="sm"
                        v-model="detail.certification"
                        value="no"
                        sm="3"
                        >No</b-form-radio
                      ></b-col
                    >
                  </b-form-row>
                </b-form-group>
              </b-col>
              <b-col sm="6" class="mb-3 px-3"> </b-col>
            </b-form-row>
            <b-form-row>
              <b-col class="mb-3 px-3">
                <b-form-group label="Additional Note">
                  <b-form-textarea
                    v-model="detail.additional_info"
                    rows="2"
                    placeholder="Enter Description"
                  ></b-form-textarea>
                </b-form-group>
              </b-col>
            </b-form-row>
          </b-container>
          <b-form-group>
            <div class="mb-3 text-center">
              <b-button
                type="submit"
                variant="dark-green"
                size="lg"
                class="px-5 d-none d-sm-block"
                >Create outline</b-button
              >
              <b-button
                type="submit"
                variant="dark-green"
                size="lg"
                block
                class="px-5 d-sm-none"
                >Create outline</b-button
              >
            </div>
          </b-form-group>
        </div>
      </b-form>
    </b-modal>
    <b-modal
      no-close-on-backdrop
      id="edit"
      hide-footer
      centered
      size="lg"
      title="Update Course Outline"
    >
      <b-form @submit.prevent="updatecourse" class="user">
        <div>
          <b-container>
            <b-form-row>
              <b-col sm="5" class="px-3">
                <b-form-group label="Course">
                  <b-form-select v-model="detail.course_id">
                    <b-form-select-option value=""
                      >Choose Course</b-form-select-option
                    >
                    <b-form-select-option
                      :value="item.id"
                      v-for="(item, id) in outlines"
                      :key="id"
                      >{{ item.title }}</b-form-select-option
                    ></b-form-select
                  >
                </b-form-group>
              </b-col>
            </b-form-row>
            <b-form-row class="px-1">
              <b-col class="mb-2 px-3">
                <b-form-group label="Overview">
                  <b-textarea rows="3" v-model="detail.overview"></b-textarea>
                </b-form-group>
              </b-col>
            </b-form-row>
            <b-form-row class="px-1">
              <b-col sm="6" class="mb-3 px-3">
                <b-form-group label="Knowledge area">
                  <b-form-select v-model="detail.knowledge_area">
                    <b-form-select-option value="primary"
                      >Primary</b-form-select-option
                    >
                  </b-form-select>
                </b-form-group>
              </b-col>
              <b-col sm="6" class="mb-3 px-3">
                <b-form-group label="Duration">
                  <b-form-input
                    v-model="detail.duration"
                    placeholder="Enter course duration"
                  ></b-form-input>
                </b-form-group>
              </b-col>
            </b-form-row>
            <div>
              <div class="mb-3 px-3">
                <div class="border rounded p-2">
                  <b-form-group label="Modules">
                    <b-input-group class="addmodule mb-3">
                      <b-form-input v-model="newmodule"></b-form-input>
                      <b-input-group-append>
                        <b-button variant="dark-green" @click="addmodule"
                          >Add module</b-button
                        >
                      </b-input-group-append>
                    </b-input-group>

                    <div>
                      <b-row>
                        <b-col
                          v-for="(item, id) in detail.modules"
                          :key="id"
                          sm="6"
                        >
                          <div
                            class="
                              border
                              rounded
                              bg-lighter-green
                              px-5
                              py-2
                              mb-2
                            "
                          >
                            <span class="mr-4 text-capitalize">{{ item }}</span>
                            <b-icon
                              icon="x"
                              @click="detail.modules.splice(id, 1)"
                            ></b-icon>
                          </div>
                        </b-col>
                      </b-row>
                    </div>
                  </b-form-group>
                </div>
              </div>
            </div>

            <div class="px-3 mb-3">
              <div class="p-2 border rounded">
                <label class="d-flex justify-content-between">
                  <span>Faqs</span>
                  <div>
                    <b-button size="sm" @click="addfaq">Add</b-button>
                  </div>
                </label>
                <b-form-row>
                  <b-col
                    sm="6"
                    v-for="(item, id) in detail.faqs"
                    :key="id"
                    class="d-flex"
                  >
                    <b-form-group class="flex-1">
                      <div class="mb-1">
                        <b-form-input
                          placeholder="Enter question"
                          v-model="item.question"
                        ></b-form-input>
                      </div>
                      <div>
                        <b-form-input
                          placeholder="Enter answer"
                          v-model="item.answer"
                        ></b-form-input>
                      </div>
                    </b-form-group>
                    <div class="ml-1">
                      <b-button size="sm" @click="detail.faqs.splice(id, 1)"
                        ><b-icon icon="x"></b-icon
                      ></b-button>
                    </div>
                    <div></div>
                  </b-col>
                </b-form-row>
              </div>
            </div>

            <b-form-row class="px-1">
              <b-col sm="6" class="mb-3 px-3">
                <b-form-group label="Certification">
                  <b-form-row>
                    <b-col sm="3">
                      <b-form-radio
                        size="sm"
                        value="yes"
                        v-model="detail.certification"
                        >Yes</b-form-radio
                      >
                    </b-col>
                    <b-col>
                      <b-form-radio
                        size="sm"
                        v-model="detail.certification"
                        value="no"
                        sm="3"
                        >No</b-form-radio
                      ></b-col
                    >
                  </b-form-row>
                </b-form-group>
              </b-col>
              <b-col sm="6" class="mb-3 px-3"> </b-col>
            </b-form-row>
            <b-form-row>
              <b-col class="mb-3 px-3">
                <b-form-group label="Additional Note">
                  <b-form-textarea
                    v-model="detail.additional_info"
                    rows="2"
                    placeholder="Enter Description"
                  ></b-form-textarea>
                </b-form-group>
              </b-col>
            </b-form-row>
          </b-container>
          <b-form-group>
            <div class="mb-3 text-center">
              <b-button
                type="submit"
                variant="dark-green"
                size="lg"
                class="px-5 d-none d-sm-block"
                >Update outline</b-button
              >
              <b-button
                type="submit"
                variant="dark-green"
                size="lg"
                block
                class="px-5 d-sm-none"
                >Update outline</b-button
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
      outlines: [],
      newmodule: "",
      facilitators: [],
      detail: {
        course_id: "",
        overview: "",
        knowledge_area: "",
        duration: "",
        modules: [],
        faqs: [
          {
            question: "",
            answer: "",
          },
        ],
        certification: null,
        additional_info: "",
      },
    };
  },
  computed: {
    filter() {
      return this.outlines
        .filter((item) =>
          item.title.toLowerCase().includes(this.search.toLowerCase())
        )
        .slice(
          this.perPage * this.currentPage - this.perPage,
          this.perPage * this.currentPage
        );
    },
  },
  mounted() {
    this.getcourses();
    this.getfacilitators();
  },
  methods: {
    sortfacilitators(data) {
      if (!data.courseschedule) {
        return "Unavailable";
      }
      var schedule = data.courseschedule;
      var newArr = schedule.map((val) => {
        var fac = this.facilitators.find(
          (item) => item.id == val.facilitator_id
        );
        if (fac) {
          return fac.name;
        }
      });
      return [...new Set(newArr)];
    },
    async getfacilitators() {
      return this.$http
        .get(`${this.$store.getters.url}/user-get-facilitators`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
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

    async getcourses() {
      return this.$http
        .get(`${this.$store.getters.url}/courses`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.outlines = res.data;
            this.rows = res.data.length;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    addmodule() {
      if (!this.newmodule) {
        this.$toast.info("Cannot be empty!");
        return;
      }
      this.detail.modules.push(this.newmodule);
      this.newmodule = "";
    },

    addfaq() {
      this.detail.faqs.push({
        question: "",
        answer: "",
      });
    },

    register() {
      this.$http
        .post(`${this.$store.getters.url}/courseoutlines`, this.detail, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Added successfully");
            this.$bvModal.hide("add");
            this.outlines.unshift(res.data);
            this.detail = {
              course_id: "",
              overview: "",
              knowledge_area: "",
              duration: "",
              modules: [],
              faqs: [
                {
                  question: "",
                  answer: "",
                },
              ],
              certification: null,
              additional_info: "",
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
      this.detail = data.courseoutline;
      this.detail.knowledge_area = data.courseoutline.knowledge_areas;
      this.detail.course_id = data.id;
      this.detail.faqs = JSON.parse(data.courseoutline.faqs);
      this.detail.modules = JSON.parse(data.courseoutline.modules);
    },
    updatecourse() {
      this.$http
        .put(
          `${this.$store.getters.url}/courseoutlines/${this.detail.id}`,
          this.detail,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Updated successfully");
            this.detail = {
              course_id: "",
              overview: "",
              knowledge_area: "",
              duration: "",
              modules: [],
              faqs: [
                {
                  question: "",
                  answer: "",
                },
              ],
              certification: null,
              additional_info: "",
            };
            this.getcourses();
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    drop(id) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/courseoutlines/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success("Removed successfully");
                this.getcourses();
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
</style>

<template>
  <div class="main_c">
    <div class="py-4 bg-light">
      <b-container>
        <b-row class="justify-content-center">
          <b-col>
            <div class="border bg-white py-4 rounded">
              <div
                class="
                  top_header
                  border-bottom
                  d-flex
                  justify-content-around
                  discussion_title
                  position-relative
                "
              >
                <div
                  :class="{ active: show == 'recent' }"
                  @click="show = 'recent'"
                >
                  Recent
                </div>

                <div
                  :class="{ active: show == 'trending' }"
                  @click="show = 'trending'"
                >
                  Trending
                </div>
              </div>
              <div v-if="showDiscussion">
                <div class="d-flex search p-2">
                  <span
                    @click="$router.go(-1)"
                    class="cursor-pointer back fs13 px-2 pt-2 d-sm-none"
                  >
                    <span class="">
                      <b-icon icon="arrow-left" class=""></b-icon
                    ></span>
                  </span>
                  <b-input-group>
                    <b-form-input
                      class=""
                      placeholder="Find a discussion"
                      type="search"
                      v-model="search"
                    ></b-form-input>

                    <!-- <template #append>
                      <b-input-group-append>
                        <b-button variant="dark-green">
                          <b-icon icon="search"></b-icon
                        ></b-button>
                      </b-input-group-append>
                    </template> -->
                  </b-input-group>
                </div>
                <div
                  class="
                    main_content
                    d-flex
                    flex-column
                    justify-content-between
                  "
                  v-if="filteredData.length"
                >
                  <div
                    class="content border-bottom p-3 pt-4 pb-5 cursor-pointer"
                    v-for="(item, index) in filteredData"
                    :key="index"
                  >
                    <div
                      class="
                        top_dis
                        d-flex
                        align-items-center
                        mb-2
                        position-relative
                      "
                    >
                      <div class="side_dis">
                        <b-avatar
                          size="1.8rem"
                          :src="item.user.profile"
                        ></b-avatar>
                      </div>
                      <div class="text-left next_dis">
                        <span>
                          <span class="asked mr-2">
                            Started
                            {{ item.created_at | moment("ll") }}</span
                          >
                          <span class="mr-2 fs13"
                            ><b-badge
                              class="
                                text-capitalize
                                font-weight-normal
                                text-sm text-dark
                              "
                              variant="lighter-green"
                              >{{ item.type }}</b-badge
                            ></span
                          >
                        </span>
                        <br />
                        <span class="title">{{ item.name }} </span>
                      </div>
                    </div>
                    <div class="top_dis d-flex align-items-start">
                      <div
                        class="
                          side_dis
                          d-flex
                          flex-column
                          align-items-center
                          justify-content-center
                          text-center
                          vote
                        "
                      >
                        <b-icon
                          icon="caret-up-fill"
                          ont-scale="1.2"
                          class="text-muted"
                        ></b-icon>
                        <span> {{ item.discussionvote }}</span>

                        <b-icon
                          icon="caret-down-fill"
                          font-scale="1.2"
                          class="text-muted"
                        ></b-icon>
                      </div>
                      <div class="text-left next_dis">
                        <div class="main_text">
                          {{ item.description }}
                        </div>
                      </div>
                    </div>

                    <div class="bottom_bar d-flex justify-content-between">
                      <div>
                        <span class="mr-4"
                          ><b-icon icon="chat" class="mr-1"></b-icon>
                          <span>{{ item.discussionmessage.length }}</span>
                          answers</span
                        >
                        <span class="mr-4"
                          ><b-icon icon="eye-fill" class="mr-1"></b-icon>
                          <span v-if="item.discussionview">{{
                            item.discussionview
                          }}</span>
                          views</span
                        >
                      </div>
                      <div>
                        <span
                          @click="joindiscussion(item)"
                          class="
                            text-dark-green
                            font-weight-bold
                            cursor-pointer
                          "
                          >{{ useraccess ? "Join" : "View" }} Discussion</span
                        >
                      </div>
                    </div>
                  </div>
                  <div
                    class="p-3 d-flex justify-content-between"
                    v-if="rows > 10"
                  >
                    <div class="fs12 text-muted">
                      Showing 1-10 of {{ filteredData.length }} items
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
                    <b-img
                      :src="require('@/assets/images/creator.svg')"
                    ></b-img>
                    <h6 class="text-muted my-3 fs14">
                      No discussion available,
                    </h6>
                  </div>
                </div>
              </div>

              <div v-else class="p-5">
                <div class="d-flex w-100 mb-3">
                  <div class="mr-2">
                    <b-skeleton type="avatar"></b-skeleton>
                  </div>
                  <div class="w-100">
                    <div class="mb-3">
                      <b-skeleton-img no-aspect height="150px"></b-skeleton-img>
                    </div>
                    <b-skeleton animation="wave" width="85%"></b-skeleton>
                    <b-skeleton animation="wave" width="35%"></b-skeleton>
                  </div>
                </div>

                <div class="d-flex w-100 mb-3">
                  <div class="mr-2 mb-3">
                    <b-skeleton type="avatar"></b-skeleton>
                  </div>
                  <div class="w-100">
                    <div class="mb-3">
                      <b-skeleton-img no-aspect height="150px"></b-skeleton-img>
                    </div>
                    <b-skeleton animation="wave" width="85%"></b-skeleton>
                    <b-skeleton animation="wave" width="35%"></b-skeleton>
                  </div>
                </div>
              </div>
            </div>
          </b-col>
        </b-row>
      </b-container>
      <b-modal
        no-close-on-backdrop
        id="start"
        hide-footer
        centered
        title="Create a Discussion"
      >
        <b-form @submit.prevent="creatediscussion">
          <b-form-group label="Title">
            <b-form-input
              placeholder="Give a title"
              v-model="discussion.name"
              required
            ></b-form-input>
          </b-form-group>

          <b-form-group label="Description">
            <b-form-textarea
              required
              v-model="discussion.description"
              placeholder="Write a brief Description"
            ></b-form-textarea
          ></b-form-group>

          <b-form-row>
            <b-col sm="6">
              <b-form-group label="Type">
                <b-form-select v-model="discussion.type">
                  <b-form-select-option value="private"
                    >Private</b-form-select-option
                  >
                  <b-form-select-option value="public"
                    >Public</b-form-select-option
                  >
                </b-form-select>
              </b-form-group>
            </b-col>
            <b-col sm="6" v-if="discussion.type == 'private'">
              <b-form-group label="Select course">
                <model-list-select
                  :list="courses"
                  v-model="discussion.course_id"
                  option-value="id"
                  option-text="title"
                  placeholder="Select course"
                >
                </model-list-select>
              </b-form-group>
            </b-col>
          </b-form-row>

          <b-form-group label="Category">
            <model-list-select
              :list="category"
              v-model="discussion.category"
              option-value="value"
              option-text="value"
              placeholder="select category"
            >
            </model-list-select>
          </b-form-group>

          <b-form-group label="Interests">
            <multi-select
              :options="filteredinterests"
              :selected-options="discussion.tags"
              placeholder="select interests"
              @select="onSelect"
            >
            </multi-select>
          </b-form-group>

          <b-button
            size="lg"
            variant="dark-green"
            type="submit"
            class="d-none d-sm-block px-3"
            >Create</b-button
          >
          <b-button
            size="lg"
            variant="dark-green"
            type="submit"
            class="d-sm-none"
            block
            >Create</b-button
          >
        </b-form>
      </b-modal>
      <b-icon
        class="mobile-add btn-circle btn-raised shadow"
        icon="plus-circle-fill"
        @click="$bvModal.show('start')"
        variant="dark-green"
        font-scale="2.4"
      ></b-icon>
    </div>
  </div>
</template>

<script>
import { MultiSelect } from "vue-search-select";
import { ModelListSelect } from "vue-search-select";
import Interest from "@/components/helpers/subcategory.js";
import Category from "@/components/helpers/category.js";
export default {
  data() {
    return {
      show: "recent",
      discussions: [],
      search: "",
      showDiscussion: false,
      showOther: false,
      recentdiscussions: [],
      courses: [],
      tag: "",
      tags: [],
      mytags: [],
      otherdiscussion: [],
      discussion_id: null,
      currentPage: 1,
      rows: null,
      perPage: 10,
      customdiscussions: [],

      discussion: {
        name: "",
        description: "",
        type: "public",
        course: null,
        tags: [],
        category: {},
      },

      options: [],
      searchText: "", // If value is falsy, reset searchText & searchItem
      items: [],
      lastSelectItem: {},
      category: [],
    };
  },
  components: {
    MultiSelect,
    ModelListSelect,
  },
  watch: {
    currentPage: "paginatedData",
  },
  mounted() {
    // this.getothers();
    this.getdiscussions();
    this.mytags = Interest.map((item) => {
      item.text = item.value;

      return item;
    });
    this.category = Category;
  },
  computed: {
    useraccess() {
      var token = null;
      if (localStorage.getItem("authAdmin")) {
        return this.$store.getters.admin;
      }
      if (localStorage.getItem("authFacilitator")) {
        return this.$store.getters.facilitator;
      }
      if (localStorage.getItem("authMember")) {
        return this.$store.getters.member;
      }
      return token;
    },

    filteredData() {
      if (this.show == "recent") {
        return this.discussions.filter((item) =>
          item.name.toLowerCase().includes(this.search.toLowerCase())
        );
      }

      if (this.show == "trending") {
        return this.discussions
          .slice()
          .sort((a, b) => {
            return (
              (b.discussionview ? b.discussionview.view : 0) -
              (a.discussionview ? a.discussionview.view : 0)
            );
          })
          .filter((item) =>
            item.name.toLowerCase().includes(this.search.toLowerCase())
          );
      }

      return [];
    },
    usertoken() {
      var token = null;
      if (this.$store.getters.admin.access_token) {
        return this.$store.getters.admin;
      }
      if (this.$store.getters.facilitator.access_token) {
        return this.$store.getters.facilitator;
      }
      if (this.$store.getters.member.access_token) {
        return this.$store.getters.member;
      }
      return token;
    },
    filteredinterests() {
      return this.mytags.filter(
        (item) => item.category_id == this.discussion.category.id
      );
    },
  },
  methods: {
    paginatedData() {
      this.$http
        .get(
          `${this.$store.getters.url}/guest/discussions?page=${this.currentPage}`,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
            },
          }
        )
        .then((res) => {
          this.discussions = res.data.data;
        });
    },
    onSelect(items, lastSelectItem) {
      this.discussion.tags = items;
      this.lastSelectItem = lastSelectItem;
    },

    requestAccess() {
      var data = {
        discussion_id: this.discussion_id,
      };

      this.$http
        .post(`${this.$store.getters.url}/join-discussion`, data, {
          headers: {
            Authorization: `Bearer ${this.usertoken.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.$toast.info("Your request has been sent");
            this.$bvModal.hide("access");
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    joindiscussion(item) {
      this.$router.push(`/member/tribe/discussion/${item.id}`);
    },

    getdiscussions() {
      this.$http
        .get(`${this.$store.getters.url}/guest/discussions`)
        .then((res) => {
          if (res.status == 200) {
            this.discussions = res.data.data;
            this.showDiscussion = true;
            this.rows = res.data.meta.total;
            this.perPage = res.data.meta.per_page;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    creatediscussion() {
      this.$http
        .post(`${this.$store.getters.url}/discussions`, this.discussion, {
          headers: {
            Authorization: `Bearer ${this.usertoken.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201 || res.status == 200) {
            this.$toast.success("Discussion created");
            this.getdiscussions();
            this.getcustomdiscussions();
            this.getdiscussionsbyinterest();
            this.getdiscussionsbytrend();
            this.discussion = {
              name: "",
              description: "",
              type: "public",
              course: null,
              tags: [],
              category: {},
            };
            this.$bvModal.hide("start");
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
.main_c {
  /* The image used */

  /* Set a specific height */
  min-height: 100vh;
}

.mywhite {
  background: #f7f8fa;
}
.top_header div {
  font-size: 14px;
  color: rgba($color: #000000, $alpha: 0.54);
  position: relative;
  padding: 10px 12px;
  cursor: pointer;
  text-transform: capitalize;
}
.top_header div::after {
  content: "";
  position: absolute;
  bottom: 0;
  width: 100%;
  border-bottom: 2px solid transparent;
  left: 0;
}
.top_header div:hover::after {
  border-color: var(--dark-green);
}
.top_header div.active::after {
  border-color: var(--dark-green);
}
.top_header div.active {
  color: var(--dark-green);
}
.main_content {
  min-height: 50vh;
  max-height: 70vh;
  overflow-y: auto;
}
.main_content::-webkit-scrollbar {
  display: none;
}

/* Hide scrollbar for IE, Edge and Firefox */
.main_content {
  -ms-overflow-style: none; /* IE and Edge */
  scrollbar-width: none; /* Firefox */
}
.content {
}
.side_dis {
  width: 15%;
  text-align: center;
}
.next_dis {
  width: 85%;
}
.asked {
  font-size: 12px;
  color: rgba($color: #000000, $alpha: 0.54);
}
.title {
  font-size: 15px;
  font-weight: 500;
  color: rgba($color: #000000, $alpha: 0.64);
  text-transform: capitalize;
}

.bottom_bar {
  width: 85%;
  margin-left: auto;
  padding: 13px;
  border-radius: 4px;
  background: #fbfbfb;
  font-size: 12px;
  margin-top: 14px;
}
.related_quest {
  border-radius: 8px;
}
.related {
  font-size: 12px;
}

.drop {
  position: absolute;
  top: 0;
  right: 15px;
}
</style>

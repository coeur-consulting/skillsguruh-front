<template>
  <div class="main_c">
    <section class="top_bg"></section>

    <div class="py-4 bg-light">
      <b-container>
        <b-row class="justify-content-center">
          <b-col sm="8">
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
                  :class="{ active: show == 'mostanswers' }"
                  @click="show = 'mostanswers'"
                >
                  Most Answers
                </div>
                <div
                  :class="{ active: show == 'trending' }"
                  @click="show = 'trending'"
                >
                  Trending
                </div>
              </div>
              <div v-if="showDiscussion">
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
                          v-if="item.creator == 'admin'"
                          :src="item.admin.profile"
                        ></b-avatar>

                        <b-avatar
                          size="1.8rem"
                          v-if="item.creator == 'user'"
                          :src="item.user.profile"
                        ></b-avatar>
                        <b-avatar
                          size="1.8rem"
                          v-if="item.creator == 'facilitator'"
                          :src="item.facilitator.profile"
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
                          class="cursor-pointer"
                        ></b-icon>
                        <span v-if="item.discussionvote">
                          <span v-if="vote(item.discussionvote) > 0">+</span>
                          <span v-if="vote(item.discussionvote) < 0">-</span
                          >{{ vote(item.discussionvote) }}</span
                        >
                        <span v-else>0</span>

                        <b-icon
                          icon="caret-down-fill"
                          font-scale="1.2"
                          class="cursor-ponte"
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
                            item.discussionview.view || 0
                          }}</span>
                          <span v-else>{{ 0 }}</span> views</span
                        >
                      </div>
                      <div>
                        <span
                          v-if="item.type == 'public'"
                          @click="
                            $router.push(`/explore/discussion/${item.id}`)
                          "
                          class="
                            text-dark-green
                            font-weight-bold
                            cursor-pointer
                          "
                          >Join Discussion</span
                        >
                        <span
                          v-else
                          @click="joindiscussion(item)"
                          class="
                            text-dark-green
                            font-weight-bold
                            cursor-pointer
                          "
                          >Join Discussion</span
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
                      It appears you havent added any Discussion yet,
                      <br class="d-none d-sm-block" />
                      Start your first Discussion now!
                    </h6>
                    <b-button
                      @click="$bvModal.show('start')"
                      variant="dark-green"
                      size="lg"
                      >Start a Discussion</b-button
                    >
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
          <b-col sm="4" class="d-none d-md-block" v-if="usertoken">
            <div class="shadow-sm bg-white p-4 rounded">
              <div class="text-center mb-4">
                <b-button
                  variant="dark-green"
                  size="lg"
                  class="px-3"
                  @click="$bvModal.show('start')"
                  >Start a discussion</b-button
                >
              </div>
              <div class="py-3 text-left related_quest border">
                <h6 class="mb-3 px-3">Other Discussions</h6>
                <div v-if="showOther">
                  <div v-if="otherdiscussion">
                    <div
                      class="d-flex p-2 px-3"
                      v-for="(dis, id) in otherdiscussion.slice(0, 6)"
                      :key="id"
                    >
                      <div>
                        <div class="mr-3 related_count">
                          {{ dis.discussionmessage.length }}
                        </div>
                      </div>
                      <span
                        @click="$router.push(`/explore/discussion/${dis.id}`)"
                        class="
                          related
                          text-left text-capitalize
                          font-weight-bold
                        "
                        >{{ dis.name }}</span
                      >
                    </div>
                  </div>
                </div>
                <div v-else class="p-2 p-sm-3 w-100">
                  <div class="d-flex w-100 mb-3">
                    <div class="mr-2 w-25">
                      <b-skeleton animation="wave" width="100%"></b-skeleton>
                    </div>
                    <div class="w-75">
                      <b-skeleton animation="wave" width="100%"></b-skeleton>
                    </div>
                  </div>
                  <div class="d-flex w-100 mb-3">
                    <div class="mr-2 w-25">
                      <b-skeleton animation="wave" width="100%"></b-skeleton>
                    </div>
                    <div class="w-75">
                      <b-skeleton animation="wave" width="100%"></b-skeleton>
                    </div>
                  </div>
                  <div class="d-flex w-100 mb-3">
                    <div class="mr-2 w-25">
                      <b-skeleton animation="wave" width="100%"></b-skeleton>
                    </div>
                    <div class="w-75">
                      <b-skeleton animation="wave" width="100%"></b-skeleton>
                    </div>
                  </div>
                  <div class="d-flex w-100 mb-3">
                    <div class="mr-2 w-25">
                      <b-skeleton animation="wave" width="100%"></b-skeleton>
                    </div>
                    <div class="w-75">
                      <b-skeleton animation="wave" width="100%"></b-skeleton>
                    </div>
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

  mounted() {
    this.getothers();
    this.getdiscussions();
    this.mytags = Interest.map((item) => {
      item.text = item.value;

      return item;
    });
    this.category = Category;
  },
  computed: {
    filtered() {
      return this.discussions.slice(
        this.perPage * this.currentPage - this.perPage,
        this.perPage * this.currentPage
      );
    },
    filteredData() {
      if (this.show == "recent") {
        return this.filtered
          .filter((item) => item.type == "public")
          .filter((item) =>
            item.name.toLowerCase().includes(this.search.toLowerCase())
          );
      }
      if (this.show == "mostanswers") {
        return this.filtered
          .filter((item) => item.type == "public")
          .sort((a, b) => {
            return b.discussionmessage.length - a.discussionmessage.length;
          });
      }
      if (this.show == "trending") {
        return this.filtered
          .filter((item) => item.type == "public")
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
      if (this.show == "private") {
        return this.filtered
          .filter((item) => item.type == "private")
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
    onSelect(items, lastSelectItem) {
      this.discussion.tags = items;
      this.lastSelectItem = lastSelectItem;
    },
    vote(val) {
      var positive = val.filter((item) => item.vote).length;
      var negative = val.filter((item) => !item.vote).length;
      return Number(positive) - Number(negative);
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
      if (item.status == "public") {
        this.$router.push(`/explore/discussion/${item.id}`);
      } else {
        if (item.user && item.user.id == this.usertoken.id) {
          this.$router.push(`/explore/discussion/${item.id}`);
        } else {
          this.$http
            .get(`${this.$store.getters.url}/discussion/private/${item.id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.usertoken.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                var result = res.data
                  .map((item) => item.user_id)
                  .includes(this.usertoken.id);

                if (result) {
                  this.$router.push(`/explore/discussion/${item.id}`);
                } else {
                  this.discussion_id = item.id;
                  this.$bvModal.show("access");
                }
              }
            });
        }
      }
    },

    getdiscussions() {
      this.$http
        .get(`${this.$store.getters.url}/guest/discussions`)
        .then((res) => {
          if (res.status == 200) {
            this.discussions = res.data;
            this.showDiscussion = true;
            this.rows = res.data.length;
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
    getothers() {
      this.$http
        .get(`${this.$store.getters.url}/other-discussions`, {
          headers: {
            Authorization: `Bearer ${this.usertoken.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.otherdiscussion = res.data;
            this.showOther = true;
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
  background-image: url("../assets/images/mountain.svg");

  /* Set a specific height */
  min-height: 100vh;

  /* Create the parallax scrolling effect */
  background-attachment: fixed;
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
}
.top_bg {
  height: 200px;
  background-image: url("../assets/images/socialimg.svg");
  background-position: center;
  background-repeat: no-repeat;
  background-size: contain;
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

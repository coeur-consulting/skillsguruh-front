<template>
  <div class="pt-sm-4">
    <b-container class="px-0 px-sm-3">
      <b-row>
        <b-col sm="8">
          <div class="border bg-white py-4 rounded">
            <div
              class="
                top_header
                border-bottom
                d-flex
                justify-content-around
                position-relative
                discussion_title
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
              <div
                :class="{ active: show == 'private' }"
                @click="show = 'private'"
              >
                Private
              </div>
            </div>
            <div v-if="showDiscussion">
              <div class="main_content" v-if="filteredData.length">
                <div
                  class="
                    content
                    border-bottom
                    p-2 p-sm-3
                    pt-4
                    pb-5
                    cursor-pointer
                  "
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
                    <b-dropdown
                      v-if="
                        item.user && item.user.id == $store.getters.learner.id
                      "
                      size="sm"
                      variant="transparent"
                      no-caret
                      class="no-focus drop"
                    >
                      <template #button-content>
                        <b-icon icon="three-dots" font-scale="1.4"></b-icon>
                      </template>
                      <b-dropdown-item
                        class="fs12"
                        @click="drop(item.id, index)"
                        >Delete</b-dropdown-item
                      >
                    </b-dropdown>
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
                      <div>
                        <span class="asked mr-2">
                          Started
                          {{ item.created_at | moment("calendar") }}</span
                        >
                        <span class="mr-2 fs13"
                          ><b-badge
                            class="text-capitalize font-weight-normal"
                            variant="dark-green"
                            >{{ item.type }}</b-badge
                          ></span
                        >
                      </div>

                      <div class="title">{{ item.name }}</div>
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
                      <span class="mr-4 dis_ses"
                        ><b-icon icon="chat" class="mr-1"></b-icon>
                        <span>{{ item.discussionmessage.length }}</span>
                        answers</span
                      >
                      <span class="mr-4 dis_ses"
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
                        @click="$router.push(`/learner/discussion/${item.id}`)"
                        class="
                          text-dark-green
                          font-weight-bold
                          cursor-pointer
                          dis_ses
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
                          dis_ses
                        "
                        >Join Discussion</span
                      >
                    </div>
                  </div>
                </div>
              </div>

              <div v-else class="text-center admin_tab p-2 p-sm-5">
                <div>
                  <b-img :src="require('@/assets/images/creator.svg')"></b-img>
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
        <b-col sm="4" class="d-none d-md-block">
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
                <div v-if="otherdiscussion.length">
                  <div
                    class="d-flex p-2 px-3"
                    v-for="(dis, id) in otherdiscussion.slice(0, 6)"
                    :key="id"
                  >
                    <div>
                      <span class="mr-3 related_count">{{
                        dis.discussionmessage.length
                      }}</span>
                    </div>
                    <span
                      class="related text-left text-capitalize font-weight-bold"
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
            required
            placeholder="Give a title"
            v-model="discussion.name"
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
              <b-form-select v-model="discussion.course_id">
                <b-form-select-option
                  :value="item.id"
                  v-for="item in courses"
                  :key="item.id"
                  >{{ item.title }}</b-form-select-option
                >
              </b-form-select>
            </b-form-group>
          </b-col>
        </b-form-row>

        <b-form-group label="Tags">
          <tags-input
            discard-search-text="Select"
            element-id="tags"
            v-model="discussion.tags"
            :existing-tags="mytags"
            :typeahead="true"
          ></tags-input>
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

    <b-modal id="access" title="Request Access" hide-footer centered>
      <div class="text-center">
        <p class="mb-4 fs16">Do you wish to join this discussion?</p>
        <b-button
          variant="outline-secondary"
          class="mr-3"
          size="sm"
          @click="$bvModal.hide('access')"
          >Cancel</b-button
        >
        <b-button variant="secondary" size="sm" @click="requestAccess"
          >Send a request</b-button
        >
      </div>
    </b-modal>
  </div>
</template>

<script>
import VoerroTagsInput from "@voerro/vue-tagsinput";
import Insight from "../insight.js";
export default {
  data() {
    return {
      show: "recent",
      discussions: [],
      search: "",
      showDiscussion: false,
      showOther: false,
      recentdiscussions: [],
      discussion: {
        name: "",
        description: "",
        type: "public",
        course: null,
        tags: [],
      },
      courses: [],
      tag: "",
      tags: [],
      mytags: [],
      otherdiscussion: [],
      discussion_id: null,
    };
  },
  components: {
    "tags-input": VoerroTagsInput,
  },

  mounted() {
    this.getdiscussions();
    this.mytags = Insight;
    this.getcourses();
    this.getothers();
  },
  computed: {
    filteredData() {
      if (this.show == "recent") {
        return this.discussions
          .filter((item) => item.type == "public")
          .filter((item) =>
            item.name.toLowerCase().includes(this.search.toLowerCase())
          );
      }
      if (this.show == "mostanswers") {
        return this.discussions
          .filter((item) => item.type == "public")
          .sort((a, b) => {
            return b.discussionmessage.length - a.discussionmessage.length;
          });
      }
      if (this.show == "trending") {
        return this.discussions
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
        return this.discussions
          .filter((item) => item.type == "private")
          .filter((item) =>
            item.name.toLowerCase().includes(this.search.toLowerCase())
          );
      }
      return [];
    },
  },
  methods: {
    requestAccess() {
      var data = {
        discussion_id: this.discussion_id,
      };

      this.$http
        .post(`${this.$store.getters.url}/join-discussion`, data, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
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
      if (item.user && item.user.id == this.$store.getters.learner.id) {
        this.$router.push(`/learner/discussion/${item.id}`);
      } else {
        this.$http
          .get(`${this.$store.getters.url}/discussion/private/${item.id}`, {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          })
          .then((res) => {
            if (res.status == 200) {
              var result = res.data
                .map((item) => item.user_id)
                .includes(this.$store.getters.learner.id);

              if (result) {
                this.$router.push(`/learner/discussion/${item.id}`);
              } else {
                this.discussion_id = item.id;
                this.$bvModal.show("access");
              }
            }
          });
      }
    },
    getcourses() {
      this.$http
        .get(`${this.$store.getters.url}/courses`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.courses = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    vote(val) {
      var positive = val.filter((item) => item.vote).length;
      var negative = val.filter((item) => !item.vote).length;
      return Number(positive) - Number(negative);
    },
    getothers() {
      this.$http
        .get(`${this.$store.getters.url}/other-discussions`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
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
    getdiscussions() {
      this.$http
        .get(`${this.$store.getters.url}/discussions`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.discussions = res.data;
            this.showDiscussion = true;
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
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201 || res.status == 200) {
            this.$toast.success("Discussion created");
            this.discussions.unshift(res.data);
            this.discussion = {
              title: "",
              description: "",
              type: "public",
              course: null,
              tags: [],
            };
            this.$bvModal.hide("start");
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    addtag() {
      if (this.tag) {
        this.discussion.tags.push(this.tag);
        this.tag = "";
      }
    },
    droptag(index) {
      this.discussion.tags.splice(index, 1);
    },
    drop(id, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/discussions/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success("Discussion deleted");
                this.discussions.splice(index, 1);
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
  min-height: 70vh;
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
.main_text {
  display: -webkit-box;
  font-size: 14px;
  line-height: 1.6;
  color: rgba($color: #000000, $alpha: 0.5);
  text-overflow: ellipsis;
  overflow: hidden;
  line-clamp: 4;
  -webkit-line-clamp: 4;
  -webkit-box-orient: vertical;
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
.related_count {
  width: 60px;
  padding: 4px 6px;
  background: var(--lighter-green);
  font-size: 11px;
  border-radius: 4px;
}
.drop {
  position: absolute;
  top: 0;
  right: 15px;
}
</style>

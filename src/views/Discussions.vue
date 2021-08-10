<template>
  <div class="py-4 bg-light">
    <b-container>
      <b-row class="justify-content-center">
        <b-col sm="9">
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
                class="main_content d-flex flex-column justify-content-between"
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
                        @click="$router.push(`/discussion/${item.id}`)"
                        class="text-dark-green font-weight-bold cursor-pointer"
                        >Join Discussion</span
                      >
                      <span
                        v-else
                        @click="joindiscussion(item)"
                        class="text-dark-green font-weight-bold cursor-pointer"
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
      </b-row>
    </b-container>
  </div>
</template>

<script>
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
      currentPage: 1,
      rows: null,
      perPage: 10,
    };
  },

  mounted() {
    this.getdiscussions();
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
  },
  methods: {
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
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
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
      this.$router.push(`/discussion/${item.id}`);
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

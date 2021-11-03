<template>
  <div class="pt-5 position-relative">
    <b-container class="px-0 px-sm-3">
      <b-row>
        <b-col>
          <div
            class="
              d-flex
              flex-column flex-sm-row
              align-items-center
              mt-2
              mb-3
              w-100
              text-left
            "
          >
            <h6 class="flex-1 font-weight-bold mb-3 mb-sm-0"></h6>
            <div class="d-flex search px-2 px-sm-0">
              <span
                @click="$router.go(-1)"
                class="cursor-pointer back fs13 px-2 pt-2 d-sm-none"
              >
                <span class="">
                  <b-icon icon="arrow-left" class=""></b-icon
                ></span>
              </span>
              <div class="search w-100">
                <b-input-group class="topbar_search bg-white">
                  <b-input-group-prepend is-text>
                    <b-iconstack font-scale="1.4" class="">
                      <b-icon
                        stacked
                        icon="circle-fill"
                        variant="lighter-green"
                      ></b-icon>
                      <b-icon
                        stacked
                        icon="search"
                        scale="0.5"
                        variant="dark-green"
                      ></b-icon>
                    </b-iconstack>
                  </b-input-group-prepend>
                  <b-form-input
                    placeholder="Find a discussion"
                    class="no-focus border-0"
                    type="search"
                    aria-label="Text input "
                    v-model="search"
                  ></b-form-input>
                  <b-input-group-append>
                    <b-button
                      variant="dark-green"
                      @click="$bvModal.show('start')"
                      ><b-icon icon="plus"></b-icon
                    ></b-button>
                  </b-input-group-append>
                </b-input-group>
              </div>
            </div>
          </div>
          <div class="border bg-white py-4 rounded">
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
                      size="sm"
                      variant="transparent"
                      no-caret
                      class="no-focus drop"
                    >
                      <template #button-content>
                        <b-icon
                          icon="three-dots-vertical"
                          font-scale="1.2"
                        ></b-icon>
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
                        :src="item.user.profile"
                      ></b-avatar>
                    </div>
                    <div class="text-left next_dis">
                      <div>
                        <span class="asked mr-2">
                          Started
                          {{ item.created_at | moment("calendar") }}</span
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
                      <span class="mr-4 dis_ses"
                        ><b-icon icon="chat" class="mr-1"></b-icon>
                        <span>{{ item.commentCount }}</span>
                        answers</span
                      >
                      <span class="mr-4 dis_ses"
                        ><b-icon icon="eye-fill" class="mr-1"></b-icon>
                        <span v-if="item.discussionview">{{
                          item.discussionview || 0
                        }}</span>
                        <span v-else>{{ 0 }}</span> views</span
                      >
                    </div>
                    <div>
                      <span
                        @click="
                          $router.push(`/organization/discussion/${item.id}`)
                        "
                        class="
                          text-dark-green
                          font-weight-bold
                          cursor-pointer
                          dis_ses
                        "
                        >View Discussion</span
                      >
                    </div>
                  </div>
                </div>

                <div class="mt-3 px-3">
                  <b-pagination
                    v-if="show == 'recent'"
                    pills
                    size="sm"
                    variant="dark-green"
                    align="right"
                    v-model="currentPage"
                    :total-rows="rows"
                    :per-page="perPage"
                  ></b-pagination>
                  <b-pagination
                    v-else
                    pills
                    size="sm"
                    variant="dark-green"
                    align="right"
                    v-model="currentPageT"
                    :total-rows="rowsT"
                    :per-page="perPageT"
                  ></b-pagination>
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
      </b-row>
    </b-container>

    <b-icon
      class="mobile-add btn-circle btn-raised shadow"
      icon="plus-circle-fill"
      @click="$bvModal.show('start')"
      variant="dark-green"
      font-scale="2"
    ></b-icon>
  </div>
</template>

<script>
import Interest from "../helpers/subcategory.js";
import Category from "../helpers/category.js";
export default {
  data() {
    return {
      currentPage: 1,
      perPage: 0,
      rows: 0,
      currentPageT: 1,
      perPageT: 0,
      rowsT: 0,
      show: "recent",
      discussions: [],
      trenddiscussions: [],
      interestdiscussions: [],
      customdiscussions: [],
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
        category: {},
      },
      courses: [],
      tag: "",
      tags: [],
      mytags: [],
      otherdiscussion: [],
      discussion_id: null,
      options: [],
      searchText: "", // If value is falsy, reset searchText & searchItem
      items: [],
      lastSelectItem: {},
      category: [],
    };
  },

  mounted() {
    this.getdiscussions();

    this.mytags = Interest.map((item) => {
      item.text = item.value;

      return item;
    });
    this.category = Category;
  },
  watch: {
    currentPage: "paginatedData",
  },
  computed: {
    filteredData() {
      return this.discussions.filter((item) =>
        item.name.toLowerCase().includes(this.search.toLowerCase())
      );
    },
    filteredinterests() {
      if (!this.discussion.category) return [];
      return this.mytags.filter(
        (item) => item.category_id == this.discussion.category.id
      );
    },
  },
  methods: {
    paginatedData() {
      this.$http
        .get(
          `${this.$store.getters.url}/get/organization/discussions?page=${this.currentPage}`,
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

    getdiscussions() {
      this.$http
        .get(`${this.$store.getters.url}/get/organization/discussions`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.discussions = res.data.data;
            this.showDiscussion = true;
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
                Authorization: `Bearer ${this.$store.getters.member.access_token}`,
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

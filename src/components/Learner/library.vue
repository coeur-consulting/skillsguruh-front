<template>
  <div>
    <b-container class="py-5">
      <h5 class="text-left mb-4">Your Library</h5>
      <b-row class="flex-column-reverse flex-sm-row">
        <b-col sm="4" class="text-left pr-4">
          <div class="bg-white w-100 h-100 p-3 border rounded">
            <h6 class="px-2 mb-4 text-muted">Recently Added</h6>
            <div v-if="showRecent">
              <div
                class="d-flex mb-5"
                v-for="(item, id) in recentlyAdded"
                :key="id"
              >
                <div style="width:80px; height100px" class="mr-3">
                  <b-img :src="item.course.cover" fluid-grow></b-img>
                </div>

                <div>
                  <div class="fs14 font-weight-bold mb-2 text-capitalize">
                    {{ item.course.title }}
                  </div>
                  <div class="fs14 text-muted">
                    <b-icon icon="book" class="mr-2"></b-icon>
                    {{ item.course.modules.length }} modules
                  </div>
                  <div>
                    <b-button-group size="sm">
                      <!-- <b-button variant="danger" disabled>
                      <b-icon
                        icon="download"
                        font-scale=".9rem"
                        variant="white"
                      ></b-icon
                    ></b-button> -->
                      <b-button
                        variant="dark-green"
                        size="sm"
                        @click="
                          $router.push(`/learner/media/${item.course.id}`)
                        "
                      >
                        <span class="fs13"> View course</span>
                      </b-button>
                    </b-button-group>
                  </div>
                </div>
              </div>
            </div>
            <div v-else>
              <div class="mb-4 d-flex w-100">
                <div class="mb-3 w-50 mr-3">
                  <b-skeleton-img></b-skeleton-img>
                </div>
                <div class="w-50">
                  <b-skeleton
                    animation="fade"
                    class="mb-2"
                    width="65%"
                  ></b-skeleton>
                  <b-skeleton
                    animation="fade"
                    class="mb-2"
                    width="55%"
                  ></b-skeleton>
                  <b-skeleton animation="fade" width="59%"></b-skeleton>
                </div>
              </div>
              <div class="mb-4 d-flex w-100">
                <div class="mb-3 w-50 mr-3">
                  <b-skeleton-img></b-skeleton-img>
                </div>
                <div class="w-50">
                  <b-skeleton
                    animation="fade"
                    class="mb-2"
                    width="65%"
                  ></b-skeleton>
                  <b-skeleton
                    animation="fade"
                    class="mb-2"
                    width="55%"
                  ></b-skeleton>
                  <b-skeleton animation="fade" width="59%"></b-skeleton>
                </div>
              </div>
            </div>
          </div>
          <div></div>
        </b-col>
        <b-col sm="8" class="p-3 bg-white border rounded mb-5 mb-sm-0">
          <div class="text-sm-right mb-3">
            <div class="d-flex align-items-center">
              <div class="search align-items-center mb-sm-4 mr-3">
                <b-input-group class="topbar_search rounded-pill">
                  <b-form-input
                    placeholder="Search by title, interest"
                    class="no-focus bg-light border-0"
                    type="search"
                    size="lg"
                    aria-label="Text input "
                    v-model="search"
                  ></b-form-input>
                  <b-input-group-append is-text>
                    <b-iconstack font-scale="1.5">
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
                  </b-input-group-append>
                </b-input-group>
              </div>
              <div>
                <b-icon
                  class="mr-3"
                  :icon="alpha ? 'sort-alpha-up' : 'sort-alpha-down'"
                  @click="alpha = !alpha"
                ></b-icon>

                <b-icon
                  class=""
                  icon="funnel"
                  @click="$bvModal.show('filter')"
                ></b-icon>
              </div>
            </div>
            <div class="d-none d-sm-block">
              <b-iconstack
                class="mr-2 cursor-pointer"
                font-scale="1"
                @click="list = true"
              >
                <b-icon stacked icon="square-fill" variant="secondary"></b-icon>
                <b-icon stacked icon="list" variant="white" scale="0.7">
                </b-icon>
              </b-iconstack>
              <b-iconstack
                font-scale="1"
                class="cursor-pointer"
                @click="list = false"
              >
                <b-icon stacked icon="square-fill" variant="secondary"></b-icon>
                <b-icon
                  stacked
                  icon="grid3x3-gap-fill"
                  variant="white"
                  scale="0.7"
                ></b-icon>
              </b-iconstack>
            </div>
          </div>
          <div>
            <b-row v-if="showLibrary">
              <b-col
                :sm="list ? 12 : 4"
                v-for="(item, id) in filteredLibrary"
                :key="id"
              >
                <div
                  class="
                    d-flex
                    justify-content-between
                    p-2
                    border
                    rounded
                    mb-4
                    text-left
                  "
                  :class="list ? 'flex-row' : 'flex-column'"
                >
                  <b-col
                    :sm="list ? 6 : 12"
                    class="d-flex"
                    :class="list ? 'flex-row' : 'flex-column'"
                  >
                    <div
                      class="mr-2"
                      :class="!list ? 'mb-4 course_img2' : 'course_img'"
                    >
                      <b-img :src="item.course.cover"></b-img>
                    </div>
                    <div
                      class="text-left course_desc"
                      :class="!list ? 'mb-2' : ''"
                    >
                      <div class="fs14 font-weight-bold mb-1">
                        {{ item.course.title }}
                      </div>
                      <div class="fs14 overview mb-2">
                        {{ item.course.description }}
                      </div>
                      <div class="fs14 overview text-capitalize">
                        {{
                          JSON.parse(item.course.courseoutline.knowledge_areas)
                            .value
                        }}
                      </div>
                    </div>
                  </b-col>

                  <b-col
                    :sm="list ? 6 : 12"
                    class="d-flex justify-content-between"
                    :class="list ? 'flex-row' : 'flex-column'"
                  >
                    <div class="">
                      <div
                        class="fs14 text-muted d-flex align-items-center"
                        :class="!list ? 'mb-2' : ''"
                        v-if="item.course.modules"
                      >
                        <b-iconstack font-scale="2rem" class="mr-2">
                          <b-icon
                            stacked
                            icon="circle-fill"
                            variant="lighter-green"
                          ></b-icon>
                          <b-icon
                            stacked
                            icon="book"
                            scale="0.5"
                            variant="dark-green"
                          ></b-icon>
                        </b-iconstack>
                        <span> {{ item.course.modules.length }} modules</span>
                      </div>
                      <div class="mt-3">
                        <div class="mb-2 fs12">Your progress</div>
                        <b-progress
                          :max="100"
                          height=".8rem"
                          class="mb-3"
                          variant="dark-green"
                        >
                          <b-progress-bar
                            :value="item.progress"
                            :label="`${Math.round(item.progress)}%`"
                          ></b-progress-bar>
                        </b-progress>
                      </div>
                    </div>

                    <div :class="list ? 'pl-4' : ''">
                      <div class="mb-2">
                        <!-- <b-button
                          block
                          variant="danger"
                          disabled
                          class="cursor-disabled"
                          size="sm"
                          ><b-icon icon="download" class="mr-2"></b-icon>
                          Download</b-button
                        > -->
                      </div>
                      <div>
                        <b-button
                          block
                          variant="dark-green"
                          size="sm"
                          @click="
                            $router.push(`/learner/media/${item.course.id}`)
                          "
                          ><b-icon icon="book" class="mr-2"></b-icon> View
                          course</b-button
                        >
                      </div>
                    </div>
                  </b-col>
                </div>
              </b-col>
            </b-row>
            <b-row v-else>
              <b-col sm="4" class="mb-4">
                <div class="mb-3"><b-skeleton-img></b-skeleton-img></div>
                <b-skeleton
                  animation="fade"
                  class="mb-2"
                  width="65%"
                ></b-skeleton>
                <b-skeleton
                  animation="fade"
                  class="mb-2"
                  width="55%"
                ></b-skeleton>
                <b-skeleton animation="fade" width="59%"></b-skeleton>
              </b-col>
              <b-col sm="4" class="mb-4">
                <div class="mb-3"><b-skeleton-img></b-skeleton-img></div>
                <b-skeleton
                  animation="fade"
                  class="mb-2"
                  width="65%"
                ></b-skeleton>
                <b-skeleton
                  animation="fade"
                  class="mb-2"
                  width="55%"
                ></b-skeleton>
                <b-skeleton animation="fade" width="59%"></b-skeleton>
              </b-col>
              <b-col sm="4" class="mb-4">
                <div class="mb-3"><b-skeleton-img></b-skeleton-img></div>
                <b-skeleton
                  animation="fade"
                  class="mb-2"
                  width="65%"
                ></b-skeleton>
                <b-skeleton
                  animation="fade"
                  class="mb-2"
                  width="55%"
                ></b-skeleton>
                <b-skeleton animation="fade" width="59%"></b-skeleton>
              </b-col>
              <b-col sm="4" class="mb-4">
                <div class="mb-3"><b-skeleton-img></b-skeleton-img></div>
                <b-skeleton
                  animation="fade"
                  class="mb-2"
                  width="65%"
                ></b-skeleton>
                <b-skeleton
                  animation="fade"
                  class="mb-2"
                  width="55%"
                ></b-skeleton>
                <b-skeleton animation="fade" width="59%"></b-skeleton>
              </b-col>
              <b-col sm="4" class="mb-4">
                <div class="mb-3"><b-skeleton-img></b-skeleton-img></div>
                <b-skeleton
                  animation="fade"
                  class="mb-2"
                  width="65%"
                ></b-skeleton>
                <b-skeleton
                  animation="fade"
                  class="mb-2"
                  width="55%"
                ></b-skeleton>
                <b-skeleton animation="fade" width="59%"></b-skeleton>
              </b-col>
              <b-col sm="4" class="mb-4">
                <div class="mb-3"><b-skeleton-img></b-skeleton-img></div>
                <b-skeleton
                  animation="fade"
                  class="mb-2"
                  width="65%"
                ></b-skeleton>
                <b-skeleton
                  animation="fade"
                  class="mb-2"
                  width="55%"
                ></b-skeleton>
                <b-skeleton animation="fade" width="59%"></b-skeleton>
              </b-col>
            </b-row>
          </div>
        </b-col>
      </b-row>
    </b-container>
    <b-modal no-close-on-backdrop id="filter" hide-footer hide-header centered>
      <div>
        <div>
          <h6 class="">Sort by</h6>
          <b-form-group label="Category">
            <b-form-radio-group v-model="course_type">
              <b-form-radio value="">General</b-form-radio>
              <b-form-radio value="free">Free</b-form-radio>
              <b-form-radio value="paid">Paid</b-form-radio>
              <b-form-radio value="group">Group</b-form-radio>
            </b-form-radio-group>
          </b-form-group>
          <!-- <b-form-group>
            <b-form-checkbox v-model="recent">Recent</b-form-checkbox>
            <b-form-checkbox v-model="trending">Trending</b-form-checkbox>
          </b-form-group> -->
        </div>
      </div>
    </b-modal>
  </div>
</template>

<script>
export default {
  data() {
    return {
      library: [],
      search: "",
      list: true,
      course_type: "",
      recent: false,
      trending: false,
      alpha: false,
      showLibrary: false,
      showRecent: false,
    };
  },
  mounted() {
    this.getLibrary();
    if (window.innerWidth < 600) {
      this.list = false;
    }
  },
  computed: {
    filteredLibrary() {
      var title = this.library.filter(
        (item) =>
          item.course.title.toLowerCase().includes(this.search.toLowerCase()) ||
          JSON.parse(item.course.courseoutline.knowledge_areas)
            .value.toLowerCase()
            .includes(this.search)
      );
      if (this.alpha) {
        title.sort((a, b) => {
          return a.course.title.localeCompare(b.course.title);
        });
      }
      var courseType;
      if (this.course_type == "free") {
        courseType = title.filter((item) => item.course.type == "free");
      } else if (this.course_type == "paid") {
        courseType = title.filter((item) => item.course.type == "paid");
      } else if (this.course_type == "group") {
        courseType = title.filter((item) => item.course.type == "group");
      } else {
        courseType = title;
      }

      if (this.recent) {
        return courseType.slice().reverse();
      }
      return courseType;
    },
    recentlyAdded() {
      return this.library.slice().reverse().splice(0, 6);
    },
  },
  methods: {
    getLibrary() {
      this.$http
        .get(`${this.$store.getters.url}/libraries`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.library = res.data;
            this.showLibrary = true;
            this.showRecent = true;
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
.search {
  width: 280px;
}
.image,
img {
  object-fit: cover;
  width: 100%;
  height: 100%;
}
.overview {
  font-size: 13px;
  color: rgba($color: #000000, $alpha: 0.54);
  display: -webkit-box;
  line-clamp: 2;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  text-align: left;
  line-height: 1.3;
}
.course_img {
  width: 35%;
  height: 80px;
  border-radius: 5px;
  & img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
}
.course_desc {
  width: 75%;
}
.course_desc.mb-2 {
  width: 100%;
}
.course_img2 {
  width: 100%;
  height: 120px;
  object-fit: cover;
}
</style>

<template>
  <div>
    <b-container class="py-5">
      <h5 class="text-left mb-4">Your Library</h5>
      <b-row>
        <b-col sm="4" class="text-left pr-4">
          <div class="bg-white w-100 h-100 p-3 shadow-sm rounded">
            <h6 class="px-2 mb-4 text-muted">Recently Added</h6>
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
                    <b-button variant="danger" disabled>
                      <b-icon
                        icon="download"
                        font-scale=".9rem"
                        variant="white"
                      ></b-icon
                    ></b-button>
                    <b-button
                      variant="dark-green"
                      size="sm"
                      @click="$router.push(`/learner/media/${item.course.id}`)"
                    >
                      <span class="fs13"> View course</span>
                    </b-button>
                  </b-button-group>
                </div>
              </div>
            </div>
          </div>
          <div></div>
        </b-col>
        <b-col sm="8" class="p-3 bg-white shadow-sm rounded">
          <div class="d-flex justify-content-between mb-3">
            <div class="search mb-4">
              <b-input-group class="topbar_search rounded-pill">
                <b-form-input
                  placeholder="Search course"
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
          <div v-if="library">
            <b-row>
              <b-col
                :sm="list ? 12 : 4"
                v-for="(item, id) in filteredLibrary"
                :key="id"
              >
                <div
                  class="d-flex justify-content-between p-2 border rounded mb-4 text-left"
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
                    <div class="text-left" :class="!list ? 'mb-2' : ''">
                      <div class="fs14 font-weight-bold mb-1">
                        {{ item.course.title }}
                      </div>
                      <div class="fs14 overview">
                        {{ item.course.description }}
                      </div>
                    </div>
                  </b-col>

                  <b-col
                    :sm="list ? 6 : 12"
                    class="d-flex justify-content-between"
                    :class="list ? 'flex-row' : 'flex-column'"
                  >
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

                    <div :class="list ? 'pl-4' : ''">
                      <div class="mb-2">
                        <b-button
                          block
                          variant="danger"
                          disabled
                          class="cursor-disabled"
                          size="sm"
                          ><b-icon icon="download" class="mr-2"></b-icon>
                          Download</b-button
                        >
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
      library: [],
      search: "",
      list: true,
    };
  },
  mounted() {
    this.getLibrary();
  },
  computed: {
    filteredLibrary() {
      return this.library.filter((item) =>
        item.course.title.toLowerCase().includes(this.search.toLowerCase())
      );
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
  object-fit: contain;
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
  width: 120px;
  height: 80px;
}
.course_img2 {
  width: 100%;
  height: 120px;
  object-fit: cover;
}
</style>

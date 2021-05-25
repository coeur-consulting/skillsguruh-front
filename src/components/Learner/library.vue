<template>
  <div>
    <b-container class="py-5">
      <b-row>
        <b-col sm="4" class="text-left">
          <h6 class="px-2">Recently Added</h6>
          <div class="bg-white w-100 h-100 p-3 shadow-sm">
            <div
              class="d-flex mb-4"
              v-for="(item, id) in recentlyAdded"
              :key="id"
            >
              <b-img
                :src="item.course.cover"
                fluid
                class="mr-2"
                style="width:80px; height100px"
              ></b-img>
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
                      View course</b-button
                    >
                  </b-button-group>
                </div>
              </div>
            </div>
          </div>
          <div></div>
        </b-col>
        <b-col sm="8" class="p-3 bg-white shadow-sm">
          <h5 class="mb-3 text-left">Your Library</h5>
          <div class="d-flex justify-content-between">
            <div class="search mb-4">
              <b-input-group size="sm" class="topbar_search">
                <b-form-input
                  placeholder="Search course name"
                  class="no-focus bg-light border-0"
                  type="search"
                  aria-label="Text input "
                  v-model="search"
                ></b-form-input>
                <b-input-group-append is-text>
                  <b-iconstack font-scale="2rem" class="mr-2">
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
          </div>
          <div v-if="library">
            <div
              class="d-flex justify-content-between pb-2 border-bottom mb-3"
              v-for="(item, id) in filteredLibrary"
              :key="id"
            >
              <b-col sm="6" class="d-flex">
                <b-img
                  :src="item.course.cover"
                  fluid
                  class="mr-2 image"
                  style="width: 120px; height: 80px"
                ></b-img>
                <div>
                  <div class="fs14 font-weight-bold mb-2">
                    {{ item.course.title }}
                  </div>
                </div>
              </b-col>

              <b-col sm="6" class="d-flex justify-content-between">
                <div
                  class="fs14 text-muted d-flex align-items-center"
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

                <div class="pl-4">
                  <div class="mb-2">
                    <b-button block variant="danger" disabled size="sm"
                      ><b-icon
                        icon="download"
                        font-scale=".9rem"
                        class="mr-2"
                      ></b-icon>
                      Download</b-button
                    >
                  </div>
                  <div>
                    <b-button
                      block
                      variant="dark-green"
                      size="sm"
                      @click="$router.push(`/learner/media/${item.course.id}`)"
                      ><b-icon
                        icon="book"
                        font-scale=".9rem"
                        class="mr-2"
                      ></b-icon>
                      View course</b-button
                    >
                  </div>
                </div>
              </b-col>
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
      library: [],
      search: "",
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

<style scoped>
.search {
  width: 300px;
}
.image,
img {
  object-fit: cover;
}
</style>

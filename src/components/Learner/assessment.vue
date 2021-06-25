<template>
  <div>
    <b-container fluid>
      <b-row class="mb-3">
        <b-col class="bg-white p-3 text-left d-flex justify-content-between">
          <h5 class="text-capitalize">{{ $route.params.type }}</h5>
          <span class="text-muted fs13 cursor-pointer" @click="$router.go(-1)"
            ><b-icon icon="arrow-left"></b-icon> Back</span
          >
        </b-col>
      </b-row>
      <div v-if="assessments.length">
        <b-row>
          <b-col sm="4" v-for="(item, index) in filter" :key="index">
            <div
              class="
                shadow
                bg-white
                rounded
                p-3
                position-relative
                text-left
                border-left-green
              "
            >
              <div class="badge">
                <b-icon
                  icon="stop-circle-fill"
                  scale="1rem"
                  class="mr-1"
                  :class="{
                    'text-danger': item.status == 'pending',
                    'text-dark-green': item.status == 'active',
                    'text-warning': item.status == 'expired',
                  }"
                ></b-icon>
                <span class="text-muted fs12 text-capitalize">{{
                  item.status
                }}</span>
              </div>

              <div class="font-weight-bold fs15 mb-2 text-capitalize">
                {{ item.questiontemplate.title }}
              </div>
              <div class="fs14 text-muted mb-1">
                <span>Duration:</span> <span>{{ item.duration }} minutes</span>
              </div>
              <div class="fs14 text-muted mb-2">
                <span>Total score:</span>
                <span>{{
                  item.questiontemplate.totalscore
                    ? item.questiontemplate.totalscore
                    : "N/A"
                }}</span>
              </div>
              <div class="fs14 text-muted mb-1">
                <span>Start date:</span>
                <span>{{ item.start | moment("ll") }}</span>
              </div>
              <div class="fs14 text-muted mb-3">
                <span>Expiry date:</span>
                <span>{{ item.end | moment("ll") }}</span>
              </div>
              <div
                class="
                  fs14
                  text-muted
                  d-flex
                  justify-content-between
                  text-right
                "
              >
                <span></span>
                <span
                  class="text-dark-green cursor-pointer"
                  @click="
                    solve(
                      item.questiontemplate.id,
                      $route.params.type.toLowerCase()
                    )
                  "
                  >Solve</span
                >
              </div>
            </div>
          </b-col>
        </b-row>
        <div class="p-3 d-flex justify-content-between">
          <div class="fs12 text-muted">
            Showing {{ perPage * currentPage - perPage + 1 }}-{{
              perPage * currentPage
            }}
            of {{ assessments.length }} items
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
      <b-row v-else>
        <b-col class="empty rounded p-5 text-center">
          <h2 class="mb-3 px-2 text-muted">
            No {{ $route.params.type }} Available
          </h2>
          <b-img
            class="mb-3 px-2"
            :src="require('@/assets/images/creator.svg')"
          ></b-img>
          <p class="mb-3 text-muted">
            There appears to be no {{ $route.params.type }} available
          </p>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
export default {
  data() {
    return {
      search: "",
      currentPage: 1,
      rows: null,
      perPage: 10,
      assessments: [],
      solvedAssessments: [],
      library: [],
    };
  },
  mounted() {
    this.getLibrary();
  },
  computed: {
    filter() {
      return this.assessments
        .filter((item) =>
          item.questiontemplate.title
            .toLowerCase()
            .includes(this.search.toLowerCase())
        )
        .slice(
          this.perPage * this.currentPage - this.perPage,
          this.perPage * this.currentPage
        );
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
            this.assessments = res.data
              .map((item) => {
                if (item.assessment) {
                  return item.assessment;
                }
              })
              .filter(
                (item) =>
                  item &&
                  item.type.toLowerCase() ==
                    this.$route.params.type.toLowerCase()
              );
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getAssessments() {
      this.$http
        .get(`${this.$store.getters.url}/learner/assessments`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.assessments = res.data;
            this.rows = res.data.length;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    solve(id, type) {
      if (type == "quiz") {
        this.$router.push(`/learner/solve/assessment/quiz/${id}`);
      } else {
        this.$router.push(`/learner/solve/assessment/${id}`);
      }
    },
    getSolvedAssessments() {},
  },
};
</script>
<style scoped>
.badge {
  position: absolute;
  top: 13px;
  right: 13px;
}
</style>

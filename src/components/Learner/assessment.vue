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
      <b-row>
        <b-col sm="4">
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
            <b-icon
              icon="stop-circle-fill"
              scale="5rem"
              class="badge"
              variant="danger"
            ></b-icon>

            <div class="font-weight-bold fs15 mb-2">Test</div>
            <div class="fs14 text-muted mb-1">
              <span>Your score:</span> <span>20</span>
            </div>
            <div class="fs14 text-muted mb-2">
              <span>Total score:</span> <span>20</span>
            </div>
            <div class="fs14 text-muted mb-3">
              <span>Expiry date:</span> <span>12/3/2021</span>
            </div>
            <div
              class="fs14 text-muted d-flex justify-content-between text-right"
            >
              <span class="fs12">
                <span>Status:</span> <span>Pending</span></span
              >
              <span class="text-dark-green cursor-pointer" @click="solve()"
                >Solve</span
              >
            </div>
          </div>
        </b-col>
        <b-col sm="4">
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
            <b-icon
              icon="stop-circle-fill"
              scale="5rem"
              class="badge"
              variant="danger"
            ></b-icon>

            <div class="font-weight-bold fs15 mb-2">Test</div>
            <div class="fs14 text-muted mb-1">
              <span>Your score:</span> <span>20</span>
            </div>
            <div class="fs14 text-muted mb-2">
              <span>Total score:</span> <span>20</span>
            </div>
            <div class="fs14 text-muted mb-3">
              <span>Expiry date:</span> <span>12/3/2021</span>
            </div>
            <div
              class="fs14 text-muted d-flex justify-content-between text-right"
            >
              <span class="fs12">
                <span>Status:</span> <span>Pending</span></span
              >
              <span class="text-dark-green cursor-pointer">Solve</span>
            </div>
          </div>
        </b-col>
        <b-col sm="4">
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
            <b-icon
              icon="stop-circle-fill"
              scale="5rem"
              class="badge"
              variant="danger"
            ></b-icon>

            <div class="font-weight-bold fs15 mb-2">Test</div>
            <div class="fs14 text-muted mb-1">
              <span>Your score:</span> <span>20</span>
            </div>
            <div class="fs14 text-muted mb-2">
              <span>Total score:</span> <span>20</span>
            </div>
            <div class="fs14 text-muted mb-3">
              <span>Expiry date:</span> <span>12/3/2021</span>
            </div>
            <div
              class="fs14 text-muted d-flex justify-content-between text-right"
            >
              <span class="fs12">
                <span>Status:</span> <span>Pending</span></span
              >
              <span class="text-dark-green cursor-pointer">Solve</span>
            </div>
          </div>
        </b-col>
      </b-row>
      <div class="p-3 d-flex justify-content-between">
        <div class="fs12 text-muted">
          Showing {{ perPage * currentPage - perPage + 1 }}-{{
            perPage * currentPage
          }}
          of {{ users.length }} items
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
    };
  },
  computed: {
    filter() {
      return this.assessments
        .filter((item) =>
          item.name.toLowerCase().includes(this.search.toLowerCase())
        )
        .slice(
          this.perPage * this.currentPage - this.perPage,
          this.perPage * this.currentPage
        );
    },
  },
  methods: {
    solve(id, type) {
      if (type == "quiz") {
        this.$router.push(`/learner/solve/assessment/quiz/${id}`);
      } else {
        this.$router.push(`/learner/solve/assessment/${id}`);
      }
    },
    getAssessments() {},
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

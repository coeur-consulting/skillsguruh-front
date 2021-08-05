<template>
  <div class="bg-light">
    <b-container class="text-left">
      <b-row class="p-3 p-sm-4 justify-content-between">
        <b-col cols="2">
          <span @click="$router.go(-1)" class="cursor-pointer back fs13">
            <span class="mr-2">
              <b-icon icon="arrow-left" class=""></b-icon
            ></span>
            <span class="d-none d-sm-inline">Back</span>
          </span>
        </b-col>

        <b-col cols="9" sm="4">
          <b-form-input
            type="search"
            v-model="search"
            placeholder="Search name"
          ></b-form-input>
        </b-col>
      </b-row>
      <b-row class="learners">
        <b-col
          sm="4"
          class="mb-5 mb-sm-0 py-3 px-4"
          v-for="(item, id) in filteredName"
          :key="id"
        >
          <div
            class="position-relative cursor-pointer"
            @click="$router.push(`/profile/u/${item.id}`)"
          >
            <div class="facilitator shadow-sm position-relative bg-white">
              <b-img
                class="rounded mb-4"
                fluid-grow
                :src="
                  item.profile
                    ? item.profile
                    : require('@/assets/images/default.jpeg')
                "
                style="object-fit: cover"
              ></b-img>
              <div>{{ item.name }}</div>
              <div class="text-muted fs13 text-capitalize">
                <span> {{ item.age ? item.age + " years" : "N/a" }}</span>
                <span v-if="item.gender"
                  >, {{ item.gender ? item.gender : "N/a" }}</span
                >
              </div>

              <div class="text-muted fs13 text-capitalize">
                {{ item.state ? item.state : "Lagos" }},
                {{ item.country ? item.country : "NG" }}
              </div>
              <div class="text-muted fs12 text-capitalize">
                {{
                  item.interests
                    ? JSON.parse(item.interests).length + " interests"
                    : "0 intersts"
                }},
              </div>

              <div class="text-muted"><small>Learner</small></div>
              <!-- <div>
              <b-icon class="text-gold" icon="star-fill"></b-icon>
              <b-icon class="text-gold" icon="star-fill"></b-icon>
              <b-icon class="text-gold" icon="star-fill"></b-icon>
              <b-icon class="text-gold" icon="star-fill"></b-icon>
              <b-icon class="text-gold" icon="star-fill"></b-icon>
            </div> -->
            </div>
            <span class="hover_box"></span>
          </div>
        </b-col>
      </b-row>
      <div class="py-3 d-flex justify-content-between" v-if="rows > 10">
        <div class="fs12 text-muted">
          Showing 1-10 of {{ learners.length }} items
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
      learners: [],
      search: "",
      currentPage: 1,
      rows: null,
      perPage: 12,
    };
  },
  mounted() {
    this.getlearners();
  },
  computed: {
    filteredName() {
      var name = this.learners.filter((item) =>
        item.name.includes(this.search)
      );
      return name.slice(
        this.perPage * this.currentPage - this.perPage,
        this.perPage * this.currentPage
      );
    },
  },
  methods: {
    getlearners() {
      this.$http
        .get(`${this.$store.getters.url}/guest/learners`)
        .then((res) => {
          if (res.status == 200) {
            this.learners = res.data;
            this.rows = res.data.length;
          }
        });
    },
  },
};
</script>

<style scoped>
.container {
  min-height: 100vh;
}
#learners {
  position: relative;
  padding-top: 8rem;
  padding-bottom: 5rem;
}
.ex-learners {
}

.ex-learners h2 {
  font-size: 25px;
  font-style: normal;
  font-weight: 600;
  line-height: 33px;
  letter-spacing: 0em;
  text-align: center;
}
.ex-learners p {
  font-size: 16px;
  font-style: normal;
  font-weight: 400;
  line-height: 28px;
  letter-spacing: 0.06em;
  text-align: center;
  color: #828282;
}
.learners {
  display: flex;
  width: 100%;
  margin: 0 auto;
  justify-content: space-around;
}
.hover_box {
  width: 100%;
  height: 100%;
  background: var(--dark-green);
  position: absolute;
  right: 0px;
  top: 0;
  border-radius: 10px;
  z-index: 0;
  transition: 0.25s;
  opacity: 0;
}
.facilitator {
  padding: 25px;
  text-align: left;
  border-radius: 10px;
  z-index: 1;
}
.facilitator:hover ~ .hover_box {
  right: -5px;
  transform: rotate(5deg);
  opacity: 1;
}
.facilitator img {
  width: 100%;
  height: 200px;
}
.facilitator > div {
}
.text-gold {
  color: gold;
}
</style>

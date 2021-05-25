<template>
  <div>
    <b-container class="pt-5">
      <b-row>
        <b-col
          sm="8"
          class="mx-auto shadow rounded text-left p-4 bg-white"
          v-if="outline.course"
        >
          <div class="mb-4 fs13">
            <span @click="$router.go(-1)" class="cursor-pointer"
              ><b-icon icon="arrow-left"></b-icon> Back</span
            >
          </div>
          <h5 class="text-capitalize font-weight-bold mb-4 text-center">
            {{ outline.course.title }} Outline<br />
            <span class="fs14 text-dark-green">{{ outline.duration }}</span>
          </h5>

          <div class="mb-4">
            <h6 class="font-weight-bold">Overview</h6>
            <span class="">{{ outline.overview }}</span>
          </div>

          <div class="mb-4">
            <h6 class="font-weight-bold">Knowledge Area</h6>
            <span class="text-capitalize">{{ outline.knowledge_areas }}</span>
          </div>

          <div class="mb-4">
            <h6 class="font-weight-bold">Modules</h6>
            <span v-for="(item, id) in JSON.parse(outline.modules)" :key="id"
              >{{ item }} <br />
            </span>
          </div>

          <div class="mb-4">
            <h6 class="font-weight-bold">Faqs</h6>
            <span v-for="(item, id) in JSON.parse(outline.faqs)" :key="id">
              <div class="fs14 mb-1 d-flex">
                <b-icon
                  icon="question-circle-fill"
                  class="mr-2 text-light-green"
                ></b-icon>
                <span>{{ item.question }}</span>
              </div>
              <div class="fs14 d-flex">
                <b-icon
                  icon="check-circle-fill"
                  class="mr-2 text-light-green"
                ></b-icon>
                <span>{{ item.answer }}</span>
              </div>
            </span>
          </div>

          <div>
            <h6 class="font-weight-bold">Certification</h6>
            <span class="text-capitalize"
              ><b-icon icon="check2-circle" variant="dark-green"></b-icon>
              {{ outline.certification }}</span
            >
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
      outline: {},
    };
  },
  mounted() {
    this.getoutline();
  },
  methods: {
    async getoutline() {
      return this.$http
        .get(
          `${this.$store.getters.url}/courseoutlines/${this.$route.params.id}`,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.outline = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
  },
};
</script>

<style scoped></style>

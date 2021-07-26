<template>
  <div>
    <b-container fluid>
      <h5 class="text-center mb-4">Choose your interests</h5>
      <div class="py-4 text-center">
        <b-form-input
          class="search"
          placeholder="Search interest"
          v-model="search"
          type="search"
        ></b-form-input>
      </div>
      <b-row class="mb-4">
        <b-col
          cols="6"
          sm="4"
          v-for="interest in filteredInterest"
          :key="interest.value"
          class="mb-4"
        >
          <div
            class="
              px-4
              py-3
              rounded-pill
              fs14
              font-weight-bold
              cursor-pointer
              d-flex
              justify-content-between
              align-items-center
              text-white
            "
            :style="`backgroundColor:${interest.color}`"
            @click="addInterest(interest.value)"
            :class="
              selected_interests.includes(interest.value)
                ? 'shadow'
                : 'disabled'
            "
          >
            <span class="value_1"> {{ interest.value }}</span>

            <b-icon
              v-if="selected_interests.includes(interest.value)"
              icon="check2-circle"
              font-scale="1.5"
            ></b-icon>
            <b-icon
              v-if="!selected_interests.includes(interest.value)"
              icon="plus-circle"
              font-scale="1.5"
            ></b-icon>
          </div>
        </b-col>
        <b-col class="text-center" v-if="initial != 60">
          <span @click="loadMore" class="fs12 cursor-pointer text-muted"
            >Load more</span
          >
        </b-col>
      </b-row>

      <div class="text-center my-4">
        <b-button
          size="sm"
          variant="outline-secondary"
          v-if="!$route.name.includes('profile')"
          class="mr-3"
          @click="skip"
        >
          Skip for later</b-button
        >
        <b-button variant="dark-green" size="sm" @click="saveinterest"
          >Save Interests</b-button
        >
      </div>
    </b-container>
  </div>
</template>

<script>
import Interest from "./insight";
export default {
  props: ["user", "type"],
  data() {
    return {
      interests: [],
      selected_interests: [],
      search: "",
      initial: 30,
    };
  },
  created() {
    this.interests = Interest;

    if (this.$props.type == "learner") {
      this.selected_interests =
        JSON.parse(this.$store.getters.learner.interests) || [];
    }
    if (this.$props.type == "facilitator") {
      this.selected_interests =
        JSON.parse(this.$store.getters.facilitator.interests) || [];
    }
  },
  computed: {
    filteredInterest() {
      return this.interests
        .filter((item) =>
          item.value.toLowerCase().includes(this.search.toLowerCase())
        )
        .slice(0, this.initial);
    },
  },
  methods: {
    loadMore() {
      this.initial = this.initial * 2;
    },
    skip() {
      this.$emit("skip");
    },
    addInterest(val) {
      if (this.selected_interests.includes(val)) {
        this.selected_interests.splice(this.selected_interests.indexOf(val), 1);
        return;
      }
      this.selected_interests.push(val);
    },
    saveinterest() {
      if (!this.selected_interests.length) {
        this.$toast.info("Choose an interest!");
        return;
      }
      this.$http
        .post(
          `${this.$store.getters.url}/save-interests`,
          { interest: this.selected_interests },
          {
            headers: {
              Authorization: `Bearer ${this.$props.user.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            var user;
            if (this.$props.type == "learner") {
              user = JSON.parse(localStorage.getItem("authLearner"));
              user.interests = res.data.interests;
              localStorage.setItem("authLearner", JSON.stringify(user));
            }
            if (this.$props.type == "facilitator") {
              user = JSON.parse(localStorage.getItem("authFacilitator"));
              user.interests = res.data.interests;
              localStorage.setItem("authFacilitator", JSON.stringify(user));
            }

            this.$toast.success("Interest Updated!");
            window.location.reload();
            this.skip();
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
.icon {
  position: absolute;
  left: 20px;
}
.disabled {
  opacity: 0.5;
}
span.value_1 {
  font-size: 0.6rem;
}
@media (min-width: 600px) {
  .search {
    width: 50%;
    margin: 0 auto;
  }
}
</style>

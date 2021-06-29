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
      <b-row>
        <b-col
          cols="6"
          sm="3"
          v-for="interest in filteredInterest"
          :key="interest.value"
          class="mb-4"
        >
          <div
            class="
              px-2
              py-3
              bg-light
              rounded-pill
              text-center
              fs12
              font-weight-bold
              cursor-pointer
              position-relative
            "
            @click="addInterest(interest.value)"
            :class="
              selected_interests.includes(interest.value)
                ? 'shadow bg-lighter-green'
                : ''
            "
          >
            <b-iconstack font-scale="1.6rem" class="mr-2 icon">
              <b-icon
                stacked
                icon="circle-fill"
                :color="interest.color"
              ></b-icon>
              <b-icon
                stacked
                :icon="interest.icon"
                scale="0.5"
                variant="light"
              ></b-icon>
            </b-iconstack>
            <span> {{ interest.value }}</span>
          </div>
        </b-col>
      </b-row>

      <div class="text-center my-4">
        <b-button variant="outline-secondary" class="mr-3" @click="skip">
          Skip for later</b-button
        >
        <b-button variant="dark-green" @click="saveinterest"
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
    };
  },
  mounted() {
    this.interests = Interest;

    if (this.$props.type == "user") {
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
      return this.interests.filter((item) =>
        item.value.toLowerCase().includes(this.search.toLowerCase())
      );
    },
  },
  methods: {
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
            if (this.$props.type == "user") {
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
@media (min-width: 600px) {
  .search {
    width: 50%;
    margin: 0 auto;
  }
}
</style>

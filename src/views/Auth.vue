<template>
  <div>
    <b-container>
      <b-row>
        <b-col class="d-flex">
          {{ $route.query.code }}
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
export default {
  mounted() {
    this.Sociallogin();
  },
  methods: {
    Sociallogin() {
      this.$http
        .post(
          `${this.$store.getters.url}/auth/google/callback`,
          this.$route.query
        )
        .then(response => {
          console.log(response.data);
        })
        .catch(err => {
          console.log({ err: err });
        });
    }
  }
};
</script>

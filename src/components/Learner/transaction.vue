<template>
  <div>
    <b-container>
      <b-row class="justify-content-center align-items-center">
        <b-col sm="6">
          <div class="box shadow rounded p-5 text-center bg-white">
            <div v-if="order.status == 'success'" class="mb-4">
              <h5>Transaction successful</h5>

              <b-icon
                icon="check2-circle"
                font-scale="6"
                variant="dark-green"
              ></b-icon>
              <p>{{ order.message }}</p>
            </div>

            <div v-else class="mb-4">
              <h5>Transaction failed</h5>

              <b-icon icon="x-circle" font-scale="6" variant="danger"></b-icon>
              <p>{{ order.message }}</p>
            </div>

            <router-link to="/learner">
              <b-button variant="lighter-green"
                >Back to Dashboard</b-button
              ></router-link
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
      order: {},
      loading: true
    };
  },
  components: {},
  mounted() {},
  methods: {
    getorder() {
      this.$http
        .get(`${this.$store.getters.url}/orders/${this.$route.query.trxref}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`
          }
        })
        .then(res => {
          if (res.status == 200) {
            this.loading = false;
            this.order = res.data;
          }
        });
    }
  }
};
</script>
<style scoped>
.container {
  height: 70vh;
}
.row {
  height: 100%;
  width: 100%;
}
.box {
}
</style>

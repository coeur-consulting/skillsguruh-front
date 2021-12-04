<template>
  <div class="bg-light">
    <b-container>
      <b-row class="justify-content-center align-items-center">
        <b-col sm="6">
          <div class="box shadow rounded p-5 text-center bg-white">
            <div v-if="loading" class="text-center">
              <h5 class="mb-4 text-muted">Verifying Transaction</h5>
              <b-icon
                icon="arrow-clockwise"
                animation="spin-pulse"
                font-scale="6"
                variant="dark-green"
              ></b-icon>
            </div>
            <div v-else>
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

                <b-icon
                  icon="x-circle"
                  font-scale="6"
                  variant="danger"
                ></b-icon>
                <p>{{ order.message }}</p>
              </div>

              <router-link to="/member/feeds">
                <b-button variant="lighter-green"
                  >Back to Home</b-button
                ></router-link
              >
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
      order: {},
      loading: true,
    };
  },
  components: {},
  mounted() {
    this.getorder();
  },
  methods: {
    getorder() {
      this.$http
        .get(`${this.$store.getters.url}/orders/${this.$route.query.trxref}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.loading = false;
            this.order = res.data;
          }
        });
    },
  },
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

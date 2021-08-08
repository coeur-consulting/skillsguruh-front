<template>
  <div>
    <b-container>
      <b-row class="justify-content-center align-items-center">
        <b-col sm="6">
          <div class="box shadow rounded p-4 text-center">
            <h5 class="mb-4">Order Information</h5>

            <Paystack />
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
import Paystack from "@/components/paystack.vue";
export default {
  data() {
    return {
      order: {},
    };
  },
  components: {
    Paystack,
  },
  mounted() {
    this.getcourse();
  },
  methods: {
    getcourse() {
      this.$http
        .get(
          `${this.$store.getters.url}/courses/${this.$route.query.params.id}`,

          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.course = res.data;
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

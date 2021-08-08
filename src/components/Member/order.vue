<template>
  <div>
    <b-container>
      <b-row class="justify-content-center align-items-center">
        <b-col sm="6">
          <div class="box shadow rounded p-5 text-left bg-white">
            <h5 class="mb-4">Order Information</h5>
            <p class="mb-1">Course Title : {{ order.title }}</p>
            <p>Course Amount : {{ order.amount | currencyFormat }}</p>
            <Paystack
              :user_amount="order.amount * 100"
              :user_email="$store.getters.member.email"
              :course_id="$route.query.id"
            />
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
          `${this.$store.getters.url}/courses/${this.$route.query.id}`,

          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
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

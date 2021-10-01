<template>
  <div>
    <b-container>
      <b-row class="justify-content-center align-items-center">
        <b-col sm="7">
          <div class="box shadow rounded p-5 text-left bg-white">
            <h5 class="mb-4">Payment Information</h5>
            <div v-if="order_type == 'course'">
              <p class="mb-1">Course Title : {{ order.title }}</p>
              <p>Course Amount : {{ order.amount | currencyFormat }}</p>
              <Paystack
                :user_amount="order.amount * 100"
                :user_email="$store.getters.member.email"
                :item_id="$route.query.id"
                type="course"
              />
            </div>
            <div v-if="order_type == 'tribe'">
              <p class="mb-1 font-weight-bold">{{ tribe.name }}</p>
              <p class="mb-1">{{ tribe.description }}</p>
              <p>Access Fee : {{ tribe.amount | currencyFormat }}</p>
              <Paystack
                :user_amount="tribe.amount * 100"
                :user_email="$store.getters.member.email"
                :item_id="$route.query.id"
                :splitCode="owner.split_code"
                type="tribe"
              />
            </div>
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
      order_type: "course",
      tribe: {},
      owner: {},
    };
  },
  components: {
    Paystack,
  },
  mounted() {
    if (this.$route.query.type_payment == "tribe") {
      this.order_type = "tribe";
      this.gettribe();
    } else {
      this.getcourse();
    }
  },
  methods: {
    gettribe() {
      this.$http
        .get(`${this.$store.getters.url}/tribes/${this.$route.query.id}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.tribe = res.data.data;
            this.owner = res.data.owner;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
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

<template>
  <paystack
    :amount="user_amount"
    :email="user_email"
    :paystackkey="paystackkey"
    :reference="reference"
    :callback="callback"
    :close="close"
    :embed="false"
  >
    <b-button variant="dark-green" class="p-0"> Make Payment</b-button>
  </paystack>
</template>

<script type="text/javascript">
import paystack from "vue-paystack";
export default {
  props: ["user_email", "user_amount", "item_id", "type"],
  components: {
    paystack,
  },
  data() {
    return {
      paystackkey: "pk_test_8047f2961e0e83a7b455b8c6644b21cccb01d900", //paystack public key
      email: "foobar@example.com", // Customer email
      amount: 1000000, // in kobo
    };
  },
  computed: {
    reference() {
      let text = "";
      let possible =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

      for (let i = 0; i < 10; i++)
        text += possible.charAt(Math.floor(Math.random() * possible.length));

      return text;
    },
  },

  methods: {
    // pk_test_8047f2961e0e83a7b455b8c6644b21cccb01d900
    // pk_live_a7a9159c8237f2a1faabbcd5058e7b5feb64c6c2
    callback: function (response) {
      response.item_id = this.$props.item_id;
      response.type = this.$props.type;
      this.$http
        .post(`${this.$store.getters.url}/orders`, response, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            var url = `https://nzukoor.com/transaction/?trxref=${response.trxref}`;
            // var url = `http://localhost:8080/transaction/?trxref=${response.trxref}`;
            window.location.href = url;
          }
        });
    },
    close: function () {
      console.log("Payment closed");
    },
  },
};
</script>

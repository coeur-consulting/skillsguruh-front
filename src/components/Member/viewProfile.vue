<template>
  <b-container class="py-5">
    <b-row class="h-100">
      <b-col sm="8" class="mx-auto bg-white rounded shadow p-3">
        <div class="fs14 text-left">
          <span @click="$router.go(-1)" class="cursor-pointer"
            ><b-icon icon="arrow-left"></b-icon> Back</span
          >
        </div>
        <div class="p-4">
          <div class="mb-5">
            <b-avatar
              badge-variant="dark-green"
              size="7rem"
              :src="user.profile"
            >
            </b-avatar>
          </div>
          <div class="text-left">
            <b-form-row>
              <b-col sm="6">
                <b-form-group label="Name" class="mb-4">
                  <span>{{ user.name ? user.name : "Unavailable" }}</span>
                </b-form-group>
              </b-col>
              <b-col sm="6">
                <b-form-group class="mb-4" label="Email">
                  <span>{{ user.email ? user.email : "Unavailable" }}</span>
                </b-form-group></b-col
              >
            </b-form-row>
            <b-form-row>
              <b-col sm="6">
                <b-form-group class="mb-4" label="Phone">
                  <span>{{
                    user.phone ? user.phone : "Unavailable"
                  }}</span></b-form-group
                >
              </b-col>
              <b-col sm="6">
                <b-form-group class="mb-4" label="Referral Code">
                  <span>{{
                    user.referral_code ? user.referral_code : "Unavailable"
                  }}</span></b-form-group
                ></b-col
              >
            </b-form-row>
            <b-form-row>
              <b-col sm="6">
                <b-form-group class="mb-4" label="Bio">
                  <span>{{
                    user.bio ? user.bio : "Unavailable"
                  }}</span></b-form-group
                >
              </b-col>
              <b-col sm="6">
                <b-form-group class="mb-4" label="Address">
                  <span>{{
                    user.address ? user.address : "Unavailable"
                  }}</span></b-form-group
                ></b-col
              >
            </b-form-row>
            <b-form-row>
              <b-col sm="6">
                <b-form-group class="mb-4" label="Status">
                  <b-badge
                    :variant="user.verification ? 'success' : 'danger'"
                    >{{ user.verification ? "Active" : "Inactive" }}</b-badge
                  ></b-form-group
                >
              </b-col>
            </b-form-row>
          </div>
        </div>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
export default {
  data() {
    return {
      user: {},
    };
  },

  mounted() {
    if (this.$route.params.type == "member") {
      this.getuser();
    }
    if (this.$route.params.type == "facilitator") {
      this.getfacilitator();
    }
  },
  methods: {
    getfacilitator() {
      this.$http
        .get(
          `${this.$store.getters.url}/admin-get-facilitator/${this.$route.params.id}`,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.user = res.data;
          }
        });
    },
    getuser() {
      this.$http
        .get(
          `${this.$store.getters.url}/admin-get-user/${this.$route.params.id}`,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.user = res.data;
          }
        });
    },
  },
};
</script>

<style scoped></style>

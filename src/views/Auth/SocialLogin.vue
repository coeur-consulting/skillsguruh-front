<template>
  <div></div>
</template>
<script>
export default {
  data() {
    return {
      access_token: null,
      USER_CLIENT_SECRET: process.env.VUE_APP_USER_CLIENT_SECRET,
      USER_CLIENT_ID: process.env.VUE_APP_USER_CLIENT_ID,
      FAC_CLIENT_SECRET: process.env.VUE_APP_FAC_CLIENT_SECRET,
      FAC_CLIENT_ID: process.env.VUE_APP_FAC_CLIENT_ID
    };
  },
  mounted() {
    this.callback().then(() => {
      this.register();
    });
  },
  methods: {
    RefreshParent() {
      if (window.opener != null && !window.opener.closed) {
        window.opener.location.reload();
        window.close();
      }
    },

    register() {
      // var authOrg = {};
      // var authAdmin = {};
      // var authFacilitator = {};
      var authLearner = {};

      // if (this.type == "organization") {
      //   let data = {
      //     grant_type: "social", // static 'social' value
      //     client_id: process.env.VUE_APP_GOOGLE_CLIENT_ID,
      //     client_secret: process.env.VUE_APP_GOOGLE_CLIENT_SECRET, // client secret
      //     provider: this.$route.params.provider, // name of provider (e.g., 'facebook', 'google' etc.)
      //     access_token: this.access_token, // access token issued by specified provider
      //   };
      //   this.$http
      //     .post("https://skillsguruh-api.herokuapp.com//oauth/token", data)
      //     .then((res) => {
      //       authOrg.access_token = res.data.access_token;
      //       authOrg.refresh_token = res.data.refresh_token;
      //       this.$http
      //         .get(`${this.$store.getters.url}/organization`, {
      //           headers: {
      //             Authorization: `Bearer ${res.data.access_token}`,
      //           },
      //         })
      //         .then((res) => {
      //           authOrg.id = res.data.id;
      //           authOrg.name = res.data.name;
      //           authOrg.email = res.data.email;
      //           authOrg.profile = res.data.logo;
      //           authOrg.referral = res.data.referral_code;

      //           localStorage.setItem("authOrg", JSON.stringify(authOrg));
      //           this.$toast.success("Login successful");
      //           window.location.href = "/organization";
      //         })
      //         .catch(() => {
      //           this.loading = false;
      //           this.$toast.error("Invalid credentials");
      //         });
      //     })
      //     .catch(() => {
      //       this.loading = false;
      //       this.$toast.error("Invalid credentials");
      //     });
      // }
      // if (this.type == "admin") {
      //   let data = {
      //     grant_type: "password",
      //     client_id: 3,
      //     client_secret: "fjiWTis9MO1KfJhnR0uVG0UwVL6adxIpp4JbVXdT",
      //     username: this.user.email,
      //     password: this.user.password,
      //   };
      //   this.$http
      //     .post("https://skillsguruh-api.herokuapp.com//oauth/token", data)
      //     .then((res) => {
      //       authAdmin.access_token = res.data.access_token;
      //       authAdmin.refresh_token = res.data.refresh_token;
      //       this.$http
      //         .get(`${this.$store.getters.url}/admin`, {
      //           headers: {
      //             Authorization: `Bearer ${res.data.access_token}`,
      //           },
      //         })
      //         .then((res) => {
      //           authAdmin.id = res.data.id;
      //           authAdmin.name = res.data.name;
      //           authAdmin.email = res.data.email;
      //           authAdmin.profile = res.data.profile;

      //           authAdmin.org_profile = res.data.organization.logo;
      //           authAdmin.org_name = res.data.organization.name;
      //           authAdmin.referral = res.data.referral_code;

      //           localStorage.setItem("authAdmin", JSON.stringify(authAdmin));
      //           this.$toast.success("Login successful");

      //           window.location.href = "/administrator";
      //         })
      //         .catch(() => {
      //           this.$toast.error("Invalid credentials");
      //         });
      //     })
      //     .catch(() => {
      //       this.loading = false;
      //       this.$toast.error("Invalid credentials");
      //     });
      // }

      // if (this.type == "facilitator") {
      //   let data = {
      //     grant_type: "password",
      //     client_id: 4,
      //     client_secret: "NVXAR1hE3wGF6cz5lZKdo2rsaafzZ73sGGsBPH7h",
      //     username: this.user.email,
      //     password: this.user.password,
      //   };
      //   this.$http
      //     .post("https://skillsguruh-api.herokuapp.com//oauth/token", data)
      //     .then((res) => {
      //       authFacilitator.access_token = res.data.access_token;
      //       authFacilitator.refresh_token = res.data.refresh_token;
      //       this.$http
      //         .get(`${this.$store.getters.url}/facilitator`, {
      //           headers: {
      //             Authorization: `Bearer ${res.data.access_token}`,
      //           },
      //         })
      //         .then((res) => {
      //           authFacilitator.id = res.data.id;
      //           authFacilitator.name = res.data.name;
      //           authFacilitator.email = res.data.email;
      //           authFacilitator.profile = res.data.profile;
      //           authFacilitator.facilitator_role = res.data.facilitator_role;
      //           authFacilitator.interests = res.data.interests;
      //           authFacilitator.org_profile = res.data.organization.logo;
      //           authFacilitator.org_name = res.data.organization.name;
      //           authFacilitator.referral = res.data.referral_code;

      //           localStorage.setItem(
      //             "authFacilitator",
      //             JSON.stringify(authFacilitator)
      //           );
      //           this.$toast.success("Login successful");

      //           window.location.href = "/facilitator";
      //         })
      //         .catch(() => {
      //           this.$toast.error("Invalid credentials");
      //         });
      //     })
      //     .catch(() => {
      //       this.loading = false;
      //       this.$toast.error("Invalid credentials");
      //     });
      // }
      //   if (this.type == "learner") {
      let data = {
        grant_type: "social", // static 'social' value
        client_id: this.USER_CLIENT_ID,
        client_secret: this.USER_CLIENT_SECRET, // client secret
        provider: this.$route.params.provider, // name of provider (e.g., 'facebook', 'google' etc.)
        access_token: this.access_token // access token issued by specified provider
      };
      this.$http
        .post("https://skillsguruh-api.herokuapp.com/oauth/token", data)
        .then(res => {
          authLearner.access_token = res.data.access_token;
          authLearner.refresh_token = res.data.refresh_token;
          this.$http
            .get(`${this.$store.getters.url}/user`, {
              headers: {
                Authorization: `Bearer ${res.data.access_token}`
              }
            })
            .then(res => {
              if (res.status == 200) {
                authLearner.id = res.data.id;
                authLearner.name = res.data.name;
                authLearner.email = res.data.email;
                authLearner.profile = res.data.profile;
                authLearner.voice = res.data.voice;
                authLearner.interests = res.data.interests;
                authLearner.org_profile = res.data.organization.logo;
                authLearner.org_name = res.data.organization.name;
                authLearner.referral = res.data.referral_code;

                localStorage.setItem(
                  "authLearner",
                  JSON.stringify(authLearner)
                );
                this.$toast.success("Login successful");
                this.RefreshParent();
              }
            })
            .catch(() => {
              this.$toast.error("Invalid credentials");
            });
        })
        .catch(() => {
          this.loading = false;
          this.$toast.error("Invalid credentials");
        });
      //   }
    },
    async callback() {
      try {
        var response = await this.$http.post(
          `https://skillsguruh-api.herokuapp.com/v1/auth/${this.$route.params.provider}/callback`,
          this.$route.query
        );

        this.access_token = response.data;
        return response;
      } catch (error) {
        this.access_token = error;
      }
    }
  }
};
</script>

<template>
  <div id="register">
    <b-container fluid class="p-sm-0 h-100">
      <b-row class="h-100">
        <b-col cols="0" sm="6" class="side p-3 p-sm-4 d-none d-sm-flex">
          <b-img
            class="logo cursor-pointer"
            @click="$router.push('/')"
            :src="require('@/assets/images/logo.png')"
          ></b-img>
          <div class="position-relative">
            <span class="rect">
              <b-img
                :src="require('@/assets/images/auth/loginimg.png')"
              ></b-img>
            </span>

            <h3 class="mt-4">{{ type ? "Facilitator" : "Member" }} Login</h3>
          </div>
        </b-col>
        <b-col
          cols="12"
          sm="6"
          class="
            main
            p-3 p-sm-5
            d-flex
            justify-content-center
            align-items-center
            text-sm-left
          "
        >
          <div class="shadow rounded p-4 p-sm-5 h-100 w-100">
            <div class="d-sm-none position-relative">
              <b-img
                class="img-l cursor-pointer"
                @click="$router.push('/')"
                width="40px"
                src="/img/logo.png"
              ></b-img>
            </div>

            <b-form @submit.stop.prevent="register" class="user w-100">
              <legend>
                Login in to
                <span class="font-weight-bold text-dark-green">Nzukoor</span>
              </legend>
              <div class="form-text mb-4">
                You do not have an account?
                <span
                  class="text-secondary cursor-pointer"
                  @click="$router.push('/register')"
                  >Sign Up</span
                >
              </div>

              <div>
                <b-form-row class="mb-2">
                  <b-col class="pr-sm-3">
                    <b-form-group label="Email" id="email" label-for="email">
                      <b-form-input
                        size="lg"
                        required
                        v-model="user.email"
                        name="email"
                        :state="validation"
                        type="email"
                        placeholder="Enter email address"
                        aria-describedby="email-feedback"
                      ></b-form-input>
                    </b-form-group>
                  </b-col>
                </b-form-row>
                <b-form-row class="mb-2">
                  <b-col cols="12" class="pr-sm-3">
                    <b-form-group
                      label=" Password"
                      id="password"
                      label-for="password"
                    >
                      <b-input-group size="lg">
                        <template #append>
                          <div>
                            <b-input-group-text
                              class="bg-transparent border-left-0"
                              :class="
                                validation === false ? 'border-danger' : ''
                              "
                            >
                              <b-icon
                                @click="toggleeye1 = !toggleeye1"
                                font-scale=".85"
                                :icon="toggleeye1 ? 'eye' : 'eye-slash'"
                                :class="
                                  validation === false ? 'text-danger' : ''
                                "
                              ></b-icon>
                            </b-input-group-text>
                          </div>
                        </template>
                        <b-form-input
                          class="border-right-0"
                          required
                          min="6"
                          v-model="user.password"
                          name="password"
                          :state="validation"
                          :type="toggleeye1 ? 'text' : 'password'"
                          placeholder="Enter  password "
                          aria-describedby="password-feedback"
                        ></b-form-input>
                      </b-input-group>
                    </b-form-group>
                  </b-col>
                </b-form-row>

                <b-form-group>
                  <div class="mb-3">
                    <b-button
                      type="submit"
                      variant="dark-green"
                      size="lg"
                      block
                      :disabled="loading"
                      class="px-5 d-flex justify-content-center"
                    >
                      <span class="fs16">Login</span>
                      <b-icon
                        icon="three-dots"
                        v-if="loading"
                        animation="cylon"
                        class="ml-3"
                        font-scale="1.5"
                      ></b-icon
                    ></b-button>
                  </div>
                  <div class="">
                    <small
                      class="text-secondary"
                      @click="
                        $router.push(
                          `/forgot-password?auth=${
                            !type ? 'user' : 'facilitator'
                          }`
                        )
                      "
                      >Forgot password?</small
                    >
                  </div>
                </b-form-group>
              </div>

              <div v-if="!type">
                <div class="or my-4">OR</div>

                <div class="socials mt-3">
                  <div
                    class="social shadow-sm mb-3 border btn-shadow"
                    @click="socialregister('google')"
                  >
                    <b-img
                      :src="require('@/assets/images/auth/goo.png')"
                      class="mr-2"
                    ></b-img>
                    Log in with Google
                  </div>
                  <div
                    class="social shadow-sm border btn-shado"
                    @click="socialregister('facebook')"
                  >
                    <b-img
                      :src="require('@/assets/images/auth/face.png')"
                      class="mr-2"
                    ></b-img>
                    Log in with Facebook
                  </div>
                </div>
              </div>
              <div class="text-center mt-4">
                <span
                  v-if="type == false"
                  class="text-secondary cursor-pointer"
                  @click="type = true"
                >
                  I am a Facilitator
                </span>
                <span
                  v-else
                  class="text-secondary cursor-pointer"
                  @click="type = false"
                >
                  I am a Member
                </span>
              </div>
            </b-form>
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
export default {
  name: "register-component",

  data() {
    return {
      type: false,
      loading: false,
      validation: null,
      toggleeye1: false,
      user: {
        email: "",

        password: "",
      },
      agree: false,
    };
  },

  mounted() {
    if (this.$route.query.auth == "facilitator") {
      this.type = true;
    }
    if (this.$route.query.auth == "member") {
      this.type = false;
    }
  },

  methods: {
    getUpload(val) {
      this.user.profile = val;
    },
    register() {
      this.loading = true;

      var authFacilitator = {};
      var authMember = {};

      if (this.type) {
        let data = {
          grant_type: "password",
          client_id: 4,
          client_secret: "NVXAR1hE3wGF6cz5lZKdo2rsaafzZ73sGGsBPH7h",
          username: this.user.email,
          password: this.user.password,
        };
        this.$http
          .post("https://nzukoor-server.herokuapp.com/oauth/token", data)
          .then((res) => {
            authFacilitator.access_token = res.data.access_token;
            authFacilitator.refresh_token = res.data.refresh_token;
            this.$http
              .get(`${this.$store.getters.url}/facilitator`, {
                headers: {
                  Authorization: `Bearer ${res.data.access_token}`,
                },
              })
              .then((res) => {
                authFacilitator.id = res.data.id;
                authFacilitator.name = res.data.name;
                authFacilitator.username = res.data.username;
                authFacilitator.email = res.data.email;
                authFacilitator.voice = res.data.voice;
                authFacilitator.profile = res.data.profile;
                authFacilitator.facilitator_role = res.data.facilitator_role;
                authFacilitator.interests = res.data.interests;
                // authFacilitator.org_profile = res.data.organization.logo;
                // authFacilitator.org_name = res.data.organization.name;
                authFacilitator.referral = res.data.referral_code;

                localStorage.setItem(
                  "authFacilitator",
                  JSON.stringify(authFacilitator)
                );
                this.$toast.success("Login successful");
                if (this.$route.query.redirect) {
                  window.location.href = this.$route.query.redirect;
                  return;
                }
                window.location.href = "/facilitator";
              })
              .catch(() => {
                this.$toast.error("Invalid credentials");
              });
          })
          .catch(() => {
            this.loading = false;
            this.$toast.error("Invalid credentials");
            this.validation = false;
            setTimeout(() => {
              this.validation = null;
            }, 5000);
          });
      }
      if (!this.type) {
        let data = {
          grant_type: "password",
          client_id: 2,
          client_secret: "OAniIlKCpBOv2oMpKVoRLBau55xLKbz1Qo5YNuee",
          username: this.user.email,
          password: this.user.password,
        };
        this.$http
          .post("https://nzukoor-server.herokuapp.com/oauth/token", data)
          .then((res) => {
            authMember.access_token = res.data.access_token;
            authMember.refresh_token = res.data.refresh_token;
            this.$http
              .get(`${this.$store.getters.url}/user`, {
                headers: {
                  Authorization: `Bearer ${res.data.access_token}`,
                },
              })
              .then((res) => {
                if (res.status == 200) {
                  authMember.id = res.data.id;
                  authMember.name = res.data.name;
                  authMember.username = res.data.username;
                  authMember.email = res.data.email;
                  authMember.profile = res.data.profile;
                  authMember.voice = res.data.voice;
                  authMember.interests = res.data.interests;
                  // if (!res.data.organization) {
                  //   authMember.org_profile = require("@/assets/images/logo.png");
                  //   authMember.org_name = "Nzukoor";
                  // } else {
                  //   authMember.org_profile = res.data.organization.logo;
                  //   authMember.org_name = res.data.organization.name;
                  // }

                  authMember.referral = res.data.referral_code;

                  localStorage.setItem(
                    "authMember",
                    JSON.stringify(authMember)
                  );
                  this.$toast.success("Login successful");
                  if (this.$route.query.redirect) {
                    window.location.href = this.$route.query.redirect;
                    return;
                  }
                  window.location.href = "/member";
                }
              })
              .catch(() => {
                this.$toast.error("Invalid credentials");
              });
          })
          .catch(() => {
            this.loading = false;
            this.$toast.error("Invalid credentials");
            this.validation = false;
            setTimeout(() => {
              this.validation = null;
            }, 5000);
          });
      }
    },
    socialregister(provider) {
      var url = `${this.$store.getters.url}/auth/${provider}/redirect`;
      window.open(
        url,
        "Social_Login",
        "toolbar=no,scrollbars=no,location=no,statusbar=no,menubar=no,resizable=0,width=100,height=100,left = 490,top = 262"
      );
    },
  },
};
</script>

<style scoped>
#register {
  height: 100vh;
  overflow: hidden;
}

.side {
  background-color: #f4faf8;
  background-position: center;
  background-size: contain;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
}
.my_type {
  width: 70%;
}
img {
  width: 100%;
}
p {
  color: #fff;
  font-size: 17px;
  font-style: normal;
  font-weight: 500;
  line-height: 22px;
  letter-spacing: 0em;
  text-align: left;
}
.logo {
  width: 200px;
  position: absolute;
  top: 50px;
  left: 40px;
}
.centerimg {
  z-index: 2;
}
.rect {
  width: 100%;
  z-index: 1;
}
.circ {
  position: absolute;
  left: -20px;
  bottom: 55px;
  z-index: 1;
}
.user {
  width: 50%;
  padding: 10px 30px;
  margin: 0 auto;
}
.type {
  padding: 8px 5px;
  border-radius: 30px;
  text-align: center;
}
.selected_type {
  background-color: rgba(56, 128, 135, 0.13);
}
.or {
  text-align: center;
  position: relative;
}
.or::before {
  content: "";
  position: absolute;
  border-top: 1px solid #ccc;
  width: 45%;
  height: 5px;
  top: 50%;
  left: 0;
  margin-top: 3.5px;
}
.or::after {
  content: "";
  position: absolute;
  border-top: 1px solid #ccc;
  width: 45%;
  height: 5px;
  top: 50%;
  right: 0;
  margin-top: 3.5px;
}
.socials {
}
.social {
  padding: 15px;
  border-radius: 5px;
  cursor: pointer;
  text-align: center;
}
.social:hover {
  background: #f4faf8;
}
.social img {
  width: 25px;
}
a {
  text-decoration: none;
  color: #04498f;
}
@media (max-width: 600px) {
  #register {
    height: 100%;
    overflow: unset;
  }
  legend {
    font-size: 16px;
  }
  .my_type {
    width: 100%;
  }
  .user {
    width: 100%;
    text-align: left;
    padding: 30px 5px;
  }
  .login {
    font-size: 14;
  }
  .img-l {
    margin-top: 20px;
    width: 150px;
  }
  .type {
    padding: 5px 5px;
  }
  .form-text {
    font-size: 0.8rem;
  }
}
</style>

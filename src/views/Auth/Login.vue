<template>
  <div id="register">
    <b-container fluid class="p-sm-0 h-100">
      <b-row class="h-100">
        <b-col cols="0" sm="3" class="side p-3 p-sm-4 d-none d-sm-flex">
          <b-img
            class="logo cursor-pointer"
            @click="$router.push('/')"
            :src="require('@/assets/images/logo-white.svg')"
          ></b-img>
          <div class="ico text-center p-3">
            <p class="mb-5">
              You are a few Click away from signing up to our platform, get
              access to a whole new world of learning
            </p>
            <div class="position-relative">
              <span class="rect">
                <b-img :src="require('@/assets/images/rect.png')"></b-img>
              </span>
              <span class="circ">
                <b-img :src="require('@/assets/images/eli-white.png')"></b-img>
              </span>
              <b-img
                class="position-relative centerimg"
                :src="require('@/assets/images/sideb.png')"
              ></b-img>
            </div>
          </div>
        </b-col>
        <b-col cols="12" sm="9" class="main p-3 p-sm-4 text-sm-left">
          <div class="d-sm-none position-relative">
            <b-img
              class="img-l cursor-pointer"
              @click="$router.push('/')"
              width="40px"
              src="/img/logo.svg"
            ></b-img>
          </div>
          <b-form @submit.prevent="register" class="user">
            <legend>Register as</legend>
            <b-form-row class="mb-4 my_type">
              <b-col cols="4">
                <div
                  class="type"
                  :class="{ selected_type: type == 'organization' }"
                >
                  <b-form-radio
                    class="reg"
                    size="sm"
                    v-model="type"
                    value="organization"
                    >Organization</b-form-radio
                  >
                </div>
              </b-col>
              <b-col cols="4">
                <div
                  class="type"
                  :class="{ selected_type: type == 'facilitator' }"
                >
                  <b-form-radio
                    class="reg"
                    size="sm"
                    v-model="type"
                    value="facilitator"
                    >Facilitator</b-form-radio
                  >
                </div>
              </b-col>
              <b-col cols="4">
                <div class="type" :class="{ selected_type: type == 'learner' }">
                  <b-form-radio
                    class="reg"
                    size="sm"
                    v-model="type"
                    value="learner"
                    >Learner</b-form-radio
                  >
                </div>
              </b-col>
            </b-form-row>

            <div>
              <b-form-row class="mb-2">
                <b-col class="pr-sm-3">
                  <b-form-group label="Email">
                    <b-form-input
                      size="lg"
                      required
                      v-model="user.email"
                      type="email"
                      placeholder="Enter email address"
                    ></b-form-input>
                  </b-form-group>
                </b-col>
              </b-form-row>
              <b-form-row class="mb-2">
                <b-col cols="12" class="pr-sm-3">
                  <b-form-group label="Password">
                    <b-form-input
                      size="lg"
                      required
                      v-model="user.password"
                      type="password"
                      placeholder="Enter password"
                    ></b-form-input>
                  </b-form-group>
                </b-col>
              </b-form-row>

              <b-form-group>
                <div class="mb-3">
                  <b-button
                    type="submit"
                    variant="dark-green"
                    size="lg"
                    class="px-5 d-none d-sm-block"
                    >Login</b-button
                  >
                  <b-button
                    type="submit"
                    variant="dark-green"
                    size="lg"
                    block
                    class="px-5 d-sm-none"
                    >Login</b-button
                  >
                </div>
              </b-form-group>
            </div>

            <div>
              <div class="or my-4">OR</div>

              <div class="socials mt-3">
                <div
                  class="social mr-4 shadow"
                  @click="socialregister('google')"
                >
                  <b-img :src="require('@/assets/images/gmail.png')"></b-img>
                </div>
                <div
                  class="social mr-4 shadow"
                  @click="socialregister('facebook')"
                >
                  <b-img :src="require('@/assets/images/facebook.png')"></b-img>
                </div>
                <div
                  class="social shadow"
                  @click="$toast.info('Not yet available')"
                >
                  <b-img :src="require('@/assets/images/linkedin.png')"></b-img>
                </div>
              </div>
            </div>
          </b-form>
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
      type: "organization",
      user: {
        name: "",
        email: "",
        phone: "",
        password: "",
        profile: "",
      },
      agree: false,
    };
  },

  methods: {
    getUpload(val) {
      this.user.profile = val;
    },
    register() {
      var authOrg = {};
      var authAdmin = {};

      if (this.type == "organization") {
        let data = {
          grant_type: "password",
          client_id: 5,
          client_secret: "vi8gsfMR9yl4XOJG7tz0AIWN1uF06FpJ1kkxpEvn",
          username: this.user.email,
          password: this.user.password,
        };
        this.$http
          .post(
            "https://skillsguruh-api.herokuapp.com/oauth/token/oauth/token",
            data
          )
          .then((res) => {
            authOrg.access_token = res.data.access_token;
            authOrg.refresh_token = res.data.refresh_token;
            this.$http
              .get(`${this.$store.getters.url}/organization`, {
                headers: {
                  Authorization: `Bearer ${res.data.access_token}`,
                },
              })
              .then((res) => {
                authOrg.id = res.data.id;
                authOrg.name = res.data.name;
                authOrg.email = res.data.name;
                authOrg.profile = res.data.logo;

                localStorage.setItem("authOrg", JSON.stringify(authOrg));
                this.$toast.success("Login successful");
                window.location.href = "/organization";
              })
              .catch((err) => {
                console.log(
                  "🚀 ~ file: Login.vue ~ line 217 ~ .then ~ err",
                  err
                );
                this.$toast.error("Invalid credentials");
              });
          })
          .catch((err) => {
            console.log(
              "🚀 ~ file: Login.vue ~ line 221 ~ register ~ err",
              err
            );
            this.$toast.error("Invalid credentials");
          });
      }
      if (this.type == "facilitator") {
        let data = {
          grant_type: "password",
          client_id: 3,
          client_secret: "fjiWTis9MO1KfJhnR0uVG0UwVL6adxIpp4JbVXdT",
          username: this.user.email,
          password: this.user.password,
        };
        this.$http
          .post("https://skillsguruh-api.herokuapp.com/oauth/token", data)
          .then((res) => {
            authAdmin.access_token = res.data.access_token;
            authAdmin.refresh_token = res.data.refresh_token;
            this.$http
              .get(`${this.$store.getters.url}/admin`, {
                headers: {
                  Authorization: `Bearer ${res.data.access_token}`,
                },
              })
              .then((res) => {
                authAdmin.id = res.data.id;
                authAdmin.name = res.data.name;
                authAdmin.email = res.data.name;
                authAdmin.profile = res.data.profile;
                authAdmin.org_profile = res.data.organization.logo;
                authAdmin.org_name = res.data.organization.name;

                localStorage.setItem("authAdmin", JSON.stringify(authAdmin));
                this.$toast.success("Login successful");

                window.location.href = "/administrator";
              })
              .catch(() => {
                this.$toast.error("Invalid credentials");
              });
          })
          .catch((err) => {
            console.log(
              "🚀 ~ file: Login.vue ~ line 257 ~ register ~ err",
              err
            );
            this.$toast.error("Invalid credentials");
          });
      }
      if (this.type == "learner") {
        this.$http
          .post(`${this.$store.getters.url}/register-user`, this.user)
          .then(() => {})
          .catch((err) => {
            if (err.response.data.errors.email[0]) {
              this.$toast.error(err.response.data.errors.email[0]);
            }
            if (err.response.data.errors.phone[0]) {
              this.$toast.error(err.response.data.errors.phone[0]);
            }
            if (err.response.data.errors.name[0]) {
              this.$toast.error(err.response.data.errors.name[0]);
            }
            if (err.response.data.errors.password[0]) {
              this.$toast.error(err.response.data.errors.password[0]);
            }
          });
      }
    },
    socialregister(provider) {
      window.open(
        `${this.$store.getters.url}/auth/${provider}/redirect`,
        "_blank"
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
  background-image: url("../../assets/images/reg.svg");
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
  width: 70px;
  position: absolute;
  top: 50px;
  left: 40px;
}
.centerimg {
  z-index: 2;
}
.rect {
  position: absolute;
  right: -32px;
  top: 20px;
  z-index: 1;
}
.circ {
  position: absolute;
  left: -20px;
  bottom: 55px;
  z-index: 1;
}
.user {
  width: 80%;
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
  display: flex;
  justify-content: center;
}
.social {
  padding: 10px;
  border-radius: 5px;
  cursor: pointer;
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
    width: 100px;
  }
  .type {
    padding: 5px 5px;
  }
}
</style>

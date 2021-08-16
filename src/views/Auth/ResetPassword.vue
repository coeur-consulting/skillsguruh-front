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

            <h3 class="mt-4">Reset Password</h3>
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
              <legend class="mb-5">Request a password reset link</legend>

              <div>
                <b-form-row class="mb-2">
                  <b-col cols="12" class="pr-sm-3">
                    <b-form-group
                      label="New Password"
                      id="password"
                      label-for="password"
                      valid-feedback="Looks good"
                      :invalid-feedback="InvalidFeedback"
                      :state="verifypassword"
                    >
                      <b-input-group>
                        <b-form-input
                          required
                          min="6"
                          v-model="user.password"
                          name="password"
                          :state="verifypassword"
                          :type="toggleEye ? 'text' : 'password'"
                          placeholder="Enter new password "
                          aria-describedby="password-feedback"
                        ></b-form-input>
                      </b-input-group>
                    </b-form-group>
                  </b-col>

                  <b-col cols="12" class="pr-sm-3">
                    <b-form-group
                      label="Confirm Password"
                      id="confirmpassword"
                      label-for="confirmpassword"
                      valid-feedback="Looks good"
                      :invalid-feedback="InvalidFeedback"
                      :state="verifypassword"
                    >
                      <b-input-group>
                        <b-form-input
                          required
                          min="6"
                          v-model="user.confirmpassword"
                          name="password"
                          :state="verifypassword"
                          :type="toggleEye ? 'text' : 'password'"
                          placeholder="Confirm new password "
                          aria-describedby="password-feedback"
                        ></b-form-input>
                      </b-input-group>
                    </b-form-group>
                    <b-form-group>
                      <b-form-checkbox size="sm" v-model="toggleEye"
                        >Show Password</b-form-checkbox
                      >
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
                      <span class="fs16">Reset password</span>
                      <b-icon
                        icon="three-dots"
                        v-if="loading"
                        animation="cylon"
                        class="ml-3"
                        font-scale="1.5"
                      ></b-icon
                    ></b-button>
                  </div>
                </b-form-group>
              </div>
              <div class="form-text mb-4 text-center text-md-left">
                You have an account?
                <span
                  class="text-secondary cursor-pointer"
                  @click="$router.push('/login')"
                  >Log In</span
                >
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
  name: "forgot-password-component",

  data() {
    return {
      loading: false,
      toggleEye: false,

      user: {
        password: "",
        confirmpassword: "",
        token: this.$route.query.token,
      },
    };
  },
  computed: {
    InvalidFeedback() {
      if (this.user.password.length < 6) {
        return "Enter at least 6 characters.";
      }
      if (this.user.password !== this.user.confirmpassword) {
        return "Password must match.";
      }
      return "Please enter something.";
    },
    verifypassword() {
      if (
        this.user.confirmpassword.length >= 6 &&
        this.user.password.length >= 6
      ) {
        var result =
          this.user.password === this.user.confirmpassword ? true : false;
        return result;
      }
      return null;
    },
  },

  methods: {
    register() {
      if (!this.verifypassword) {
        this.$toast.error("Check password");
        return;
      }
      this.loading = true;

      this.$http
        .post(`${this.$store.getters.url}/reset-password`, this.user)
        .then((res) => {
          if (res.status === 200) {
            console.log(
              "🚀 ~ file: ResetPassword.vue ~ line 192 ~ .then ~ res.data.message",
              res.data.message
            );
            if (res.data.message == "identical password") {
              this.$toast.info("New password cannot be same with old password");
              this.loading = false;
              return;
            }
            this.$toast.success("Password reset successful");
            this.$router.push("/login");
            this.loading = false;
          }
        })
        .catch(() => {
          this.loading = false;
        });
    },
  },
};
</script>

<style scoped>
#register {
  height: 100vh;
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

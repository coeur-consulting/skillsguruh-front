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
            <h3 class="mt-4">Forgot password?</h3>
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
          <div class="shadow rounded p-4 p-sm-5 bg-white w-100">
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
                  <b-col class="pr-sm-3">
                    <b-form-group label="Email" id="email" label-for="email">
                      <b-form-input
                        size="lg"
                        required
                        v-model="user.email"
                        name="email"
                        type="email"
                        placeholder="Enter email address"
                        aria-describedby="email-feedback"
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
                      block
                      :disabled="loading"
                      class="px-5 d-flex justify-content-center"
                    >
                      <span class="fs16">Request link</span>
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

      user: {
        email: "",
        type: "user",
      },
    };
  },

  methods: {
    register() {
      this.loading = true;

      this.$http
        .post(`${this.$store.getters.url}/forgot-password`, this.user)
        .then((res) => {
          if (res.status === 200) {
            if (res.data.message == "email not found") {
              this.$toast.error("Email not found!");
              return;
            }
            this.$toast.info("We have sent a link to your mail!");
            this.user.email = "";
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
  text-align: center;
  background-image: url("/img/auth.png");
  background-position: center;
  background-size: cover;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  color: white;
}

h2 {
  font-weight: 600;
  line-height: 1.4;
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
  .main {
    background-image: url("/img/auth.png");
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

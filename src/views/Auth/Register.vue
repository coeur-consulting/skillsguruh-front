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

            <h3 class="mt-4">
              {{ type ? "Facilitator" : "Member" }} Registration
            </h3>
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
          <div class="shadow rounded p-4 p-sm-4 h-100 w-100 reg_page">
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
                Sign up to
                <span class="font-weight-bold text-dark-green">Nzukoor</span>
              </legend>
              <div class="form-text mb-4">
                Already a member?
                <span
                  class="text-secondary cursor-pointer"
                  @click="$router.push('/login')"
                  >Log in</span
                >
              </div>
              <div>
                <b-form-row class="mb-2">
                  <b-col sm="12">
                    <b-form-group label="Full name" id="name" label-for="name">
                      <b-form-input
                        v-model="user.name"
                        placeholder="Enter your full name"
                        :state="validateState('name')"
                        name="name"
                        aria-describedby="name-feedback"
                      ></b-form-input>
                      <b-form-invalid-feedback id="name-feedback"
                        >Full name is required
                      </b-form-invalid-feedback>
                      <b-form-valid-feedback id="name-feedback"
                        >Looks good
                      </b-form-valid-feedback>
                    </b-form-group>
                  </b-col>
                </b-form-row>
                <b-form-row class="mb-2">
                  <b-col sm="6">
                    <b-form-group label="Email" id="email" label-for="email">
                      <b-form-input
                        v-model="user.email"
                        autocomplete="off"
                        type="email"
                        name="email"
                        :state="validateState('email')"
                        placeholder="Enter your email address"
                        aria-describedby="email-feedback"
                      ></b-form-input>
                      <b-form-invalid-feedback id="email-feedback"
                        >Valid email is required
                      </b-form-invalid-feedback>
                      <b-form-valid-feedback id="email-feedback"
                        >Looks good
                      </b-form-valid-feedback>
                    </b-form-group>
                  </b-col>
                  <b-col sm="6">
                    <b-form-group label="Username">
                      <b-form-input
                        autocomplete="off"
                        v-model="user.username"
                        type="text"
                        :required="!type"
                        placeholder="Your unique username"
                      ></b-form-input>
                    </b-form-group>
                  </b-col>
                  <b-col sm="6">
                    <b-form-group label="Phone" id="phone" label-for="phone">
                      <b-form-input
                        autocomplete="off"
                        v-model="user.phone"
                        type="tel"
                        name="phone"
                        :state="validateState('phone')"
                        aria-describedby="phone-feedback"
                        placeholder="Enter phone number"
                      ></b-form-input>
                      <b-form-invalid-feedback id="phone-feedback"
                        >Valid phone is required and length must be 11 or more
                      </b-form-invalid-feedback>
                      <b-form-valid-feedback id="phone-feedback"
                        >Looks good
                      </b-form-valid-feedback>
                    </b-form-group>
                  </b-col>
                  <b-col sm="6">
                    <b-form-group
                      label="Password"
                      id="password"
                      label-for="password"
                    >
                      <b-form-input
                        v-model="user.password"
                        type="password"
                        autocomplete="off"
                        name="password"
                        :state="validateState('password')"
                        placeholder="Enter password"
                        aria-describedby="password-feedback"
                      ></b-form-input>
                      <b-form-invalid-feedback id="password-feedback"
                        >Password is required and length must be more than 3
                      </b-form-invalid-feedback>
                      <b-form-valid-feedback id="password-feedback"
                        >Looks good
                      </b-form-valid-feedback>
                    </b-form-group>
                  </b-col>
                </b-form-row>

                <b-form-row class="mb-2">
                  <b-col sm="6">
                    <div class="form-group">
                      <label for="">
                        {{
                          type == "organization" ? "Logo" : "Profile image"
                        }}</label
                      >

                      <Upload @getUpload="getUpload" />
                    </div>
                  </b-col>
                  <b-col sm="6">
                    <b-form-group label="Referral code(optional)">
                      <b-form-input
                        v-model="user.referral"
                        type="tel"
                        placeholder="Do you have a referral code?"
                      ></b-form-input>
                    </b-form-group>
                  </b-col>
                </b-form-row>

                <b-form-group>
                  <div class="mb-3 mt-4">
                    <div class="form-text">
                      <span
                        ><b-form-checkbox
                          :state="validateState('agree')"
                          v-model="user.agree"
                          name="agree"
                          aria-describedby="agree-feedback"
                          >I agree to the
                          <router-link to="">Terms</router-link> and
                          <router-link to=""
                            >Privacy Policy</router-link
                          ></b-form-checkbox
                        >
                      </span>
                    </div>
                    <b-form-invalid-feedback id="agree-feedback"
                      >Agreement is required
                    </b-form-invalid-feedback>
                    <b-form-valid-feedback id="agree-feedback"
                      >Looks good
                    </b-form-valid-feedback>
                  </div>
                  <div class="mb-3">
                    <b-button
                      type="submit"
                      variant="dark-green"
                      block
                      :disabled="loading"
                      class="px-5"
                      >Create Account
                      <b-icon
                        icon="three-dots"
                        v-if="loading"
                        animation="cylon"
                        class=""
                        font-scale="1.5"
                      ></b-icon
                    ></b-button>
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
                    Sign up with Google
                  </div>
                  <div
                    class="social shadow-sm border btn-shado"
                    @click="socialregister('facebook')"
                  >
                    <b-img
                      :src="require('@/assets/images/auth/face.png')"
                      class="mr-2"
                    ></b-img>
                    Sign up with Facebook
                  </div>
                </div>
              </div>
              <div class="text-center mt-4">
                <span
                  v-if="type == false"
                  class="text-secondary cursor-pointer"
                  @click="type = true"
                >
                  I want to be a Facilitator
                </span>
                <span
                  v-else
                  class="text-secondary cursor-pointer"
                  @click="type = false"
                >
                  I want to be a Member
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
import { validationMixin } from "vuelidate";
import { integer, email, required, minLength } from "vuelidate/lib/validators";

import Upload from "@/components/UploadComponent";

export default {
  name: "register-component",
  mixins: [validationMixin],
  data() {
    return {
      type: false,
      loading: false,
      user: {
        name: "",
        email: "",
        phone: "",
        password: "",
        profile: "",
        referral: "",
        referral_type: "",
        agree: null,
        username: "",
      },
    };
  },
  mounted() {
    if (this.$route.query.invite) {
      this.user.referral = this.$route.query.invite;
      this.user.referral_type = "normal";
    }
  },
  components: {
    Upload,
  },
  validations: {
    user: {
      agree: { required },
      name: { required, minLength: minLength(3) },
      phone: { required, minLength: minLength(11), integer },
      email: {
        required,
        email,
      },
      password: {
        required,
        minLength: minLength(3),
      },
    },
  },
  methods: {
    validateState(name) {
      const { $dirty, $error } = this.$v.user[name];
      return $dirty ? !$error : null;
    },
    getUpload(val) {
      this.user.profile = val;
    },
    register() {
      this.$v.user.$touch();
      if (this.$v.user.$anyError) {
        return;
      }

      if (this.user.agree) {
        this.loading = true;
        // if (this.type == "organization") {
        //   this.$http
        //     .post(`${this.$store.getters.url}/register-organization`, this.user)
        //     .then((res) => {
        //       if (res.status == 201) {
        //         this.$toast.success("Registration successful");
        //         this.$router.push("/login");
        //         this.user = {
        //           name: "",
        //           email: "",
        //           phone: "",
        //           password: "",
        //           profile: "",
        //         };
        //       }
        //     })
        //     .catch((err) => {
        //       this.loading = false;
        //       if (err.response.data.errors.email) {
        //         this.$toast.error(err.response.data.errors.email[0]);
        //       }
        //       if (err.response.data.errors.phone) {
        //         this.$toast.error(err.response.data.errors.phone[0]);
        //       }
        //       if (err.response.data.errors.name) {
        //         this.$toast.error(err.response.data.errors.name[0]);
        //       }
        //       if (err.response.data.errors.password) {
        //         this.$toast.error(err.response.data.errors.password[0]);
        //       }
        //     });
        // }
        if (this.type) {
          this.$http
            .post(`${this.$store.getters.url}/facilitator-register`, this.user)
            .then((res) => {
              if (res.status == 201) {
                this.$toast.success("Registration successful");
                this.$router.push("/login");
                this.user = {
                  name: "",
                  email: "",
                  phone: "",
                  password: "",
                  profile: "",
                };
              }
            })
            .catch((err) => {
              this.loading = false;
              if (err.response.data.errors.email) {
                this.$toast.error(err.response.data.errors.email[0]);
              }
              if (err.response.data.errors.phone) {
                this.$toast.error(err.response.data.errors.phone[0]);
              }
              if (err.response.data.errors.name) {
                this.$toast.error(err.response.data.errors.name[0]);
              }
              if (err.response.data.errors.password) {
                this.$toast.error(err.response.data.errors.password[0]);
              }
            });
        }
        if (!this.type) {
          this.$http
            .post(`${this.$store.getters.url}/user-register`, this.user)
            .then((res) => {
              if (res.status == 201) {
                this.$toast.success("Registration successful");
                if (this.$route.query.course_id) {
                  this.$router.push(
                    `/login/?course_id=${this.$route.query.course_id}`
                  );
                } else {
                  this.$router.push("/login");
                }

                this.user = {
                  name: "",
                  email: "",
                  phone: "",
                  password: "",
                  profile: "",
                };
              }
            })
            .catch((err) => {
              this.loading = false;
              if (err.response.data.errors.email) {
                this.$toast.error(err.response.data.errors.email[0]);
              }
              if (err.response.data.errors.phone) {
                this.$toast.error(err.response.data.errors.phone[0]);
              }
              if (err.response.data.errors.name) {
                this.$toast.error(err.response.data.errors.name[0]);
              }
              if (err.response.data.errors.password) {
                this.$toast.error(err.response.data.errors.password[0]);
              }
            });
        }
      } else {
        this.$toast.info("Click to agree");
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
.reg_page {
  max-height: 85vh;
  overflow-y: auto;
}
::placeholder {
  font-size: 0.7rem;
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
  .reg_page {
    max-height: 95vh;
    overflow-y: auto;
  }
}
</style>

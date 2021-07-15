<template>
  <b-container fluid class="p-0 bg-white">
    <b-row class="h-100">
      <b-col sm="3" class="border-right text-left p-3">
        <div
          class="mb-3 px-2 fs14 cursor-pointer d-flex align-items-center"
          :class="{ 'font-weight-bold': type == 'edit' }"
          @click="type = 'edit'"
        >
          <span class="flex-1">
            <b-icon class="mr-2" icon="pencil"></b-icon
            ><span class="">Edit Profile</span></span
          >
          <b-icon v-if="type == 'edit'" icon="chevron-right"></b-icon>
        </div>
        <div
          class="mb-3 px-2 cursor-pointer d-flex fs14"
          @click="type = 'notification'"
          :class="{ 'font-weight-bold': type == 'notification' }"
        >
          <span class="flex-1">
            <b-icon class="mr-2" icon="bell"></b-icon>
            <span class="">Notifications</span>
          </span>
          <b-icon v-if="type == 'notification'" icon="chevron-right"></b-icon>
        </div>
        <div
          class="mb-3 px-2 cursor-pointer d-flex fs14"
          @click="type = 'request'"
          :class="{ 'font-weight-bold': type == 'request' }"
        >
          <span class="flex-1">
            <b-icon class="mr-2" icon="info-circle"></b-icon>
            <span class="mr-1">Requests</span>
            <b-icon
              v-if="requests.filter((item) => !item.response)"
              class=""
              variant="danger"
              font-scale=".4"
              icon="circle-fill"
            ></b-icon>
          </span>
          <b-icon v-if="type == 'request'" icon="chevron-right"></b-icon>
        </div>
        <div
          class="mb-3 px-2 cursor-pointer d-flex fs14"
          @click="type = 'preference'"
          :class="{ 'font-weight-bold': type == 'preference' }"
        >
          <span class="flex-1">
            <b-icon class="mr-2" icon="nut"></b-icon>
            <span class="">Preferences</span>
          </span>
          <b-icon v-if="type == 'preference'" icon="chevron-right"></b-icon>
        </div>
        <div
          class="px-2 fs14 cursor-pointer d-flex"
          :class="{ 'font-weight-bold': type == 'security' }"
          @click="type = 'security'"
        >
          <span class="flex-1">
            <b-icon class="mr-2" icon="shield"></b-icon>
            <span>Password & Security </span></span
          >
          <b-icon v-if="type == 'security'" icon="chevron-right"></b-icon>
        </div>
      </b-col>
      <b-col sm="9" class="sideB">
        <div class="p-4" v-if="type == 'edit'">
          <div class="mb-5">
            <Upload @getUpload="getUpload" :id="'avatar'">
              <b-avatar
                badge-variant="dark-green"
                size="7rem"
                :src="user.profile"
              >
                <template #badge><b-icon icon="pencil"></b-icon></template>
              </b-avatar>
            </Upload>
          </div>
          <b-form class="text-left" @submit.prevent="updateuser">
            <b-form-row>
              <b-col sm="6">
                <b-form-group label="Name">
                  <b-form-input v-model="user.name"></b-form-input
                ></b-form-group>
              </b-col>
              <b-col sm="6">
                <b-form-group label="Email">
                  <b-form-input
                    type="email"
                    v-model="user.email"
                  ></b-form-input></b-form-group
              ></b-col>
            </b-form-row>
            <b-form-row>
              <b-col sm="6">
                <b-form-group label="Age">
                  <b-form-input v-model="user.age" type="number"></b-form-input
                ></b-form-group>
              </b-col>
              <b-col sm="6">
                <b-form-group label="Gender">
                  <b-form-select v-model="user.gender">
                    <b-form-select-option value="male"
                      >Male</b-form-select-option
                    >
                    <b-form-select-option value="female"
                      >Female</b-form-select-option
                    >
                  </b-form-select></b-form-group
                ></b-col
              >
            </b-form-row>
            <b-form-row>
              <b-col sm="6">
                <b-form-group label="State">
                  <b-form-input v-model="user.state"></b-form-input
                ></b-form-group>
              </b-col>
              <b-col sm="6">
                <b-form-group label="Country">
                  <b-form-select v-model="user.country">
                    <b-form-select-option value="NG"
                      >Nigeria</b-form-select-option
                    >
                  </b-form-select>
                </b-form-group></b-col
              >
            </b-form-row>
            <b-form-row>
              <b-col sm="6">
                <b-form-group label="Phone">
                  <b-form-input v-model="user.phone"></b-form-input
                ></b-form-group>
              </b-col>
              <b-col sm="6">
                <b-form-group label="Referral Code">
                  <b-form-input
                    readonly
                    v-model="user.referral_code"
                  ></b-form-input></b-form-group
              ></b-col>
            </b-form-row>
            <div>
              <b-button variant="dark-green" type="submit" class="px-5 mt-4"
                >Save</b-button
              >
            </div>
          </b-form>
        </div>

        <div v-if="type == 'notification'" class="p-4">
          <div class="notif text-left pt-4">
            <h5 class="font-weight-bold mb-4">Notifications</h5>

            <div
              class="d-flex mb-3 border bg-light p-3 rounded"
              v-for="item in notifications"
              :key="item.id"
            >
              <b-icon
                variant="dark-green"
                icon="bell-fill"
                class="mr-2 mt-1"
              ></b-icon>
              <span> {{ item.data.notification }}</span>
            </div>
          </div>
        </div>
        <div v-if="type == 'security'" class="p-4">
          <div class="pt-5 text-left password">
            <b-form @submit.prevent="updatepassword">
              <b-form-group label="Old Passoword">
                <b-form-input
                  v-model="detail.old_password"
                  type="password"
                  placeholder="Enter old Password"
                  required
                ></b-form-input>
              </b-form-group>
              <b-form-group label="New Password">
                <b-form-input
                  type="password"
                  v-model="detail.new_password"
                  placeholder="Enter new Password"
                  required
                ></b-form-input>
              </b-form-group>

              <div class="my-3">
                <b-button variant="dark-green" type="submit" class="px-5"
                  >Update password</b-button
                >
              </div>
            </b-form>
          </div>
        </div>

        <div v-if="type == 'preference'" class="p-4">
          <div class="pt-5 text-left preference">
            <Interest :user="$store.getters.learner" :type="'learner'" />
          </div>
        </div>
        <div v-if="type == 'request'" class="p-4">
          <div class="notif text-left pt-4">
            <h5 class="font-weight-bold mb-4">Requests</h5>

            <div class="d-flex mb-3" v-for="item in requests" :key="item.id">
              <b-icon
                variant="dark-green"
                icon="bell-fill"
                class="mr-2 mt-1"
              ></b-icon>
              <div class="d-flex justify-content-between">
                <p class="mb-0">{{ item.body }} -</p>
                <div class="d-flex text-right" v-if="!item.response">
                  <span>
                    <b-button
                      v-b-tooltip.hover
                      title="Accept request"
                      class="mr-3 fs11"
                      variant="lighter-green"
                      size="sm"
                      @click="accept(item)"
                      ><b-icon icon="check2-circle"></b-icon></b-button
                  ></span>
                  <span>
                    <b-button
                      v-b-tooltip.hover
                      title="Reject request"
                      class="fs11"
                      size="sm"
                      @click="reject(item)"
                      ><b-icon icon="x-circle-fill"></b-icon></b-button
                  ></span>
                </div>
                <div v-else class="text-capitalize text-muted">
                  {{ item.response }}
                </div>
              </div>
            </div>
          </div>
        </div>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import Upload from "../fileupload";
import Interest from "../InterestComponent";
export default {
  data() {
    return {
      type: "edit",
      user: {},
      requests: [],
      detail: {
        old_password: "",
        new_password: "",
      },
    };
  },
  components: {
    Upload,
    Interest,
  },
  mounted() {
    this.getuser();
    this.getrequests();
  },
  computed: {
    notifications() {
      return this.$store.getters.notifications;
    },
  },
  methods: {
    getrequests() {
      this.$http
        .get(`${this.$store.getters.url}/discussion/requests`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          this.requests = res.data;
        });
    },
    accept(item) {
      this.$http
        .post(`${this.$store.getters.url}/discussion/private`, item, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then(() => {
          this.getrequests();
        });
    },
    reject(item) {
      this.$http
        .post(`${this.$store.getters.url}/discussion/reject`, item, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then(() => {
          this.getrequests();
        });
    },
    getUpload(val) {
      this.user.profile = val;
      this.updateuser();
    },
    getuser() {
      this.$http
        .get(
          `${this.$store.getters.url}/users/${this.$store.getters.learner.id}`,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.user = res.data;
          }
        });
    },
    updateuser() {
      this.$http
        .put(`${this.$store.getters.url}/users/${this.user.id}`, this.user, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.user = res.data;
            var authLearner = JSON.parse(localStorage.getItem("authLearner"));
            authLearner.profile = res.data.profile;
            localStorage.setItem("authLearner", JSON.stringify(authLearner));
            this.$toast.success("Updated successfully");
          }
        });
    },
    updatepassword() {
      this.$http
        .post(`${this.$store.getters.url}/update-password`, this.detail, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            if (res.data.message == "success") {
              this.$toast.success("Password updated");
              return;
            }
            this.$toast.error(res.data.message);
          }
        });
    },
  },
};
</script>

<style scoped>
.container-fluid {
  height: calc(100vh - 85px);
  overflow: hidden;
}
.edit_button {
  bottom: 10px;
  right: 0;
}
.password {
  width: 60%;
  margin: 0 auto;
}

.notif {
  width: 80%;
  margin: 0 auto;
}
.preference {
  max-height: 80vh;
  overflow: scroll;
}
</style>

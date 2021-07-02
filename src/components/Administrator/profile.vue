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
      <b-col sm="9">
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
                  <b-form-input
                    type="text"
                    v-model="user.country"
                  ></b-form-input></b-form-group
              ></b-col>
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
              class="d-flex mb-3 align-items-center border bg-light p-3 rounded"
              v-for="item in notifications"
              :key="item.id"
            >
              <b-icon variant="dark-green" icon="bell" class="mr-2"></b-icon>
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
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import Upload from "../fileupload";
export default {
  data() {
    return {
      type: "edit",
      user: {},
      detail: {
        old_password: "",
        new_password: "",
      },
    };
  },
  components: {
    Upload,
  },
  mounted() {
    this.getuser();
  },
  computed: {
    notifications() {
      return this.$store.getters.notifications;
    },
  },
  methods: {
    getUpload(val) {
      this.user.profile = val;
      this.updateuser();
    },
    getuser() {
      this.$http
        .get(`${this.$store.getters.url}/admin`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.user = res.data;
          }
        });
    },
    updateuser() {
      this.$http
        .put(`${this.$store.getters.url}/admins/${this.user.id}`, this.user, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.user = res.data;
            var authAdmin = JSON.parse(localStorage.getItem("authAdmin"));
            authAdmin.profile = res.data.profile;
            localStorage.setItem("authAdmin", JSON.stringify(authAdmin));
            this.$toast.success("Updated successfully");
          }
        });
    },
    updatepassword() {
      this.$http
        .post(`${this.$store.getters.url}/update-password`, this.detail, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
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
  height: calc(100vh - 120px);
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
</style>

<template>
  <b-container class="py-5 px-3 text-left">
    <b-row>
      <b-col sm="7">
        <div class="box p-4 mb-4">
          <h6 class="font-weight-bold mb-4">Invite Friends and Earn Points</h6>

          <div class="mb-3">
            <b-row class="">
              <b-col cols="4">
                <b-img :src="require('@/assets/images/bonus.png')"></b-img
              ></b-col>
              <b-col cols="8">
                <p>
                  Refer your friends to skillsguruh and earn bonus point we also
                  give your friends bonus because we value your friendship
                </p>
                <b-form
                  class="text-center p-3 mb-4"
                  @submit.prevent="sendInvite"
                >
                  <div
                    class="px-3 py-2 d-flex align-items-center search bg-light mb-3"
                  >
                    <b-icon icon="envelope"></b-icon>
                    <b-form-input
                      autocomplete="off"
                      autocorrect="off"
                      size="sm"
                      class="flex-1 border-0 no-focus search-bg"
                      type="search"
                      required
                      v-model="email"
                      placeholder="Enter an email address"
                    ></b-form-input>
                  </div>
                  <b-button variant="dark-green" type="submit">Invite</b-button>
                </b-form>

                <div>
                  <b-row class="justify-content-center">
                    <div class="mr-4">
                      <b-img
                        width="40"
                        :src="require('@/assets/images/twitter.png')"
                      ></b-img>
                    </div>
                    <div class="mr-4">
                      <b-img
                        width="40"
                        :src="require('@/assets/images/linked.png')"
                      ></b-img>
                    </div>
                    <div class="mr-4">
                      <b-img
                        width="40"
                        :src="require('@/assets/images/fb.png')"
                      ></b-img>
                    </div>
                    <div>
                      <b-img
                        width="40"
                        :src="require('@/assets/images/google.png')"
                      ></b-img>
                    </div>
                  </b-row>
                </div>
              </b-col>
            </b-row>
          </div>
        </div>

        <div class="box p-3 text-center mb-4">
          <div class="mb-3 border px-4 py-2 rounded-pill d-flex text-muted">
            <b-icon icon="link45deg" font-scale="1.5rem"></b-icon>
            <b-form-input
              v-model="message"
              readonly
              class="text-align flex-1 rounded-pill no-focus fs13"
            >
            </b-form-input>
          </div>
          <div>
            <b-button
              variant="lighter-green"
              type="button"
              v-clipboard:copy="message"
              v-clipboard:success="onCopy"
              v-clipboard:error="onError"
              class="rounded px-4"
              >Copy link</b-button
            >
          </div>
        </div>

        <div class="box text-left">
          <h6 class="mb-4 py-2 px-3">Course Referral List</h6>
          <b-table-simple class="border-top-0">
            <b-thead class="border-0">
              <b-tr>
                <b-th class="fs14">Course</b-th>
                <b-th class="fs14">Referral link</b-th>
              </b-tr>
            </b-thead>
            <b-tbody>
              <b-tr v-for="item in communities_link" :key="item.id">
                <b-td class="fs13">{{ item.course.title }}</b-td>
                <b-td
                  class="fs13 cursor-copy"
                  v-clipboard:copy="
                    `https://skillsguruh.herokuapp.com/register/?referral_code=${item.code}`
                  "
                  v-clipboard:success="onCopy"
                  >{{
                    `https://skillsguruh.herokuapp.com/register/?referral_code=${item.code}`
                  }}</b-td
                >
              </b-tr>
            </b-tbody>
          </b-table-simple>
        </div>
      </b-col>
      <b-col sm="5">
        <div class="box">
          <h6 class="mb-4 py-2 px-3">Referral List</h6>

          <b-table-simple v-if="referrals.length">
            <b-thead>
              <b-tr>
                <b-th class="fs14">Name</b-th>
                <b-th class="fs14">Earning</b-th>
              </b-tr>
            </b-thead>
            <b-tbody>
              <b-tr v-for="item in referrals" :key="item.id">
                <b-td class="text-capitalize">{{
                  item.learner_detail.name
                }}</b-td>
                <b-td class="fs14">NGN 10.00</b-td>
              </b-tr>
              <b-tr>
                <b-td>Total earnings</b-td>
                <b-td class="text-dark-green font-weight-bold fs14">
                  NGN {{ referrals.length * 10 }}.00</b-td
                >
              </b-tr>
            </b-tbody>
          </b-table-simple>
        </div>
      </b-col>
    </b-row>
  </b-container>
</template>
<script>
export default {
  data() {
    return {
      referrals: [],
      email: "",
      message: `https://skillsguruh.herokuapp.com/register/?referral_code=${this.$store.getters.learner.referral}`,
      communities_link: [],
    };
  },
  mounted() {
    this.getreferrals();
    this.getcommunity();
    this.message = `https://skillsguruh.herokuapp.com/register/?referral_code=${this.$store.getters.learner.referral}`;
  },
  methods: {
    getreferrals() {
      this.$http
        .get(`${this.$store.getters.url}/referrals`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.referrals = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getcommunity() {
      this.$http
        .get(`${this.$store.getters.url}/add-community`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.communities_link = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    sendInvite() {
      var data = {
        email: this.email,
        code: this.$store.getters.learner.referral,
      };
      this.$http
        .post(`${this.$store.getters.url}/send-referral`, data, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Invite sent");
            this.email = "";
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    onCopy: function (e) {
      alert("You just copied the following text to the clipboard: " + e.text);
    },
    onError: function (e) {
      alert("Failed to copy the text to the clipboard");
      console.log(e);
    },
  },
};
</script>
<style scoped>
.box {
  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
  border-radius: 8px;
  background: white;
}
.search {
  background: #fbfbfb;
  border-radius: 8px;
}
.search-bg {
  background: #fbfbfb;
}
.connection_box {
  height: 50vh;
  overflow: auto;
}
.suggestion_box {
  max-height: 40vh;
  overflow: auto;
}
</style>

<template>
  <b-container class="py-5 px-3 text-left">
    <b-row>
      <b-col sm="7" v-if="showRef">
        <div class="box p-4 mb-4">
          <h6 class="mb-4">Invite Friends and Earn Points</h6>

          <div class="mb-3">
            <b-row class="mb-3">
              <b-col class="text-center">
                <b-img
                  class="img-s"
                  :src="require('@/assets/images/bonus.png')"
                ></b-img
              ></b-col>
              <b-col>
                <p>
                  Refer your friends to nzukoor and earn bonus point we also
                  give your friends bonus because we value your friendship
                </p>
                <b-form
                  class="text-center p-3 mb-4"
                  @submit.prevent="sendInvite"
                >
                  <div>
                    <div
                      v-for="(item, id) in inviteUsers.users"
                      :key="id"
                      class="mb-1 text-center"
                    >
                      <div
                        class="
                          px-3
                          py-2
                          d-flex
                          align-items-center
                          search
                          bg-light
                          mb-3
                        "
                      >
                        <b-icon icon="envelope"></b-icon>
                        <b-form-input
                          autocomplete="off"
                          autocorrect="off"
                          size="sm"
                          class="flex-1 border-0 no-focus search-bg"
                          type="search"
                          required
                          v-model="item.email"
                          placeholder="Enter an email address"
                        ></b-form-input>
                        <b-icon
                          v-if="inviteUsers.users.length > 1"
                          icon="x"
                          font-scale="1.4"
                          class="ml-2"
                          @click="inviteUsers.users.splice(id, 1)"
                        ></b-icon>
                      </div>
                    </div>
                    <div class="text-center mt-3">
                      <b-button
                        size="sm"
                        class="mr-3"
                        variant="lighter-green"
                        @click="addinvite"
                      >
                        <b-icon icon="plus" font-scale="1.4"></b-icon> Add
                        email</b-button
                      >
                      <b-button size="sm" variant="dark-green" type="submit">
                        Send Invite
                      </b-button>
                    </div>
                  </div>
                </b-form>

                <div class="d-none d-md-block">
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
            <div class="p-3 text-center mb-4">
              <div
                class="px-3 py-2 d-flex align-items-center search bg-light mb-3"
              >
                <b-icon icon="link45deg" font-scale="1.5rem"></b-icon>
                <b-form-input
                  v-model="message"
                  readonly
                  class="flex-1 border-0 no-focus search-bg"
                >
                </b-form-input>
              </div>
              <div>
                <b-button
                  size="sm"
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
          </div>
        </div>
      </b-col>
      <b-col sm="7" v-else class="p-5">
        <div class="d-flex w-100 mb-3 box">
          <div class="mr-2">
            <b-skeleton type="avatar"></b-skeleton>
          </div>
          <div class="w-100">
            <div class="mb-3">
              <b-skeleton-img no-aspect height="150px"></b-skeleton-img>
            </div>
            <b-skeleton animation="wave" width="85%"></b-skeleton>
            <b-skeleton animation="wave" width="35%"></b-skeleton>
          </div>
        </div>

        <div class="d-flex w-100 mb-3">
          <div class="mr-2 mb-3">
            <b-skeleton type="avatar"></b-skeleton>
          </div>
          <div class="w-100">
            <div class="mb-3">
              <b-skeleton-img no-aspect height="150px"></b-skeleton-img>
            </div>
            <b-skeleton animation="wave" width="85%"></b-skeleton>
            <b-skeleton animation="wave" width="35%"></b-skeleton>
          </div>
        </div>
      </b-col>
      <b-col sm="5">
        <div class="box">
          <h5 class="py-2 px-3">Referral List</h5>
          <div class="" v-if="showReferral">
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
                    item.member_detail.username
                  }}</b-td>
                  <b-td class="fs14">200 points</b-td>
                </b-tr>
                <b-tr>
                  <b-td>Total earnings</b-td>
                  <b-td class="text-dark-green fs14">
                    {{ referrals.length * 200 }} points</b-td
                  >
                </b-tr>
              </b-tbody>
            </b-table-simple>

            <h6 v-else class="text-center text-muted">No Data Available</h6>
          </div>

          <div v-else>
            <b-skeleton-table
              :rows="3"
              :columns="2"
              :table-props="{ bordered: true, striped: true }"
            ></b-skeleton-table>
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
      showCommunity: false,
      showReferral: false,
      showRef: false,
      inviteUsers: {
        code: "",
        users: [
          {
            email: "",
          },
        ],
      },
      referrals: [],
      email: "",
      message: `https://nzukoor.com/invite/${this.$store.getters.admin.referral}`,
      communities_link: [],
    };
  },
  mounted() {
    this.getreferrals();
    this.getcommunity();
    this.message = `https://nzukoor.com/invite/${this.$store.getters.admin.referral}`;
  },
  methods: {
    addinvite() {
      this.inviteUsers.users.push({
        email: "",
      });
    },
    getreferrals() {
      this.$http
        .get(`${this.$store.getters.url}/referrals`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.referrals = res.data;
            this.showReferral = true;
            this.showRef = true;
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
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.communities_link = res.data;
            this.showCommunity = true;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    sendInvite() {
      var data = {
        emails: this.inviteUsers.users,
        code: this.$store.getters.administrator.referral,
      };
      this.$http
        .post(`${this.$store.getters.url}/send-referral`, data, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
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
  /* box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important; */
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
@media (max-width: 600px) {
  h4.card-title {
    font-size: 0.9rem;
  }
  p {
    font-size: 0.8rem;
    text-align: center;
  }
  nav ul li {
    font-size: 12px !important;
  }
  .btn-sm,
  .btn-group-sm > .btn {
    padding: 0.2rem 0.5rem;
    font-size: 0.5rem !important;
    line-height: 1.3;
    border-radius: 0.2rem;
  }
  p {
    margin-bottom: 1px;
  }
}
</style>

<template>
  <b-container class="py-5 text-left">
    <b-row>
      <b-col sm="7" v-if="showRef">
        <div class="box border py-3 px-2 py-sm-4 px-sm-3 mb-4">
          <h6 class="mb-4">Invite Friends and Earn Points</h6>

          <div class="mb-3">
            <b-row class="mb-3 flex-column flex-sm-row">
              <b-col sm="12" class="text-center">
                <b-img
                  class="img-s"
                  :src="require('@/assets/images/bonus.png')"
                ></b-img
              ></b-col>
              <b-col sm="12">
                <p class="fs14">
                  Refer your friends to nzukoor and earn bonus points.
                  <!-- we also
                  give your friends bonus because we value your friendship -->
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
              </b-col>
            </b-row>
            <div class="py-3 px-2 text-center mb-4">
              <h6>Your referral link</h6>
              <div
                class="px-2 py-2 d-flex align-items-center search bg-light mb-3"
              >
                <b-form-input
                  v-model="message"
                  readonly
                  class="flex-1 border-0 no-focus search-bg fs12"
                >
                </b-form-input>
                <b-button
                  size="sm"
                  variant="dark-green"
                  type="button"
                  v-clipboard:copy="message"
                  v-clipboard:success="onCopy"
                  v-clipboard:error="onError"
                  class="fs13"
                  >Copy</b-button
                >
              </div>
            </div>
          </div>
        </div>
      </b-col>
      <b-col sm="7" v-else class="p-5">
        <div class="d-flex w-100 mb-3 border">
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
          <h5 class="py-2">Referral History</h5>
          <div class="mb-1">
            <small class="text-muted">Your earnings</small>
            <p>{{ referrals.length * 200 }}</p>
          </div>
          <div class="mb-3">
            <small class="text-muted">Total referrals</small>
            <p>{{ referrals.length }}</p>
          </div>
          <div class="" v-if="showReferral">
            <b-table-simple v-if="referrals.length">
              <b-thead>
                <b-tr>
                  <b-th class="fs13">Username</b-th>
                </b-tr>
              </b-thead>
              <b-tbody>
                <b-tr v-for="item in referrals" :key="item.id">
                  <b-td class="text-capitalize fs13">{{
                    item.member_detail.username
                  }}</b-td>
                </b-tr>
                <b-tr>
                  <b-td class="fs13"
                    >Total earnings :
                    <span> {{ referrals.length * 200 }} points</span></b-td
                  >
                </b-tr>
              </b-tbody>
            </b-table-simple>
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
      message: `https://nzukoor.com/invite/${this.$store.getters.member.referral}`,
      communities_link: [],
    };
  },
  mounted() {
    this.getreferrals();

    this.message = `https://nzukoor.com/invite/${this.$store.getters.member.referral}`;
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
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
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

    sendInvite() {
      var data = {
        emails: this.inviteUsers.users,
        code: this.$store.getters.member.referral,
      };
      this.$http
        .post(`${this.$store.getters.url}/send-referral`, data, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Invite sent");
            this.email = "";
            this.invitedUsers = {
              code: "",
              users: [
                {
                  email: "",
                },
              ],
            };
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    onCopy: function (e) {
      alert("You just copied the following text to the clipboard: " + e.text);
    },
    onError: function () {
      alert("Failed to copy the text to the clipboard");

    },
  },
};
</script>
<style scoped>
.box {
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
  max-height: 20vh;
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

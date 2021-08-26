<template>
  <div>
    <b-container fluid class="main">
      <b-row>
        <b-col class="px-0"> <TopBar /></b-col>
      </b-row>
      <b-row>
        <b-col sm="3" class="p-0 d-none d-sm-block"> <SideBar /></b-col>
        <b-col sm="6" class="p-0">
          <div class="content">
            <main id="page-wrap" class="pb-5">
              <router-view></router-view>
            </main>
          </div>
        </b-col>
        <b-col sm="3"> <RightBar /></b-col>
      </b-row>
    </b-container>
    <b-modal id="insight" size="xl" hide-footer>
      <Insight @skip="skip" :user="$store.getters.member" :type="'member'" />
    </b-modal>
  </div>
</template>
<script>
import SideBar from "@/components/Member/sidebar.vue";
import RightBar from "@/components/Member/Navigation/RightTab.vue";
import TopBar from "@/components/Member/Navigation/Header.vue";
import Insight from "@/components/InterestComponent";
export default {
  components: {
    SideBar,
    RightBar,
    TopBar,
    Insight,
  },
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      window.speechSynthesis.onvoiceschanged = function () {
        var speech = window.speechSynthesis.getVoices();

        vm.$store.commit("SET_SPEECH", speech);
      };
    });
  },
  watch: {
    $route: "getnotification",
  },

  mounted() {
    this.getnotification();
    this.getloginhistory();
    this.getinbox();
    if (!this.$store.getters.member.interests) {
      this.$bvModal.show("insight");
    }
  },
  methods: {
    getnotification() {
      this.$store.dispatch("getNotifications", "member");
    },
    getinbox() {
      this.$store.dispatch("getInbox", "member");
    },
    skip() {
      this.$bvModal.hide("insight");
    },
    getloginhistory() {
      this.$http
        .get(
          `${this.$store.getters.url}/login-history`,

          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then()
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
  },
};
</script>
<style scoped>
.main {
  background: #fbfbfb;
  width: 100vw;
  overflow: hidden;
  height: 100vh;
}
.content {
  height: 100vh;
  overflow-y: scroll;
  -ms-overflow-style: none; /* IE and Edge */
  scrollbar-width: none; /* Firefox */
}
.content::-webkit-scrollbar {
  display: none;
}

.notification_container {
}
</style>

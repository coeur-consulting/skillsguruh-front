<template>
  <div>
    <b-container fluid class="main">
      <b-row>
        <b-col sm="2" class="p-0 d-none d-sm-block"> <SideBar /></b-col>
        <b-col sm="10" class="p-0">
          <div class="content">
            <TopBar />
            <main id="page-wrap" class="pb-5">
              <router-view></router-view>
            </main>
          </div>
        </b-col>
      </b-row>
    </b-container>
    <b-modal id="insight" size="xl" hide-footer>
      <Insight @skip="skip" :user="$store.getters.admin" />
    </b-modal>
  </div>
</template>
<script>
import SideBar from "@/components/Administrator/sidebar.vue";
import TopBar from "@/components/Administrator/topbar.vue";
import Insight from "@/components/InterestComponent";
export default {
  components: {
    SideBar,
    TopBar,
    Insight,
  },
  watch: {
    $route: "getnotification",
  },
  created() {
    var channel = this.$pusher.subscribe("inbox");

    channel.bind("inboxSent", (data) => {
      console.log(data);
    });
  },
  mounted() {
    this.getnotification();
    this.getloginhistory();
  },
  methods: {
    getnotification() {
      this.$store.dispatch("getNotifications", "admin");
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
              Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
            },
          }
        )
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
  overflow-x: scroll;
}
</style>

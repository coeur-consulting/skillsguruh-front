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
    <b-modal id="insight" size="xl" hide-footer hide-header>
      <Insight @skip="skip" :user="$store.getters.learner" :type="'user'" />
    </b-modal>
  </div>
</template>
<script>
import SideBar from "@/components/Learner/sidebar.vue";
import TopBar from "@/components/Learner/topbar.vue";
import Insight from "@/components/InterestComponent";
export default {
  components: {
    SideBar,
    TopBar,
    Insight,
  },
  mounted() {
    this.$store.dispatch("getNotifications", "learner");
    this.getloginhistory();
    this.$http
      .get(
        `${this.$store.getters.url}/send-mail`,

        {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        }
      )
      .then();
  },
  methods: {
    skip() {
      this.$bvModal.hide("insight");
    },
    getloginhistory() {
      this.$http
        .get(
          `${this.$store.getters.url}/login-history`,

          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            if (res.data.length == 1) {
              this.$bvModal.show("insight");
            }
          }
        })
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
}
</style>

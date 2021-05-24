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
  </div>
</template>
<script>
import SideBar from "@/components/Administrator/sidebar.vue";
import TopBar from "@/components/Administrator/topbar.vue";
export default {
  components: {
    SideBar,
    TopBar,
  },
  mounted() {
    this.$store.dispatch("getNotifications", "admin");
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

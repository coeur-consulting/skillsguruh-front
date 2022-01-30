<template >
  <div class="d-flex main-container">
    <span class="side bg-light" v-show="!mobile || mobile === 'menu'">
      <side-chat @toggleView="toggleView"></side-chat
    ></span>
    <span class="box" v-show="!mobile || mobile === 'chat'">
      <message-box @toggleView="toggleView"></message-box
    ></span>
<BottomBar class="d-md-none" v-if="!mobile || mobile === 'menu'"/>
  </div>
</template>
<script>
import SideChat from "./sidechat.vue";
import MessageBox from "./messagebox.vue";
import BottomBar from "@/components/Member/Navigation/BottomNav.vue";
export default {
  components: {
    SideChat,
    MessageBox,
    BottomBar
  },
  data() {
    return {
      mobile: null,
    };
  },
  mounted() {
    if (window.innerWidth < 768) {
      this.mobile ="menu";
    }
  },
  methods: {
    toggleView(val) {
      if (window.innerWidth < 768) {
        this.mobile = val;
      }
    },
  },
};
</script>
<style scoped lang="scss">
.main-container {
  height: 100vh;
}
.side {
  width: 25%;
  border-right: 1px solid rgba(0, 0, 0, 0.3);
  height: 100vh;
  overflow-y: auto;
}
.box {
  width: 75%;
  height: 100%;
}
@media (max-width: 768px) {
  .box {
    width: 100%;
  }
  .side {
    width: 100%;
  }
}
</style>
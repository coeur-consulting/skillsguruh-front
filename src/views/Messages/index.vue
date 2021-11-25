<template >
  <div class="d-flex main-container">
    <span class="side"> <side-chat></side-chat></span>
    <span class="box"> <message-box></message-box></span>
  </div>
</template>
<script>
import SideChat from "./sidechat.vue";
import MessageBox from "./messagebox.vue";
export default {
  components: {
    SideChat,
    MessageBox,
  },
};
</script>
<style scoped lang="scss">
.main-container{
  height: 100vh;
}
.side {
  width: 25%;
  border-right: 1px solid rgba(0, 0, 0, .3);
  height: 100%;
}
.box {
  width: 75%;
  height: 100%;
}
</style>
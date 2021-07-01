<template>
  <div class="main"></div>
</template>

<script>
export default {
  beforeRouteEnter(to, from, next) {
    next((vm) => {
      vm.$router.push(`/register?invite=${to.params.code}`);
    });
  },
};
</script>
<style scoped>
.main {
  height: 80vh;
}
</style>

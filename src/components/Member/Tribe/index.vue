<template>
  <router-view />
</template>
<script>
export default {
  beforeDestroy() {
    localStorage.removeItem("tribe");
  },
};
</script>
<template>
  <div>
    <audio :src="src" controls></audio>
  </div>
</template>
<script>
export default {
  props: ["src"],
};
</script>
<style scoped>
video {
  width: 100%;
  min-height: 300px;
  background: black;
}
</style>

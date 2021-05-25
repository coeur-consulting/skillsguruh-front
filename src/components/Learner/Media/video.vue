<template>
  <div>
    <video :src="media.file" controls></video>
  </div>
</template>
<script>
export default {
  props: ["media"],
};
</script>
<style scoped>
video {
  width: 100%;
  min-height: 500px;
  background: black;
}
</style>

<template>
  <div class="position-relative pb-2 viewmore">
    <div :class="isFull ? 'full' : 'minimum'">
      <slot name="content"> </slot>
    </div>

    <div v-show="!isFull" class="text-center" @click="toggleStyle">
      <slot name="seemore"> </slot>
    </div>
    <div v-show="isFull" class="text-center" @click="toggleStyle">
      <slot name="seeless"> </slot>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      isFull: false,
    };
  },
  methods: {
    toggleStyle() {
      this.isFull = !this.isFull;
    },
  },
};
</script>
<style scoped>
.minimum {
  min-height: 50px;
  overflow-y: hidden;
  -webkit-transition: height 0.4s ease-in-out;
  -moz-transition: height 0.4s ease-in-out;
  -o-transition: height 0.4s ease-in-out;
  transition: height 0.4s ease-in-out;
}
.full {
  max-height: 200px;
  -webkit-transition: height 0.4s ease-in-out;
  -moz-transition: height 0.4s ease-in-out;
  -o-transition: height 0.4s ease-in-out;
  transition: height 0.4s ease-in-out;
  overflow-y: auto;
}
</style>
<template>
  <div>
    <b-icon
      v-b-tooltip.hover
      title="Play text"
      icon="play-circle-fill"
      variant="gray"
      font-scale="1"
      @click="togglePlay"
    ></b-icon>
    <vue-web-speech-synth
      :voice="voice"
      v-model="play"
      :pitch="1"
      :text="text"
    />
  </div>
</template>
<script>
export default {
  props: ["text", "voice"],
  data() {
    return {
      play: false,
    };
  },
  computed: {},

  methods: {
    togglePlay() {
      if (!this.$props.text) {
        this.$toast.info("Input a text");
        return;
      }
      this.play = !this.play;
    },
  },
};
</script>

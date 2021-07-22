<template>
  <div class="icon">
    <span class="speaker">
      <b-icon
        v-b-tooltip.hover
        title="Play text"
        icon="volume-up-fill"
        variant="gray"
        font-scale="1.2"
        @click="togglePlay"
      ></b-icon>
    </span>
    <span class="play">
      <b-icon
        v-b-tooltip.hover
        title="Play text"
        icon="play-circle-fill"
        variant="gray"
        font-scale="1.2"
        @click="togglePlay"
      ></b-icon>
    </span>
    <vue-web-speech-synth
      :voice="voice"
      v-model="play"
      :pitch="1"
      :rate="0.8"
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

<style scoped>
.play {
  display: none;
}
.icon:hover .speaker {
  display: none;
}
.icon:hover .play {
  display: block;
}
</style>

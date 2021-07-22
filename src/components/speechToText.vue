<template>
  <div>
    <span
      class="
        position-relative
        d-flex
        align-items-center
        bg-lighter-green
        rounded-pill
      "
    >
      <div class="fs10 px-2" v-show="listening">
        {{ listen_text }}
      </div>
      <div>
        <b-iconstack
          font-scale="1.7"
          @click="record = !record"
          v-b-tooltip.hover
          title="Voice to text"
          class="cursor-pointer"
        >
          <b-icon
            stacked
            icon="circle-fill"
            :variant="record ? 'dark-green' : 'lighter-green'"
          ></b-icon>
          <b-icon
            stacked
            icon="mic-fill"
            :variant="record ? 'white' : 'grey'"
            scale="0.5"
          ></b-icon>
        </b-iconstack>
      </div>
    </span>
    <vue-web-speech
      @error="onError"
      @start="onStart"
      @speechstart="onSpeechStart"
      @speechend="onSpeechEnd"
      @end="onEnd"
      @soundstart="onSoundStart"
      @soundend="onSoundEnd"
      @audiostart="onAudioStart"
      @audioend="onAudioEnd"
      @resultsRaw="onresultsRaw"
      v-model="record"
      @results="onResults"
      :continuous="true"
      :confidenceLimit="0.6"
    />
  </div>
</template>
<script>
export default {
  data() {
    return {
      record: false,
      listening: false,
      listen_text: ""
    };
  },
  methods: {
    onError() {
      this.$toast.error("Something went wrong");
      this.listening = false;
    },
    onEnd() {
      this.listening = false;
    },
    onStart() {
      this.listening = true;

      this.listen_text = "Speak now!";
    },
    onSpeechStart() {
      this.listen_text = "Listening";
    },
    onSpeechEnd() {
      this.listen_text = "Speak now!";
    },
    onSoundStart() {
      // this.listen_text = "Listening";
    },
    onSoundEnd() {
      this.listen_text = "Speak now!";
    },
    onAudioStart() {
      //this.listen_text = "Listening";
    },
    onAudioEnd() {
      this.listen_text = "Speak now!";
    },
    onresultsRaw() {},
    onResults(res) {
      this.$emit("getText", res.pop().toString());
    }
  }
};
</script>

<style scoped>
.listen {
  transition: 0.4s;
}
</style>

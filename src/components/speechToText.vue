<template>
  <div>
    <b-iconstack
      font-scale="1.5"
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
    <vue-web-speech
      @error="onError"
      @start="onStart"
      @speechstart="onSpeechStart"
      @speechend="onSpeechEnd"
      @end="onEnd"
      v-model="record"
      @results="onResults"
      :continuous="true"
    />
  </div>
</template>
<script>
export default {
  data() {
    return {
      record: false,
    };
  },
  methods: {
    onError() {
      this.$toast.error("Something went wrong");
    },
    onEnd() {
      // this.$toast.info("Ended");
    },
    onStart() {
      this.$toast.info("Speak now");
    },
    onSpeechStart() {
      this.$toast.info("Listening");
    },
    onSpeechEnd() {
      // this.$toast.info("Ended");
    },

    onResults(res) {
      console.log(
        "🚀 ~ file: SpeechToText.vue ~ line 48 ~ onResults ~ res",
        res
      );
      this.$emit("getText", res.toString());
    },
  },
};
</script>

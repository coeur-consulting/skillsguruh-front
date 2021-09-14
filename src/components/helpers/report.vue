<template>
  <div>
    <b-list-group v-if="!status">
      <b-list-group-item
        href="#"
        @click="handleReport(item)"
        class="d-flex justify-content-between fs13 align-items-center"
        v-for="(item, id) in messages"
        :key="id"
      >
        <span> {{ item }}</span>
        <b-icon icon="chevron-right" font-scale=".9"></b-icon>
      </b-list-group-item>
    </b-list-group>

    <div class="text-center p-3" v-else>
      <b-icon icon="check2-circle" variant="dark-green" font-scale="4"></b-icon>
      <br />
      <p>Thank you for reporting, it will be reviewed</p>
    </div>
  </div>
</template>

<script>
export default {
  props: ["id", "type"],

  data() {
    return {
      status: null,
      messages: [
        " It's spam",
        "Nudity or sexual activity",

        "Hate speech or symbols",

        "Violence or dangerous organisations",

        "Sale of illegal or regulated goods",

        "Bullying or harassment",

        "Intellectual property violation",

        "Suicide or self-injury",

        "Eating disorders",

        "Scam or fraud",

        "False information",

        "I just don't like it",
      ],
    };
  },
  methods: {
    handleReport(message) {
      var detail = {
        type: this.$props.type,
        type_report_id: this.$props.id,
        message: message,
      };

      this.$store.dispatch("REPORT_CONTENT", detail).then((res) => {
        if (res.status === 201) {
          this.status = res.data;
        } else {
          this.$toast.info(
            "You already reported this content,and it is being reviewed"
          );
        }
      });
    },
  },
};
</script>

<style scoped>
</style>
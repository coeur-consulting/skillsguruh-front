<template>
  <div class="pt-5 px-sm-4">
    <div>
      <b-form-checkbox v-model="team" name="check-button" switch>
        Switch Team
      </b-form-checkbox>
    </div>
    <Facilitator v-if="team" />
    <Learners v-else />
  </div>
</template>
<script>
import Facilitator from "./facilitators";
import Learners from "./learners";
export default {
  data() {
    return {
      team: true
    };
  },
  components: {
    Facilitator,
    Learners
  }
};
</script>

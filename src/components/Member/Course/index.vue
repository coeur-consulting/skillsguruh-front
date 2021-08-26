<template>
  <div class="py-4 px-3 px-sm-0">
    <b-tabs content-class="mt-3 " class="connect_tab mt-3">
      <b-tab title="Courses" active>
        <courses />
      </b-tab>
      <b-tab title="Assessments">
        <assessments />
      </b-tab>
      <b-tab title="Library">
        <library />
      </b-tab>
    </b-tabs>
  </div>
</template>

<script>
import Courses from "../courses.vue";
import Library from "../library.vue";
import Assessments from "../assessments.vue";
export default {
  components: {
    Courses,
    Library,
    Assessments,
  },
};
</script>

<style scoped lang="scss">
</style>
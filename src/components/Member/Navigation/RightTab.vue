<template>
  <div class="p-4 bg-transparent topright">
    <b-img
      :src="require('@/assets/images/tribeimg.png')"
      alt="tribeimg"
      class="tribe_img mb-5"
    ></b-img>
    <div class="suggestions text-left" v-if="useraccess">
      <suggested-tribe
        v-if="
          $route.meta.routetype == 'mytribes' ||
          ($route.meta.routetype == 'feeds' && !$route.params.tribe)
        "
      />
      <!-- <view-course
        v-else-if="$route.meta.routetype == 'courses'"
        :course="$store.getters.course"
      /> -->
      <other-discussion v-else-if="$route.meta.routetype == 'discussion'" />
      <Schedule v-else-if="$route.meta.routetype == 'events'" />
      <tribe-members
        v-else-if="$route.meta.routetype == 'feeds' && $route.params.tribe"
      />
      <suggested-connections v-else />
    </div>
  </div>
</template>

<script>
import SuggestedTribe from "../Tribe/suggestions/tribesugesstions.vue";
import SuggestedConnections from "../Tribe/suggestions/connectionsuggestion.vue";
import Schedule from "../Tribe/suggestions/schedulerside.vue";
import TribeMembers from "../Tribe/suggestions/tribemembers.vue";
// import ViewCourse from "../components/course.vue";
import OtherDiscussion from "../components/otherdiscussions.vue";
export default {
  name: "Righttab",
  components: {
    SuggestedConnections,
    SuggestedTribe,
    // ViewCourse,
    OtherDiscussion,
    Schedule,
    TribeMembers,
  },
  data() {
    return {
      tribe: true,
    };
  },
  computed: {
    useraccess() {
      var token = null;
      if (localStorage.getItem("authAdmin")) {
        return this.$store.getters.admin;
      }
      if (localStorage.getItem("authFacilitator")) {
        return this.$store.getters.facilitator;
      }
      if (localStorage.getItem("authMember")) {
        return this.$store.getters.member;
      }
      return token;
    },
  },
};
</script>

<style scoped lang="scss">
.tribe_img {
  width: 100%;
}
.topright {
  height: 100vh;
  overflow: hidden;
}

.suggestion {
  height: calc(100vh - 300px);
  overflow-y: auto;
  padding-bottom: 75px;
}
</style>
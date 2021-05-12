<template>
  <div>
    <b-container fluid class="p-sm-0">
      <b-row>
        <b-col sm="3"> <SideBar /></b-col>
        <b-col sm="9"> <router-view></router-view></b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
import SideBar from "@/components/Organization/sidebar.vue";
export default {
  components: {
    SideBar,
  },
};
</script>

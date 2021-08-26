<template>
  <b-container class="py-5 text-left">
    <b-row>
      <b-col class="mb-5">
        <div class="box py-4 px-3">
          <b-tabs content-class="mt-3 " class="connect_tab mt-3">
            <b-tab title="Events" active>
              <Event />
            </b-tab>
            <b-tab title="Schedule" lazy>
              <Schedule />
            </b-tab>
          </b-tabs>
        </div>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import Event from "./events.vue";
import Schedule from "./schedule.vue";
export default {
  data() {
    return {};
  },
  components: {
    Event,
    Schedule,
  },
};
</script>
<style scoped>
.box {
  /* box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important; */
  border-radius: 8px;
  background: white;
}

.connection_box {
  height: 50vh;
  overflow: auto;
}
.suggestion_box {
  max-height: 40vh;
  overflow: auto;
}
.btn-sm,
.btn-group-sm > .btn {
  padding: 0.25rem 0.5rem;
  font-size: 0.7rem !important;
  line-height: 1.4;
  border-radius: 0.2rem;
}
h6 {
  font-size: 0.95rem;
}

@media (max-width: 600px) {
  h6 {
    font-size: 0.9rem;
  }
}
@media (max-width: 600px) {
  h4.card-title {
    font-size: 0.9rem;
  }
  nav ul li {
    font-size: 12px !important;
  }
  .btn-sm,
  .btn-group-sm > .btn {
    padding: 0.2rem 0.5rem;
    font-size: 0.5rem !important;
    line-height: 1.3;
    border-radius: 0.2rem;
  }
  p {
    margin-bottom: 1px;
  }
}
</style>

<template>
  <div class="text-left">
    <h6 class="mb-4">Suggested Tribe</h6>
    <ul class="ml-0 pl-0 suggestion">
      <li class="d-flex mb-3" v-for="n in tribes" :key="n.id">
        <b-avatar class="mr-2"></b-avatar>
        <div class="text-left">
          <div class="tribe_name">{{ n.name }} Tribe</div>
          <div class="tribe_members">
            <span class="d-flex align-items-center"
              >{{ n.users.length }}
              {{ n.users.length > 1 ? "members" : "member" }}
            </span>
          </div>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  data() {
    return {
      tribes: [],
    };
  },
  mounted() {
    this.getsuggestions();
  },
  methods: {
    async getsuggestions() {
      return this.$http
        .get(`${this.$store.getters.url}/tribe/suggestions`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.tribes = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
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
.tribe_name {
  font-size: 0.9rem;
  color: rgba($color: #000000, $alpha: 0.64);
}
.tribe_members {
  font-size: 0.7rem;
  color: rgba($color: #000000, $alpha: 0.44);
}
.suggestion {
  height: calc(100vh - 300px);
  overflow-y: auto;
  padding-bottom: 75px;
}
</style>
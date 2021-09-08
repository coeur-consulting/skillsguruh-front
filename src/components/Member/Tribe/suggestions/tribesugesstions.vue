<template>
  <div class="text-left">
    <h6 class="mb-4">Suggested Tribe</h6>
    <ul class="ml-0 pl-0 suggestion">
      <li class="d-flex mb-3" v-for="(n, id) in tribes" :key="n.id">
        <b-avatar class="mr-2"></b-avatar>
        <div class="text-left" :id="`suggestedpopover-${id}`">
          <div class="tribe_name">{{ n.name }} Tribe</div>
          <div class="tribe_members">
            <span class="d-flex align-items-center"
              >{{ n.users.length }}
              {{ n.users.length > 1 ? "members" : "member" }}
            </span>
          </div>
        </div>
        <b-popover :target="`suggestedpopover-${id}`" triggers="hover">
          <template #title> {{ n.name }} tribe</template>

          <p class="fs13">{{ n.description }}</p>
          <p class="fs13 text-muted mb-1">{{ n.users.length }} users</p>
          <p class="fs13 text-muted mb-1">
            {{ n.discussions.length }} discussions
          </p>
          <p class="fs13 text-muted mb-3">
            {{ n.events.length }} active events
          </p>
          <b-button
            block
            variant="lighter-green"
            size="sm"
            @click="entertribe(n.id)"
            >Join</b-button
          >
        </b-popover>
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
    entertribe(id) {
      var details = {
        tribe_id: id,
        user: this.$store.getters.member,
      };
      localStorage.removeItem("tribe");
      localStorage.setItem("tribe", id);
      this.$store.dispatch("checkTribe", details).then((res) => {
        if (res.status == 200 && res.data.message == "found") {
          this.$router.push(`/member/tribe/discussions/${id}`);
        } else {
          this.$bvModal
            .msgBoxConfirm("Do you wish to join this tribe?")
            .then((val) => {
              if (val) {
                this.$store.dispatch("joinTribe", details).then((res) => {
                  if (res.status == 200 && res.data.message == "successful") {
                    this.$toast.success("Joined successfully");
                    this.$router.push(`/member/tribe/discussions/${id}`);
                  }
                });
              }
            });
        }
      });
    },

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
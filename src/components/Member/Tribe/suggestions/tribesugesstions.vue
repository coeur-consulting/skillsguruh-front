<template>
  <div class="text-left">
    <h6 class="mb-4">Suggested Tribe</h6>
    <ul class="ml-0 pl-0 suggestion">
      <li class="d-flex mb-3" v-for="(n, id) in tribes" :key="n.id">
        <b-avatar class="mr-2" :src="n.cover"></b-avatar>
        <div class="text-left" :id="`suggestedpopover-${id}`">
          <div class="tribe_name text-left">{{ n.name }} Tribe</div>
          <div class="tribe_members">
            <span class="d-flex align-items-center"
              >{{ n.users }}
              {{ n.users > 1 ? "members" : "member" }}
            </span>
          </div>
        </div>
        <b-popover :target="`suggestedpopover-${id}`" triggers="hover">
          <template #title> {{ n.name }} tribe</template>

          <p class="fs13">{{ n.description }}</p>
          <p class="fs14 text-muted mb-1">
            <font-awesome-icon :icon="users" size="1x" class="icon" />
            {{ n.users }}
          </p>

          <b-button
            v-if="n.type == 'free'"
            block
            variant="dark-green"
            size="sm"
            @click="entertribe(n.id)"
          >
            {{ n.isMember ? "Engage" : "Join" }}</b-button
          >
           <b-button
              v-else-if="n.type == 'private'"
              block
              variant="dark-green"
              size="sm"
              @click="sendrequest(n.id)"
            >
              Request access</b-button
            >
          <div v-else>
            <b-button
              v-if="n.isMember"
              block
              variant="dark-green"
              size="sm"
              @click="entertribe(n.id)"
            >
              <font-awesome-icon :icon="signIn"
            /></b-button>
            <b-button
              v-else
              block
              variant="dark-green"
              size="sm"
              @click="purchase(n.id)"
            >
              <font-awesome-icon :icon="signIn"
            /></b-button>
          </div>
        </b-popover>
      </li>
    </ul>
  </div>
</template>

<script>
import { faUsers } from "@fortawesome/free-solid-svg-icons";
import { faSignInAlt } from "@fortawesome/free-solid-svg-icons";
export default {
  data() {
    return {
      users: faUsers,
      signIn: faSignInAlt,
      tribes: [],
    };
  },
  mounted() {
    this.getsuggestions();
  },
  methods: {
    purchase(id) {
      this.$router.push(`/me/order?id=${id}&type_payment=tribe`);
    },
     sendrequest(id) {
      if (!this.useraccess) {
        this.$router.push("/login?redirect=%2Fexplore%2Fcommunity");
      }
      this.$http
        .get(`${process.env.VUE_APP_API_PATH}/create/tribe/request/${id}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status === 200) {
            this.$toast.success("Request sent");
          }
        })
        .catch(() => {
          this.$toast.error("Request failed");
        });
    },
    entertribe(id) {
      if (!this.useraccess) {
        this.$router.push("/login?redirect=%2Fexplore%2Fcommunity");
      }
      var details = {
        tribe_id: id,
        user: this.$store.getters.member,
      };


      this.$store.dispatch("checkTribe", details).then((res) => {
        if (res.status == 200 && res.data.message == "found") {
          window.location.href = `/me/tribe/discussions/${id}`;
        } else {
          this.$bvModal
            .msgBoxConfirm("Do you wish to join this tribe?")
            .then((val) => {
              if (val) {
                this.$store.dispatch("joinTribe", details).then((res) => {
                  if (res.status == 200 && res.data.message == "successful") {
                    this.$toast.success("Joined successfully");
                    window.location.href = `/me/tribe/discussions/${id}`;
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
        .catch(() => {
          this.$toast.error("Request failed");
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
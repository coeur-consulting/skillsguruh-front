<template>
  <b-container fluid class="px-sm-0" v-if="suggestions.length">
    <div class="my-3 position-relative">
      <h6 class="mb-3 text-left text-muted">Some connection suggestions</h6>
      <b-iconstack
        font-scale="2.5"
        class="nav-left shadow-sm"
        v-if="index > 0"
        @click="index--"
      >
        <b-icon stacked icon="circle-fill" variant="white"></b-icon>
        <b-icon
          stacked
          icon="arrow-left"
          scale="0.5"
          variant="secondary"
        ></b-icon>
      </b-iconstack>

      <b-iconstack
        font-scale="2.5"
        class="nav-right shadow-sm"
        @click="index++"
        v-if="index < suggestions.length - 1"
      >
        <b-icon stacked icon="circle-fill" variant="secondary"></b-icon>
        <b-icon stacked icon="arrow-right" scale="0.5" variant="white"></b-icon>
      </b-iconstack>
      <carousel
        :perPage="5"
        :scrollPerPage="true"
        :paginationEnabled="false"
        :navigationEnabled="false"
        :spacePaddingMaxOffsetFactor="20"
        :navigateTo="index"
      >
        <slide v-for="(item, id) in suggestions" :key="id">
          <b-card
            no-body
            class="mr-3 suggestion position-relative rounded overflw-hidden"
            style="min-width: 170px"
          >
            <b-card-img
              :src="
                item.profile
                  ? item.profile
                  : require('@/assets/images/default.jpeg')
              "
            ></b-card-img>
            <b-card-body class="text-center p-2">
              <div class="text-left">
                <div
                  class="name text-capitalize text-left mb-1 cursor-pointer"
                  @click="gotoprofile(item)"
                >
                  {{ item.username }}
                </div>

                <div class="fs11 mb-2">
                  {{ item.similar }} similar interests
                </div>
              </div>
              <b-button
                variant="dark-green"
                size="sm"
                block
                class="fs10 py-1"
                v-if="item.qualifications"
                @click="addconnections(item.id, 'facilitator')"
                >Connect</b-button
              >
              <b-button
                variant="dark-green"
                size="sm"
                block
                class="fs10 py-1"
                v-else
                @click="addconnections(item.id, 'user')"
                >Connect</b-button
              >
            </b-card-body>
          </b-card>
        </slide>
      </carousel>
    </div>
  </b-container>
</template>

<script>
export default {
  props: {
    user: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      suggestions: 6,
      showConnect: false,
      index: 0,
    };
  },
  computed: {
    useraccess() {
      var token = null;
      if (this.$props.user == "admin") {
        return this.$store.getters.admin;
      }
      if (this.$props.user == "facilitator") {
        return this.$store.getters.facilitator;
      }
      if (this.$props.user == "member") {
        return this.$store.getters.member;
      }
      return token;
    },
  },
  mounted() {
    this.getsimilarusers();
  },
  methods: {
    gotoprofile(val) {
      if (this.$props.user == "facilitator") {
        if (val.qualifications) {
          return this.$router.push(`/facilitator/profile/f/${val.id}`);
        }
        return this.$router.push(`/facilitator/profile/u/${val.id}`);
      }
      if (this.$props.user == "member") {
        if (val.qualifications) {
          return this.$router.push(`/member/profile/f/${val.id}`);
        }
        return this.$router.push(`/member/profile/u/${val.id}`);
      }
    },

    async getsimilarusers() {
      return this.$http
        .get(`${this.$store.getters.url}/similar/users`, {
          headers: {
            Authorization: `Bearer ${this.useraccess.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.suggestions = res.data;
            this.showConnect = true;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    async addconnections(id, type) {
      return this.$http
        .post(
          `${this.$store.getters.url}/connections`,
          { following_id: id, follow_type: type },
          {
            headers: {
              Authorization: `Bearer ${this.useraccess.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 201) {
            this.getsimilarusers();
            this.$toast.success("Connected");
            this.$store.dispatch("newConnection", {
              id,
              type,
              token: this.$store.getters.member.access_token,
            });
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
.suggestion img {
  height: 120px;
  width: 100%;
  object-fit: cover;
}
.name {
  font-size: 0.72rem;
  font-weight: 500;
}
.name:hover {
  color: rgba($color: #000000, $alpha: 0.44);
}
@media (max-width: 768px) {
  .name {
    font-size: 0.7rem;
  }
}
</style>

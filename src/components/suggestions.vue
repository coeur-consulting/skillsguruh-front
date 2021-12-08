<template>
  <div class="px-3" v-if="suggestions.length">
    <div class="my-3 position-relative">
      <div class="mb-3 text-left text-muted">
        <small>Some connection suggestions</small>
      </div>
      <b-iconstack
        font-scale="2.5"
        class="nav-left shadow-sm cursor-pointer"
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
        class="nav-right shadow-sm cursor-pointer"
        @click="index++"
        v-if="index < maxnavigation"
      >
        <b-icon stacked icon="circle-fill" variant="secondary"></b-icon>
        <b-icon stacked icon="arrow-right" scale="0.5" variant="white"></b-icon>
      </b-iconstack>
      <carousel

        :perPageCustom="[[300, 3], [768, 4]]"
        :paginationEnabled="false"
        :navigationEnabled="false"
        :navigate-to="index"
      >
        <slide v-for="(item, id) in suggestions" :key="id" class="p-1">
          <b-card
            no-body
            class=" suggestion position-relative rounded p-1 "
            style="min-width: 150px"
          >
            <b-card-img
              class="rounded-circle"
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

                <div class="sim mb-2">{{ item.similar }} similar interests</div>
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
  </div>
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
      perpage:4
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
    maxnavigation(){
      return Math.floor(this.suggestions.length/this.perpage)
    }
  },
  mounted() {
    this.getsimilarusers();
    if(window.innerWidth < 768){
      this.perpage = 3
    }
  },

  methods: {
    gotoprofile(val) {
      if (this.$props.user == "member") {
        return this.$router.push(`/member/profile/${val.username}`);
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
  height: 130px;
  width: 130px;
  object-fit: cover;
  margin: 0 auto;
}
.name {
  font-size: 0.72rem;
  font-weight: 500;
}
.sim {
  font-size: 0.7rem;
}
.name:hover {
  color: rgba($color: #000000, $alpha: 0.44);
}
@media (max-width: 768px) {
  .suggestion {
    min-width: 120px !important;
  }
  .suggestion img {
    height: 100px;
    width: 100px;
    object-fit: cover;
  }
  .name {
    font-size: 0.6rem;
  }
  .sim {
    font-size: 0.56rem;
  }
}
</style>

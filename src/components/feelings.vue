<template>
  <div>
    <div @click="$bvModal.show('feelings')">
      <slot> </slot>
    </div>

    <b-modal
      id="feelings"
      hide-footer
      v-if="feelings"
      title="How are you feeling today?"
    >
      <div>
        <p
          v-if="feed.message"
          class="text-secondary font-weight-bold"
          v-html="feed.message"
        ></p>
        <b-container class="feelings">
          <b-row>
            <b-col cols="6" v-for="(item, id) in feelings" :key="id">
              <div
                class="
                  smiles
                  rounded-pill
                  py-2
                  text-center
                  px-3
                  d-flex
                  align-items-center
                "
                :class="active == id ? 'active' : ''"
                @click="selectFeeling(id, item)"
              >
                <span class="smiley mr-3">{{ item }}</span>
                <span class="text-capitalize textt">{{ id }}</span>
              </div>
            </b-col>
          </b-row>
        </b-container>
        <div class="py-2 text-center">
          <b-button @click="post">Post</b-button>
        </div>
      </div>
    </b-modal>
  </div>
</template>

<script>
import Emojis from "@/components/people.js";

export default {
  props: {
    user: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      feed: {
        media: "",
        message: "",
        publicId: "",
        tags: [],
      },
      active: null,
    };
  },
  computed: {
    feelings() {
      return Emojis;
    },
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
  methods: {
    selectFeeling(id, item) {
      this.active = id;
      this.feed.message = `<div>${this.useraccess.username} is <span class='mr-1'>${item}</span> feeling  ${id}.</div>  <div class='text-center'> <div style='font-size:9rem' class='animate__animated animate__heartBeat animate__delay-3s animate__repeat-3'>${item}</div></div>`;
    },
    post() {
      if (!this.feed.message) {
        return;
      }
      this.$http
        .post(`${this.$store.getters.url}/feeds`, this.feed, {
          headers: {
            Authorization: `Bearer ${this.useraccess.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.$toast.success("Feed Updated ");
            this.$bvModal.hide("feelings");

            this.feed = {
              media: "",
              message: "",
              publicId: "",
              tags: [],
            };
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
.smiles {
  margin-bottom: 0.7rem;
}
.smiles:hover {
  background: rgb(252, 252, 252);
}
.smiles.active {
  background: rgb(252, 252, 252);
}
.feelings {
  height: 500px;
  overflow-y: auto;
}
.smiley {
  background: rgb(243, 242, 242);
  border-radius: 50rem;
  font-size: 1.3rem;
  width: 2.6rem;
  height: 2.6rem;
  text-align: center;
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>

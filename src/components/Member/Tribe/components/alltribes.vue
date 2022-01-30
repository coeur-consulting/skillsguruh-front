<template>
  <div class="py-5">
    <b-container>
      <b-row class="mb-4">
        <b-col sm="12">
          <div class="search w-100">
            <b-input-group class="topbar_search bg-white">
              <b-input-group-prepend is-text>
                <b-iconstack font-scale="1.4" class="">
                  <b-icon
                    stacked
                    icon="circle-fill"
                    variant="lighter-green"
                  ></b-icon>
                  <b-icon
                    stacked
                    icon="search"
                    scale="0.5"
                    variant="dark-green"
                  ></b-icon>
                </b-iconstack>
              </b-input-group-prepend>
              <b-form-input
                placeholder="Find a tribe"
                class="no-focus border-0"
                type="search"
                aria-label="Text input "
                v-model="search"
              ></b-form-input>
              <b-input-group-append>
                <b-button variant="dark-green"
                  ><b-icon icon="search"></b-icon
                ></b-button>
              </b-input-group-append>
            </b-input-group>
          </div>
        </b-col>
      </b-row>

      <b-row>
        <b-col
          cols="6"
          sm="4"
          v-for="(n, id) in sortedTribes"
          :key="id"
          class="mb-4 position-relative"
        >
          <span class="position-absolute check">
            <b-icon
              icon="check-circle-fill"
              v-if="n.isMember"
              class="text-white"
            ></b-icon>
          </span>
          <b-popover :target="`popover-${id}`" triggers="hover">
            <template #title> {{ n.name }}</template>
            <p class="fs13 text-capitalize mb-2">
              Access :

              <span v-if="n.type === 'paid'">{{
                n.amount | currencyFormat
              }}</span>
              <span v-else>{{ n.type }}</span>
            </p>
            <p class="fs13 mb-1" style="min-width: 150px">
              {{ n.description }}
            </p>
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
          <div class="tribe_box rounded" :id="`popover-${id}`">
            <div
              class="
                d-flex
                align-items-center
                justify-content-center
                rounded
                p-2
              "
            >
              <span class="tribe_name text-white">{{ n.name }}</span>
            </div>

            <div
              class="
                d-flex
                justify-content-between
                align-items-center
                bg-white
                tribe_member_container
              "
            >
              <span class="d-flex align-items-center fs13">
                <span class="mr-1">{{ n.users }}</span>
                <span class=""> {{ n.users > 1 ? "members" : "member" }}</span>
              </span>
            </div>
            <span class="tribe_circle cursor-pointer">
              <b-avatar :src="n.cover" class="d-md-none"></b-avatar>
              <b-avatar
                size="lg"
                class="d-none d-md-block"
                :src="n.cover"
              ></b-avatar>
            </span>
          </div>
        </b-col>
        <b-col cols="6" sm="4" class="mb-4" v-if="useraccess">
          <div
            @click="$bvModal.show('start')"
            class="
              bg-lighter-green
              tribe_box
              shadow-sm
              rounded
              d-flex
              justify-content-center
              aling-items-center
            "
          >
            <span class="text-center">
              <b-icon
                icon="plus-circle"
                variant="dark-green"
                font-scale="4rem"
                class="mb-4"
              ></b-icon>
              <br />
              <small>Create A Tribe</small>
            </span>
          </div>
        </b-col>
      </b-row>
      <infinite-loading @infinite="infiniteHandler"></infinite-loading>
    </b-container>

    <b-modal id="start" hide-footer centered title="Create your tribe">
      <create-tribe @response="response" />
    </b-modal>
    <div class="tribe_join animated animate_fadeIn" v-show="toggleJoin">
      <div class="position-absolute p-3 p-md-5 shadow rounded bg-white">
        <span class="cancel">
          <b-icon
            icon="x"
            class="text-white"
            @click="toggleJoin = !toggleJoin"
          ></b-icon>
        </span>
        <div class="mb-4 text-center font-weight-bold text-dark-green">
          You have belong to the tribe first!
        </div>

        <div class="d-flex flex-column flex-md-row text-left" v-if="newtribe">
          <b-avatar
            class="mb-4 mb-md-0 mr-md-3"
            :src="newtribe.cover"
            size="4rem"
          ></b-avatar>
          <span>
            <span class="font-weight-bold">{{ newtribe.name }}</span> <br />
            <span>{{ newtribe.description }}</span>
          </span>
        </div>
        <div class="mt-4 text-right">
          <b-button @click="jointribe"
            >Join Tribe <b-icon icon="arrow-right"></b-icon
          ></b-button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Interest from "@/components/helpers/subcategory.js";
import Category from "@/components/helpers/category.js";
import CreateTribe from "./createtribe.vue";
import { faUsers, faSignInAlt } from "@fortawesome/free-solid-svg-icons";
import { bus } from "@/main.js";
export default {
  data() {
    return {
      toggleJoin: false,
      interest: "",
      sortValue: "all",
      signIn: faSignInAlt,
      users: faUsers,
      search: "",
      tribe: {
        name: "",
        description: "",
        cover: "",
        tags: [],
        category: {},
        amount: "",
      },
      price: "free",
      newtribe: {},
      tribes: [],
      ags: [],
      mytags: [],

      options: [],
      searchText: "", // If value is falsy, reset searchText & searchItem
      items: [],
      lastSelectItem: {},
      category: [],
      page: 1,
    };
  },
  components: {
    CreateTribe,
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
    filteredinterests() {
      if (!this.tribe.category) return [];
      return this.mytags.filter(
        (item) => item.category_id == this.tribe.category.id
      );
    },
    filterTribes() {
      return this.tribes.filter((item) =>
        item.name.toLowerCase().includes(this.search.toLowerCase())
      );
    },
    sortedTribes() {
      if (this.sortValue == "members") {
        return this.filterTribes.slice().sort(function (a, b) {
          return b.users - a.users;
        });
      }
      if (this.sortValue == "alpha") {
        return this.filterTribes.slice().sort(function (a, b) {
          let fa = a.name.toLowerCase();
          let fb = b.name.toLowerCase();

          if (fa > fb) {
            return 1;
          }
          if (fa < fb) {
            return -1;
          }
          return 0;
        });
      }
      if (this.sortValue == "interest") {
        return this.filterTribes.filter((item) => {
          var mapped = item.tags.map((val) => val.value.toLowerCase());

          return mapped.includes(this.interest.toLowerCase());
        });
      }
      return this.filterTribes;
    },
  },
  created() {
    bus.$on("toggleSort", (res) => {
      if (res.interest) {
        this.sortValue = "interest";
        this.interest = res.val;
      } else {
        this.sortValue = res.val;
      }
    });
    this.mytags = Interest.map((item) => {
      item.text = item.value;

      return item;
    });
    this.category = Category;
  },
  mounted() {
    if (this.$route.query.tribe) {
      this.search = this.$route.query.tribe;
    }
    if (this.$route.query.activity == "join_tribe") {
      this.gettribe();
    }
  },
  methods: {
    gettribe() {
      this.$http
        .get(
          `${this.$store.getters.url}/tribes/${this.$route.query.tribe_id}`,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.newtribe = res.data.data;
            this.toggleJoin = true;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    jointribe() {
      if (this.newtribe.type == "paid") {
        this.purchase(this.newtribe.id);
      } else {
        this.entertribe(this.newtribe.id);
      }
    },
    purchase(id) {
      this.$router.push(`/member/order?id=${id}&type_payment=tribe`);
    },
    isMember(arr) {
      return arr.some((item) => item.id == this.$store.getters.member.id);
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
        .catch((err) => {
          this.$toast.error(err.response.data);
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
          window.location.href = `/member/tribe/discussions/${id}`;
        } else {
          this.$bvModal
            .msgBoxConfirm("Do you wish to join this tribe?")
            .then((val) => {
              if (val) {
                this.$store.dispatch("joinTribe", details).then((res) => {
                  if (res.status == 200 && res.data.message == "successful") {
                    this.$toast.success("Joined successfully");
                    window.location.href = `/member/tribe/discussions/${id}`;
                  }
                });
              }
            });
        }
      });
    },

    infiniteHandler($state) {
      this.$http
        .get(`${process.env.VUE_APP_API_PATH}/tribes?page=${this.page}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.data.data.length) {
            this.page += 1;
            this.tribes.push(...res.data.data);
            $state.loaded();
          } else {
            $state.complete();
          }
        });
    },
    getUpload(val) {
      this.tribe.cover = val;
    },
    onSelect(items, lastSelectItem) {
      this.tribe.tags = items;
      this.lastSelectItem = lastSelectItem;
    },

    response(type, res) {
      this.tribes.unshift(res);
      this.$toast.success("Tribe Created");
      this.$bvModal.hide("start");
    },

    getmytribe() {
      this.$http
        .get(`${process.env.VUE_APP_API_PATH}/tribes`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status === 200) {
            this.tribes = res.data.data;
          }
        });
    },
  },
};
</script>
<style scoped lang="scss">
.check {
  top: 10px;
  right: 10px;
  z-index: 10;
}
</style>


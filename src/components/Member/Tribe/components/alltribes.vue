<template>
  <div class="py-5">
    <b-container>
      <b-row class="mb-4">
        <b-col sm="6">
          <b-form-input
            v-model="search"
            type="search"
            placeholder="Search name"
          ></b-form-input
        ></b-col>
      </b-row>
      <b-row>
        <b-col
          cols="6"
          sm="4"
          v-for="(n, id) in filterTribes"
          :key="id"
          class="mb-4"
        >
          <b-popover :target="`popover-${id}`" triggers="hover">
            <template #title> {{ n.name }} tribe</template>
            <p class="fs13 text-capitalize mb-2">
              Entry :
              <span v-if="n.type == 'free'">{{ n.type }}</span>
              <span v-else>{{ n.amount | currencyFormat }}</span>
            </p>
            <p class="fs13 mb-1">{{ n.description }}</p>
            <p class="fs13 text-muted mb-1">{{ n.users.length }} users</p>
            <p class="fs13 text-muted mb-1">
              {{ n.discussions.length }} discussions
            </p>

            <p class="fs13 text-muted mb-3">
              {{ n.events.length }} active events
            </p>
            <b-button
              v-if="n.type == 'free'"
              block
              variant="lighter-green"
              size="sm"
              @click="entertribe(n.id)"
            >
              {{ isMember(n.users) ? "Engage" : "Join" }}</b-button
            >
            <div v-else>
              <b-button
                v-if="isMember(n.users)"
                block
                variant="lighter-green"
                size="sm"
                @click="entertribe(n.id)"
              >
                Engage</b-button
              >
              <b-button
                v-else
                block
                variant="lighter-green"
                size="sm"
                @click="purchase(n.id)"
              >
                Join</b-button
              >
            </div>
          </b-popover>
          <div class="tribe_box rounded" :id="`popover-${id}`">
            <div class="d-flex align-items-center justify-content-center">
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
              <span class="d-flex align-items-center">
                <span class="mr-1">{{ n.users.length }}</span>
                <span> {{ n.users.length > 1 ? "members" : "member" }}</span>
              </span>
              <!-- <b-dropdown
                size="sm"
                variant="transparent"
                no-caret
                class="no-focus"
              >
                <template #button-content>
                  <b-icon icon="three-dots-vertical" font-scale=".8"></b-icon>
                </template>

                <b-dropdown-item class="fs12" @click="entertribe(n.id)"
                  >Drop</b-dropdown-item
                >
              </b-dropdown> -->
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
                font-scale="6rem"
                class="mb-4"
              ></b-icon>
              <br />
              <span>Create A Tribe</span>
            </span>
          </div>
        </b-col>
      </b-row>
      <infinite-loading @infinite="infiniteHandler"></infinite-loading>
    </b-container>

    <b-modal id="start" hide-footer centered title="Create your tribe">
      <create-tribe @response="response" />
    </b-modal>
  </div>
</template>

<script>
import Interest from "@/components/helpers/subcategory.js";
import Category from "@/components/helpers/category.js";
import CreateTribe from "./createtribe.vue";
export default {
  data() {
    return {
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
  },
  created() {
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
  },
  methods: {
    purchase(id) {
      this.$router.push(`/member/order?id=${id}&type_payment=tribe`);
    },
    isMember(arr) {
      return arr.some((item) => item.id == this.$store.getters.member.id);
    },
    entertribe(id) {
      if (!this.useraccess) {
        this.$router.push("/login?redirect=%2Fexplore%2Fcommunity");
      }
      var details = {
        tribe_id: id,
        user: this.$store.getters.member,
      };

      localStorage.removeItem("tribe");
      localStorage.setItem("tribe", id);
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

    response(res) {
      this.tribes.unshift(res.data.data);
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
</style>


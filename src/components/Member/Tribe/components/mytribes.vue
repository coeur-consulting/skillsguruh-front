<template>
  <div class="py-5">
    <b-container>
      <b-row class="mb-4">
        <b-col sm="12">
          <b-form-input
            v-model="search"
            type="search"
            placeholder="Search tribe name"
            class="w-100"
          ></b-form-input
        ></b-col>
      </b-row>
      <div v-if="!filterTribes.length">
        <div class="alert alert-warning alert-dismissible fade show" role="alert">

          <small>You do not belong to any tribe yet! Try joining one or <span @click="$bvModal.show('start')">Create yours now</span></small>
        </div>
      </div>
      <b-row>
        <b-col
          cols="6"
          sm="4"
          v-for="(n, id) in filterTribes"
          :key="id"
          class="mb-4"
          @click="entertribe(n.id)"
        >

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
              <span class="tribe_name text-center text-white">{{
                n.name
              }}</span>
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
              <b-dropdown
                v-if="n.isOwner"
                size="sm"
                variant="transparent"
                no-caret
                class="no-focus"
              >
                <template #button-content>
                  <b-icon icon="three-dots-vertical" font-scale=".8"></b-icon>
                </template>
                <b-dropdown-item class="fs12" @click="edit(n, id)"
                  >Edit</b-dropdown-item
                >

                <b-dropdown-item class="fs12" @click="droptribe(n.id, id)"
                  >Drop</b-dropdown-item
                >
              </b-dropdown>
            </div>
            <span class="tribe_circle cursor-pointer">
              <b-avatar :src="n.cover"></b-avatar>
            </span>
          </div>
        </b-col>
        <b-col cols="6" sm="4" class="mb-4">
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
      <create-tribe @response="response" @resetTribe="resetTribe" />
    </b-modal>
    <b-modal
      id="edit"
      hide-footer
      centered
      title="Edit your tribe"
      v-if="tribe"
    >
      <edit-tribe :tribe="tribe" @response="response" />
    </b-modal>
  </div>
</template>

<script>
import Interest from "@/components/helpers/subcategory.js";
import Category from "@/components/helpers/category.js";
import CreateTribe from "./createtribe.vue";
import EditTribe from "./edittribe.vue";
import { faUsers, faSignInAlt } from "@fortawesome/free-solid-svg-icons";
export default {
  data() {
    return {
      index: null,
      signIn: faSignInAlt,
      users: faUsers,
      search: "",
      tribe: {
        id: "",
        name: "",
        description: "",
        cover: "",
        tags: [],
        category: {},
        type: "free",
        amount: "",
      },
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
    EditTribe,
  },
  computed: {
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

  methods: {
    resetTribe() {
      this.tribe = {
        id: "",
        name: "",
        description: "",
        cover: "",
        tags: [],
        category: {},
        type: "free",
        amount: "",
      };
    },
    entertribe(id) {
      localStorage.removeItem("tribe");
      localStorage.setItem("tribe", id);
      window.location.href = `/member/tribe/discussions/${id}`;
    },
    infiniteHandler($state) {
      this.$http
        .get(`${process.env.VUE_APP_API_PATH}/user/tribes?page=${this.page}`, {
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

    edit(val, index) {
      this.index = index;
      this.tribe.id = val.id;
      this.tribe.name = val.name;
      this.tribe.type = val.type;
      this.tribe.description = val.description;
      this.tribe.amount = val.amount;
      this.tribe.category = val.category;
      this.tribe.tags = val.tags;
      this.$bvModal.show("edit");
    },
    response(type, res) {
      if (type == "create") {
        this.$toast.success("Tribe Created");
        this.$bvModal.hide("start");
        this.tribes.unshift(res);
      }
      if (type == "edit") {
        this.tribes.splice(this.index, 1, res);
        this.$toast.success("Tribe Updated");
        this.$bvModal.hide("edit");
      }
    },

    droptribe(id, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${process.env.VUE_APP_API_PATH}/tribes/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.member.access_token}`,
              },
            })
            .then((res) => {
              if (res.status === 200) {
                this.tribes.splice(index, 1);
                this.$toast.success("Tribe removed");
              }
            })
            .catch((err) => {
              this.$toast.error(err.response.data);
            });
        }
      });
    },
    getmytribe() {
      this.$http
        .get(`${process.env.VUE_APP_API_PATH}/user/tribes`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status === 200) {
            this.tribes = res.data.data.data;
          }
        });
    },
  },
};
</script>
<style scoped lang="scss"></style>

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
              <b-dropdown
                size="sm"
                variant="transparent"
                no-caret
                class="no-focus"
              >
                <template #button-content>
                  <b-icon icon="three-dots-vertical" font-scale=".8"></b-icon>
                </template>
                <!-- <b-dropdown-item class="fs12" @click="entertribe(n.id)"
                  >Join</b-dropdown-item
                > -->
              </b-dropdown>
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
    <b-modal
      no-close-on-backdrop
      id="start"
      hide-footer
      centered
      title="Create your tribe"
    >
      <b-form @submit.prevent="createtribe">
        <b-form-group label="Name">
          <b-form-input
            placeholder="Give a title"
            v-model="tribe.name"
            required
          ></b-form-input>
        </b-form-group>

        <b-form-group label="Description">
          <b-form-textarea
            required
            v-model="tribe.description"
            placeholder="Write a brief Description"
          ></b-form-textarea
        ></b-form-group>

        <b-form-group label="Category">
          <model-list-select
            :list="category"
            v-model="tribe.category"
            option-value="value"
            option-text="value"
            placeholder="select category"
          >
          </model-list-select>
        </b-form-group>

        <b-form-group label="Interests">
          <multi-select
            :options="filteredinterests"
            :selected-options="tribe.tags"
            placeholder="select interests"
            @select="onSelect"
          >
          </multi-select>
        </b-form-group>
        <b-form-group label="Tribe Image">
          <Cover @getUpload="getUpload" />
        </b-form-group>

        <div class="text-center mt-4">
          <b-button
            size="lg"
            variant="dark-green"
            type="submit"
            class="d-none d-sm-block px-3"
            >Create</b-button
          >
          <b-button
            size="lg"
            variant="dark-green"
            type="submit"
            class="d-sm-none"
            block
            >Create</b-button
          >
        </div>
      </b-form>
    </b-modal>
    <b-modal
      no-close-on-backdrop
      id="edit"
      hide-footer
      centered
      title="Create your tribe"
    >
      <b-form @submit.prevent="updatetribe">
        <b-form-group label="Name">
          <b-form-input
            placeholder="Give a title"
            v-model="tribe.name"
            required
          ></b-form-input>
        </b-form-group>

        <b-form-group label="Description">
          <b-form-textarea
            required
            v-model="tribe.description"
            placeholder="Write a brief Description"
          ></b-form-textarea
        ></b-form-group>

        <b-form-group label="Category">
          <model-list-select
            :list="category"
            v-model="tribe.category"
            option-value="value"
            option-text="value"
            placeholder="select category"
          >
          </model-list-select>
        </b-form-group>

        <b-form-group label="Interests">
          <multi-select
            :options="filteredinterests"
            :selected-options="tribe.tags"
            placeholder="select interests"
            @select="onSelect"
          >
          </multi-select>
        </b-form-group>
        <b-form-group label="Tribe Image">
          <Cover @getUpload="getUpload" />
        </b-form-group>

        <div class="text-center mt-4">
          <b-button
            size="lg"
            variant="dark-green"
            type="submit"
            class="d-none d-sm-block px-3"
            >Update tribe</b-button
          >
          <b-button
            size="lg"
            variant="dark-green"
            type="submit"
            class="d-sm-none"
            block
            >Update tribe</b-button
          >
        </div>
      </b-form>
    </b-modal>
  </div>
</template>

<script>
import { MultiSelect } from "vue-search-select";
import { ModelListSelect } from "vue-search-select";
import Interest from "@/components/helpers/subcategory.js";
import Category from "@/components/helpers/category.js";
import Cover from "@/components/UploadComponent";
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
    MultiSelect,
    ModelListSelect,
    Cover,
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
  mounted() {
    if (this.$route.query.tribe) {
      this.search = this.$route.query.tribe;
    }
  },
  methods: {
    entertribe(id) {
      var details = {
        tribe_id: id,
        user: this.$store.getters.member,
      };
      localStorage.setItem("tribe", id);
      this.$store.dispatch("checkTribe", details).then((res) => {
        if (res.status == 200 && res.data.message == "found") {
          this.$router.push(`/member/tribe/feed/${id}`);
        } else {
          this.$bvModal
            .msgBoxConfirm("Do you wish to join this tribe?")
            .then((val) => {
              if (val) {
                this.$store.dispatch("joinTribe", details).then((res) => {
                  if (res.status == 200 && res.data.message == "successful") {
                    this.$toast.success("Joined successfully");
                    this.$router.push(
                      `/member/tribe/feed/${id}`
                    );
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
    edittribe(val) {
      this.tribe = val;
      this.tribe.category = JSON.parse(val.category).value;
      this.tribe.tags = JSON.parse(val.tags);
      this.$bvModal.show("edit");
    },
    createtribe() {
      this.$http
        .post(`${process.env.VUE_APP_API_PATH}/tribes`, this.tribe, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status === 201) {
            this.tribes.unshift(res.data.data);

            this.$toast.success("Tribe Created");
            this.$bvModal.hide("start");
          }
        });
    },
    updatetribe() {
      this.$http
        .post(
          `${process.env.VUE_APP_API_PATH}/tribes/${this.tribe.id}`,
          this.tribe,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status === 200) {
            this.gegetmytribe();
            this.$toast.success("Tribe Updated");
            this.$bvModal.hide("start");
          }
        });
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
            });
        }
      });
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


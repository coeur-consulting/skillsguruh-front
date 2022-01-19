<template>
  <div class="pt-sm-4">
    <b-container>
      <b-form @submit.prevent="creatediscussion">
        <b-form-group label="Title">
          <b-form-input
            placeholder="Give a title"
            v-model="discussion.name"
            required
          ></b-form-input>
        </b-form-group>

        <b-form-group label="Description">
          <b-form-textarea
            required
            v-model="discussion.description"
            placeholder="Write a brief Description"
          ></b-form-textarea
        ></b-form-group>

        <b-form-row>
          <b-col sm="6">
            <b-form-group label="Type">
              <b-form-select v-model="discussion.type">
                <b-form-select-option value="private"
                  >Private</b-form-select-option
                >
                <b-form-select-option value="public"
                  >Public</b-form-select-option
                >
              </b-form-select>
            </b-form-group>
          </b-col>
          <!-- <b-col sm="6" v-if="discussion.type == 'private'">
            <b-form-group label="Select course">
              <model-list-select
                :list="courses"
                v-model="discussion.course_id"
                option-value="id"
                option-text="title"
                placeholder="Select course"
              >
              </model-list-select>
            </b-form-group>
          </b-col> -->
        </b-form-row>

        <b-form-group label="Category">
          <model-list-select
            :list="category"
            v-model="discussion.category"
            option-value="value"
            option-text="value"
            placeholder="select category"
          >
          </model-list-select>
        </b-form-group>

        <b-form-group label="Interests">
          <multi-select
            :options="filteredinterests"
            :selected-options="discussion.tags"
            placeholder="select interests"
            @select="onSelect"
          >
          </multi-select>
        </b-form-group>

        <b-button
          size="lg"
          variant="dark-green"
          type="submit"
          class="d-none d-sm-block px-3"
          >Update</b-button
        >
        <b-button
          size="lg"
          variant="dark-green"
          type="submit"
          class="d-sm-none"
          block
          >Update</b-button
        >
      </b-form>
    </b-container>
  </div>
</template>

<script>
import Interest from "@/components/helpers/subcategory.js";
import Category from "@/components//helpers/category.js";
import { MultiSelect } from "vue-search-select";
import { ModelListSelect } from "vue-search-select";
export default {
  props: {
    information: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      show: "recent",
      discussion_id: null,

      discussions: [],
      trenddiscussions: [],
      interestdiscussions: [],
      customdiscussions: [],
      recentdiscussions: [],
      courses: [],
      otherdiscussion: [],

      tag: "",
      tags: [],
      mytags: [],
      showDiscussion: false,
      showOther: false,
      rows: null,
      search: "",
      options: [],
      searchText: "", // If value is falsy, reset searchText & searchItem
      items: [],
      lastSelectItem: {},
      category: [],
      discussion: {},
    };
  },
  components: {
    ModelListSelect,
    MultiSelect,
  },
  watch: {
    information: "setDiscussion",
  },
  mounted() {
    this.category = Category;
    this.mytags = Interest.map((item) => {
      item.text = item.value;

      return item;
    });

    // this.getcourses();
    this.setDiscussion();
  },
  computed: {
    filteredinterests() {
      if (this.discussion.category) {
        var cat = this.category.find(
          (val) => val.value == this.discussion.category
        );

        return this.mytags.filter((item) => item.category_id == cat.id);
      }
      return [];
    },
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
  },
  methods: {
    setDiscussion() {
      this.discussion = this.$props.information;
      this.discussion.category = this.$props.information.category.value;
      this.discussion.tags = this.$props.information.tags;
    },
    getcustomdiscussions() {
      this.$http
        .get(`${this.$store.getters.url}/custom/discussions`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.customdiscussions = res.data;
            this.showDiscussion = true;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    onSelect(items, lastSelectItem) {
      this.discussion.tags = items;
      this.lastSelectItem = lastSelectItem;
    },

    // getcourses() {
    //   this.$http
    //     .get(`${this.$store.getters.url}/guest/courses`)
    //     .then((res) => {
    //       if (res.status == 200) {
    //         this.courses = res.data;
    //       }
    //     })
    //     .catch((err) => {
    //       this.$toast.error(err.response.data.message);
    //     });
    // },

    creatediscussion() {
      this.$http
        .put(
          `${this.$store.getters.url}/discussions/${this.discussion.id}`,
          this.discussion,
          {
            headers: {
              Authorization: `Bearer ${this.useraccess.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 201 || res.status == 200) {
            this.$toast.success("Discussion created");
            this.$emit("refresh");
            this.$bvModal.hide("start");
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
.top_header div {
  font-size: 14px;
  color: rgba($color: #000000, $alpha: 0.54);
  position: relative;
  padding: 10px 12px;
  cursor: pointer;
  text-transform: capitalize;
}
.top_header div::after {
  content: "";
  position: absolute;
  bottom: 0;
  width: 100%;
  border-bottom: 2px solid transparent;
  left: 0;
}
.top_header div:hover::after {
  border-color: var(--dark-green);
}
.top_header div.active::after {
  border-color: var(--dark-green);
}
.top_header div.active {
  color: var(--dark-green);
}
.main_content {
  min-height: 70vh;
  max-height: 70vh;
  overflow-y: auto;
}
.content {
}
.side_dis {
  width: 15%;
  text-align: center;
}
.next_dis {
  width: 85%;
}
.asked {
  font-size: 12px;
  color: rgba($color: #000000, $alpha: 0.54);
}
.title {
  font-size: 15px;
  font-weight: 500;
  color: rgba($color: #000000, $alpha: 0.64);
}

.bottom_bar {
  width: 85%;
  margin-left: auto;
  padding: 13px;
  border-radius: 4px;
  background: #fbfbfb;
  font-size: 12px;
  margin-top: 14px;
}
.related_quest {
  border-radius: 8px;
}
.related {
  font-size: 12px;
}

.drop {
  position: absolute;
  top: 0;
  right: 15px;
}
</style>

<template>
  <div>
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
 <b-form-row>
        <b-col md="6">
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
        </b-col>
        <b-col md="6">
          <b-form-group label="Interests">
            <multi-select
              :options="filteredinterests"
              :selected-options="tribe.tags"
              placeholder="select interests"
              @select="onSelect"
            >
            </multi-select>
          </b-form-group>
        </b-col>
      </b-form-row>

      <b-form-group label="Access Fee">
        <b-form-row>
          <b-col>
            <b-form-radio v-model="tribe.type" value="free"
              >Free</b-form-radio
            ></b-col
          >
           <b-col>
            <b-form-radio v-model="tribe.type" value="private"
              >Private</b-form-radio
            ></b-col
          >
          <b-col>
            <b-form-radio v-model="tribe.type" value="paid"
              >Paid</b-form-radio
            ></b-col
          >
        </b-form-row>
         <div v-if="tribe.type == 'paid'">
          <small
            >Have you saved your account details?
             <router-link to="/me/profile/#account"
              ><span class="text-dark-green"
                >Click here to save</span
              ></router-link
            ></small
          >
        </div>
      </b-form-group>
     <b-form-group label="Access Fee" v-if="tribe.type == 'paid'">
        <b-input-group prepend="NGN">
          <b-form-input
            placeholder="Amount"
            v-model="tribe.amount"
          ></b-form-input>
        </b-input-group>
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
  </div>
</template>

<script>
import { MultiSelect } from "vue-search-select";
import { ModelListSelect } from "vue-search-select";
import Interest from "@/components/helpers/subcategory.js";
import Category from "@/components/helpers/category.js";
import Cover from "@/components/UploadComponent";
export default {
  props: {
    tribe: { type: Object, required: true },
  },
  data() {
    return {
      search: "",

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
      accountStatus:false
    };
  },
  components: {
    MultiSelect,
    ModelListSelect,
    Cover,
  },
  computed: {
    filteredinterests() {
      if (!this.$props.tribe.category) return [];
      return this.mytags.filter(
        (item) => item.category_id == this.$props.tribe.category.id
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

    this.getbankdetail();
  },
  beforeDestroy() {
    this.$emit("resetTribe");
  },
  methods: {
      getbankdetail() {
      this.$http
        .get(`${this.$store.getters.url}/get/bank/detail`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          this.accountStatus = true;
          this.bankdetail = res.data;
          this.tribe.bank_name = res.data.bank_name;
          this.tribe.bank_code = res.data.bank_code;
          this.tribe.account_no = res.data.account_no;
          this.showdetails = true;
        })
        .catch(() => {
          this.accountStatus = false;
        });
    },
    getUpload(val) {
      this.tribe.cover = val;
    },
    onSelect(items, lastSelectItem) {
      this.tribe.tags = items;
      this.lastSelectItem = lastSelectItem;
    },

    updatetribe() {
        if(!this.accountStatus){
              this.$toast.info('No bank record found')
              return;
            }
      this.$http
        .put(
          `${process.env.VUE_APP_API_PATH}/tribes/${this.$props.tribe.id}`,
          this.$props.tribe,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status === 200) {

            this.$emit("response", "edit", res.data.data);
          }
        }).catch(err=>{
          this.$toast.error(err.response.data.message)
        });
    },
  },
};
</script>
<style scoped lang="scss">
</style>


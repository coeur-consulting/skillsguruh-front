<template>
  <div>
    <b-form @submit.prevent="createtribe">
      <b-form-group label="Name">
        <b-form-input
          placeholder="Give a title"
          v-model="tribe.name"
          required
          max="25"
        ></b-form-input>
      </b-form-group>

      <b-form-group label="Description">
        <b-form-textarea
          required
          v-model="tribe.description"
          placeholder="Write a brief Description"
          max="150"
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
      </b-form-group>

      <b-form-group label="Access Fee" v-if="tribe.type == 'paid'">
        <b-input-group prepend="NGN">
          <b-form-input
            placeholder="Amount"
            v-model="tribe.amount"
          ></b-form-input>
        </b-input-group>
      </b-form-group>
      <b-form-row v-if="bankdetail && price == 'paid'">
        <b-col sm="6">
          <b-form-group label="Bank Name">
            <div class="form-group">
              <select class="form-control" v-model="bank_id">
                <option :value="null" disabled>Select your bank</option>
                <option :value="bank.id" v-for="(bank, id) in banks" :key="id">
                  {{ bank.name }}
                </option>
              </select>
            </div>
          </b-form-group>
        </b-col>
        <b-col sm="6">
          <b-form-group label="Account number">
            <b-form-input
              type="number"
              placeholder="Provide your account number"
              v-model="tribe.account_no"
            ></b-form-input></b-form-group
        ></b-col>
      </b-form-row>
      <b-form-group label="Tribe Image">
        <Cover @getUpload="getUpload" />
      </b-form-group>

      <div class="text-center mt-4">
        <b-button
          size="lg"
          variant="dark-green"
          type="submit"
          class="d-none d-sm-block px-3"
          :disabled="disable"
          >Create</b-button
        >
        <b-button
          size="lg"
          variant="dark-green"
          type="submit"
          class="d-sm-none"
          block
          :disabled="disable"
          >Create</b-button
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
        type: "free",
        bank_name: "",
        bank_code: "",
        account_no: "",
      },
      bankdetail: {},
      bank_id: null,
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
      banks: [],
      showdetails: false,
      disable: false,
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
    this.getbanks();
    this.getbankdetail();
  },

  methods: {
    handleBank() {
      var bank = this.banks.find((item) => item.id == this.bank_id);
      if (!bank) {
        return;
      }
      this.tribe.bank_name = bank.name;
      this.tribe.bank_code = bank.code;
    },
    getbanks() {
      this.$http.get(`${this.$store.getters.url}/get/banks`).then((res) => {
        this.banks = res.data;
      });
    },
    getbankdetail() {
      this.$http
        .get(`${this.$store.getters.url}/get/bank/detail`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          this.bankdetail = res.data;
          this.tribe.bank_name = res.data.bank_name;
          this.tribe.bank_code = res.data.bank_code;
          this.tribe.account_no = res.data.account_no;
          this.showdetails = true;
        });
    },
    getUpload(val) {
      this.tribe.cover = val;
    },
    onSelect(items, lastSelectItem) {
      this.tribe.tags = items;
      this.lastSelectItem = lastSelectItem;
    },

    createtribe() {
      this.disable = true;
      this.$http
        .post(`${process.env.VUE_APP_API_PATH}/tribes`, this.tribe, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status === 201) {
            this.$emit("response", "create", res.data.data);
            this.disable = false;
          }
        })
        .catch(() => {
          this.$toast.error("Fill all fields");
          this.disable = false;
        });
    },
  },
};
</script>
<style scoped lang="scss">
</style>


<template>
  <div class="bg-light">
    <b-container class="text-left">
      <b-row
        class="py-3 px-0 p-sm-4 align-items-center justify-content-between"
      >
        <b-col cols="1" sm="2">
          <span @click="$router.go(-1)" class="cursor-pointer back fs13">
            <span class="mr-2">
              <b-icon icon="arrow-left" class=""></b-icon
            ></span>
            <span class="d-none d-sm-inline">Back</span>
          </span>
        </b-col>

        <b-col cols="11" sm="4">
          <b-form-input
            type="search"
            v-model="search"
            placeholder="Search name"
          ></b-form-input>
        </b-col>
      </b-row>
      <b-row class="facilitators justify-content-start">
        <b-col
          cols="4"
          class="mb-5 mb-sm-0 p-0 py-sm-3 px-sm-4"
          v-for="(item, id) in facilitators"
          :key="id"
        >
          <div
            class="position-relative cursor-pointer"
            @click="$router.push(`/profile/f/${item.id}`)"
          >
            <div class="facilitator shadow-sm position-relative bg-white">
              <b-img
                class="rounded-sm mb-4"
                fluid-grow
                :src="
                  item.profile
                    ? item.profile
                    : require('@/assets/images/default.jpeg')
                "
                style="object-fit: cover"
              ></b-img>
              <div class="f_name text-truncate text-truncate--1">
                {{ item.name }}
              </div>
              <div class="text-muted fs13 text-capitalize f_detail">
                <span> {{ item.age ? item.age + " years" : "N/a" }}</span>
                <span v-if="item.gender"
                  >, {{ item.gender ? item.gender : "N/a" }}</span
                >
              </div>

              <div class="text-muted fs13 text-capitalize f_detail">
                {{ item.state ? item.state : "Lagos" }},
                {{ item.country ? item.country : "NG" }}
              </div>
              <div class="text-muted fs12 text-capitalize f_detail">
                {{
                  item.interests
                    ? JSON.parse(item.interests).length + " interests"
                    : "0 intersts"
                }},
              </div>

              <div class="text-muted">
                <small class="f_detail">Facilitator</small>
              </div>
              <!-- <div>
              <b-icon class="text-gold" icon="star-fill"></b-icon>
              <b-icon class="text-gold" icon="star-fill"></b-icon>
              <b-icon class="text-gold" icon="star-fill"></b-icon>
              <b-icon class="text-gold" icon="star-fill"></b-icon>
              <b-icon class="text-gold" icon="star-fill"></b-icon>
            </div> -->
            </div>
            <span class="hover_box"></span>
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
export default {
  data() {
    return {
      facilitators: [],
      search: "",
      currentPage: 1,
      rows: null,
      perPage: 12,
    };
  },
  mounted() {
    this.getfacilitators();
  },
  computed: {
    filteredName() {
      var name = this.facilitators.filter((item) =>
        item.name.includes(this.search)
      );
      return name.slice(
        this.perPage * this.currentPage - this.perPage,
        this.perPage * this.currentPage
      );
    },
  },
  methods: {
    getfacilitators() {
      this.$http
        .get(`${this.$store.getters.url}/guest/facilitators`)
        .then((res) => {
          if (res.status == 200) {
            this.facilitators = res.data;
            this.rows = res.data.length;
          }
        });
    },
  },
};
</script>

<style scoped>
.container {
  min-height: 100vh;
}
#facilitators {
  position: relative;
  padding-top: 8rem;
  padding-bottom: 5rem;
}
.ex-facilitators {
}

.ex-facilitators h2 {
  font-size: 25px;
  font-style: normal;
  font-weight: 600;
  line-height: 33px;
  letter-spacing: 0em;
  text-align: center;
}
.ex-facilitators p {
  font-size: 16px;
  font-style: normal;
  font-weight: 400;
  line-height: 28px;
  letter-spacing: 0.06em;
  text-align: center;
  color: #828282;
}
.facilitators {
  display: flex;
  width: 100%;
  margin: 0 auto;
  justify-content: space-around;
}
.hover_box {
  width: 100%;
  height: 100%;
  background: var(--dark-green);
  position: absolute;
  right: 0px;
  top: 0;
  border-radius: 10px;
  z-index: 0;
  transition: 0.25s;
  opacity: 0;
}
.facilitator {
  padding: 0;
  text-align: left;
  border-radius: 0;
  z-index: 1;
}
.facilitator:hover ~ .hover_box {
  right: -5px;
  transform: rotate(5deg);
  opacity: 1;
}
.facilitator img {
  width: 100%;
}
.facilitator > div {
}
.text-gold {
  color: gold;
}
.facilitator img {
  height: 150px;
  margin-bottom: 0 !important;
  border-radius: 0 0 5px 5px !important;
}
.f_detail,
.f_name {
  font-size: 0.8rem !important;
  padding: 0 15px 1px;
  line-height: 1.4;
}
@media (max-width: 600px) {
  .facilitator {
    border-radius: 0;
    padding: 0;
  }
  .facilitator img {
    height: 100px;
    margin-bottom: 0 !important;
  }
  .f_detail,
  .f_name {
    font-size: 0.6rem !important;
    padding: 0 5px 1px;
  }
}

@media (max-width: 375px) {
  .facilitator {
    border-radius: 0;
    padding: 0;
  }
  .facilitator img {
    height: 100px;
    margin-bottom: 0 !important;
  }
  .f_detail,
  .f_name {
    font-size: 0.55rem !important;
    padding: 0 5px 1px;
  }
}
</style>

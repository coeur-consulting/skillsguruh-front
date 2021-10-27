<template>
  <div class="bg-light">
    <b-container class="text-left">
      <b-row
        class="py-3 px-0 p-sm-4 align-items-center justify-content-between"
      >
        <b-col cols="1" sm="3" md="4">
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
            placeholder="Search username"
          ></b-form-input>
        </b-col>
      </b-row>
      <b-row class="members justify-content-start">
        <b-col
          cols="4"
          sm="3"
          class="mb-0 mb-sm-0 p-0-rem py-sm-3 px-sm-4"
          v-for="(item, id) in filteredName"
          :key="id"
        >
          <div
            class="position-relative cursor-pointer"
            @click="
              item.qualifications
                ? $router.push(`/profile/${item.username}`)
                : $router.push(`/profile/${item.username}`)
            "
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
              <div class="p-1">
                <div class="f_name text-truncate text-truncate--1">
                  {{ item.username ? item.username : `User-${item.id}` }}
                </div>
                <div class="text-muted fs13 f_detail">
                  <span class=""
                    >{{
                      item.age
                        ? `${showInfo($store.getters.show_age, item.age)} yrs, `
                        : "N/a"
                    }}
                    {{ item.gender ? item.gender : "" }}</span
                  >
                </div>

                <div class="text-muted fs13 text-capitalize f_detail">
                  {{ item.state ? item.state : "Lagos" }},
                  {{ item.country ? item.country : "NG" }}
                </div>
                <div class="text-muted fs12 text-capitalize f_detail">
                  {{
                    item.interests
                      ? item.interests.length + " interests"
                      : "0 intersts"
                  }}
                </div>

                <div class="text-muted" v-if="item.qualifications">
                  <small class="f_detail role">Facilitator</small>
                </div>
                <div class="text-muted" v-else>
                  <small class="f_detail role">Member</small>
                </div>
              </div>
            </div>
            <span class="hover_box"></span>
          </div>
        </b-col>
      </b-row>
      <div class="py-3 d-flex justify-content-between" v-if="rows > 10">
        <div class="fs12 text-muted">
          Showing 1-10 of {{ members.length }} items
        </div>
        <b-pagination
          pills
          size="sm"
          variant="dark-green"
          align="right"
          v-model="currentPage"
          :total-rows="rows"
          :per-page="perPage"
        ></b-pagination>
      </div>
    </b-container>
  </div>
</template>

<script>
export default {
  data() {
    return {
      members: [],
      search: "",
      currentPage: 1,
      rows: null,
      perPage: 12,
    };
  },
  mounted() {
    this.getmembers();
  },
  computed: {
    filteredName() {
      var name = this.members.filter((item) =>
        item.username.toLowerCase().includes(this.search.toLowerCase())
      );

      return name.slice(
        this.perPage * this.currentPage - this.perPage,
        this.perPage * this.currentPage
      );
    },
  },
  methods: {
    getmembers() {
      this.$http.get(`${this.$store.getters.url}/get/members`).then((res) => {
        if (res.status == 200) {
          this.members = res.data;
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
#members {
  position: relative;
  padding-top: 8rem;
  padding-bottom: 5rem;
}
.ex-members {
}

.ex-members h2 {
  font-size: 25px;
  font-style: normal;
  font-weight: 600;
  line-height: 33px;
  letter-spacing: 0em;
  text-align: center;
}
.ex-members p {
  font-size: 16px;
  font-style: normal;
  font-weight: 400;
  line-height: 28px;
  letter-spacing: 0.06em;
  text-align: center;
  color: #828282;
}
.members {
  display: flex;
  width: 100%;
  margin: 0 auto;
  justify-content: space-around;
}

.facilitator {
  padding: 0;
  text-align: left;
  border-radius: 10px;
  z-index: 1;
  overflow: hidden;
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
    border-radius: 5px;
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

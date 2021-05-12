<template>
  <div>
    <b-container>
      <b-row>
        <b-col class="mb-5 mb-sm-0">
          <div
            class="d-flex flex-column flex-sm-row justify-content-between align-items-center mb-4"
          >
            <h6 class="mb-3 mb-sm-0">Administrators</h6>
            <div>
              <b-form-input
                placeholder="Search"
                size="sm"
                type="search"
                class="search"
              ></b-form-input>
            </div>
          </div>

          <div class="shadow bg-white">
            <div
              class="d-flex justify-content-between align-items-center p-3 e"
            >
              <b-icon icon="filter"></b-icon>
              <div>
                <b-button variant="dark-green" size="sm">
                  <b-icon
                    icon="plus"
                    @click="$bvModal.show('add')"
                    font-scale="1.5"
                  ></b-icon
                ></b-button>
              </div>
            </div>

            <div class="">
              <b-table-simple class="org_home_table text-left" responsive="sm">
                <b-thead>
                  <b-tr class="text-left">
                    <b-th class="text-muted">Name</b-th>
                    <b-th class="text-muted">Last login</b-th>
                    <b-th class="text-muted">Department</b-th>
                    <b-th class="text-muted">Status</b-th>
                    <b-th></b-th> </b-tr
                ></b-thead>
                <b-tbody>
                  <b-tr>
                    <b-td>
                      <div class="d-flex">
                        <b-avatar size="sm" class="mr-2"></b-avatar>
                        <div class="text-left">
                          <span>John Doe</span> <br />
                          <span class="text-muted">jdoe@gmail.com</span>
                        </div>
                      </div>
                    </b-td>
                    <b-td>
                      <div class="text-left">
                        <span>September 11, 2021</span> <br />
                        <span class="text-muted">2 days ago</span>
                      </div>
                    </b-td>
                    <b-td> Accounting </b-td>
                    <b-td class="text-success text-left">Active</b-td>
                    <b-td><b-icon icon="chevron-down"></b-icon> </b-td>
                  </b-tr>
                  <b-tr>
                    <b-td>
                      <div class="d-flex">
                        <b-avatar size="sm" class="mr-2"></b-avatar>
                        <div class="text-left">
                          <span>John Doe</span> <br />
                          <span class="text-muted">jdoe@gmail.com</span>
                        </div>
                      </div>
                    </b-td>
                    <b-td>
                      <div class="text-left">
                        <span>September 11, 2021</span> <br />
                        <span class="text-muted">2 days ago</span>
                      </div>
                    </b-td>
                    <b-td> Accounting </b-td>
                    <b-td class="text-success text-left">Active</b-td>
                    <b-td><b-icon icon="chevron-down"></b-icon> </b-td>
                  </b-tr>
                  <b-tr>
                    <b-td>
                      <div class="d-flex">
                        <b-avatar size="sm" class="mr-2"></b-avatar>
                        <div class="text-left">
                          <span>John Doe</span> <br />
                          <span class="text-muted">jdoe@gmail.com</span>
                        </div>
                      </div>
                    </b-td>
                    <b-td>
                      <div class="text-left">
                        <span>September 11, 2021</span> <br />
                        <span class="text-muted">2 days ago</span>
                      </div>
                    </b-td>
                    <b-td> Accounting </b-td>
                    <b-td class="text-success text-left">Active</b-td>
                    <b-td><b-icon icon="chevron-down"></b-icon> </b-td>
                  </b-tr>
                </b-tbody>
              </b-table-simple>
              <div class="py-3">
                <b-pagination
                  pills
                  size="sm"
                  variant="dark-green"
                  align="center"
                  v-model="currentPage"
                  :total-rows="rows"
                  :per-page="perPage"
                ></b-pagination>
              </div>
            </div>
          </div>
        </b-col>
      </b-row>
    </b-container>

    <b-modal id="add" hide-footer centered size="lg"> </b-modal>
  </div>
</template>
<script>
export default {
  data() {
    return {
      search: "",
      currentPage: 1,
      rows: 3,
      perPage: 2,
      users: [],
    };
  },
  computed: {
    filter() {
      return this.users
        .filter((item) =>
          item.name.toLowerCase().includes(this.search.toLowerCase())
        )
        .slice(
          this.perPage * this.currentPage - this.perPage,
          this.perPage * this.currentPage
        );
    },
  },
};
</script>
<style scoped lang="scss">
.container {
  padding-top: 30px;
}
.shadow {
  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
  border-radius: 8px;
}
.search.form-control {
  width: 250px;
  border: 1px solid rgba($color: #000000, $alpha: 0.07) !important;
}
.search::placeholder {
  color: rgba($color: #000000, $alpha: 0.2);
}
</style>

<template>
  <div id="topbar">
    <span>
      <b-input-group size="sm" class="mb-2 topbar_search">
        <b-input-group-prepend is-text>
          <b-icon icon="search" font-scale="1" class="text-muted"></b-icon>
        </b-input-group-prepend>
        <b-form-input
          placeholder="Search"
          class="bg-transparent border-0"
          type="search"
          aria-label="Text input "
        ></b-form-input> </b-input-group
    ></span>
    <div class="d-flex align-items-center">
      <b-icon
        id="bell"
        icon="bell"
        font-scale="1.2"
        class="mr-4 text-dark-green"
      ></b-icon>
      <b-popover target="bell" triggers="hover" placement="bottom">
        <template #title>Notifications</template>
        <div class="noti">I am notification!</div>
      </b-popover>
      <b-icon
        icon="envelope"
        font-scale="1.2"
        class="mr-4 text-muted cursor-pointer"
      ></b-icon>
      <b-avatar id="profile" class="cursor-pointer" size="30px"></b-avatar>
      <b-popover target="profile" id="prof" triggers="click" placement="bottom">
        <div class="">Log out</div>
      </b-popover>
    </div>
  </div>
</template>

<style scoped>
#topbar {
  height: 80px;
  background: #f8f7f7;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;
}
.noti {
  width: 300px;
}
</style>

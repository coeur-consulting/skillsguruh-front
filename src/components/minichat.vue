<template>
  <div class="reply_box bg-white shadow border">
    <div class="d-flex px-3 py-2 align-items-center border-bottom">
      <div class="d-flex flex-1 align-items-center">
        <b-avatar size="2rem" class="mr-2"></b-avatar>
        <span class="chat_name">John Doe</span>
      </div>
      <div class="d-flex align-items-center">
        <b-icon
          class="mr-3 cursor-pointer"
          icon="arrows-angle-expand"
          @click="open = !open"
        ></b-icon>
        <b-icon font-scale="1.5" class="cursor-pointer" icon="x"></b-icon>
      </div>
    </div>
    <div v-if="open">
      <div class="reply py-3 text-left">
        <div class="left_text mb-1">
          <div class="d-flex flex-1 align-items-center mb-1">
            <b-avatar size="1.5rem" class="mr-2"></b-avatar>
            <span class="chatting_name font-weight-bold mr-3">John Doe</span>
            <span class="chatting_name"> 3:14 am</span>
          </div>
          <span
            >Lorem ipsum dolor sit, amet consectetur adipisicing elit.
            Architecto, animi!</span
          >
        </div>
        <div class="right_text mb-1">
          <div
            class="d-flex flex-1 align-items-center mb-1 justify-content-end"
          >
            <b-avatar size="1.5rem" class="mr-2"></b-avatar>
            <span class="chatting_name font-weight-bold mr-3">Jane Doe</span>
            <span class="chatting_name"> 3:14 am</span>
          </div>
          <span
            >Lorem ipsum dolor sit, amet consectetur adipisicing elit.
            Architecto, animi!</span
          >
        </div>
        <div class="left_text mb-1">
          <div class="d-flex flex-1 align-items-center mb-1">
            <b-avatar size="1.5rem" class="mr-2"></b-avatar>
            <span class="chatting_name font-weight-bold mr-3">John Doe</span>
            <span class="chatting_name"> 3:14 am</span>
          </div>
          <span
            >Lorem ipsum dolor sit, amet consectetur adipisicing elit.
            Architecto, animi!</span
          >
        </div>
        <div class="right_text mb-1">
          <div
            class="d-flex flex-1 align-items-center mb-1 justify-content-end"
          >
            <b-avatar size="1.5rem" class="mr-2"></b-avatar>
            <span class="chatting_name font-weight-bold mr-3">Jane Doe</span>
            <span class="chatting_name"> 3:14 am</span>
          </div>
          <span
            >Lorem ipsum dolor sit, amet consectetur adipisicing elit.
            Architecto, animi!</span
          >
        </div>
        <div class="left_text mb-1">
          <div class="d-flex flex-1 align-items-center mb-1">
            <b-avatar size="1.5rem" class="mr-2"></b-avatar>
            <span class="chatting_name font-weight-bold mr-3">John Doe</span>
            <span class="chatting_name"> 3:14 am</span>
          </div>
          <span
            >Lorem ipsum dolor sit, amet consectetur adipisicing elit.
            Architecto, animi!</span
          >
        </div>
        <div class="right_text mb-1">
          <div
            class="d-flex flex-1 align-items-center mb-1 justify-content-end"
          >
            <b-avatar size="1.5rem" class="mr-2"></b-avatar>
            <span class="chatting_name font-weight-bold mr-3">Jane Doe</span>
            <span class="chatting_name"> 3:14 am</span>
          </div>
          <span
            >Lorem ipsum dolor sit, amet consectetur adipisicing elit.
            Architecto, animi!</span
          >
        </div>
      </div>
      <div class="text-left px-1 pb-1 border-top">
        <b-input-group class="mt-1">
          <template #append>
            <b-input-group-text class="border-0 bg-transparent">
              <b-icon
                font-scale="1"
                icon="cursor-fill
"
                class="text-dark-green cursor-pointer"
              ></b-icon>
            </b-input-group-text>
          </template>
          <template #prepend>
            <b-input-group-text class="border-0 bg-transparent"
              ><span class=""
                ><b-icon
                  icon="emoji-smile-fill"
                  class="text-dark-green cursor-pointer"
                  font-scale="1"
                ></b-icon></span
            ></b-input-group-text>
          </template>
          <b-form-input
            size="sm"
            autocomplete="off"
            autocorrect="off"
            placeholder="Type here .."
            class="border-0 no-focus"
          ></b-form-input>
        </b-input-group>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      open: false,
    };
  },
};
</script>
<style scoped lang="scss">
.rounded-8 {
  border-radius: 8px;
}

.reply_box {
  position: fixed;
  bottom: 0;
  width: 330px;
  left: 30%;
  border-radius: 10px 10px 0 0;
}
.reply {
  height: 360px;
  overflow: scroll;
}
.left_text {
  font-size: 12px;
  padding: 10px;
  background-color: #fbfbfb;
  border-radius: 0 10px 10px 0;
  width: 90%;
  margin-right: auto;
}
.right_text {
  font-size: 12px;
  padding: 10px;
  border-radius: 10px;
  width: 90%;
  margin-left: auto;
}
.chat_name {
  font-size: 13px;
  font-weight: bold;
}
.chatting_name {
  font-size: 12px;
}
</style>

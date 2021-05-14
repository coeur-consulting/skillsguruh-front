<template>
  <div class="messages shadow-sm rounded-8 bg-white pb-3 pt-1">
    <div class="d-flex p-3 align-items-center border-bottom">
      <h6 class="flex-1 text-left">Messaging</h6>
      <b-icon icon="chevron-down"></b-icon>
    </div>
    <div class="px-3 py-2 mb-2">
      <div class="px-3 py-2 d-flex align-items-center search">
        <b-icon icon="search"></b-icon>
        <b-form-input
          autocomplete="off"
          autocorrect="off"
          size="sm"
          class="flex-1 border-0 no-focus search-bg"
          type="search"
          placeholder="Search name"
        ></b-form-input>
        <b-icon icon="sliders"></b-icon>
      </div>
    </div>

    <div class="message_box py-3">
      <div class="message active px-3 py-3 d-flex">
        <b-avatar size="2.2rem"></b-avatar>
        <div class="message_text flex-1 px-2">
          <span class="message_name">Jonny Cage</span> <br />
          <div class="last_message">
            lorem oh no non nono oh non ono nonon onono non
          </div>
        </div>

        <div>
          <span class="message_time"> 2:20 pm</span>
        </div>
      </div>
      <div class="message d-flex px-3 py-3">
        <b-avatar size="2.2rem"></b-avatar>
        <div class="message_text flex-1 px-2">
          <span class="message_name">Jonny Cage</span> <br />
          <div class="last_message">
            lorem oh no non nono oh non ono nonon onono non
          </div>
        </div>

        <div>
          <span class="message_time"> 2:20 pm</span>
        </div>
      </div>
      <div class="message d-flex px-3 py-3">
        <b-avatar size="2.2rem"></b-avatar>
        <div class="message_text flex-1 px-2">
          <span class="message_name">Jonny Cage</span> <br />
          <div class="last_message">
            lorem oh no non nono oh non ono nonon onono non
          </div>
        </div>

        <div>
          <span class="message_time"> 2:20 pm</span>
        </div>
      </div>
      <div class="message d-flex px-3 py-3">
        <b-avatar size="2.2rem"></b-avatar>
        <div class="message_text flex-1 px-2">
          <span class="message_name">Jonny Cage</span> <br />
          <div class="last_message">
            lorem oh no non nono oh non ono nonon onono non
          </div>
        </div>

        <div>
          <span class="message_time"> 2:20 pm</span>
        </div>
      </div>
      <div class="message d-flex px-3 py-3">
        <b-avatar size="2.2rem"></b-avatar>
        <div class="message_text flex-1 px-2">
          <span class="message_name">Jonny Cage</span> <br />
          <div class="last_message">
            lorem oh no non nono oh non ono nonon onono non
          </div>
        </div>

        <div>
          <span class="message_time"> 2:20 pm</span>
        </div>
      </div>
      <div class="message d-flex px-3 py-3">
        <b-avatar size="2.2rem"></b-avatar>
        <div class="message_text flex-1 px-2">
          <span class="message_name">Jonny Cage</span> <br />
          <div class="last_message">
            lorem oh no non nono oh non ono nonon onono non
          </div>
        </div>

        <div>
          <span class="message_time"> 2:20 pm</span>
        </div>
      </div>
      <div class="message d-flex px-3 py-3">
        <b-avatar size="2.2rem"></b-avatar>
        <div class="message_text flex-1 px-2">
          <span class="message_name">Jonny Cage</span> <br />
          <div class="last_message">
            lorem oh no non nono oh non ono nonon onono non
          </div>
        </div>

        <div>
          <span class="message_time"> 2:20 pm</span>
        </div>
      </div>
      <div class="message d-flex px-3 py-3">
        <b-avatar size="2.2rem"></b-avatar>
        <div class="message_text flex-1 px-2">
          <span class="message_name">Jonny Cage</span> <br />
          <div class="last_message">
            lorem oh no non nono oh non ono nonon onono non
          </div>
        </div>

        <div>
          <span class="message_time"> 2:20 pm</span>
        </div>
      </div>
      <div class="message d-flex px-3 py-3">
        <b-avatar size="2.2rem"></b-avatar>
        <div class="message_text flex-1 px-2">
          <span class="message_name">Jonny Cage</span> <br />
          <div class="last_message">
            lorem oh no non nono oh non ono nonon onono non
          </div>
        </div>

        <div>
          <span class="message_time"> 2:20 pm</span>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {};
  },
};
</script>
<style scoped lang="scss">
.rounded-8 {
  border-radius: 8px;
}

.messages {
  position: fixed;
  top: 13%;
  width: 350px;
  right: 2%;
}
.search {
  background: #fbfbfb;
  border-radius: 8px;
}
.search-bg {
  background: #fbfbfb;
}
.message_box {
  height: 68.5vh;
  overflow: scroll;
}
.message_text {
  line-height: 1.4;
  text-align: left;
}
.message_name {
  font-size: 13px;
  font-weight: bold;
  color: rgba($color: #000000, $alpha: 0.64);
}
.last_message {
  font-size: 12px;
  color: rgba($color: #000000, $alpha: 0.54);
  display: -webkit-box;
  line-clamp: 1;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
}
.message_time {
  font-size: 11px;
  color: rgba($color: #000000, $alpha: 0.44);
}
.message.active,
.message:hover {
  background: #f7f8fa;
  cursor: pointer;
}
</style>

<template>
  <div class="pb-5 pt-4">
    <b-container>
      <b-row>
        <b-col sm="8">
          <div class="shadow-sm bg-white p-4 rounded-8 mb-4">
            <div class="d-flex align-items-center mb-3">
              <b-avatar size="2.5rem" class="mr-3"></b-avatar>
              <b-form-input
                class="rounded-pill"
                size="lg"
                placeholder="Whats on your mind john?"
              ></b-form-input>
            </div>

            <div class="d-flex justify-content-around event">
              <div>
                <b-img
                  :src="require('@/assets/images/advert.svg')"
                  width="18px"
                  class="mr-1"
                ></b-img>
                Image
              </div>
              <div>
                <b-img
                  :src="require('@/assets/images/youtube.svg')"
                  width="18px"
                  class="mr-1"
                ></b-img
                >Video
              </div>
              <div>
                <b-img
                  :src="require('@/assets/images/event.svg')"
                  width="18px"
                  class="mr-1"
                ></b-img>
                Event
              </div>
            </div>
          </div>

          <div class="feed-content">
            <div class="shadow-sm bg-white rounded-8 mb-4">
              <div class="d-flex mb-3 px-3 pt-3">
                <div class="d-flex flex-1 text-left">
                  <b-avatar class="mr-2"></b-avatar>
                  <div class="profile">
                    <span class="name">John Doe</span> <br />
                    <span class="date">May 5</span>
                  </div>
                </div>
                <b-icon icon="three-dots" font-scale="1.4"></b-icon>
              </div>
              <div class="text-left feed_text px-4 pb-3">
                <span
                  >Lorem, ipsum dolor sit amet consectetur adipisicing elit.
                  Dicta, tenetur vitae minima debitis excepturi nostrum soluta
                  odit quaerat provident consectetur.</span
                >
              </div>
              <div>
                <b-img
                  fluid-grow
                  :src="require('@/assets/images/feed.png')"
                ></b-img>
              </div>
              <div class="interactions text-left px-3 py-3">
                <span class="mr-3">
                  <b-icon icon="star-fill" class="text-blue"></b-icon> 5
                  stars</span
                >
                <span class="mr-3"
                  ><b-icon icon="heart-fill" class="text-danger"></b-icon> 21
                  likes</span
                >
                <span class="mr-3">
                  <b-icon icon="chat-fill"></b-icon> 21 comments</span
                >
                <span class="cursor-pointer">
                  <b-icon icon="share"></b-icon>
                </span>
              </div>
              <div class="comments px-3 pt-2 border-top text-left">
                <span class="comment_header">View all 28 comments</span>
                <div class="all_comment">
                  <div class="comment d-flex text-left mb-1">
                    <div class="flex-1 pr-2">
                      <span class="font-weight-bold mr-2"> John Doe</span>
                      <span>Lorem ipsum dolor sit amet.</span>
                    </div>
                    <b-icon icon="heart"></b-icon>
                  </div>
                  <div class="comment d-flex text-left mb-1">
                    <div class="flex-1 pr-2">
                      <span class="font-weight-bold mr-2"> John Doe</span>
                      <span>Lorem ipsum dolor sit amet.</span>
                    </div>
                    <b-icon icon="heart"></b-icon>
                  </div>
                </div>
              </div>
              <div class="px-3 py-1 comment_header mb-1 text-left">
                29 minutes ago
              </div>
              <div class="interact text-left px-3 pb-1 border-top">
                <b-input-group class="mt-1">
                  <template #append>
                    <b-input-group-text class="border-0 bg-transparent d-block"
                      ><span class="text-dark-green cursor-pointer"
                        >Post</span
                      ></b-input-group-text
                    >
                  </template>
                  <template #prepend>
                    <b-input-group-text class="border-0 bg-transparent d-block"
                      ><span class=""
                        ><b-icon
                          icon="emoji-smile-fill"
                          class="text-dark-green cursor-pointer"
                          font-scale="1.5"
                        ></b-icon></span
                    ></b-input-group-text>
                  </template>
                  <b-form-textarea
                    size="sm"
                    autocomplete="off"
                    autocorrect="off"
                    rows="1"
                    placeholder="Add comment"
                    class="border-0 no-focus"
                  ></b-form-textarea>
                </b-input-group>
              </div>
            </div>
            <div class="shadow-sm bg-white rounded-8 mb-4">
              <div class="d-flex mb-3 px-3 pt-3">
                <div class="d-flex flex-1 text-left">
                  <b-avatar class="mr-2"></b-avatar>
                  <div class="profile">
                    <span class="name">John Doe</span> <br />
                    <span class="date">May 5</span>
                  </div>
                </div>
                <b-icon icon="three-dots" font-scale="1.4"></b-icon>
              </div>
              <div class="text-left feed_text px-4 pb-3">
                <span
                  >Lorem, ipsum dolor sit amet consectetur adipisicing elit.
                  Dicta, tenetur vitae minima debitis excepturi nostrum soluta
                  odit quaerat provident consectetur.</span
                >
              </div>
              <div>
                <b-img
                  fluid-grow
                  :src="require('@/assets/images/feed.png')"
                ></b-img>
              </div>
              <div class="interactions text-left px-3 py-3">
                <span class="mr-3">
                  <b-icon icon="star-fill" class="text-blue"></b-icon> 5
                  stars</span
                >
                <span class="mr-3"
                  ><b-icon icon="heart-fill" class="text-danger"></b-icon> 21
                  likes</span
                >
                <span class="mr-3">
                  <b-icon icon="chat-fill"></b-icon> 21 comments</span
                >
                <span class="cursor-pointer">
                  <b-icon icon="share"></b-icon>
                </span>
              </div>
              <div class="comments px-3 pt-2 border-top text-left">
                <span class="comment_header">View all 28 comments</span>
                <div class="all_comment">
                  <div class="comment d-flex text-left mb-1">
                    <div class="flex-1 pr-2">
                      <span class="font-weight-bold mr-2"> John Doe</span>
                      <span>Lorem ipsum dolor sit amet.</span>
                    </div>
                    <b-icon icon="heart"></b-icon>
                  </div>
                  <div class="comment d-flex text-left mb-1">
                    <div class="flex-1 pr-2">
                      <span class="font-weight-bold mr-2"> John Doe</span>
                      <span>Lorem ipsum dolor sit amet.</span>
                    </div>
                    <b-icon icon="heart"></b-icon>
                  </div>
                </div>
              </div>
              <div class="px-3 py-1 comment_header mb-1 text-left">
                29 minutes ago
              </div>
              <div class="interact text-left px-3 pb-1 border-top">
                <b-input-group class="mt-1">
                  <template #append>
                    <b-input-group-text class="border-0 bg-transparent d-block"
                      ><span class="text-dark-green cursor-pointer"
                        >Post</span
                      ></b-input-group-text
                    >
                  </template>
                  <template #prepend>
                    <b-input-group-text class="border-0 bg-transparent d-block"
                      ><span class=""
                        ><b-icon
                          icon="emoji-smile-fill"
                          class="text-dark-green cursor-pointer"
                          font-scale="1.5"
                        ></b-icon></span
                    ></b-input-group-text>
                  </template>
                  <b-form-textarea
                    size="sm"
                    autocomplete="off"
                    autocorrect="off"
                    rows="1"
                    placeholder="Add comment"
                    class="border-0 no-focus"
                  ></b-form-textarea>
                </b-input-group>
              </div>
            </div>
            <div class="shadow-sm bg-white rounded-8 mb-4">
              <div class="d-flex mb-3 px-3 pt-3">
                <div class="d-flex flex-1 text-left">
                  <b-avatar class="mr-2"></b-avatar>
                  <div class="profile">
                    <span class="name">John Doe</span> <br />
                    <span class="date">May 5</span>
                  </div>
                </div>
                <b-icon icon="three-dots" font-scale="1.4"></b-icon>
              </div>
              <div class="text-left feed_text px-4 pb-3">
                <span
                  >Lorem, ipsum dolor sit amet consectetur adipisicing elit.
                  Dicta, tenetur vitae minima debitis excepturi nostrum soluta
                  odit quaerat provident consectetur.</span
                >
              </div>
              <div>
                <b-img
                  fluid-grow
                  :src="require('@/assets/images/feed.png')"
                ></b-img>
              </div>
              <div class="interactions text-left px-3 py-3">
                <span class="mr-3">
                  <b-icon icon="star-fill" class="text-blue"></b-icon> 5
                  stars</span
                >
                <span class="mr-3"
                  ><b-icon icon="heart-fill" class="text-danger"></b-icon> 21
                  likes</span
                >
                <span class="mr-3">
                  <b-icon icon="chat-fill"></b-icon> 21 comments</span
                >
                <span class="cursor-pointer">
                  <b-icon icon="share"></b-icon>
                </span>
              </div>
              <div class="comments px-3 pt-2 border-top text-left">
                <span class="comment_header">View all 28 comments</span>
                <div class="all_comment">
                  <div class="comment d-flex text-left mb-1">
                    <div class="flex-1 pr-2">
                      <span class="font-weight-bold mr-2"> John Doe</span>
                      <span>Lorem ipsum dolor sit amet.</span>
                    </div>
                    <b-icon icon="heart"></b-icon>
                  </div>
                  <div class="comment d-flex text-left mb-1">
                    <div class="flex-1 pr-2">
                      <span class="font-weight-bold mr-2"> John Doe</span>
                      <span>Lorem ipsum dolor sit amet.</span>
                    </div>
                    <b-icon icon="heart"></b-icon>
                  </div>
                </div>
              </div>
              <div class="px-3 py-1 comment_header mb-1 text-left">
                29 minutes ago
              </div>
              <div class="interact text-left px-3 pb-1 border-top">
                <b-input-group class="mt-1">
                  <template #append>
                    <b-input-group-text class="border-0 bg-transparent d-block"
                      ><span class="text-dark-green cursor-pointer"
                        >Post</span
                      ></b-input-group-text
                    >
                  </template>
                  <template #prepend>
                    <b-input-group-text class="border-0 bg-transparent d-block"
                      ><span class=""
                        ><b-icon
                          icon="emoji-smile-fill"
                          class="text-dark-green cursor-pointer"
                          font-scale="1.5"
                        ></b-icon></span
                    ></b-input-group-text>
                  </template>
                  <b-form-textarea
                    size="sm"
                    autocomplete="off"
                    autocorrect="off"
                    rows="1"
                    placeholder="Add comment"
                    class="border-0 no-focus"
                  ></b-form-textarea>
                </b-input-group>
              </div>
            </div>
          </div>
        </b-col>
        <Message class="d-none d-md-block" />
      </b-row>

      <div class="minichats d-none d-md-block">
        <Minichat />
      </div>
    </b-container>
  </div>
</template>
<script>
import Minichat from "../minichat";
import Message from "../messagecomponent";
export default {
  data() {
    return {
      open: false,
    };
  },
  components: {
    Minichat,
    Message,
  },
};
</script>
<style scoped lang="scss">
.rounded-8 {
  border-radius: 8px;
}
.feed-content {
}
.event {
  width: 80%;
  margin: 0 auto;
}
.event div {
  font-size: 14px;
}
.profile {
  line-height: 1.2;
}
.name {
  font-size: 14px;
}
.date {
  font-size: 12px;
  color: rgba($color: #000000, $alpha: 0.44);
}
.feed_text {
  font-size: 14px;
  color: rgba($color: #000000, $alpha: 0.54);
}
.interactions {
  font-size: 12px;
}
.form-control.no-focus:focus {
  outline: none !important;
  box-shadow: unset;
}
.form-control.no-focus {
  font-size: 13px;
}
.comment_header {
  font-size: 12px;
  color: rgba($color: #000000, $alpha: 0.44);
}
.comment {
  font-size: 12px;
  color: rgba($color: #000000, $alpha: 0.64);
}
.messages {
  position: fixed;
  top: 13%;
  width: 350px;
}
.search {
  background: #fbfbfb;
  border-radius: 8px;
}
.search-bg {
  background: #fbfbfb;
}
.message_box {
  height: 68vh;
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

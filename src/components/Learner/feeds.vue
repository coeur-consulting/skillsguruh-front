/* eslint-disable no-unused-vars */
<template>
  <b-container fluid class="px-1 px-sm 4">
    <div class="pb-5 pt-4">
      <b-modal
        no-close-on-backdrop
        id="feed"
        hide-footer
        centered
        title="Create feed"
        size="md"
      >
        <div class="wrapper mb-2">
          <b-form-input
            class="rounded-pill stat border-0"
            size="lg"
            v-model="feed.message"
            :placeholder="
              'Whats on your mind ' + $store.getters.learner.name + '?'
            "
          ></b-form-input>

          <emoji-picker
            class="d-none d-md-block"
            @emoji="insertfeed"
            :search="search"
          >
            <div
              class="emoji-invoker"
              slot="emoji-invoker"
              slot-scope="{ events: { click: clickEvent } }"
              @click.stop="clickEvent"
            >
              <svg
                height="24"
                viewBox="0 0 24 24"
                width="24"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path d="M0 0h24v24H0z" fill="none" />
                <path
                  d="M11.99 2C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8zm3.5-9c.83 0 1.5-.67 1.5-1.5S16.33 8 15.5 8 14 8.67 14 9.5s.67 1.5 1.5 1.5zm-7 0c.83 0 1.5-.67 1.5-1.5S9.33 8 8.5 8 7 8.67 7 9.5 7.67 11 8.5 11zm3.5 6.5c2.33 0 4.31-1.46 5.11-3.5H6.89c.8 2.04 2.78 3.5 5.11 3.5z"
                />
              </svg>
            </div>
            <div slot="emoji-picker" slot-scope="{ emojis, insert }">
              <div class="emoji-picker">
                <div class="emoji-picker__search">
                  <input type="text" v-model="search" v-focus />
                </div>
                <div>
                  <div v-for="(emojiGroup, category) in emojis" :key="category">
                    <h5>{{ category }}</h5>
                    <div class="emojis">
                      <span
                        v-for="(emoji, emojiName) in emojiGroup"
                        :key="emojiName"
                        @click="insert(emoji)"
                        :title="emojiName"
                        >{{ emoji }}</span
                      >
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </emoji-picker>
        </div>
        <div>
          <h6 class="text-muted fs11 mb-2">Add tags</h6>
          <multi-select
            :options="options"
            :selected-options="feed.tags"
            placeholder="select item"
            @select="onSelect"
          >
          </multi-select>
        </div>

        <div class="mb-4 position-relative media border rounded">
          <FeedUpload
            @getUpload="getUpload"
            :id="'edit'"
            class="position-absolute edit_button"
          >
            <div class="bg-lighter-green fs12 px-3 py-1 rounded cursor-pointer">
              Edit
            </div>
          </FeedUpload>
          <b-img
            v-if="feed.media && img_ext.includes(getextension(feed.media))"
            fluid-grow
            :src="feed.media"
          ></b-img>
          <video
            width="100%"
            v-if="feed.media && vid_ext.includes(getextension(feed.media))"
            :src="feed.media"
            class="fluid-grow"
            controls
          ></video>
          <div
            v-if="feed.media && doc_ext.includes(getextension(feed.media))"
            class="text-center p-3 p-sm-4 bg-skills-grey"
          >
            <b-icon icon="image" font-scale="3rem"></b-icon>
          </div>
        </div>
        <div class="d-flex justify-content-around my-3 border rounded p-2">
          <div>
            <FeedUpload @getUpload="getUpload" :id="'image'">
              <b-img
                :src="require('@/assets/images/advert.svg')"
                width="18px"
                class="mr-1 cursor-pointer"
              ></b-img>
              Image
            </FeedUpload>
          </div>
          <div>
            <FeedUpload @getUpload="getUpload" :id="'video'">
              <b-img
                :src="require('@/assets/images/youtube.svg')"
                width="18px"
                class="mr-1 cursor-pointer"
              ></b-img
              >Video
            </FeedUpload>
          </div>
          <div>
            <FeedUpload @getUpload="getUpload" :id="'event'">
              <b-img
                :src="require('@/assets/images/event.svg')"
                width="18px"
                class="mr-1 cursor-pointer"
              ></b-img>
              Event
            </FeedUpload>
          </div>
        </div>
        <b-button @click="post" block variant="dark-green">Post</b-button>
      </b-modal>

      <b-modal
        no-close-on-backdrop
        id="allcomments"
        hide-footer
        centered
        title="Comments"
        size="md"
      >
        <div class="comments" v-if="allcomments">
          <div class="mb-4">
            <div class="d-flex mb-3 pt-3">
              <div class="d-flex flex-1 text-left">
                <div
                  class="font-weight-bold mr-2 mb-1"
                  v-if="allcomments.admin"
                >
                  <b-avatar
                    class="mr-2"
                    :src="allcomments.admin.profile"
                    size="3rem"
                  ></b-avatar>
                </div>
                <div class="font-weight-bold mr-2 mb-1" v-if="allcomments.user">
                  <b-avatar
                    class="mr-2"
                    size="3rem"
                    :src="allcomments.user.profile"
                  ></b-avatar>
                </div>
                <div
                  class="font-weight-bold mr-2 mb-1"
                  v-if="allcomments.facilitator"
                >
                  <b-avatar
                    size="3rem"
                    class="mr-2"
                    :src="allcomments.facilitator.profile"
                  ></b-avatar>
                </div>
                <div class="profile">
                  <span class="name" v-if="allcomments.admin">{{
                    allcomments.admin.name
                  }}</span>
                  <span class="name" v-if="allcomments.user">{{
                    allcomments.user.name
                  }}</span>
                  <span class="name" v-if="allcomments.facilitator">{{
                    allcomments.facilitator.name
                  }}</span>
                  <br />
                  <span class="date fs11">{{
                    allcomments.created_at | moment("ll")
                  }}</span>
                </div>
              </div>
            </div>
            <div class="text-left feed_text px-3 px-sm-4 pb-3">
              <span>{{ allcomments.message }}</span>
            </div>
          </div>
          <div class="comments">
            <div
              class="comment d-flex text-left mb-2"
              v-for="(item, index) in allcomments.comments"
              :key="index"
            >
              <b-col cols="9">
                <div class="flex-1 pr-2">
                  <div class="font-weight-bold mr-2 mb-1" v-if="item.admin">
                    <b-avatar
                      class="mr-2"
                      size="sm"
                      :src="item.admin.profile"
                    ></b-avatar>
                    {{ item.admin.name }}
                  </div>
                  <div class="font-weight-bold mr-2 mb-1" v-if="item.user">
                    <b-avatar
                      class="mr-2"
                      size="sm"
                      :src="item.user.profile"
                    ></b-avatar>
                    {{ item.user.name }}
                  </div>
                  <div
                    class="font-weight-bold mr-2 mb-1"
                    v-if="item.facilitator"
                  >
                    <b-avatar
                      class="mr-2"
                      size="sm"
                      :src="item.facilitator.profile"
                    ></b-avatar>
                    {{ item.facilitator.name }}
                  </div>

                  <div>{{ item.comment }}</div>
                </div>
              </b-col>
              <b-col cols="3">
                <div>
                  <span class="fs11">{{
                    item.created_at | moment("calendar")
                  }}</span>
                </div></b-col
              >
            </div>
          </div>
        </div>
      </b-modal>
      <b-container>
        <b-row>
          <b-col sm="8" class="px-0">
            <div class="border bg-white py-3 px-2 p-sm-4 rounded-8 mb-4">
              <div class="d-flex align-items-center mb-3">
                <b-avatar
                  class="mr-2"
                  size="3rem"
                  :src="$store.getters.learner.profile"
                ></b-avatar>

                <b-form-input
                  class="rounded-pill stat cursor-pointer"
                  size="lg"
                  readonly
                  @click="$bvModal.show('feed')"
                  :placeholder="
                    'Whats on your mind ' + $store.getters.learner.name + '?'
                  "
                ></b-form-input>
              </div>

              <div class="d-flex justify-content-around event">
                <div @click="$bvModal.show('feed')">
                  <b-img
                    :src="require('@/assets/images/advert.svg')"
                    width="18px"
                    class="mr-1 cursor-pointer"
                  ></b-img>
                  Image
                </div>
                <div @click="$bvModal.show('feed')">
                  <b-img
                    :src="require('@/assets/images/youtube.svg')"
                    width="18px"
                    class="mr-1 cursor-pointer"
                  ></b-img
                  >Video
                </div>
                <div @click="$bvModal.show('feed')">
                  <b-img
                    :src="require('@/assets/images/event.svg')"
                    width="18px"
                    class="mr-1 cursor-pointer"
                  ></b-img>
                  Event
                </div>
              </div>
            </div>

            <div v-if="showFeeds">
              <div v-if="feeds.length">
                <div class="feed-content">
                  <div
                    v-for="(feed, index) in feeds"
                    :key="index"
                    class="border bg-white rounded-8 mb-2"
                  >
                    <div class="d-flex mb-3 px-2 px-sm-3 pt-3">
                      <div class="d-flex flex-1 text-left">
                        <div
                          class="font-weight-bold mr-2 mb-1 fs14"
                          v-if="feed.admin"
                        >
                          <b-avatar
                            class="mr-2"
                            :src="feed.admin.profile"
                          ></b-avatar>
                        </div>
                        <div
                          class="font-weight-bold mr-2 mb-1 fs14"
                          v-if="feed.user"
                        >
                          <b-avatar
                            class="mr-2"
                            :src="feed.user.profile"
                          ></b-avatar>
                        </div>
                        <div
                          class="font-weight-bold mr-2 mb-1 fs14"
                          v-if="feed.facilitator"
                        >
                          <b-avatar
                            class="mr-2"
                            :src="feed.facilitator.profile"
                          ></b-avatar>
                        </div>
                        <div class="profile">
                          <span class="name" v-if="feed.admin">{{
                            feed.admin.name
                          }}</span>
                          <span class="name" v-if="feed.user">{{
                            feed.user.name
                          }}</span>
                          <span
                            @click="
                              $router.push(
                                `/learner/facilitator/${feed.facilitator.id}`
                              )
                            "
                            class="name"
                            v-if="feed.facilitator"
                            >{{ feed.facilitator.name }}</span
                          >

                          <br />
                          <span class="date">{{
                            feed.created_at | moment("ll")
                          }}</span>
                        </div>
                      </div>

                      <b-dropdown
                        v-if="
                          feed.user && feed.user.id == $store.getters.learner.id
                        "
                        size="sm"
                        variant="transparent"
                        no-caret
                        class="no-focus"
                      >
                        <template #button-content>
                          <b-icon icon="three-dots" font-scale="1.4"></b-icon>
                        </template>

                        <b-dropdown-item
                          class="fs12"
                          @click="drop(feed.id, index)"
                          v-if="
                            feed.user &&
                            feed.user.id == $store.getters.learner.id
                          "
                          >Delete</b-dropdown-item
                        >
                      </b-dropdown>
                    </div>
                    <div class="text-left feed_text px-3 pb-3">
                      <div class="mb-2" v-html="feed.message"></div>

                      <div v-if="feed.url" class="text-dark-green">
                        <a :href="feed.url" target="_blank">Click link</a>
                      </div>
                      <div v-if="feed.tags" class="px-1">
                        <b-row class="justify-content-start">
                          <b-col
                            sm="auto"
                            class="px-1"
                            v-for="(tag, id) in JSON.parse(feed.tags)"
                            :key="id"
                          >
                            <b-badge
                              class="fs11 text-black-50"
                              variant="lighter-green"
                              >#{{ tag.text }}</b-badge
                            >
                          </b-col>
                        </b-row>
                      </div>
                    </div>
                    <div>
                      <div class="mb-4 position-relative">
                        <b-img
                          v-if="
                            feed.media &&
                            img_ext.includes(getextension(feed.media))
                          "
                          fluid-grow
                          :src="feed.media"
                        ></b-img>
                        <video
                          width="100%"
                          controls
                          v-if="
                            feed.media &&
                            vid_ext.includes(getextension(feed.media))
                          "
                          :src="feed.media"
                          class="fluid-grow"
                        ></video>
                        <div
                          v-if="
                            feed.media &&
                            doc_ext.includes(getextension(feed.media))
                          "
                          class="text-center p-3 p-sm-4 bg-skills-grey"
                        >
                          <b-icon icon="image" font-scale="3rem"></b-icon>
                        </div>
                      </div>
                    </div>
                    <div class="interactions text-left px-3 py-3 border-bottom">
                      <span
                        class="mr-3 cursor-pointer"
                        @click="toggleStar(feed.id, index)"
                      >
                        <b-icon
                          :icon="
                            feed.stars.find(
                              (item) =>
                                item.star &&
                                item.user_id == $store.getters.learner.id
                            )
                              ? 'star-fill'
                              : 'star'
                          "
                          class="text-blue mr-1"
                        ></b-icon>
                        <span>{{
                          feed.stars.filter((item) => item.star).length
                        }}</span>
                        stars</span
                      >
                      <span
                        class="mr-3 cursor-pointer"
                        @click="toggleLike(feed.id, index)"
                        ><b-icon
                          :icon="
                            feed.likes.find(
                              (item) =>
                                item.like &&
                                item.user_id == $store.getters.learner.id
                            )
                              ? 'heart-fill'
                              : 'heart'
                          "
                          class="text-danger mr-1"
                        ></b-icon>
                        <span>{{
                          feed.likes.filter((item) => item.like).length
                        }}</span>
                        likes</span
                      >
                      <span class="mr-3">
                        <b-icon icon="chat-fill" class="mr-1"></b-icon>
                        <span
                          ><span>{{ feed.comments.length }}</span></span
                        >
                        comments</span
                      >
                      <span class="cursor-pointer">
                        <b-icon icon="share"></b-icon>
                      </span>
                    </div>
                    <div
                      class="comments px-3 pt-2 border-bottom text-left"
                      v-if="feed.comments.length"
                    >
                      <span
                        v-if="feed.comments.length"
                        class="comment_header mb-2 cursor-pointer"
                        @click="showcomments(feed)"
                        >View all {{ feed.comments.length }} comments</span
                      >
                      <div class="all_comment">
                        <div
                          class="comment d-flex text-left mb-1"
                          v-for="item in feed.comments.slice(0, 2)"
                          :key="item.id"
                        >
                          <div class="flex-1 pr-2">
                            <span
                              class="font-weight-bold mr-2"
                              v-if="item.admin"
                            >
                              {{ item.admin.name }}</span
                            >
                            <span
                              class="font-weight-bold mr-2"
                              v-if="item.user"
                            >
                              {{ item.user.name }}</span
                            >
                            <span
                              class="font-weight-bold mr-2"
                              v-if="item.facilitator"
                              @click="
                                $router.push(
                                  `/learner/facilitator/${item.facilitator.id}`
                                )
                              "
                            >
                              {{ item.facilitator.name }}</span
                            >
                            <span>{{ item.comment }}</span>
                          </div>
                          <div>
                            <span class="fs11">{{
                              item.created_at | moment("calendar")
                            }}</span>
                          </div>
                        </div>
                      </div>
                    </div>
                    <!-- <div class="px-3 py-1 comment_header mb-1 text-left">
                  {{ feed.created_at | moment("calendar") }}
                </div> -->
                    <div class="interact text-left px-3 pb-1">
                      <b-input-group class="mt-1">
                        <template #append>
                          <b-input-group-text
                            class="border-0 bg-transparent d-block"
                            ><span
                              @click="addcomment(feed.id, index)"
                              class="text-dark-green cursor-pointer"
                              >Post</span
                            ></b-input-group-text
                          >
                        </template>
                        <template #prepend class="d-none d-md-block">
                          <b-input-group-text
                            class="border-0 bg-transparent d-none d-md-block"
                          >
                            <emoji-picker
                              @emoji="insertcomment"
                              :search="search"
                            >
                              <div
                                class="emoji-invoker2"
                                slot="emoji-invoker"
                                slot-scope="{ events: { click: clickEvent } }"
                                @click.stop="clickEvent"
                              >
                                <svg
                                  height="24"
                                  viewBox="0 0 24 24"
                                  width="24"
                                  xmlns="http://www.w3.org/2000/svg"
                                >
                                  <path d="M0 0h24v24H0z" fill="none" />
                                  <path
                                    d="M11.99 2C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8zm3.5-9c.83 0 1.5-.67 1.5-1.5S16.33 8 15.5 8 14 8.67 14 9.5s.67 1.5 1.5 1.5zm-7 0c.83 0 1.5-.67 1.5-1.5S9.33 8 8.5 8 7 8.67 7 9.5 7.67 11 8.5 11zm3.5 6.5c2.33 0 4.31-1.46 5.11-3.5H6.89c.8 2.04 2.78 3.5 5.11 3.5z"
                                  />
                                </svg>
                              </div>
                              <div
                                slot="emoji-picker"
                                slot-scope="{ emojis, insert }"
                              >
                                <div class="emoji-picker picker">
                                  <div class="emoji-picker__search">
                                    <input
                                      type="text"
                                      v-model="search"
                                      v-focus
                                    />
                                  </div>
                                  <div>
                                    <div
                                      v-for="(emojiGroup, category) in emojis"
                                      :key="category"
                                    >
                                      <h5>{{ category }}</h5>
                                      <div class="emojis">
                                        <span
                                          v-for="(
                                            emoji, emojiName
                                          ) in emojiGroup"
                                          :key="emojiName"
                                          @click="insert(emoji)"
                                          :title="emojiName"
                                          >{{ emoji }}</span
                                        >
                                      </div>
                                    </div>
                                  </div>
                                </div>
                              </div>
                            </emoji-picker>
                          </b-input-group-text>
                        </template>
                        <b-form-input
                          autocomplete="off"
                          autocorrect="off"
                          rows="1"
                          v-model="comment.comment"
                          placeholder="Add comment"
                          class="border-0 no-focus"
                        ></b-form-input>
                      </b-input-group>
                    </div>
                  </div>
                </div>
              </div>
              <div v-else class="text-center p-3 p-sm-4">No feed Available</div>
            </div>
            <div v-else class="p-3 p-sm-4">
              <div class="d-flex w-100 mb-3 box">
                <div class="mr-2">
                  <b-skeleton type="avatar"></b-skeleton>
                </div>
                <div class="w-100">
                  <div class="mb-3">
                    <b-skeleton-img no-aspect height="150px"></b-skeleton-img>
                  </div>
                  <b-skeleton animation="wave" width="85%"></b-skeleton>
                  <b-skeleton animation="wave" width="35%"></b-skeleton>
                </div>
              </div>
              <div class="d-flex w-100 mb-3 box">
                <div class="mr-2">
                  <b-skeleton type="avatar"></b-skeleton>
                </div>
                <div class="w-100">
                  <div class="mb-3">
                    <b-skeleton-img no-aspect height="150px"></b-skeleton-img>
                  </div>
                  <b-skeleton animation="wave" width="85%"></b-skeleton>
                  <b-skeleton animation="wave" width="35%"></b-skeleton>
                </div>
              </div>
              <div class="d-flex w-100 mb-3 box">
                <div class="mr-2">
                  <b-skeleton type="avatar"></b-skeleton>
                </div>
                <div class="w-100">
                  <div class="mb-3">
                    <b-skeleton-img no-aspect height="150px"></b-skeleton-img>
                  </div>
                  <b-skeleton animation="wave" width="85%"></b-skeleton>
                  <b-skeleton animation="wave" width="35%"></b-skeleton>
                </div>
              </div>
            </div>
          </b-col>
          <Message class="d-none d-md-block" :user="'learner'" />
        </b-row>
      </b-container>
    </div>
  </b-container>
</template>
<script>
import EmojiPicker from "vue-emoji-picker";
import FeedUpload from "../feedupload";
import Message from "../messagecomponent";
import { MultiSelect } from "vue-search-select";
import Interest from "../insight.js";
export default {
  data() {
    return {
      options: [],
      searchText: "", // If value is falsy, reset searchText & searchItem
      items: [],
      lastSelectItem: {},
      open: false,
      feeds: [],
      search: "",
      allcomments: [],
      feed: {
        media: "",
        message: "",
        tags: [],
      },
      img_ext: ["jpg", "png", "jpeg", "gif"],
      vid_ext: ["mp4", "3gp", "flv", "mov"],
      aud_ext: ["mp3", "aac"],
      doc_ext: ["docx", "pdf", "ppt", "zip"],
      comment: {
        comment: "",
        id: "",
      },
      mini_info: {
        id: "",
        name: "",
        type: "",
        profile: "",
      },
      showFeeds: false,
    };
  },
  components: {
    Message,
    EmojiPicker,
    FeedUpload,
    MultiSelect,
  },
  created() {
    var channel = this.$pusher.subscribe("addfeed");

    channel.bind("addfeed", (data) => {
      this.feeds.unshift(data.message);
    });
    this.options = Interest.map((item) => {
      var res = {};
      res.text = item.value;
      res.value = item.value;
      res.color = item.color;
      res.icon = item.icon;
      return res;
    });
  },
  mounted() {
    this.getfeeds();
    // this.getmyfeeds();
  },
  methods: {
    onSelect(items, lastSelectItem) {
      this.feed.tags = items;
      this.lastSelectItem = lastSelectItem;
    },
    // deselect option
    reset() {
      this.tags = []; // reset
    },
    showcomments(feed) {
      this.allcomments = feed;
      this.$bvModal.show("allcomments");
    },
    getextension(fileName) {
      if (fileName) {
        var regex = new RegExp("[^.]+$");
        var extension = fileName.match(regex);

        return extension[0];
      }
    },
    getUpload(val) {
      if (
        !this.img_ext.includes(this.getextension(val)) &&
        !this.vid_ext.includes(this.getextension(val)) &&
        !this.aud_ext.includes(this.getextension(val)) &&
        !this.doc_ext.includes(this.getextension(val))
      ) {
        this.$toast.error("Unsupported content type !");
        return;
      }

      this.feed.media = val;
    },
    insertfeed(emoji) {
      this.feed.message += emoji + "";
    },
    insertcomment(emoji) {
      this.comment.comment += emoji + "";
    },
    getmyfeeds() {
      this.$http
        .get(`${this.$store.getters.url}/feeds/tags`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        // .then((res) => {
        //   if (res.status == 201 || res.status == 200) {

        //   }
        // })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    getfeeds() {
      this.$http
        .get(`${this.$store.getters.url}/feeds`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201 || res.status == 200) {
            this.feeds = res.data;
            this.showFeeds = true;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    post() {
      if (!this.feed.message) {
        return;
      }
      this.$http
        .post(`${this.$store.getters.url}/feeds`, this.feed, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201 || res.status == 200) {
            this.$toast.success("Feed Updated ");
            this.$bvModal.hide("feed");
            // this.feeds.unshift(res.data);

            this.feed = {
              media: "",
              message: "",
            };
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    addcomment(id, index) {
      if (!this.comment.comment) {
        this.$toast.info("Type a comment ");
        return;
      }
      this.comment.id = id;

      this.$http
        .post(`${this.$store.getters.url}/feed-comments`, this.comment, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.$toast.success("Comment updated ");
            // this.$bvModal.hide("feed");

            this.feeds[index].comments.unshift(res.data);

            this.comment = {
              comment: "",
              id: "",
            };
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    toggleLike(id, index) {
      this.$http
        .post(
          `${this.$store.getters.url}/feed-likes`,
          { id },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 201) {
            this.feeds[index].likes.push(res.data);
          }
          if (res.status == 200) {
            this.feeds[index].likes.map((item) => {
              if (item.user_id == this.$store.getters.learner.id) {
                return (item.like = res.data.like);
              }
            });
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    toggleStar(id, index) {
      this.$http
        .post(
          `${this.$store.getters.url}/feed-stars`,
          { id },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 201) {
            this.feeds[index].stars.push(res.data);
          }
          if (res.status == 200) {
            this.feeds[index].stars.map((item) => {
              if (item.user_id == this.$store.getters.learner.id) {
                return (item.star = res.data.star);
              }
            });
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    drop(id, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/feeds/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success("Feed deleted");
                this.feeds.splice(index, 1);
              }
            })
            .catch((err) => {
              this.$toast.error(err.response.data.message);
            });
        }
      });
    },
  },
};
</script>
<style scoped lang="scss">
.stat {
  height: 50px;
}
.wrapper {
  position: relative;
  width: 100%;
}
.text-post {
  width: 85%;
  margin-left: auto;
}
.regular-input {
  padding: 0.5rem 1rem;
  border-radius: 3px;
  border: 1px solid #ccc;
  height: 7rem;
  outline: none;
}

.regular-input:focus {
  box-shadow: 0 0 0 3px rgba(66, 153, 225, 0.5);
}

.emoji-invoker {
  position: absolute;
  top: 0.5rem;
  right: 0.5rem;
  width: 1.5rem;
  height: 1.5rem;
  border-radius: 50%;
  cursor: pointer;
  transition: all 0.2s;
}
.emoji-invoker:hover {
  transform: scale(1.1);
}
.emoji-invoker > svg {
  fill: #b1c6d0;
}
.emoji-invoker2 {
  width: 1.5rem;
  height: 1.5rem;
  border-radius: 50%;
  cursor: pointer;
  transition: all 0.2s;
}
.emoji-invoker2:hover {
  transform: scale(1.1);
}
.emoji-invoker2 > svg {
  fill: #b1c6d0;
}

.emoji-picker {
  position: absolute;
  z-index: 1;
  font-family: Montserrat;
  border: 1px solid #ccc;
  width: 15rem;
  height: 20rem;
  overflow: scroll;
  padding: 1rem;
  box-sizing: border-box;
  border-radius: 0.5rem;
  background: #fff;
  box-shadow: 1px 1px 8px #c7dbe6;
  top: 40px;
  right: -150px;
}
.emoji-picker.picker {
  position: absolute;
  z-index: 1;
  font-family: Montserrat;
  border: 1px solid #ccc;
  width: 15rem;
  height: 20rem;
  overflow: scroll;
  padding: 1rem;
  box-sizing: border-box;
  border-radius: 0.5rem;
  background: #fff;
  box-shadow: 1px 1px 8px #c7dbe6;
  top: unset;
  bottom: 60px;
  right: -150px;
}
.emoji-picker__search {
  display: flex;
}
.emoji-picker__search > input {
  flex: 1;
  border-radius: 10rem;
  border: 1px solid #ccc;
  padding: 0.5rem 1rem;
  outline: none;
}
.emoji-picker h5 {
  margin-bottom: 0;
  color: #b1b1b1;
  text-transform: uppercase;
  font-size: 0.8rem;
  cursor: default;
}
.emoji-picker .emojis {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}
.emoji-picker .emojis:after {
  content: "";
  flex: auto;
}
.emoji-picker .emojis span {
  padding: 0.2rem;
  cursor: pointer;
  border-radius: 5px;
}
.emoji-picker .emojis span:hover {
  background: #ececec;
  cursor: pointer;
}

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

.search {
  background: #fbfbfb;
  border-radius: 8px;
}
.search-bg {
  background: #fbfbfb;
}

.edit_button {
  display: none;
}
.media:hover .edit_button {
  display: block;
}
</style>

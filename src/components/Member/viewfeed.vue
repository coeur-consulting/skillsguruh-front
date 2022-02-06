<template>
  <div class="bg-light">
    <b-container class="main-card py-sm-5" v-if="feed">
      <div class="text-left mb-3">
        <span @click="$router.go(-1)" class="cursor-pointer back fs13">
          <span class="mr-2">
            <b-icon icon="arrow-left" class=""></b-icon
          ></span>
          <span class="d-none d-sm-inline">Back</span>
        </span>
      </div>
      <b-row>
        <b-col>
          <b-card no-body class="">
            <b-row no-gutters>
              <b-col md="7" class="text-left  px-md-0 py-md-4 border-right">
                <div
                  class="
                    d-flex
                    justify-content-between
                    p-3
                    px-md-2
                    d-md-none
                    border-bottom
                  "
                >
                  <div class="d-flex align-items-center" v-if="feed.user">
                    <b-avatar
                      :src="feed.user.profile"
                      size="sm"
                      class="mr-2"
                    ></b-avatar>
                    <div
                      @click="$router.push(`/me/profile/${feed.user.username}`)"
                      class="feed_name"
                    >
                      {{ feed.user.username }}
                    </div>
                  </div>

                  <b-dropdown
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
                        feed.user && feed.user.id == $store.getters.member.id
                      "
                      >Delete</b-dropdown-item
                    >
                    <b-dropdown-item
                      v-if="
                        feed.user && feed.user.id !== $store.getters.member.id
                      "
                      class="fs12"
                      >Report
                    </b-dropdown-item>
                  </b-dropdown>
                </div>
                <div>
                  <p
                    class="p-3"
                    v-html="$options.filters.tagsfilter(feed.message)"
                  ></p>
                  <div v-if="feed.url" class="text-dark-green mb-1">
                    <a :href="feed.url" target="_blank">Click link</a>
                  </div>

                  <div class="px-1" v-if="feed.media && feed.media.length">
                    <div class="mb-4 position-relative w-100 media bg-white">
                      <b-carousel
                        v-if="feed.mediaType === 'image'"
                        id="carousel-fade"
                        style="text-shadow: 0px 0px 2px #000"
                        indicators
                        :interval="0"
                      >
                        <b-carousel-slide
                          v-for="(item, id) in feed.media"
                          :key="id"
                          background="#000"
                        >
                          <template #img>
                            <img
                              class="d-block img-fluid w-100"
                              width="1024"
                              height="480"
                              :src="item"
                              alt="image"
                            />
                          </template>
                        </b-carousel-slide>
                      </b-carousel>
                      <video
                        v-if="feed.mediaType === 'video'"
                        controls
                        width="100%"
                        height="480"
                        :src="feed.media[0]"
                      ></video>
                    </div>
                  </div>
                </div>
              </b-col>
              <b-col md="5">
                <b-card-body
                  class="text-left px-0 d-flex flex-column h-100 pb-0"
                >
                  <div class="justify-content-between px-3 d-none d-md-flex">
                    <div class="d-flex align-items-center" v-if="feed.user">
                      <b-avatar
                        :src="feed.user.profile"
                        size="sm"
                        class="mr-2"
                      ></b-avatar>
                      <div
                        @click="
                          $router.push(`/me/profile/${feed.user.username}`)
                        "
                        class="feed_name"
                      >
                        {{ feed.user.username }}
                      </div>
                    </div>

                    <b-dropdown
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
                          feed.user && feed.user.id == $store.getters.member.id
                        "
                        >Delete</b-dropdown-item
                      >
                      <b-dropdown-item
                        class="fs12"
                        v-if="feed.user.id !== $store.getters.member.id"
                        >Report post</b-dropdown-item
                      >
                    </b-dropdown>
                  </div>

                  <hr />
                  <div class="comments py-2 px-3 flex-1">
                    <div v-if="feed.comments.length" class="comment_header">
                      View {{ feed.comments.length }}
                      {{ feed.comments.length > 1 ? "comments" : "comment" }}
                    </div>
                    <b-card-text
                      v-for="(comment, id) in feed.comments"
                      :key="id"
                      style="line-height: 1"
                      class="mb-2"
                    >
                      <span
                        class="comment_name mr-1"
                        @click="
                          $router.push(`/me/profile/${comment.user.username}`)
                        "
                        v-if="comment.user"
                        >{{ comment.user.username }}</span
                      >

                      <span
                        class="comment_text mr-2"
                        v-html="$options.filters.tagsfilter(comment.comment)"
                      >
                      </span>
                      <div
                        class="
                          d-flex
                          justify-content-between
                          align-items-center
                        "
                      >
                        <div class="replyfeed d-flex justify-content-between align-items-center">
                          <span>
                            <small
                              class="text-muted mr-2"
                              @click="handlereplycomment(comment, id)"
                              >Reply
                            </small>
                            <small>
                              <span class="mr-1">{{
                                  comment.likeCount ? comment.likeCount : ""
                                }}</span>
                              <b-icon
                                v-b-tooltip.hover
                                title="Like comment"
                                class="mr-2 text-danger"
                                :icon="comment.isLiked ? 'heart-fill' : 'heart'"
                                @click="likecomment(comment.id, id)"
                              ></b-icon>
                            </small>
                          </span>

                          <b-icon
                            icon="trash"
                             font-scale=".8"
                            v-if="$store.getters.member.id === feed.user_id"
                            @click="dropcomment(comment.id, id)"
                          ></b-icon>
                        </div>

                        <div
                          v-if="comment.commentreplycount"
                          class="replyfeed text-muted"
                          @click="handlereplies(comment)"
                        >
                          <small>
                            View {{ comment.commentreplycount }}
                            {{
                              comment.commentreplycount > 1
                                ? "replies"
                                : "reply"
                            }}</small
                          >
                        </div>
                      </div>
                    </b-card-text>
                  </div>
                  <hr />
                  <div class="border-bottom">
                    <div class="interactions text-left py-1 px-3">
                      <span
                        class="mr-2 cursor-pointer"
                        @click="toggleLike(feed.id)"
                        v-b-tooltip.hover
                        title="Like post"
                      >
                        <b-icon
                          font-scale="1.1"
                          :icon="feed.isLiked ? 'heart-fill' : 'heart'"
                          class="mr-1 text-danger"
                        ></b-icon>
                      </span>

                      <span class="mr-3">
                        <b-icon
                          font-scale="1.1"
                          icon="chat"
                          class="mr-1"
                        ></b-icon>
                        <span
                          ><span>{{ feed.comments.length }}</span></span
                        >
                      </span>
                      <span class="cursor-pointer flex-1 text-right"
                        ><b-icon
                          @click="sharenow(feed)"
                          icon="
                            share
                          "
                          class=""
                        ></b-icon>
                      </span>
                    </div>
                    <div
                      v-if="feed.likesCount"
                      class="liked_by px-3"
                      @click="showlikes(feed)"
                      v-html="getlikes(feed.likesCount)"
                    ></div>

                    <div class="fs10 text-muted py-1 px-3 text-right">
                      {{ $moment(feed.created_at).fromNow() }}
                    </div>
                  </div>

                  <div class="interact text-left">
                    <b-input-group class="py-1">
                      <template #append>
                        <b-input-group-text
                          class="border-0 bg-transparent d-block"
                          ><span
                            @click="addcomment(feed.id, index)"
                            class="
                              text-dark-green
                              cursor-pointer
                              comment_post
                              fs14
                            "
                            >Post</span
                          ></b-input-group-text
                        >
                      </template>
                      <template #prepend class="">
                        <b-input-group-text class="border-0 bg-transparent">
                          <emoji-picker @emoji="insertcomment" :search="search">
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
                                  <input type="text" v-model="search" v-focus />
                                </div>
                                <div>
                                  <div
                                    v-for="(emojiGroup, category) in emojis"
                                    :key="category"
                                  >
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
                        </b-input-group-text>
                      </template>

                      <a-mentions
                        v-model="comment.comment"
                        type="text"
                        autocomplete="off"
                        placeholder="Leave comment"
                        class="rounded-pill no-focus"
                      >
                        <a-mentions-option
                          v-for="(item, id) in connections"
                          :key="id"
                          :value="item"
                        >
                          {{ item }}
                        </a-mentions-option>
                      </a-mentions>
                    </b-input-group>
                  </div>
                </b-card-body>
              </b-col>
            </b-row>
          </b-card>
        </b-col>
      </b-row>
    </b-container>
    <b-modal no-close-on-backdrop id="alllikes" hide-footer centered>
      <template #modal-title>
        <div
          class="font-weight-bold"
          v-if="alllikes"
          v-html="alllikes.message"
        ></div>
      </template>
      <div class="comments" v-if="alllikes">
        <div class="comments">
          <h6>Liked by</h6>
          <b-row>
            <b-col
              cols="6"
              class="comment d-flex text-left mb-2"
              v-for="(item, index) in alllikes.likes.filter((val) => val.like)"
              :key="index"
            >
              <div class="flex-1">
                <div class="flex-1 pr-2">
                  <div class="d-flex mb-1" v-if="item.admin">
                    <div class="d-flex flex-1">
                      <b-avatar
                        class="mr-2"
                        size="sm"
                        :src="item.admin.profile"
                      ></b-avatar>
                      <div>
                        <div class="comment_name">
                          {{ item.admin.name }}
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="d-flex mb-1" v-if="item.user">
                    <div
                      class="d-flex flex-1"
                      @click="$router.push(`/me/profile/${item.user.username}`)"
                    >
                      <b-avatar
                        class="mr-2"
                        size="sm"
                        :src="item.user.profile"
                      ></b-avatar>
                      <div>
                        <div class="comment_name">
                          {{ item.user.username }}
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="d-flex mb-1" v-if="item.facilitator">
                    <div
                      class="d-flex flex-1"
                      @click="
                        $router.push(`/me/profile/f/${item.facilitator.id}`)
                      "
                    >
                      <b-avatar
                        class="mr-2"
                        size="sm"
                        :src="item.facilitator.profile"
                      ></b-avatar>
                      <div>
                        <div class="comment_name">
                          {{ item.facilitator.username }}
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </b-col>
          </b-row>
        </div>
      </div>
    </b-modal>
    <b-modal id="share" hide-footer centered size="lg">
      <div class="p-2 text-center">
        <h6 class="font-weight-bold mb-3">Share</h6>
        <ShareNetwork
          class="mr-3"
          network="facebook"
          :url="link"
          title="Check out my new feed post on Nzùkóór:"
          :description="description"
          quote="Nzukoor"
          hashtags="Nzukoor,  Social learning"
        >
          <b-button size="sm" class="mb-2 mb-sm-0" variant="outline-dark-green"
            ><b-icon class="mr-1" icon="facebook"></b-icon>
            <span class="d-none d-md-block">Facebook</span></b-button
          >
        </ShareNetwork>
        <ShareNetwork
          class="mr-3"
          network="twitter"
          :url="link"
          title="Check out my new feed post on Nzùkóór:"
          :description="description"
          quote="Nzukoor"
          hashtags="Nzukoor,  Social learning"
        >
          <b-button size="sm" class="mb-2 mb-sm-0" variant="outline-dark-green"
            ><b-icon class="mr-1" icon="twitter"></b-icon>
            <span class="d-none d-md-block">Twitter</span>
          </b-button>
        </ShareNetwork>
        <ShareNetwork
          class="mr-3"
          network="whatsApp"
          :url="link"
          title="Check out my new feed post on Nzùkóór:"
          :description="description"
          quote="Nzukoor"
          hashtags="Nzukoor,  Social learning"
        >
          <b-button size="sm" class="mb-2 mb-sm-0" variant="outline-dark-green">
            <b-iconstack>
              <b-icon stacked icon="circle-fill" variant="dark-green"></b-icon>
              <b-icon
                stacked
                icon="telephone-plus"
                variant="light"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
            <span class="d-none d-md-block">Whatsapp</span>
          </b-button>
        </ShareNetwork>
        <ShareNetwork
          class="mr-3"
          network="Telegram"
          :url="link"
          title="Check out my new feed post on Nzùkóór:"
          :description="description"
          quote="Nzukoor"
          hashtags="Nzukoor,  Social learning, Feeds"
        >
          <b-button size="sm" class="mb-2 mb-sm-0" variant="outline-dark-green"
            ><b-icon class="mr-1" icon="cursor-fill"></b-icon>
            <span class="d-none d-md-block">Telegram</span>
          </b-button>
        </ShareNetwork>
      </div>
    </b-modal>
    <b-modal id="replycomment" hide-footer>
      <template #modal-title>
        <div class="d-flex align-items-center">
          <b-avatar
            class="mr-1 feedcommentavatar"
            :src="replycomment.user.profile"
          ></b-avatar>
          <span
            class="comment_name"
            @click="$router.push(`/me/profile/${replycomment.user.username}`)"
          >
            {{ replycomment.user.username }}
          </span>
        </div>
        <div
          class="fs14"
          v-if="replycomment"
          v-html="$options.filters.tagsfilter(replycomment.comment)"
        ></div>
      </template>
      <a-mentions
        v-model="commentreply"
        placeholder="Reply comment"
        class="mb-3 commentreply w-100"
      >
        <a-mentions-option
          v-for="(item, id) in connections"
          :key="id"
          :value="item"
        >
          {{ item }}
        </a-mentions-option>
      </a-mentions>
      <b-button variant="dark-green" @click="postreply" size="sm"
        >Reply</b-button
      >
    </b-modal>
    <b-modal id="allreplies" hide-footer centered size="md">
      <template #modal-title>
        <div class="d-flex align-items-center">
          <b-avatar
            class="mr-1 feedcommentavatar"
            :src="allreplies.user.profile"
          ></b-avatar>
          <span
            class="comment_name"
            @click="$router.push(`/me/profile/${allreplies.user.username}`)"
          >
            {{ allreplies.user.username }}
          </span>
        </div>
        <div
          class="font-weight-bold"
          v-if="allreplies"
          v-html="allreplies.comment"
        ></div>
      </template>
      <div class="comments" v-if="allreplies">
        <div class="comments">
          <div
            class="p-2 bg-light rounded w-100"
            v-if="allreplies.feedcommentreplies"
          >
            <label class="text-muted font-weight-bold mb-1">Replies</label>
            <div
              class="mb-1"
              v-for="(rep, id) in allreplies.feedcommentreplies"
              :key="id"
            >
              <div class="d-flex align-items-center">
                <b-avatar
                  class="mr-1 feedcommentavatar"
                  :src="rep.user.profile"
                ></b-avatar>
                <span
                  class="comment_name"
                  @click="$router.push(`/me/profile/${rep.user.username}`)"
                >
                  {{ rep.user.username }}
                </span>
              </div>
              <div class="d-flex align-items-start flex-1">
                <span class="d-flex justify-content-between w-100 flex-1">
                  <span
                    class="comment_text flex-1 d-flex align-items-center"
                    v-html="$options.filters.tagsfilter(rep.message)"
                  ></span>
                  <span>
                    <span v-b-tooltip.hover title="Like reply" class="mr-2">
                      <span class="mr-1">{{
                                  rep.likeCount ? rep.likeCount : ""
                                }}</span>
                      <b-icon
                        :icon="rep.isLiked ? 'heart-fill' : 'heart'"
                        class="text-danger"
                        @click="likecommentreply(rep.id, id)"
                        font-scale=".8"
                      ></b-icon
                    ></span>
                    <b-icon
                      v-b-tooltip.hover
                      title="Delete reply"
                      icon="trash"
                      font-scale=".8"
                      v-if="$store.getters.member.id === rep.user_id"
                      @click="dropcommentreply(rep.id, id)"
                    ></b-icon>
                  </span>
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </b-modal>
  </div>
</template>
<script>
import EmojiPicker from "vue-emoji-picker";
import "ant-design-vue/dist/antd.css";
export default {
  data() {
    return {
      allreplies: {},
      replycomment: null,
      commentreply: "",
      link: "",
      description: "",
      id: this.$route.params.id,
      feed: null,
      search: "",
      showFeeds: false,
      img_ext: ["jpg", "png", "jpeg", "gif"],
      vid_ext: ["mp4", "3gp", "flv", "mov"],
      aud_ext: ["mp3", "aac"],
      doc_ext: ["docx", "pdf", "ppt", "zip"],
      comment: {
        comment: "",
        id: "",
      },
      alllikes: null,
      comment_index: null,
    };
  },
  components: {
    EmojiPicker,
  },
  created() {
    this.getfeeds();
    this.$store.dispatch("GET_CONNECTIONS");
  },
  computed: {
    connections() {
      return this.$store.getters.connections.map((item) => item.username);
    },
    useraccess() {
      var token = null;
      if (this.$store.getters.admin.access_token) {
        return "admin";
      }
      if (this.$store.getters.facilitator.access_token) {
        return "facilitator";
      }
      if (this.$store.getters.member.access_token) {
        return "member";
      }
      return token;
    },
  },
  methods: {
    likecomment(id, index) {
      this.$http
        .post(
          `${this.$store.getters.url}/feed/comment/like`,
          { feed_comment_id: id },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.data === "success") {
            this.feed.comments[index].isLiked = true;
          } else {
            this.feed.comments[index].isLiked = false;
          }
        });
    },

    likecommentreply(id) {
      this.$http
        .post(
          `${this.$store.getters.url}/feed/comment/reply/like`,
          { feed_comment_reply_id: id },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.data === "success") {
            this.allreplies.feedcommentreplies[
              this.comment_index
            ].isLiked = true;
          } else {
            this.allreplies.feedcommentreplies[
              this.comment_index
            ].isLiked = false;
          }
        });
    },
    postreply() {
      if (!this.commentreply) {
        this.$toast.info("Cannot be empty");
        return;
      }
      var data = {
        feed_comment_id: this.replycomment.id,
        message: this.commentreply,
        feed_id: this.replycomment.feed_id,
      };

      this.$http
        .post(`${this.$store.getters.url}/feed/comment/reply`, data, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.$toast.success("Reply successful ");

            this.feed.comments[this.comment_index].feedcommentreplies.unshift(
              res.data
            );
            this.feed.comments[this.comment_index].commentreplycount++;
            this.commentreply = "";
            this.$bvModal.hide("replycomment");
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    handlereplies(val) {
      this.allreplies = val;
      this.$bvModal.show("allreplies");
    },
    handlereplycomment(comment, comment_index) {
      this.replycomment = comment;
      this.comment_index = comment_index;

      this.$bvModal.show("replycomment");
    },
    toText(HTML) {
      if (!HTML) return;
      var input = HTML;

      return input
        .replace(/<(style|script|iframe)[^>]*?>[\s\S]+?<\/\1\s*>/gi, "")
        .replace(/<[^>]+?>/g, "")
        .replace(/\s+/g, " ")
        .replace(/ /g, " ")
        .replace(/>/g, " ");
    },
    showlikes(likes) {
      this.alllikes = likes;

      this.$bvModal.show("alllikes");
    },
    getlikes(item) {
      return item > 1
        ? `${item} people liked this post`
        : `${item} person liked this post`;
    },
    sharenow(feed) {
      this.description = this.toText(feed.message);
      this.link = `https://nzukoor.com/feed/${feed.id}?utf_medium=share`;
      this.$bvModal.show("share");
    },
    getextension(fileName) {
      if (fileName) {
        var regex = new RegExp("[^.]+$");
        var extension = fileName.match(regex);

        return extension[0].toLowerCase();
      }
    },

    getfeeds() {
      this.$http
        .get(`${this.$store.getters.url}/feeds/${this.id}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.feed = res.data;
            this.showFeeds = true;
            window.title = `${this.toText(this.feed.message)} | NzuKoor`;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    insertfeed(emoji) {
      this.feed.message += emoji + "";
    },
    insertcomment(emoji) {
      this.comment.comment += emoji + "";
    },

    addcomment(id) {
      if (!this.comment.comment) {
        this.$toast.info("Cannot be empty");
        return;
      }
      this.comment.id = id;

      this.$http
        .post(`${this.$store.getters.url}/feed-comments`, this.comment, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.$toast.success("Comment updated ");

            this.feed.comments.unshift(res.data);

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
    toggleLike(id) {
      this.$http
        .post(
          `${this.$store.getters.url}/feed-likes`,
          { id },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 201 || res.status == 200) {
            this.getfeeds();
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    toggleStar(id) {
      this.$http
        .post(
          `${this.$store.getters.url}/feed-stars`,
          { id },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 201) {
            this.feed.stars.push(res.data);
          }
          if (res.status == 200) {
            this.feed.stars.map((item) => {
              if (item.user_id == this.$store.getters.member.id) {
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
            .delete(`${this.$store.getters.url}/feeds/${this.id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.member.access_token}`,
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
    dropcomment(id, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/feed-comments/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.member.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success("Removed");
                this.feed.comments.splice(index, 1);

              }
            })
            .catch((err) => {
              this.$toast.error(err.response.data.message);
            });
        }
      });
    },
    dropcommentreply(id, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/feed/comment/reply/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.member.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success(" deleted");
                this.getfeeds();
                this.allreplies.feedcommentreplies.splice(index, 1);
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
<style scoped>
.main-card {
  height: 80vh;
}
.comments {
  max-height: 500px;
  overflow-y: auto;
  -ms-overflow-style: none;
  -webkit-overflow-scrolling: none;
}
.comments::-webkit-scrollbar {
  display: none;
}
hr {
  margin-top: 0.5rem;
  margin-bottom: 0.5rem;
  border: 0;
  border-top: 1px solid rgba(0, 0, 0, 0.1);
}
.replyfeed {
  font-size: 0.8rem;
  padding: 4px 0 0;
}
@media (max-width: 768px) {
  .feed_name{
    font-size:14px;
  }
  .comments{
    border-top:1px solid rgba(0, 0, 0, 0.01);

  }
  .main-card {
    height: auto;
  }
}
</style>

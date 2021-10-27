<template>
  <div class="bg-light">
    <b-container class="main-card py-md-5" v-if="feed">
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
              <b-col md="8" class="text-left p-0 p-sm-4 border-right">
                <div
                  class="d-flex justify-content-between p-3 px-md-2 d-md-none"
                >
                  <div class="d-flex align-items-center" v-if="feed.admin">
                    <b-avatar
                      :src="feed.admin.profile"
                      size="sm"
                      class="mr-2"
                    ></b-avatar>
                    <div class="feed_name">{{ feed.admin.name }}</div>
                  </div>
                  <div class="d-flex align-items-center" v-if="feed.user">
                    <b-avatar
                      :src="feed.user.profile"
                      size="sm"
                      class="mr-2"
                    ></b-avatar>
                    <div
                      @click="
                        $router.push(`/facilitator/profile/u/${feed.user.id}`)
                      "
                      class="feed_name"
                    >
                      {{ feed.user.username }}
                    </div>
                  </div>
                  <div
                    class="d-flex align-items-center"
                    v-if="feed.facilitator"
                  >
                    <b-avatar
                      :src="feed.facilitator.profile"
                      size="sm"
                      class="mr-2"
                    ></b-avatar>
                    <div
                      @click="
                        $router.push(
                          `/facilitator/profile/f/${feed.facilitator.id}`
                        )
                      "
                      class="feed_name"
                    >
                      {{ feed.facilitator.username }}
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
                        feed.user &&
                          feed.facilitator.id == $store.getters.facilitator.id
                      "
                      >Delete</b-dropdown-item
                    >
                  </b-dropdown>
                </div>
                <div class="p-3">
                  <b-card-text v-html="feed.message"> </b-card-text>
                  <div v-if="feed.url" class="text-dark-green mb-1">
                    <a :href="feed.url" target="_blank">Click link</a>
                  </div>
                  <div v-if="feed.tags" class="px-3 px-md-0 mb-1">
                    <div class="d-flex justify-content-start">
                      <b-col
                        cols="auto"
                        class="pr-2 pl-0"
                        v-for="(tag, id) in feed.tags"
                        :key="id"
                      >
                        <b-badge
                          class="fs10 text-dark font-weight-normal"
                          size="sm"
                          variant="lighter-green"
                          >{{ tag.text }}</b-badge
                        >
                      </b-col>
                    </div>
                  </div>
                  <div v-if="feed.media || feed.publicId">
                    <div class="mb-4 position-relative w-100 media">
                      <cld-image
                        v-if="
                          feed.publicId &&
                            img_ext.includes(getextension(feed.media))
                        "
                        :publicId="feed.publicId"
                      >
                        <cld-transformation crop="fill" quality="auto" />
                        <cld-transformation width="auto" crop="scale" />
                        <cld-transformation dpr="auto" />
                      </cld-image>
                      <b-img
                        v-if="
                          !feed.publicId &&
                            feed.media &&
                            img_ext.includes(getextension(feed.media))
                        "
                        :src="feed.media"
                      ></b-img>

                      <cld-video
                        controls
                        v-if="
                          feed.publicId &&
                            vid_ext.includes(getextension(feed.media))
                        "
                        :publicId="feed.publicId"
                      >
                        <cld-transformation crop="fill" height="500" />
                      </cld-video>

                      <audio
                        width="100%"
                        controls
                        v-if="
                          feed.media &&
                            aud_ext.includes(getextension(feed.media))
                        "
                        :src="feed.media"
                        class="fluid-grow"
                      ></audio>
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
                </div>
              </b-col>
              <b-col md="4">
                <b-card-body
                  class="text-left px-0 h-100 d-flex flex-column pb-0"
                >
                  <div class="justify-content-between px-3 d-none d-md-flex">
                    <div class="d-flex align-items-center" v-if="feed.admin">
                      <b-avatar
                        :src="feed.admin.profile"
                        size="sm"
                        class="mr-2"
                      ></b-avatar>
                      <div class="feed_name">{{ feed.admin.name }}</div>
                    </div>
                    <div class="d-flex align-items-center" v-if="feed.user">
                      <b-avatar
                        :src="feed.user.profile"
                        size="sm"
                        class="mr-2"
                      ></b-avatar>
                      <div
                        @click="
                          $router.push(`/facilitator/profile/u/${feed.user.id}`)
                        "
                        class="feed_name"
                      >
                        {{ feed.user.username }}
                      </div>
                    </div>
                    <div
                      class="d-flex align-items-center"
                      v-if="feed.facilitator"
                    >
                      <b-avatar
                        :src="feed.facilitator.profile"
                        size="sm"
                        class="mr-2"
                      ></b-avatar>
                      <div
                        @click="
                          $router.push(
                            `/facilitator/profile/f/${feed.facilitator.id}`
                          )
                        "
                        class="feed_name"
                      >
                        {{ feed.facilitator.username }}
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
                          feed.user &&
                            feed.facilitator.id == $store.getters.facilitator.id
                        "
                        >Delete</b-dropdown-item
                      >
                    </b-dropdown>
                  </div>

                  <hr />
                  <div class="comments px-3 flex-1">
                    <div v-if="feed.comments.length" class="comment_header">
                      View {{ feed.comments.length }}
                      {{ feed.comments.length > 1 ? "comments" : "comment" }}
                    </div>
                    <b-card-text
                      v-for="(comment, id) in feed.comments"
                      :key="id"
                      style="line-height: 1.1"
                      class="mb-1"
                    >
                      <span class="comment_name mr-1" v-if="comment.admin">{{
                        comment.admin.name
                      }}</span>
                      <span
                        class="comment_name mr-1"
                        @click="
                          $router.push(
                            `/facilitator/profile/f/${comment.user.id}`
                          )
                        "
                        v-if="comment.user"
                        >{{ comment.user.username }}</span
                      >
                      <span
                        class="comment_name mr-1"
                        @click="
                          $router.push(
                            `/facilitator/profile/f/${comment.facilitator.id}`
                          )
                        "
                        v-if="comment.facilitator"
                        >{{ comment.facilitator.username }}</span
                      >
                      <span class="comment_text">{{
                        comment.comment
                      }}</span></b-card-text
                    >
                  </div>
                  <hr />
                  <div class="px-3 py-2 border-bottom">
                    <div class="interactions text-left px-3 py-2">
                      <span
                        class="mr-3 cursor-pointer"
                        @click="toggleLike(feed.id, index)"
                      >
                        <b-icon
                          font-scale="1.3"
                          :icon="
                            feed.likes
                              .filter(item => item.like)
                              .find(
                                item => item.user_id == $store.getters.member.id
                              )
                              ? 'heart-fill'
                              : 'heart'
                          "
                          class="mr-1"
                          :class="
                            feed.likes
                              .filter(item => item.like)
                              .find(
                                item => item.user_id == $store.getters.member.id
                              )
                              ? 'text-danger'
                              : ''
                          "
                        ></b-icon>
                      </span>

                      <span class="mr-3">
                        <b-icon
                          font-scale="1.3"
                          icon="chat-fill"
                          class="mr-1"
                        ></b-icon>
                        <span
                          ><span>{{ feed.comments.length }}</span></span
                        >
                        comments</span
                      >
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
                      class="liked_by py-1"
                      @click="showlikes(feed)"
                      v-html="getlikes(feed.likes)"
                    ></div>

                    <div class="fs12 text-muted">
                      {{ $moment(feed.created_at).fromNow() }}
                    </div>
                  </div>
                  <div class="interact text-left">
                    <b-input-group class="py-2">
                      <template #append>
                        <b-input-group-text
                          class="border-0 bg-transparent d-block"
                          ><span
                            @click="addcomment(feed.id, index)"
                            class="text-dark-green cursor-pointer comment_post"
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
                      <b-form-input
                        autocomplete="off"
                        autocorrect="off"
                        v-model="comment.comment"
                        placeholder="Add comment"
                        class="border-0 no-focus"
                      ></b-form-input>
                    </b-input-group>
                  </div>
                </b-card-body>
              </b-col>
            </b-row>
          </b-card>
        </b-col>
      </b-row>
    </b-container>
    <b-modal
      no-close-on-backdrop
      id="alllikes"
      hide-footer
      centered
      title="Likes"
      size="sm"
    >
      <div class="comments" v-if="alllikes">
        <div class="mb-3">
          <div class="d-flex mb-3 pt-3">
            <div class="d-flex flex-1 text-left">
              <div class="mr-2 mb-1" v-if="alllikes.admin">
                <b-avatar
                  class="mr-2"
                  size="1.8rem"
                  :src="alllikes.admin.profile"
                ></b-avatar>
              </div>
              <div class="mr-2 mb-1" v-if="alllikes.user">
                <b-avatar
                  class="mr-2"
                  size="1.8rem"
                  :src="alllikes.user.profile"
                ></b-avatar>
              </div>
              <div class="comment_name mr-2 mb-1" v-if="alllikes.facilitator">
                <b-avatar
                  class="mr-2"
                  size="1.8rem"
                  :src="alllikes.facilitator.profile"
                ></b-avatar>
              </div>
              <div class="profile">
                <div class="name" v-if="alllikes.admin">
                  {{ alllikes.admin.name }}
                </div>
                <div class="name" v-if="alllikes.user">
                  {{ alllikes.user.username }}
                </div>
                <div class="name" v-if="alllikes.facilitator">
                  {{ alllikes.facilitator.username }}
                </div>

                <div class="date fs11">
                  {{ alllikes.created_at | moment("ll") }}
                </div>
              </div>
            </div>
          </div>
          <div class="text-left feed_text pb-3">
            <span>{{ alllikes.message }}</span>
          </div>
        </div>
        <div class="comments">
          <h6>Liked by</h6>
          <div
            class="comment d-flex text-left mb-2"
            v-for="(item, index) in alllikes.likes.filter(val => val.like)"
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
                    @click="$router.push(`/member/profile/${item.username}`)"
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
                      $router.push(`/member/profile/f/${item.facilitator.id}`)
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
          </div>
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
  </div>
</template>
<script>
import EmojiPicker from "vue-emoji-picker";
export default {
  data() {
    return {
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
        id: ""
      },
      alllikes: null
    };
  },
  components: {
    EmojiPicker
  },
  created() {
    this.getfeeds();
  },
  computed: {
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
    }
  },
  methods: {
    showlikes(likes) {
      this.alllikes = likes;

      this.$bvModal.show("alllikes");
    },
    getlikes(item) {
      var arr = item.filter(val => val.like);
      var first = {};
      var check = null;
      first = arr.slice().shift();
      var result = "";
      if (arr.length == 1) {
        if (first.user) {
          result = `<span>Liked by ${
            this.useraccess == "member" &&
            this.$store.getters.member.id == first.user.id
              ? "you"
              : first.user.username
          } </span>`;
          return result;
        }
        if (first.facilitator) {
          result = `<span>Liked by ${
            this.useraccess == "facilitator" &&
            this.$store.getters.facilitator.id == first.facilitator.id
              ? "you"
              : first.facilitator.username
          } </span>`;
          return result;
        }
        if (first.admin) {
          result = `<span>Liked by ${
            this.useraccess == "admin" &&
            this.$store.getters.admin.id == first.admin.id
              ? "you"
              : first.admin.name
          } </span>`;
          return result;
        }
      }
      if (arr.length > 1) {
        if (this.$store.getters.member.access_token) {
          check = arr.some(
            val => val.user_id && val.user.id == this.$store.getters.member.id
          );
          if (check) {
            result = `Liked by you and ${arr.length - 1} others`;
            return result;
          } else {
            if (first.user) {
              result = `Liked by  ${first.user.username} and  ${arr.length -
                1} ${arr.length - 1 > 1 ? "others" : "other"} `;
              return result;
            }
            if (first.facilitator) {
              result = `Liked by  ${
                first.facilitator.username
              } and  ${arr.length - 1} ${
                arr.length - 1 > 1 ? "others" : "other"
              } `;
              return result;
            }
            if (first.admin) {
              result = `Liked by  ${first.admin.name} and  ${arr.length - 1} ${
                arr.length - 1 > 1 ? "others" : "other"
              } `;
              return result;
            }
          }
        }
        if (this.$store.getters.facilitator.access_token) {
          check = arr.some(
            val =>
              val.facilitator_id &&
              val.facilitator.id == this.$store.getters.facilitator.id
          );
          if (check) {
            result = `Liked by you and ${arr.length - 1} others`;
            return result;
          } else {
            if (first.user) {
              result = `Liked by  ${first.user.username} and  ${arr.length -
                1} ${arr.length - 1 > 1 ? "others" : "other"} `;
              return result;
            }
            if (first.facilitator) {
              result = `Liked by  ${
                first.facilitator.username
              } and  ${arr.length - 1} ${
                arr.length - 1 > 1 ? "others" : "other"
              } `;
              return result;
            }
            if (first.admin) {
              result = `Liked by  ${first.admin.name} and  ${arr.length - 1} ${
                arr.length - 1 > 1 ? "others" : "other"
              } `;
              return result;
            }
          }
        }
        if (this.$store.getters.admin.access_token) {
          check = arr.some(
            val => val.admin && val.admin.id == this.$store.getters.admin.id
          );
          if (check) {
            result = `Liked by you and ${arr.length - 1} others`;
            return result;
          } else {
            if (first.user) {
              result = `Liked by  ${first.user.username} and  ${arr.length -
                1} ${arr.length - 1 > 1 ? "others" : "other"} `;
              return result;
            }
            if (first.facilitator) {
              result = `Liked by  ${
                first.facilitator.username
              } and  ${arr.length - 1} ${
                arr.length - 1 > 1 ? "others" : "other"
              } `;
              return result;
            }
            if (first.admin) {
              result = `Liked by  ${first.admin.name} and  ${arr.length - 1} ${
                arr.length - 1 > 1 ? "others" : "other"
              } `;
              return result;
            }
          }
        } else {
          result = `Liked by ${arr.length} people`;
          return result;
        }
      }
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
        .get(`${this.$store.getters.url}/feeds/${this.id}`)
        .then(res => {
          if (res.status == 200) {
            this.feed = res.data;
            this.showFeeds = true;
            window.title = `${this.toText(this.feed.message)} | NzuKoor`;
          }
        })
        .catch(err => {
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
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`
          }
        })
        .then(res => {
          if (res.status == 201) {
            this.$toast.success("Comment updated ");

            this.feed.comments.unshift(res.data);

            this.comment = {
              comment: "",
              id: ""
            };
          }
        })
        .catch(err => {
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
              Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`
            }
          }
        )
        .then(res => {
          if (res.status == 201) {
            this.feed.likes.push(res.data);
          }
          if (res.status == 200) {
            this.feed.likes.map(item => {
              if (item.user_id == this.$store.getters.facilitator.id) {
                return (item.like = res.data.like);
              }
            });
          }
        })
        .catch(err => {
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
              Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`
            }
          }
        )
        .then(res => {
          if (res.status == 201) {
            this.feed.stars.push(res.data);
          }
          if (res.status == 200) {
            this.feed.stars.map(item => {
              if (item.user_id == this.$store.getters.facilitator.id) {
                return (item.star = res.data.star);
              }
            });
          }
        })
        .catch(err => {
          this.$toast.error(err.response.data.message);
        });
    },
    drop(id, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then(val => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/feeds/${this.id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`
              }
            })
            .then(res => {
              if (res.status == 200) {
                this.$toast.success("Feed deleted");
                this.feeds.splice(index, 1);
              }
            })
            .catch(err => {
              this.$toast.error(err.response.data.message);
            });
        }
      });
    }
  }
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
@media (max-width: 768px) {
  .main-card {
    height: auto;
  }
}
</style>

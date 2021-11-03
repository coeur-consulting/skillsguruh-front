/* eslint-disable no-unused-vars */
<template>
  <b-container fluid class="px-0 px-sm-4">
    <div class="pb-5 pt-sm-4">
      <b-container>
        <b-row class="justify-content-center">
          <b-col class="px-0" md="8">
            <div>
              <div>
                <div class="feed-content">
                  <div
                    v-for="(feed, index) in filteredFeeds"
                    :key="index"
                    class="border bg-white rounded-8 mb-3"
                  >
                    <div class="d-flex mb-3 px-2 px-sm-3 pt-3">
                      <div class="flex-1 text-left">
                        <div class="mr-2 mb-1 feedname" v-if="feed.user">
                          <b-avatar
                            size="1.8rem"
                            class="mr-2"
                            :src="feed.user.profile"
                          ></b-avatar>
                          <span class="hover_green">
                            <div style="line-height: 1.2">
                              {{ feed.user.username }}
                            </div>
                            <small
                              v-if="feed.user.state"
                              class="text-muted font-weight-normal"
                              >{{ feed.user.state }}</small
                            >
                          </span>
                        </div>
                      </div>
                      <b-dropdown
                        size="sm"
                        variant="transparent"
                        no-caret
                        class="no-focus"
                      >
                        <template #button-content>
                          <b-icon
                            icon="three-dots-vertical"
                            font-scale="1.2"
                          ></b-icon>
                        </template>
                        <b-dropdown-item
                          class="fs12"
                          @click="$router.push(`/organization/feed/${feed.id}`)"
                          >View</b-dropdown-item
                        >

                        <b-dropdown-item
                          class="fs12"
                          @click="drop(feed.id, index)"
                          >Delete</b-dropdown-item
                        >
                      </b-dropdown>
                    </div>

                    <div v-if="feed.media || feed.publicId">
                      <div class="mb-4 position-relative w-100 media bg-white">
                        <b-icon
                          v-if="toggleOn == index"
                          icon="heart-fill"
                          variant="danger"
                          class="
                            heart
                            animate__animated
                            animate__fadeIn
                            animate__fadeOut
                            animate__slow
                          "
                        ></b-icon>
                        <cld-image
                          v-if="
                            feed.publicId &&
                            img_ext.includes(getextension(feed.media))
                          "
                          :publicId="feed.publicId"
                        >
                          <cld-transformation
                            aspectRatio="1.0"
                            height="500"
                            crop="fill"
                          />
                        </cld-image>
                        <b-img
                          v-if="
                            !feed.publicId &&
                            feed.media &&
                            img_ext.includes(getextension(feed.media))
                          "
                          class="img_feed"
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
                    <div class="text-left feed_text px-3">
                      <div class="mb-1" v-html="feed.message"></div>

                      <div v-if="feed.url" class="text-dark-green mb-1">
                        <a :href="feed.url" target="_blank">Click link</a>
                      </div>
                      <div v-if="feed.tags" class="px-2 mb-1">
                        <b-row class="justify-content-start">
                          <b-col
                            cols="auto"
                            class="px-1"
                            v-for="(tag, id) in feed.tags"
                            :key="id"
                          >
                            <b-badge
                              class="fs10 text-dark font-weight-normal text-sm"
                              size="sm"
                              variant="lighter-green"
                              >{{ tag.text }}</b-badge
                            >
                          </b-col>
                        </b-row>
                      </div>
                    </div>
                    <div class="interactions text-left px-3 py-1">
                      <span
                        class="mr-2 cursor-pointer d-flex align-items-center"
                      >
                        <b-icon
                          font-scale="1.3"
                          :icon="
                            feed.likes
                              .filter((item) => item.like)
                              .find(
                                (item) =>
                                  item.user_id == $store.getters.member.id
                              )
                              ? 'heart-fill'
                              : 'heart'
                          "
                          :class="
                            feed.likes
                              .filter((item) => item.like)
                              .find(
                                (item) =>
                                  item.user_id == $store.getters.member.id
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
                    </div>
                    <div class="d-flex align-items-center">
                      <div
                        v-if="feed.likes.length"
                        class="liked_by px-3 border-bottom"
                        v-html="getlikes(feed.likes)"
                      ></div>
                    </div>

                    <div
                      class="comments px-3 pt-2 border-bottom text-left"
                      style="line-height: 1.6"
                      v-if="feed.comments.length"
                    >
                      <div
                        v-if="feed.comments.length"
                        class="comment_header mb-1 cursor-pointer"
                        @click="showcomments(feed)"
                      >
                        View {{ feed.comments.length }}
                        {{ feed.comments.length > 1 ? "comments" : "comment" }}
                      </div>
                      <div class="all_comment">
                        <div
                          class="comment d-flex text-left mb-1"
                          v-for="item in feed.comments.slice(0, 2)"
                          :key="item.id"
                        >
                          <div class="flex-1 pr-2" style="line-height: 1">
                            <span class="comment_name mr-2" v-if="item.admin">
                              {{ item.admin.name }}</span
                            >
                            <span class="comment_name mr-2 hover_green">
                              {{ item.user.username }}</span
                            >

                            <span class="comment_text">{{ item.comment }}</span>
                          </div>
                          <div>
                            <small>
                              <b-icon
                                class="mr-2"
                                :icon="
                                  item.feedcommentlikes ? 'heart-fill' : 'heart'
                                "
                                :class="
                                  item.feedcommentlikes ? 'text-danger' : ''
                                "
                              ></b-icon>
                            </small>
                            <span class="comment_mins"
                              >{{ $moment(item.created_at).fromNow() }}
                            </span>
                          </div>
                        </div>
                      </div>
                    </div>

                    <div
                      class="
                        feed_time
                        text-muted
                        py-2
                        px-3
                        text-left
                        border-top
                      "
                    >
                      {{ $moment(feed.created_at).fromNow() }}
                    </div>
                  </div>
                  <infinite-loading
                    @infinite="infiniteHandler"
                  ></infinite-loading>
                </div>
              </div>
              <!-- <div v-else class="text-center p-3 p-sm-4">No feed Available</div> -->
            </div>
          </b-col>
        </b-row>
      </b-container>
    </div>
    <b-modal id="allcomments" hide-footer centered size="md">
      <template #modal-title>
        <div
          class="font-weight-bold"
          v-if="allcomments"
          v-html="allcomments.message"
        ></div>
      </template>
      <div class="comments" v-if="allcomments">
        <label for="">Comments</label>
        <div class="comments">
          <div
            class="comment d-flex text-left mb-2"
            v-for="(item, index) in allcomments.comments"
            :key="index"
          >
            <div class="flex-1">
              <div class="flex-1 pr-2">
                <div class="d-flex mb-1" v-if="item.user">
                  <div class="d-flex flex-1">
                    <b-avatar
                      class="mr-2"
                      size="sm"
                      :src="item.user.profile"
                    ></b-avatar>
                    <div class="w-100">
                      <div class="mb-2">
                        <div>
                          <div class="comment_name">
                            {{ item.user.username }}
                          </div>
                          <div class="comment_text" :id="item.comment">
                            {{ item.comment }}
                          </div>
                        </div>

                        <small
                          v-if="
                            (allcomments.user &&
                              allcomments.user.id ==
                                $store.getters.member.id) ||
                            $store.getters.member.id == item.user.id
                          "
                        >
                          <b-icon
                            :icon="
                              item.feedcommentlikes ? 'heart-fill' : 'heart'
                            "
                            :class="item.feedcommentlikes ? 'text-danger' : ''"
                          ></b-icon>
                        </small>
                      </div>
                    </div>
                  </div>

                  <div>
                    <span class="comment_mins pl-2">{{
                      $moment(item.created_at).fromNow()
                    }}</span>
                  </div>
                </div>
                <div
                  class="p-2 bg-light rounded w-100"
                  v-if="item.feedcommentreplies.length"
                >
                  <div class="text-muted fs12 font-weight-bold mb-2">
                    <a :href="`#${item.comment}`" class="text-muted">
                      <small>
                        <i class="fa fa-reply" aria-hidden="true"></i>
                        Replying {{ item.user.username }}
                      </small></a
                    >
                  </div>

                  <ViewMore>
                    <template v-slot:content>
                      <div
                        class="mb-2"
                        v-for="(rep, id) in item.feedcommentreplies"
                        :key="id"
                      >
                        <div class="d-flex">
                          <b-avatar
                            class="mr-2 feedcommentavatar"
                            :src="rep.user.profile"
                          ></b-avatar>
                          <div class="d-flex align-items-start flex-1">
                            <p class="flex-1 mr-2 mb-1">
                              <span class="comment_name mr-1">
                                {{ rep.user.username }}
                              </span>
                              <span class="comment_text flex-1">{{
                                rep.message
                              }}</span>
                            </p>
                            <span
                              ><b-icon
                                :icon="
                                  rep.feedcommentreplylikes
                                    ? 'heart-fill'
                                    : 'heart'
                                "
                                :class="
                                  rep.feedcommentreplylikes ? 'text-danger' : ''
                                "
                                font-scale=".8"
                              ></b-icon
                            ></span>
                          </div>
                        </div>
                        <small class="text-muted">{{
                          $moment(rep.created_at).fromNow()
                        }}</small>
                      </div>
                    </template>
                    <template v-slot:seemore>
                      <div class="btn-vm">see more</div>
                    </template>
                    <template v-slot:seeless>
                      <div class="btn-vm">see less</div>
                    </template>
                  </ViewMore>
                </div>
              </div>
            </div>
            <div></div>
          </div>
        </div>
      </div>
    </b-modal>
  </b-container>
</template>

<script>
import ViewMore from "@/components/Member/components/viewmore";
export default {
  data() {
    return {
      report_id: null,
      report_type: null,
      index: null,
      replycomment: null,
      commentreply: "",
      toggleOn: null,
      link: "",

      description: "",
      recentfeeds: [],
      trendingfeeds: [],
      customfeeds: [],
      feedShown: "recent",
      options: [],
      searchText: "", // If value is falsy, reset searchText & searchItem
      items: [],
      lastSelectItem: {},
      open: false,
      feeds: [],
      search: "",
      allcomments: null,
      feed: {
        media: "",
        message: "",
        publicId: "",
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
      page: 1,
      alllikes: null,
      counter: 0,
      comment_index: null,
    };
  },
  components: {
    ViewMore,
  },
  created() {
    //  this.getfeeds
  },
  computed: {
    filteredFeeds() {
      return this.feeds;
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

  watch: {
    feedShown: "toggleFeeds",
  },
  directives: {
    focus: {
      inserted(el) {
        el.focus();
      },
    },
  },
  methods: {
    handleReport(id, type) {
      this.report_type = type;
      this.report_id = id;
      this.$bvModal.show("report");
    },
    checkpost(word) {
      var res = word.substring(0, 4);

      if (res !== "<div") {
        return true;
      }
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
    handleChange() {},
    likeimage(index) {
      this.toggleOn = index;

      setTimeout(() => {
        this.toggleOn = null;
      }, 1500);
    },
    showlikes(likes) {
      this.alllikes = likes;

      this.$bvModal.show("alllikes");
    },
    getlikes(item) {
      var arr = item.filter((val) => val.like);
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
            (val) => val.user_id && val.user.id == this.$store.getters.member.id
          );
          if (check) {
            result = `Liked by you and ${arr.length - 1} others`;
            return result;
          } else {
            if (first.user) {
              result = `Liked by  ${first.user.username} and  ${
                arr.length - 1
              } ${arr.length - 1 > 1 ? "others" : "other"} `;
              return result;
            }
            if (first.facilitator) {
              result = `Liked by  ${first.facilitator.username} and  ${
                arr.length - 1
              } ${arr.length - 1 > 1 ? "others" : "other"} `;
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
            (val) =>
              val.facilitator_id &&
              val.facilitator.id == this.$store.getters.facilitator.id
          );
          if (check) {
            result = `Liked by you and ${arr.length - 1} others`;
            return result;
          } else {
            if (first.user) {
              result = `Liked by  ${first.user.username} and  ${
                arr.length - 1
              } ${arr.length - 1 > 1 ? "others" : "other"} `;
              return result;
            }
            if (first.facilitator) {
              result = `Liked by  ${first.facilitator.username} and  ${
                arr.length - 1
              } ${arr.length - 1 > 1 ? "others" : "other"} `;
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
            (val) => val.admin && val.admin.id == this.$store.getters.admin.id
          );
          if (check) {
            result = `Liked by you and ${arr.length - 1} others`;
            return result;
          } else {
            if (first.user) {
              result = `Liked by  ${first.user.username} and  ${
                arr.length - 1
              } ${arr.length - 1 > 1 ? "others" : "other"} `;
              return result;
            }
            if (first.facilitator) {
              result = `Liked by  ${first.facilitator.username} and  ${
                arr.length - 1
              } ${arr.length - 1 > 1 ? "others" : "other"} `;
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
    toggle(id) {
      console.log("🚀 ~ file: feeds.vue ~ line 967 ~ toggle ~ id", id);
    },
    toggleFeeds() {
      if (this.feedShown == "recent") {
        this.recentfeeds();
      }
      if (this.feedShown == "custom") {
        this.customfeeds();
      }
      if (this.feedShown == "trending") {
        this.trendingfeeds();
      }
    },
    sharenow(feed) {
      this.description = this.toText(feed.message);
      this.link = `https://nzukoor.com/explore/feed/view/${feed.id}?utf_medium=share`;
      this.$bvModal.show("share");
    },
    infiniteHandler($state) {
      this.$http
        .get(
          `${this.$store.getters.url}/get/organization/feeds?page=${this.page}`,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.data.data.length) {
            this.page += 1;
            this.feeds.push(...res.data.data);
            $state.loaded();
          } else {
            $state.complete();
          }
        });
    },
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

        return extension[0].toLowerCase();
      }
    },
    getUpload(val) {
      if (
        !this.img_ext.includes(this.getextension(val.secure_url)) &&
        !this.vid_ext.includes(this.getextension(val.secure_url)) &&
        !this.aud_ext.includes(this.getextension(val.secure_url)) &&
        !this.doc_ext.includes(this.getextension(val.secure_url))
      ) {
        this.$toast.error("Unsupported content type !");
        return;
      }

      this.feed.media = val.secure_url;
      this.feed.publicId = val.public_id;
      this.$bvModal.show("media");
    },

    drop(id, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/get/organization/feeds/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.organization.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 204) {
                this.$toast.success("Feed deleted");
                this.filteredFeeds.splice(index, 1);
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
.container {
  max-width: 1000px;
}
.stat {
  height: 50px;
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

.form-control.no-focus:focus {
  outline: none !important;
  box-shadow: unset;
}
// .form-control.no-focus {
//   font-size: 13px;
// }
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

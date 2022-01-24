<template>
  <div class="bg-light">
    <section class="explore_banner">
      <h1>View Feed</h1>
    </section>
    <b-container class="main-card py-5" v-if="feed">
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
              <b-col md="8" class="text-left p-0 p-md-4 border-right">
                <div
                  class="d-flex justify-content-between p-3 px-md-2 d-md-none"
                >
                  <div class="d-flex align-items-center" v-if="feed.user">
                    <b-avatar
                      :src="feed.user.profile"
                      size="sm"
                      class="mr-2"
                    ></b-avatar>
                    <div class="feed_name">
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

                    <b-dropdown-item class="fs12" @click="drop(feed.id, index)"
                      >Delete</b-dropdown-item
                    >
                  </b-dropdown>
                </div>
                <div class="p-3">
                  <b-card-text v-html="feed.message" class="mb-1">
                  </b-card-text>
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
                  class="text-left px-0 d-flex flex-column h-100 pb-0"
                >
                  <div class="justify-content-between px-3 d-none d-md-flex">
                    <div class="d-flex align-items-center" v-if="feed.user">
                      <b-avatar
                        :src="feed.user.profile"
                        size="sm"
                        class="mr-2"
                      ></b-avatar>
                      <div class="feed_name">
                        {{ feed.user.name }}
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
                    <div
                      class="comment d-flex text-left mb-2"
                      v-for="(item, index) in feed.comments"
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
                                    <div
                                      class="comment_name"
                                      @click="
                                        $router.push(
                                          `/member/profile/${item.user.username}`
                                        )
                                      "
                                    >
                                      {{ item.user.username }}
                                    </div>
                                    <div class="comment_text">
                                      {{ item.comment }}
                                    </div>
                                  </div>

                                  <small>
                                    <b-icon
                                      :icon="
                                        item.feedcommentlikes
                                          ? 'heart-fill'
                                          : 'heart'
                                      "
                                      :class="
                                        item.feedcommentlikes
                                          ? 'text-danger'
                                          : ''
                                      "
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
                                    <div
                                      class="d-flex align-items-start flex-1"
                                    >
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
                                            rep.feedcommentreplylikes
                                              ? 'text-danger'
                                              : ''
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
                  <hr />
                  <div class="px-3 py-2 border-bottom">
                    <div class="interactions text-left py-2">
                      <span class="mr-2 cursor-pointer">
                        <b-icon
                          font-scale="1.3"
                          icon="heart"
                          class="mr-1"
                        ></b-icon>
                      </span>

                      <span class="mr-3">
                        <b-icon
                          font-scale="1.3"
                          icon="chat"
                          class="mr-1"
                        ></b-icon>
                        <span
                          ><span>{{ feed.comments.length }}</span></span
                        >
                        comments</span
                      >
                    </div>
                    <div
                      class="liked_by py-1"
                      v-html="getlikes(feed.likes)"
                    ></div>

                    <div class="fs12 text-muted py-2">
                      {{ $moment(feed.created_at).fromNow() }}
                    </div>
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
                  {{ alllikes.user.name }}
                </div>
                <div class="name" v-if="alllikes.facilitator">
                  {{ alllikes.facilitator.name }}
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
  </div>
</template>
<script>
import ViewMore from "@/components/Member/components/viewmore";
export default {
  data() {
    return {
      auth: false,
      report_id: null,
      report_type: null,
      index: null,
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
    };
  },
  components: {
    ViewMore,
  },
  created() {
    this.getfeeds();
  },
  computed: {
    useraccess() {
      return "organization";
    },
    usertoken() {
      return this.$store.getters.organization;
    },
  },
  mounted() {
    if (
      localStorage.getItem("authMember") ||
      localStorage.getItem("authFacilitator")
    ) {
      this.auth = true;
    }
  },
  methods: {
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
              : first.user.name
          } </span>`;
          return result;
        }
        if (first.facilitator) {
          result = `<span>Liked by ${
            this.useraccess == "facilitator" &&
            this.$store.getters.facilitator.id == first.facilitator.id
              ? "you"
              : first.facilitator.name
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
              result = `Liked by  ${first.user.name} and  ${arr.length - 1} ${
                arr.length - 1 > 1 ? "others" : "other"
              } `;
              return result;
            }
            if (first.facilitator) {
              result = `Liked by  ${first.facilitator.name} and  ${
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
              result = `Liked by  ${first.user.name} and  ${arr.length - 1} ${
                arr.length - 1 > 1 ? "others" : "other"
              } `;
              return result;
            }
            if (first.facilitator) {
              result = `Liked by  ${first.facilitator.name} and  ${
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
              result = `Liked by  ${first.user.name} and  ${arr.length - 1} ${
                arr.length - 1 > 1 ? "others" : "other"
              } `;
              return result;
            }
            if (first.facilitator) {
              result = `Liked by  ${first.facilitator.name} and  ${
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

    drop(id, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/feeds/${id}`, {
              headers: {
                Authorization: `Bearer ${this.usertoken.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 204) {
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
<style scoped>
.main-card {
  height: 100vh;
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

/* eslint-disable vue/no-unused-vars */
<template>
  <div class="pt-sm-4">
    <b-container fluid>
      <b-row v-if="showdiscussion">
        <b-col class="px-0 px-sm-3" sm="8">
          <div class="bg-white py-4 rounded">
            <div class="main_content text-left">
              <div @click="$router.go(-1)" class="d-flex w-100">
                <b-icon icon="arrow-left" class="pl-4 cursor-pointer"></b-icon>
              </div>
              <div class="content px-2 py-3 pt-4 pb-3">
                <div class="top_dis d-flex align-items-center mb-2">
                  <div class="side_dis">
                    <b-avatar
                      :src="discussion.admin.profile"
                      v-if="discussion.admin"
                    ></b-avatar>
                    <b-avatar
                      :src="discussion.user.profile"
                      v-if="discussion.user"
                      @click="
                        $router.push(`/learner/profile/u/${discussion.user.id}`)
                      "
                    ></b-avatar>
                    <b-avatar
                      :src="discussion.facilitator.profile"
                      v-if="discussion.facilitator"
                      @click="
                        $router.push(
                          `/learner/profile/f/${discussion.facilitator.id}`
                        )
                      "
                    ></b-avatar>
                  </div>
                  <div class="text-left next_dis">
                    <div class="title h4 mb-1 d-flex">
                      <span class="mr-2 flex-1">{{ discussion.name }}</span
                      ><span>
                        <text-to-speech
                          :text="thread"
                          :voice="voices"
                        ></text-to-speech
                      ></span>
                    </div>
                    <div class="asked">
                      Created
                      {{ discussion.created_at | moment("ll") }}
                    </div>
                  </div>
                </div>
                <div class="top_dis d-flex align-items-start">
                  <div
                    class="
                      side_dis
                      d-flex
                      flex-column
                      align-items-center
                      justify-content-center
                      text-center
                      vote
                    "
                  >
                    <b-icon
                      @click="addvote"
                      icon="caret-up-fill"
                      font-scale="1.2"
                      class="cursor-pointer"
                    ></b-icon>
                    <span v-if="discussion.discussionvote">{{ vote }}</span>
                    <span v-else>0</span>
                    <b-icon
                      @click="dropvote"
                      icon="caret-down-fill"
                      font-scale="1.2"
                      class="cursor-pointer"
                    ></b-icon>
                  </div>
                  <div class="text-left next_dis">
                    <div class="main_text">
                      {{ discussion.description }}
                    </div>
                  </div>
                </div>

                <div
                  class="
                    bottom_bar
                    d-flex
                    justify-content-between
                    mb-4
                    discussion_title
                  "
                >
                  <div>
                    <span class="mr-3 dis_set"
                      ><b-icon icon="chat" class="mr-1"></b-icon>
                      <span v-if="posts"> {{ posts.length }}</span>
                      <span v-else>0</span> answers</span
                    >
                    <span class="mr-3 dis_set"
                      ><b-icon icon="eye-fill" class="mr-1"></b-icon>
                      <span v-if="views"> {{ views }}</span>
                      <span v-else>0</span> views</span
                    >
                  </div>
                  <div class="dis_set">
                    <span> Created by </span>
                    <span
                      v-if="discussion.admin"
                      class="cursor-pointer text-dark-green"
                      >{{ discussion.admin.name }}</span
                    >
                    <span
                      v-if="discussion.user"
                      class="cursor-pointer text-dark-green"
                      @click="
                        $router.push(`/learner/profile/u/${discussion.user.id}`)
                      "
                      >{{ discussion.user.name }}</span
                    >
                    <span
                      v-if="discussion.facilitator"
                      class="cursor-pointer text-dark-green"
                      @click="
                        $router.push(
                          `/learner/profile/f/${discussion.facilitator.id}`
                        )
                      "
                      >{{ discussion.facilitator.name }}</span
                    >
                  </div>
                </div>

                <div v-if="posts" v-chat-scroll>
                  <div
                    class="bottom_bar mb-3 position-relative"
                    v-for="(item, index) in posts"
                    :key="index"
                  >
                    <span v-if="item.message" class="text2speech">
                      <text-to-speech
                        :text="toText(item.message)"
                        :voice="voices"
                      ></text-to-speech>
                    </span>

                    <div class="position-relative">
                      <div
                        class="fs14 mb-1"
                        v-if="item.message"
                        v-html="item.message"
                      ></div>
                      <div
                        class="text-center"
                        v-if="
                          item.attachment &&
                          img_ext.includes(getextension(item.attachment))
                        "
                      >
                        <div class="image">
                          <a
                            download=""
                            target="_blank"
                            :href="item.attachment"
                          >
                            <b-img fluid-grow :src="item.attachment"></b-img
                          ></a>
                        </div>
                      </div>

                      <div class="document text-center mb-2" v-else>
                        <a download="" target="_blank" :href="item.attachment">
                          <span
                            class="d-flex justify-content-center"
                            v-if="
                              item.attachment &&
                              vid_ext.includes(getextension(item.attachment))
                            "
                          >
                            <span class="p-2 text-dark bg-white"
                              >Download video</span
                            >
                            <b-iconstack font-scale="3">
                              <b-icon
                                stacked
                                icon="square-fill"
                                variant="warning"
                              ></b-icon>
                              <b-icon
                                stacked
                                icon="camera-video"
                                variant="white"
                                scale="0.5"
                              ></b-icon>
                            </b-iconstack>
                          </span>

                          <span
                            class="d-flex justify-content-center"
                            v-if="
                              item.attachment &&
                              aud_ext.includes(getextension(item.attachment))
                            "
                          >
                            <span class="p-2 text-dark bg-white"
                              >Download audio</span
                            >
                            <b-iconstack font-scale="3">
                              <b-icon
                                stacked
                                icon="square-fill"
                                variant="warning"
                              ></b-icon>
                              <b-icon
                                stacked
                                icon="music-note-beamed"
                                variant="white"
                                scale="0.5"
                              ></b-icon>
                            </b-iconstack>
                          </span>

                          <span
                            class="d-flex justify-content-center"
                            v-if="
                              item.attachment &&
                              doc_ext.includes(getextension(item.attachment))
                            "
                          >
                            <span class="p-2 text-dark bg-white"
                              >Download file</span
                            >
                            <b-iconstack font-scale="3">
                              <b-icon
                                stacked
                                icon="square-fill"
                                variant="warning"
                              ></b-icon>
                              <b-icon
                                stacked
                                icon="file-arrow-down"
                                scale="0.5"
                                variant="white"
                              ></b-icon>
                            </b-iconstack>
                          </span>
                        </a>
                      </div>
                    </div>

                    <div
                      class="d-flex justify-content-between align-items-center"
                    >
                      <div class="d-flex align-items-center">
                        <span class="">
                          <b-avatar
                            size="sm"
                            :src="item.admin.profile"
                            v-if="item.admin"
                            class="mr-2"
                          ></b-avatar>
                          <b-avatar
                            size="sm"
                            :src="item.user.profile"
                            v-if="item.user"
                            class="mr-2"
                          ></b-avatar>
                          <b-avatar
                            size="sm"
                            :src="item.facilitator.profile"
                            v-if="item.facilitator"
                            class="mr-2"
                          ></b-avatar>
                        </span>
                        <span v-if="item.admin" class="fs13">{{
                          item.admin.name
                        }}</span>
                        <span
                          v-if="item.user"
                          @click="
                            $router.push(`/learner/profile/u/${item.user.id}`)
                          "
                          class="fs13 cursor-pointer"
                          >{{ item.user.name }}</span
                        >
                        <span
                          v-if="item.facilitator"
                          @click="
                            $router.push(
                              `/learner/profile/f/${item.facilitator.id}`
                            )
                          "
                          class="fs13 cursor-pointer"
                          >{{ item.facilitator.name }}</span
                        >
                      </div>
                      <span>{{ item.created_at | moment("ll") }}</span>
                    </div>
                  </div>
                </div>
              </div>
              <div class="py-4 px-3 text-post">
                <b-form @submit.prevent="post" class="wrapper">
                  <!-- <b-textarea
                    @keyup.enter="post"
                    class="regular-input mb-2"
                    v-model="info.message"
                    rows="3"
                    placeholder="Start typing here.."
                  ></b-textarea> -->
                  <b-form-group>
                    <editor
                      api-key="0faxd6jp8vlrnoj74njdtskkywu2nqvbuta5scv42arkdczq"
                      @keyup.enter="post"
                      class="regular-input mb-4"
                      placeholder="Start typing here.."
                      v-model="info.message"
                      :init="{
                        height: 150,
                        menubar: false,
                        plugins: [
                          '  lists link  charmap   anchor',
                          'searchreplace visualblocks code fullscreen',
                          '  table paste code',
                        ],
                        toolbar:
                          ' formatselect | bold italic | \
           alignleft aligncenter alignright alignjustify | \
           bullist numlist  ',
                      }"
                    />
                  </b-form-group>

                  <div class="d-flex justify-content-between">
                    <div class="d-none d-md-block">
                      <emoji-picker @emoji="insert" :search="search">
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
                        <div
                          slot="emoji-picker"
                          slot-scope="{ emojis, insert }"
                        >
                          <div class="emoji-picker">
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
                    </div>
                    <div
                      class="
                        d-flex
                        justify-content-between
                        align-items-center
                        w-100
                      "
                    >
                      <div class="share text-left">
                        <span
                          class="mr-3 fs12 cursor-pointer"
                          @click="$bvModal.show('share')"
                          >Share
                          <b-icon icon="share-fill" font-scale=".9"></b-icon
                        ></span>
                        <span
                          class="fs12 cursor-pointer"
                          @click="$bvModal.show('invite')"
                          >Invite
                          <b-icon
                            icon="person-plus-fill"
                            font-scale=".9"
                          ></b-icon
                        ></span>
                      </div>
                      <div class="d-flex align-items-center">
                        <Attachment @getUpload="getUpload" class="" />
                        <speech-to-text
                          class="mx-2"
                          @getText="getText"
                        ></speech-to-text>
                        <b-button variant="dark-green" size="sm" type="submit"
                          >Post</b-button
                        >
                      </div>
                    </div>
                  </div>
                </b-form>
              </div>
            </div>
          </div>
        </b-col>
        <b-col sm="4" class="d-none d-md-block">
          <div class="bg-white p-4 rounded">
            <div class="text-center mb-4">
              <b-button variant="dark-green" size="lg" class="px-3"
                >Start a discussion</b-button
              >
            </div>
            <div class="py-3 text-left related_quest border" v-if="related">
              <h6 class="mb-3 px-3">Related Discussions</h6>
              <div v-for="item in related" :key="item.id">
                <div
                  class="d-flex p-2 px-3 cursor-pointer"
                  v-if="item.type == 'public'"
                  @click="$router.push(`/administrator/discussion/${item.id}`)"
                >
                  <div v-if="item.discussionmessage.length">
                    <div class="mr-3 related_count">
                      {{ item.discussionmessage.length }}
                    </div>
                  </div>
                  <div class="related text-left">{{ item.name }}</div>
                </div>
                <div
                  class="d-flex p-2 px-3"
                  v-else
                  @click="$bvModal.show('access')"
                >
                  <div v-if="item.discussionmessage.length">
                    <div class="mr-3 related_count">
                      {{ item.discussionmessage.length }}
                    </div>
                  </div>
                  <div class="related text-left">{{ item.name }}</div>
                </div>
              </div>
            </div>
          </div>
        </b-col>
      </b-row>
    </b-container>
    <b-modal id="access" title="Request Access" hide-footer centered>
      <div class="text-center">
        <p class="mb-4 fs16">Do you wish to join this discussion?</p>
        <b-button
          variant="outline-secondary"
          class="mr-3"
          size="sm"
          @click="$bvModal.hide('access')"
          >Cancel</b-button
        >
        <b-button
          variant="secondary"
          size="sm"
          @click="$toast.success('Request sent succesfully')"
          >Send a request</b-button
        >
      </div>
    </b-modal>
    <b-modal no-close-on-backdrop id="share" hide-footer centered size="lg">
      <div class="p-2 text-center">
        <h6 class="font-weight-bold mb-3">Share Invite</h6>
        <ShareNetwork
          v-if="discussion.name"
          class="mr-3"
          network="facebook"
          :url="link"
          title="DISCUSSION INVITATION"
          :description="`I just joined a discussion, ${discussion.name.toUpperCase()}  on SkillsGuruh and I’d like to hear your thoughts. `"
          quote="SkillsGuruh"
          hashtags="SkillsGuruh,  Social learning"
        >
          <b-button variant="outline-dark-green"
            ><b-icon class="mr-1" icon="facebook"></b-icon> Facebook</b-button
          >
        </ShareNetwork>
        <ShareNetwork
          v-if="discussion.name"
          class="mr-3"
          network="twitter"
          :url="link"
          title="DISCUSSION INVITATION"
          :description="`I just joined a discussion, ${discussion.name.toUpperCase()}  on SkillsGuruh and I’d like to hear your thoughts. `"
          quote="SkillsGuruh"
          hashtags="SkillsGuruh,  Social learning"
        >
          <b-button variant="outline-dark-green"
            ><b-icon class="mr-1" icon="twitter"></b-icon> Twitter</b-button
          >
        </ShareNetwork>
        <ShareNetwork
          v-if="discussion.name"
          class="mr-3"
          network="whatsApp"
          :url="link"
          title="DISCUSSION INVITATION"
          :description="`I just joined a discussion, ${discussion.name.toUpperCase()}  on SkillsGuruh and I’d like to hear your thoughts. `"
          quote="SkillsGuruh"
          hashtags="SkillsGuruh,  Social learning"
        >
          <b-button variant="outline-dark-green">
            <b-iconstack>
              <b-icon stacked icon="circle-fill" variant="dark-green"></b-icon>
              <b-icon
                stacked
                icon="telephone-plus"
                variant="light"
                scale="0.5"
              ></b-icon>
            </b-iconstack>
            Whatsapp</b-button
          >
        </ShareNetwork>
        <ShareNetwork
          v-if="discussion.name"
          class="mr-3"
          network="Telegram"
          :url="link"
          title="DISCUSSION INVITATION"
          :description="`I just joined a discussion, ${discussion.name.toUpperCase()}  on SkillsGuruh and I’d like to hear your thoughts. `"
          quote="SkillsGuruh"
          hashtags="SkillsGuruh,  Social learning"
        >
          <b-button variant="outline-dark-green"
            ><b-icon class="mr-1" icon="cursor-fill"></b-icon>
            Telegram</b-button
          >
        </ShareNetwork>
        <b-button variant="outline-dark-green" @click="addToFeed">
          <b-icon icon="rss-fill" variant="dark-green"></b-icon>

          Feeds</b-button
        >
      </div>
    </b-modal>

    <b-modal no-close-on-backdrop id="invite" size="sm" centered hide-footer>
      <div class="box text-center">
        <h6 class="text-center">Invite your friends</h6>
        <div class="mb-4">
          <div
            v-for="(item, id) in inviteUsers.users"
            :key="id"
            class="mb-1 text-center"
          >
            <b-input-group size="sm" class="">
              <template #append>
                <b-button @click="inviteUsers.users.splice(id, 1)"
                  ><strong>x</strong></b-button
                >
              </template>
              <b-form-input
                v-model="item.email"
                placeholder="Enter email address"
              ></b-form-input>
            </b-input-group>
          </div>
          <div class="text-center mt-3">
            <b-button
              size="sm"
              class="mr-3 py-1 px-2 fs12"
              variant="lighter-green"
              @click="addinvite"
            >
              <b-icon icon="plus" font-scale="1.4"></b-icon> Add email</b-button
            >
            <b-button
              size="sm"
              variant="dark-green"
              class="fs12 py-1 px-2"
              @click="sendinvite(discussion.name)"
            >
              Send Invite
            </b-button>
          </div>
        </div>

        <div class="connections p-3 border rounded">
          <h6 class="mb-3 fs13 text-left">Connections</h6>
          <div class="px-2 py-1 d-flex align-items-center search bg-light mb-3">
            <b-icon icon="search"></b-icon>
            <b-form-input
              autocomplete="off"
              autocorrect="off"
              size="sm"
              v-model="search"
              class="flex-1 border-0 no-focus search-bg"
              type="search"
              placeholder="Search name"
            ></b-form-input>
          </div>
          <div v-for="(item, id) in filteredConnections" :key="id">
            <div v-if="item.user_follower" class="d-flex align-items-end mb-4">
              <b-form-checkbox
                size="sm"
                v-model="emails"
                :value="item.user_follower.email"
              >
                <div class="d-flex align-items-center flex-1">
                  <b-avatar class="mr-2" size="1.3rem"></b-avatar>
                  <div class="text-left" style="line-height: 1.1">
                    <span class="fs12">{{ item.user_follower.name }}</span>
                  </div>
                </div>
              </b-form-checkbox>
            </div>
            <div v-else class="d-flex align-items-end mb-4">
              <b-form-checkbox
                size="sm"
                :value="item.facilitator_follower.email"
                v-model="emails"
              >
                <div class="d-flex align-items-center flex-1">
                  <b-avatar class="mr-2" size="1.3rem"></b-avatar>
                  <div>
                    <span>{{ item.facilitator_follower.name }}</span>
                  </div>
                </div>
              </b-form-checkbox>
            </div>
          </div>
        </div>
      </div>
    </b-modal>
  </div>
</template>

<script>
import EmojiPicker from "vue-emoji-picker";
import Attachment from "../miniupload";
import Editor from "@tinymce/tinymce-vue";
import SpeechToText from "@/components/speechToText";
import TextToSpeech from "@/components/textToSpeech";

export default {
  data() {
    return {
      img_ext: ["jpg", "png", "jpeg", "gif"],
      vid_ext: ["mp4", "3gp"],
      aud_ext: ["mp3"],
      doc_ext: ["docx", "pdf", "ppt", "zip"],
      discussion: {},
      link: "",
      info: {
        attachment: "",
        message: "",
        discussion_id: null,
      },
      myviews: null,
      search: "",
      feed: {},
      inviteUsers: {
        title: "",
        users: [],
      },
      connections: [],
      emails: [],
      play: "",
      record: "",
      showdiscussion: false,
    };
  },
  components: {
    EmojiPicker,
    Attachment,
    SpeechToText,
    TextToSpeech,
    Editor,
  },
  created() {
    this.getdiscussion();
    this.addview();
    this.getvote();
    this.getconnections();
    this.link =
      "https://skillsguruh.com/learner/discussion/" + this.$route.params.id;

    var channel = this.$pusher.subscribe("adddiscussion");

    channel.bind("adddiscussion", (data) => {
      this.posts.push(data.message);
    });
  },
  computed: {
    thread() {
      var thread = this.discussion.discussionmessage.map((item) => {
        if (item.admin) {
          return `${item.admin.name}, ${this.toText(item.message)} ... `;
        }
        if (item.facilitator) {
          return `${item.facilitator.name}, ${this.toText(item.message)} ... `;
        }
        if (item.user) {
          return `${item.user.name}, ${this.toText(item.message)} ... `;
        }
      });
      if (this.discussion.admin) {
        thread.unshift(
          `${this.discussion.name} by ${this.discussion.admin.name} . ${this.discussion.description} ... `
        );
      }
      if (this.discussion.facilitator) {
        thread.unshift(
          `${this.discussion.name} by ${this.discussion.facilitator.name}. ${this.discussion.description} ... `
        );
      }
      if (this.discussion.user) {
        thread.unshift(
          `${this.discussion.name} by ${this.discussion.user.name}. ${this.discussion.description} ... `
        );
      }
      return thread.toString();
    },
    voices() {
      return this.$store.getters.voices[
        Number(this.$store.getters.learner.voice)
      ];
    },
    related() {
      if (!this.discussion.related) {
        return [];
      }
      return this.discussion.related.filter(
        (item) => Number(item.id) != Number(this.$route.params.id)
      );
    },
    posts() {
      return this.discussion.discussionmessage;
    },
    views() {
      return this.myviews;
    },
    vote() {
      var positive = this.discussion.discussionvote.filter(
        (item) => item.vote
      ).length;
      var negative = this.discussion.discussionvote.filter(
        (item) => !item.vote
      ).length;
      return Number(positive) - Number(negative);
    },

    filteredConnections() {
      return this.connections.filter((item) => {
        if (item.user_follower) {
          return item.user_follower.name
            .toLowerCase()
            .includes(this.search.toLowerCase());
        }
        if (item.facilitator_follower) {
          return item.facilitator_follower.name
            .toLowerCase()
            .includes(this.search.toLowerCase());
        }
      });
    },
  },
  methods: {
    toText(HTML) {
      var input = HTML;
      return input
        .replace(/<(style|script|iframe)[^>]*?>[\s\S]+?<\/\1\s*>/gi, "")
        .replace(/<[^>]+?>/g, "")
        .replace(/\s+/g, " ")
        .replace(/ /g, " ")
        .replace(/>/g, " ");
    },
    getText(res) {
      this.info.message = `${this.info.message} ${res}`;
    },
    async getconnections() {
      return this.$http
        .get(`${this.$store.getters.url}/connections`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.connections = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    addToFeed() {
      this.feed = {
        message:
          "I just started a discussion, " +
          this.discussion.name.toUpperCase() +
          " and I’d like to hear your thoughts",
        url: "https://skillsguruh.com/learner/discussion/" + this.discussion.id,
      };
      this.$http
        .post(`${this.$store.getters.url}/feeds`, this.feed, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201 || res.status == 200) {
            this.$toast.success("Added to feeds ");
            this.$bvModal.hide("share");

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
    sendinvite() {
      var emails = this.emails.map((item) => {
        return {
          email: item,
        };
      });
      this.inviteUsers.title = this.discussion.name;
      this.inviteUsers.id = this.discussion.id;
      this.inviteUsers.users = this.inviteUsers.users.concat(emails);
      this.$http
        .post(
          `${this.$store.getters.url}/send/discussion/invite`,
          this.inviteUsers,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Invite Sent");
            this.$bvModal.hide("share");
            this.inviteUsers = {
              title: "",
              users: [
                {
                  email: "",
                },
              ],
            };
          }
        });
    },
    addinvite() {
      this.inviteUsers.users.push({
        email: "",
      });
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

      this.info.attachment = val;
    },
    insert(emoji) {
      this.info.message += emoji + "";
    },
    getdiscussion() {
      this.$http
        .get(
          `${this.$store.getters.url}/discussions/${this.$route.params.id}`,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.discussion = res.data;
            this.showdiscussion = true;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    post() {
      this.info.discussion_id = this.$route.params.id;
      this.$http
        .post(`${this.$store.getters.url}/discussion-messages`, this.info, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201 || res.status == 200) {
            // this.$toast.success("Discussion created");
            // this.discussion.push(res.data);

            this.info = {
              attachment: "",
              message: "",
              discussion_id: null,
            };
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    addview() {
      this.$http
        .get(`${this.$store.getters.url}/add-view/${this.$route.params.id}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200 || res.status == 201) {
            this.myviews = res.data.view;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getvote() {
      this.$http
        .get(`${this.$store.getters.url}/votes/${this.$route.params.id}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.topvote = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    addvote() {
      this.$http
        .post(
          `${this.$store.getters.url}/votes`,
          { id: this.$route.params.id, vote: 1 },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 201) {
            this.discussion.discussionvote.push(res.data);
          }
          if (res.status == 200) {
            this.discussion.discussionvote.map((item) => {
              if (item.learner_id == this.$store.getters.learner.id) {
                return (item.vote = res.data.vote);
              }
            });
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    dropvote() {
      this.$http
        .post(
          `${this.$store.getters.url}/votes`,
          { id: this.$route.params.id, vote: 0 },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 201) {
            this.discussion.discussionvote.push(res.data);
          }
          if (res.status == 200) {
            this.discussion.discussionvote.map((item) => {
              if (item.learner_id == this.$store.getters.learner.id) {
                return (item.vote = res.data.vote);
              }
            });
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
  },
  directives: {
    focus: {
      inserted(el) {
        el.focus();
      },
    },
  },
};
</script>
<style scoped lang="scss">
.image {
  width: 100px;
  height: 150px;
  margin: 0 auto;
}
.wrapper {
  position: relative;
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
  z-index: 9;
}
.emoji-invoker:hover {
  transform: scale(1.1);
}
.emoji-invoker > svg {
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
  bottom: 10rem;
  right: 0;
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

.top_header div {
  font-size: 14px;
  color: rgba($color: #000000, $alpha: 0.54);
  position: relative;
  padding: 10px 12px;
  cursor: pointer;
  text-transform: capitalize;
}
.top_header div::after {
  content: "";
  position: absolute;
  bottom: 0;
  width: 100%;
  border-bottom: 2px solid transparent;
  left: 0;
}
.top_header div:hover::after {
  border-color: var(--dark-green);
}
.top_header div.active::after {
  border-color: var(--dark-green);
}
.top_header div.active {
  color: var(--dark-green);
}
.main_content {
  min-height: 80vh;
  max-height: 80vh;
  overflow-y: auto;
}
.content {
}
.side_dis {
  width: 15%;
  text-align: center;
}
.next_dis {
  width: 85%;
}
.asked {
  font-size: 12px;
  color: rgba($color: #000000, $alpha: 0.54);
}
.title {
  color: rgba($color: #000000, $alpha: 0.64);
}
.main_text {
  display: -webkit-box;
  font-size: 15px;
  line-height: 1.6;
  color: rgba($color: #000000, $alpha: 0.5);
  text-overflow: ellipsis;
  overflow: hidden;
  line-clamp: 4;
  -webkit-line-clamp: 4;
  -webkit-box-orient: vertical;
}
.bottom_bar {
  width: 85%;
  margin-left: auto;
  padding: 13px;
  border-radius: 4px;
  background: #fbfbfb;
  font-size: 12px;
  margin-top: 14px;
}
.related_quest {
  border-radius: 8px;
}
.related {
  font-size: 12px;
}

@media (max-width: 600px) {
  .b-avatar {
    width: 1.8rem;
    height: 1.8rem;
  }
}
</style>

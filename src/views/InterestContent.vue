<template>
  <div>
    <section class="explore_banner">
      <div class="text-capitalize d-flex align-items-center">
        <h1 class="mb-0">{{ currentinterests.value }}</h1>
        <span class="px-1 text-white">/</span>
        <h5 class="text-white mb-0">{{ subId }}</h5>
      </div>
    </section>
    <div
      class="bg-light pb-5 pt-0 pt-sm-5 position-relative"
      v-if="currentinterests"
    >
      <b-container class="">
        <div class="text-left mb-2 d-none d-sm-block">
          <span @click="$router.go(-1)" class="cursor-pointer back fs13">
            <span class="mr-2">
              <b-icon icon="arrow-left" class=""></b-icon
            ></span>
            <span class="d-none d-sm-inline">Back</span>
          </span>
        </div>
        <b-row class="px-3 px-sm-0" no-gutters>
          <b-col sm="9" class="">
            <b-row>
              <b-col cols="12" class="mb-0 rounded-sm px-0 px-sm-4 pb-2">
                <b-card
                  no-body
                  class="overflow-hidden border-0 bg-white rounded-sm"
                  style=""
                >
                  <b-card-body class="p-0">
                    <div class="d-flex align-items-center">

                      <div
                        class="text-left d-inline d-sm-none border-right p-2"
                      >
                        <span
                          @click="$router.go(-1)"
                          class="cursor-pointer back fs13"
                        >
                          <span class="mr-2">
                            <b-icon icon="arrow-left" class=""></b-icon
                          ></span>
                          <span class="d-none d-sm-inline">Back</span>
                        </span>
                      </div>

                    </div>
                    <hr class="mt-0" />
                    <nav class="w-100">
                      <ul
                        id="navbar"
                        class="
                          d-flex
                          justify-content-start
                          text-decoration-none
                          list-unstyled
                        "
                      >


                        <li
                          class="h6 fs14 cursor-pointer mb-0 text-muted"
                          :class="active == 2 ? 'active' : ''"
                          @click="active = 2"
                        >
                          Discussions
                        </li>

                      </ul>
                    </nav>
                  </b-card-body>
                </b-card>
              </b-col>

              <b-col cols="12" class="px-1 px-sm-4">
                <b-card
                  no-body
                  class="border-0 bg-transparent rounded"
                  style=""
                >
                  <b-card-body class="px-0">

                    <div v-if="active == 2" class="pt-0 px-0">
                      <div>
                        <div class="main_content" v-if="discussions.length">
                          <div
                            class="
                              content
                              border-bottom
                              p-3
                              pt-4
                              pb-5
                              cursor-pointer
                              bg-white
                            "
                            v-for="(item, index) in discussions"
                            :key="index"
                          >
                            <div
                              class="
                                top_dis
                                d-flex
                                align-items-center
                                mb-2
                                position-relative
                              "
                            >
                              <!-- <b-dropdown
                                size="sm"
                                variant="transparent"
                                no-caret
                                class="no-focus drop"
                              >
                                <template #button-content>
                                  <b-icon
                                    icon="three-dots-vertical"
                                    font-scale="1.1"
                                  ></b-icon>
                                </template>
                                <b-dropdown-item
                                  class="fs12"
                                  @click="$router.push(`/feed/view/${feed.id}`)"
                                  >View</b-dropdown-item
                                >
                              </b-dropdown> -->
                              <div class="side_dis">
                                <b-avatar
                                  v-if="item.creator == 'admin'"
                                  :src="item.admin.profile"
                                ></b-avatar>
                                <b-avatar
                                  v-if="item.creator == 'user'"
                                  :src="item.user.profile"
                                ></b-avatar>
                                <b-avatar
                                  v-if="item.creator == 'facilitator'"
                                  :src="item.facilitator.profile"
                                ></b-avatar>
                              </div>
                              <div class="text-left next_dis">
                                <span>
                                  <span class="asked mr-2">
                                    Started
                                    {{ item.created_at | moment("ll") }}</span
                                  >
                                  <span class="mr-2 fs13"
                                    ><b-badge
                                      class="text-capitalize font-weight-normal"
                                      variant="dark-green"
                                      >{{ item.type }}</b-badge
                                    ></span
                                  >
                                </span>
                                <br />
                                <span class="title">{{ item.name }} </span>
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
                                  icon="caret-up-fill"
                                  font-scale="1.2"
                                  class="cursor-pointer"
                                ></b-icon>
                                <span v-if="item.discussionvote">
                                  <span v-if="vote(item.discussionvote) > 0"
                                    >+</span
                                  >
                                  <span v-if="vote(item.discussionvote) < 0"
                                    >-</span
                                  >{{ vote(item.discussionvote) }}</span
                                >
                                <span v-else>0</span>

                                <b-icon
                                  icon="caret-down-fill"
                                  font-scale="1.2"
                                  class="cursor-pointer"
                                ></b-icon>
                              </div>
                              <div class="text-left next_dis">
                                <div class="main_text">
                                  {{ item.description }}
                                </div>
                              </div>
                            </div>

                            <div
                              class="bottom_bar d-flex justify-content-between"
                            >
                              <div>
                                <span class="mr-4"
                                  ><b-icon icon="chat" class="mr-1"></b-icon>
                                  <span>{{
                                    item.discussionmessage.length
                                  }}</span>
                                  answers</span
                                >
                                <span class="mr-4"
                                  ><b-icon
                                    icon="eye-fill"
                                    class="mr-1"
                                  ></b-icon>
                                  <span v-if="item.discussionview">{{
                                    item.discussionview.view || 0
                                  }}</span>
                                  <span v-else>{{ 0 }}</span> views</span
                                >
                              </div>
                              <div>
                                <span
                                  @click="joindiscussion"
                                  class="
                                    text-dark-green
                                    font-weight-bold
                                    cursor-pointer
                                  "
                                  >Join Discussion</span
                                >
                              </div>
                            </div>
                          </div>


                        </div>

                        <div v-else class="text-center admin_tab p-3 p-sm-5">
                          <div>
                            <b-img
                              :src="require('@/assets/images/creator.svg')"
                            ></b-img>
                            <h6 class="text-muted my-3 fs14">
                              No Discussion availbale
                            </h6>
                          </div>
                        </div>
                      </div>
                      <div class="d-flex justify-content-end mt-4" v-if="discussions.length">
                             <b-button  size="sm" class="mr-2" :disabled="page===1" @click="page--">Prev</b-button>
                            <b-button size="sm" :disabled="page===lastpage" @click="page++">Next</b-button>
                          </div>
                    </div>

                  </b-card-body>
                </b-card>
              </b-col>
            </b-row>
          </b-col>
          <b-col sm="3" class="d-none d-sm-block">
            <nav class="rounded px-3">
              <ul>
                <li
                  v-for="(sub, id) in filteredinterests"
                  :key="id"
                  @click="subId = sub.value.trim()"
                  :class="subId == sub.value ? 'activesub' : ''"
                  class="d-flex align-items-center"
                >

                  <span>{{ sub.value.trim() }}</span>
                </li>
              </ul>
            </nav>
          </b-col>
        </b-row>
      </b-container>
      <b-modal
        no-close-on-backdrop
        id="share"
        hide-footer
        centered
        v-if="course"
        size="lg"
      >
        <div class="p-2 text-center">
          <h6 class="font-weight-bold mb-3">Share Invite</h6>
          <ShareNetwork
            class="mr-3"
            network="facebook"
            :url="link"
            title="COURSE INVITATION"
            :description="`I enrolled for the course, *${course.title}* on Nzukoor and I think you'd like it. Join me`"
            quote="Nzukoor"
            hashtags="Nzukoor,  Social learning"
          >
            <b-button variant="outline-dark-green"
              ><b-icon class="mr-1" icon="facebook"></b-icon>
              <span class="d-none d-md-block">Facebook</span></b-button
            >
          </ShareNetwork>
          <ShareNetwork
            class="mr-3"
            network="twitter"
            :url="link"
            title="COURSE INVITATION"
            :description="`I enrolled for the course, *${course.title}* on Nzukoor and I think you'd like it. Join me`"
            quote="Nzukoor"
            hashtags="Nzukoor,  Social learning"
          >
            <b-button variant="outline-dark-green"
              ><b-icon class="mr-1" icon="twitter"></b-icon>
              <span class="d-none d-md-block">Twitter</span>
            </b-button>
          </ShareNetwork>
          <ShareNetwork
            class="mr-3"
            network="whatsApp"
            :url="link"
            title="COURSE INVITATION"
            :description="`I enrolled for the course, *${course.title}* on Nzukoor and I think you'd like it. Join me`"
            quote="Nzukoor"
            hashtags="Nzukoor,  Social learning"
          >
            <b-button variant="outline-dark-green">
              <b-iconstack>
                <b-icon
                  stacked
                  icon="circle-fill"
                  variant="dark-green"
                ></b-icon>
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
            title="COURSE INVITATION"
            :description="`I enrolled for the course, *${course.title}* on Nzukoor and I think you'd like it. Join me`"
            quote="Nzukoor"
            hashtags="Nzukoor,  Social learning"
          >
            <b-button variant="outline-dark-green"
              ><b-icon class="mr-1" icon="cursor-fill"></b-icon>
              <span class="d-none d-md-block">Telegram</span>
            </b-button>
          </ShareNetwork>
        </div>
      </b-modal>

      <b-modal no-close-on-backdrop id="sharecourse" centered hide-footer>
        <div class="box p-3 text-center">
          <h6 class="text-center">Invite your friends</h6>
          <div>
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
                  type="email"
                  v-model="item.email"
                  placeholder="Enter email address"
                ></b-form-input>
              </b-input-group>
            </div>
            <div class="text-center mt-3">
              <b-button
                size="sm"
                class="mr-3"
                variant="lighter-green"
                @click="addinvite"
              >
                <b-icon icon="plus" font-scale="1.4"></b-icon> Add
                email</b-button
              >
              <b-button
                size="sm"
                variant="dark-green"
                :disabled="sending"
                @click="sendinvite(course.title)"
              >
                Send Invite
              </b-button>
            </div>
          </div>
          <div class="mt-3 border p-2 rounded-pill d-flex text-muted">
            <b-icon icon="link45deg" font-scale="1.2rem"></b-icon>

            <span
              class="fs12"
              v-clipboard:copy="message"
              v-clipboard:success="onCopy"
              v-clipboard:error="onError"
              >{{ message }}</span
            >
          </div>
        </div>
      </b-modal>

      <div class="mobile-nav mobile_nav d-flex align-items-end">
        <nav
          class="rounded p-2 mr-2 mb-3 bg-white shadow rounded"
          v-show="toggleNav"
        >
          <ul class="mb-0">
            <li
              v-for="(sub, id) in filteredinterests"
              :key="id"
              @click="subId = sub.value.trim()"
              :class="subId == sub.value ? 'activesub' : ''"
              class="d-flex align-items-center"
            >
              <span>{{ sub.value.trim() }}</span>
            </li>
          </ul>
        </nav>

        <b-icon
          variant="dark-green"
          class="mobile-add btn-circle btn-raised shadow"
          icon="plus-circle-fill"
          @click="toggleNav = !toggleNav"
          font-scale="2"
        ></b-icon>
      </div>
      <b-modal id="share" hide-footer centered size="lg">
        <div class="p-2 text-center">
          <h6 class="font-weight-bold mb-3">Share</h6>
          <ShareNetwork
            class="mr-3"
            network="facebook"
            :url="link"
            title=""
            :description="description"
            quote="Nzukoor"
            hashtags="Nzukoor,  Social learning"
          >
            <b-button
              size="sm"
              class="mb-2 mb-sm-0"
              variant="outline-dark-green"
              ><b-icon class="mr-1" icon="facebook"></b-icon>
              <span class="d-none d-md-block">Facebook</span></b-button
            >
          </ShareNetwork>
          <ShareNetwork
            class="mr-3"
            network="twitter"
            :url="link"
            title=""
            :description="description"
            quote="Nzukoor"
            hashtags="Nzukoor,  Social learning"
          >
            <b-button
              size="sm"
              class="mb-2 mb-sm-0"
              variant="outline-dark-green"
              ><b-icon class="mr-1" icon="twitter"></b-icon>
              <span class="d-none d-md-block">Twitter</span>
            </b-button>
          </ShareNetwork>
          <ShareNetwork
            class="mr-3"
            network="whatsApp"
            :url="link"
            title=""
            :description="description"
            quote="Nzukoor"
            hashtags="Nzukoor,  Social learning"
          >
            <b-button
              size="sm"
              class="mb-2 mb-sm-0"
              variant="outline-dark-green"
            >
              <b-iconstack>
                <b-icon
                  stacked
                  icon="circle-fill"
                  variant="dark-green"
                ></b-icon>
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
            title=""
            :description="description"
            quote="Nzukoor"
            hashtags="Nzukoor,  Social learning, Feeds"
          >
            <b-button
              size="sm"
              class="mb-2 mb-sm-0"
              variant="outline-dark-green"
              ><b-icon class="mr-1" icon="cursor-fill"></b-icon>
              <span class="d-none d-md-block">Telegram</span>
            </b-button>
          </ShareNetwork>
        </div>
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
          <div class="mb-3">
            <div class="d-flex mb-3 pt-3">
              <div class="d-flex flex-1 text-left">
                <div class="mr-2 mb-1" v-if="allcomments.admin">
                  <b-avatar
                    class="mr-2"
                    size="1.8rem"
                    :src="allcomments.admin.profile"
                  ></b-avatar>
                </div>
                <div class="mr-2 mb-1" v-if="allcomments.user">
                  <b-avatar
                    class="mr-2"
                    size="1.8rem"
                    :src="allcomments.user.profile"
                  ></b-avatar>
                </div>
                <div
                  class="comment_name mr-2 mb-1"
                  v-if="allcomments.facilitator"
                >
                  <b-avatar
                    class="mr-2"
                    size="1.8rem"
                    :src="allcomments.facilitator.profile"
                  ></b-avatar>
                </div>
                <div class="profile">
                  <div class="name" v-if="allcomments.admin">
                    {{ allcomments.admin.name }}
                  </div>
                  <div class="name" v-if="allcomments.user">
                    {{ allcomments.user.username }}
                  </div>
                  <div class="name" v-if="allcomments.facilitator">
                    {{ allcomments.facilitator.username }}
                  </div>

                  <div class="date fs11">
                    {{ allcomments.created_at | moment("ll") }}
                  </div>
                </div>
              </div>
            </div>
            <div class="text-left feed_text px-3 pb-3">
              <span>{{ allcomments.message }}</span>
            </div>
          </div>
          <div class="comments">
            <div
              class="comment d-flex text-left mb-2"
              v-for="(item, index) in allcomments.comments"
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
                        <div class="comment_text">{{ item.comment }}</div>
                      </div>
                    </div>
                    <div>
                      <span class="comment_mins pl-2">{{
                        $moment(item.created_at).fromNow()
                      }}</span>
                    </div>
                  </div>
                  <div class="d-flex mb-1" v-if="item.user">
                    <div class="d-flex flex-1">
                      <b-avatar
                        class="mr-2"
                        size="sm"
                        :src="item.user.profile"
                      ></b-avatar>
                      <div>
                        <div class="comment_name">
                          {{ item.user.username }}
                        </div>
                        <div class="comment_text">{{ item.comment }}</div>
                      </div>
                    </div>
                    <div>
                      <span class="comment_mins pl-2">{{
                        $moment(item.created_at).fromNow()
                      }}</span>
                    </div>
                  </div>
                  <div class="d-flex mb-1" v-if="item.facilitator">
                    <div class="d-flex flex-1">
                      <b-avatar
                        class="mr-2"
                        size="sm"
                        :src="item.facilitator.profile"
                      ></b-avatar>
                      <div>
                        <div class="comment_name">
                          {{ item.facilitator.username }}
                        </div>
                        <div class="comment_text">{{ item.comment }}</div>
                      </div>
                    </div>
                    <div>
                      <span class="comment_mins pl-2">{{
                        $moment(item.created_at).fromNow()
                      }}</span>
                    </div>
                  </div>
                </div>
              </div>
              <div></div>
            </div>
          </div>
        </div>
      </b-modal>

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
  </div>
</template>
<script>
import interests from "@/components/helpers/category.js";
import subinterests from "@/components/helpers/subcategory.js";
export default {
  data() {
    return {
      id: this.$route.params.id,
      toggleNav: false,
      description: "",
      subId: null,
      detail: [],
      active: 2,
      search: "",
      currentPage: 1,
      rows: null,
      perPage: 10,
      feeds: [],
      users: [],
      discussions: [],
      facilitators: [],

      img_ext: ["jpg", "png", "jpeg", "gif"],
      vid_ext: ["mp4", "3gp"],
      aud_ext: ["mp3"],
      doc_ext: ["docx", "pdf", "ppt", "zip"],
      mini_info: {
        id: "",
        name: "",
        type: "",
        profile: "",
      },
      open: false,
      showAll: false,

      link: "",
      message: "",
      interests: [],
      subinterests: [],
      inviteUsers: {
        code: "",
        title: "",
        url: "",
        users: [
          {
            email: "",
          },
        ],
      },
      course: null,
      courses: [],
      type: 1,
      newmodule: "",
      toggleCourse: 1,
      alpha: false,
      showCourse: false,
      course_type: "",
      recent: false,
      trending: false,
      sending: false,
      feed: null,
      alllikes: null,
      allcomments: null,
      page:1,
      lastpage:null
    };
  },
  created() {
    this.interests = interests;
    this.subinterests = subinterests;
  },
  watch: {
    $route: "getcontent",
    filteredinterests: "setSubInterest",
    subId: "getcontent",
    page:"getcontent"
  },
  computed: {
    usertoken() {
      var token = null;
      if (this.$store.getters.admin.access_token) {
        return this.$store.getters.admin;
      }
      if (this.$store.getters.facilitator.access_token) {
        return this.$store.getters.facilitator;
      }
      if (this.$store.getters.member.access_token) {
        return this.$store.getters.member;
      }
      return token;
    },
    filteredinterests() {
      return this.subinterests.filter(
        (item) => item.category_id == this.$route.params.id
      );
    },
    currentinterests() {
      var result = this.interests.filter(
        (item) => item.id == this.$route.params.id
      );
      return result.slice().shift();
    },

    filter() {
      return this.courses.slice(
        this.perPage * this.currentPage - this.perPage,
        this.perPage * this.currentPage
      );
    },

  },

  methods: {
    joindiscussion() {
      this.$router.push(`/login`);
    },
    showlikes(likes) {
      this.alllikes = likes;

      this.$bvModal.show("alllikes");
    },
    sharenow(feed) {
      this.description = this.toText(feed.message);
      this.link = `https://nzukoor.com/member/feed/view/${feed.id}?utf_medium=share`;
      this.$bvModal.show("share");
    },
    setSubInterest() {
      this.subId = this.filteredinterests.slice().shift().value.trim();
    },
    sharelink(id) {
      this.link = `https://nzukoor.com/explore/courses/?course=${encodeURIComponent(
        this.course.title.trim()
      )}&course_id=${id}`;
      this.$bvModal.show("share");
    },
    loadCourse() {
      this.course = this.courses.find(
        (item) => item.id == this.$route.query.course_id
      );
    },
    getmediacount(arr, media) {
      var newarr = [];
      if (!arr.length) {
        return 0;
      }
      if (media == "document") {
        arr.forEach((val) => {
          JSON.parse(val.modules).forEach((item) => {
            if (
              item.file_type.toLowerCase() == media.toLowerCase() ||
              item.file_type.toLowerCase() == "worksheet"
            ) {
              newarr.push(item);
            }
          });
        });
      } else {
        arr.forEach((val) => {
          JSON.parse(val.modules).forEach((item) => {
            if (item.file_type.toLowerCase() == media.toLowerCase()) {
              newarr.push(item);
            }
          });
        });
      }

      return newarr.length;
    },
    showcourse(val) {
      this.course = val;

      // this.addcount(val.id);

      this.$bvModal.show("mobile-course");
    },
    addcourse() {
      this.$toast.info("Register to enroll");
      this.$router.push(
        `/register/?invite=${this.$route.query.invite}&course_id=${this.$route.query.course_id}`
      );
    },
    sortmodules(data) {
      if (!data.courseoutline) {
        return 0;
      }
      return JSON.parse(data.courseoutline.modules).length;
    },
    showcomments(feed) {
      this.allcomments = feed;
      this.$bvModal.show("allcomments");
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
    getextension(fileName) {
      if (fileName) {
        var regex = new RegExp("[^.]+$");
        var extension = fileName.match(regex);

        return extension[0].toLowerCase();
      }
    },

    getcontent() {
      this.$http
        .get(`${this.$store.getters.url}/get/interests/${this.subId}?page=${this.page}`)
        .then((res) => {
          if (res.status == 200) {
            this.discussions =res.data.discussions.data;
            this.showCourse = true;
            this.lastpage = res.data.discussions.last_page
          }
        })
        .catch(() => {
          this.$toast.error("Something went wrong");
        });
    },
    getUsers() {
      this.$http
        .get(`${this.$store.getters.url}/guest/users/${this.subId}`)
        .then((res) => {
          if (res.status == 200) {
            this.users = res.data;
            this.rows = res.data.length;
          }
        });
    },
    getfacilitators() {
      this.$http
        .get(`${this.$store.getters.url}/guest/facilitators`)
        .then((res) => {
          if (res.status == 200) {
            this.facilitators = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    sharecourse(id) {
      this.message = `https://nzukoor.com/explore/courses?course_id=${id}`;
      this.$bvModal.show("sharecourse");
    },
    vote(val) {
      var positive = val.filter((item) => item.vote).length;
      var negative = val.filter((item) => !item.vote).length;
      return Number(positive) - Number(negative);
    },
    sendinvite(title) {
      this.sending = true;
      this.inviteUsers.title = title;
      this.inviteUsers.url = this.message;

      if (this.usertoken.access_token) {
        this.$http
          .post(`${this.$store.getters.url}/send/invite`, this.inviteUsers, {
            headers: {
              Authorization: `Bearer ${this.usertoken.access_token}`,
            },
          })
          .then((res) => {
            if (res.status == 200) {
              this.$toast.success("Invite Sent");
              this.$bvModal.hide("sharecourse");
              this.sending = false;
              this.inviteUsers = {
                code: "",
                title: "",
                users: [
                  {
                    email: "",
                  },
                ],
              };
            }
          })
          .catch(() => {
            this.$toast.error("Sending failed!");
            this.sending = false;
          });
      } else if (this.$store.getters.facilitator.access_token) {
        this.$http
          .post(`${this.$store.getters.url}/send/invite`, this.inviteUsers, {
            headers: {
              Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
            },
          })
          .then((res) => {
            if (res.status == 200) {
              this.$toast.success("Invite Sent");
              this.$bvModal.hide("sharecourse");
              this.sending = false;
              this.inviteUsers = {
                code: "",
                title: "",
                users: [
                  {
                    email: "",
                  },
                ],
              };
            }
          })
          .catch(() => {
            this.$toast.error("Sending failed!");
            this.sending = false;
          });
      } else {
        this.$http
          .post(
            `${this.$store.getters.url}/guest/send/invite`,
            this.inviteUsers
          )
          .then((res) => {
            if (res.status == 200) {
              this.$toast.success("Invite Sent");
              this.$bvModal.hide("sharecourse");
              this.sending = false;
              this.inviteUsers = {
                code: "",
                title: "",
                users: [
                  {
                    email: "",
                  },
                ],
              };
            }
          })
          .catch(() => {
            this.$toast.error("Sending failed!");
            this.sending = false;
          });
      }
    },
    addinvite() {
      this.inviteUsers.users.push({
        email: "",
      });
    },
    onCopy: function (e) {
      alert("You just copied the following text to the clipboard: " + e.text);
    },
    onError: function (e) {
      alert("Failed to copy the text to the clipboard");
      console.log(e);
    },
  },
};
</script>
<style scoped lang="scss">
.container {
  padding-top: 0px;
  min-height: 100vh;
}
.discussion_overlay {
  position: absolute;
  width: 100%;
  height: 100%;
  background: rgba($color: #000000, $alpha: 0.24);
  // border-radius: 1px;
}
ul {
  text-decoration: none;
  list-style: none;
  text-align: left;
  padding-left: 0;
}
ul li {
  padding: 5px 10px;
  font-size: 0.9rem;
  cursor: pointer;
}
.activesub,
.active {
  color: var(--dark-green) !important;
}
.shadow {
  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
  border-radius: 8px;
}
h4.card-title {
  font-size: 1.1rem;
}

.search.form-control {
  width: 250px;
  border: 1px solid rgba($color: #000000, $alpha: 0.07) !important;
}
.search::placeholder {
  color: rgba($color: #000000, $alpha: 0.2);
}
#navbar {
  border-bottom: 1px solid #f7f8fa;
  margin-bottom: 0;
}
#navbar li {
  border-bottom: 3px solid transparent;
  width: 33.3%;
  text-align: center;
  padding-bottom: 8px;
}
#navbar li:hover {
  border-color: var(--lighter-green);
}
#navbar li.active {
  border-color: var(--dark-green);
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
  font-size: 15px;
  font-weight: 500;
  color: rgba($color: #000000, $alpha: 0.64);
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

.drop {
  position: absolute;
  top: 0;
  right: 15px;
}
.shadow {
  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
  border-radius: 8px;
}
.search.form-control {
  width: 250px;
  border: 1px solid rgba($color: #000000, $alpha: 0.07) !important;
}
.search::placeholder {
  color: rgba($color: #000000, $alpha: 0.2);
}
.admin_tab {
  min-height: 350px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.description {
  font-size: 15px;
  color: rgba($color: #000000, $alpha: 0.54);
  display: -webkit-box;
  line-clamp: 2;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  line-height: 1.3;
}
.options {
  position: absolute;
  right: 15px;
  top: 15px;
}
.my_courses {
  max-height: 100%;

}
.my_courses::-webkit-scrollbar {
  display: none;
}

/* Hide scrollbar for IE, Edge and Firefox */
.my_courses {
  -ms-overflow-style: none; /* IE and Edge */
  scrollbar-width: none; /* Firefox */
}
.main_box {
  transition: 0.5s;
}

.course_title {
  font-weight: 500;
}
.course_title {
  font-weight: 500;
}
.overview {
  font-size: 13px;
  color: rgba($color: #000000, $alpha: 0.54);
  display: -webkit-box;
  line-clamp: 2;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  line-height: 1.3;
}
.card-img,
.card-img-top {
  height: 4rem;
  width: 8rem;
  object-fit: contain;
}
.card-title {
  font-size: 13px;
  display: -webkit-box;
  line-clamp: 1;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  line-height: 1.3;
}
.course {
  position: relative;
  background: white;
  border-radius: 8px;
  overflow: hidden;
}
.course_img {
  width: 100%;
  border-radius: 8px;
  background-repeat: no-repeat;
  background-size: cover;
}
.course_text {
  height: 55%;
  padding: 10px;
}

.sideopen {
  position: absolute;
  top: 0;
  left: 0;
  padding: 2px 4px;
  background: var(--lighter-green);
  color: #333;
  font-size: 11px;
  cursor: pointer;
}
#facilitators {
  position: relative;
  padding-top: 8rem;
  padding-bottom: 5rem;
}
.ex-facilitators {
}

.ex-facilitators h2 {
  font-size: 25px;
  font-style: normal;
  font-weight: 600;
  line-height: 33px;
  letter-spacing: 0em;
  text-align: center;
}
.ex-facilitators p {
  font-size: 16px;
  font-style: normal;
  font-weight: 400;
  line-height: 28px;
  letter-spacing: 0.06em;
  text-align: center;
  color: #828282;
}
.facilitators {
  display: flex;
  width: 100%;
  margin: 0 auto;
  justify-content: space-around;
}

.facilitator {
  padding: 0;
  text-align: left;
  border-radius: 0;
  z-index: 1;
}
.facilitator:hover ~ .hover_box {
  right: -5px;
  transform: rotate(5deg);
  opacity: 1;
}
.facilitator img {
  width: 100%;
}
.facilitator > div {
}
.text-gold {
  color: gold;
}
.facilitator img {
  height: 150px;
  margin-bottom: 0 !important;
  border-radius: 0 0 5px 5px !important;
}
.f_detail,
.f_name {
  font-size: 0.8rem !important;
  padding: 0 5px 1px;
  line-height: 1.4;
}
@media (max-width: 600px) {
  .facilitator {
    border-radius: 0;
    padding: 0;
  }
  .facilitator img {
    height: 100px;
    margin-bottom: 0 !important;
  }
  .f_detail,
  .f_name {
    font-size: 0.6rem !important;
    padding: 0 5px 1px;
  }
}

@media (max-width: 375px) {
  .facilitator {
    border-radius: 0;
    padding: 0;
  }
  .facilitator img {
    height: 100px;
    margin-bottom: 0 !important;
  }
  .f_detail,
  .f_name {
    font-size: 0.55rem !important;
    padding: 0 5px 1px;
  }
}

.mobile_nav {
  display: none;
  z-index: 99;
}
@media (max-width: 600px) {
  h6 {
    font-size: 0.9rem;
  }
  nav ul li {
    font-size: 14px;
  }
  .card-img,
  .card-img-top {
    height: 3rem;
    width: 5rem;
    object-fit: contain;
  }
  .container {
    min-height: 80vh;
    padding: 0px 0px 30px;
  }
  .mobile_nav {
    display: block;
    position: fixed;
    bottom: 40px;
    right: 30px;
  }
  h6.fs14 {
    font-size: 12.5px;
  }
}
</style>

<template>
  <div>
    <b-container>
      <b-row class="justify-content-sm-center">
        <b-col sm="10">
          <b-row>
            <b-col cols="12" class="mb-0 rounded pt-2 px-4 pb-2">
              <b-card no-body class="overflow-hidden border-0" style="">
                <b-row no-gutters>
                  <div class="prof_img">
                    <b-card-img
                      width="15%"
                      :src="
                        detail.profile
                          ? detail.profile
                          : require('@/assets/images/default.png')
                      "
                      alt="Image"
                      class="rounded-0"
                    ></b-card-img>
                  </div>
                  <div class="flex-1">
                    <b-card-body
                      :title="detail.name"
                      class="text-left text-capitalize"
                    >
                      <b-card-text class="mb-1">
                        <span class="fs15 text-muted">
                          {{ detail.bio ? detail.bio : "N/A" }}</span
                        >
                      </b-card-text>
                      <b-card-text
                        class="d-flex align-items-center mb-0"
                        style="line-height: 1.1"
                      >
                        <span
                          class="fs11 text-muted cursor-pointer mr-2"
                          v-if="detail.age"
                        >
                          {{ detail.age }} years </span
                        >,

                        <span
                          class="fs12 text-muted cursor-pointer"
                          style="line-height: 1.1"
                        >
                          <span v-if="detail.state">{{ detail.state }}</span
                          >,
                          <span v-if="detail.country">
                            {{ detail.country }}</span
                          >
                        </span>
                      </b-card-text>

                      <b-card-text class="d-flex align-items-center">
                        <span
                          class="fs11 text-muted cursor-pointer"
                          @click="$bvModal.show('connections')"
                        >
                          {{ connections.length }}
                          {{
                            connections.length > 1
                              ? "connections"
                              : "connection"
                          }}</span
                        >
                        <span class="mx-2 mb-2">
                          <b-icon
                            class="text-muted"
                            icon="circle-fill"
                            font-scale=".2rem"
                          ></b-icon
                        ></span>
                        <span
                          class="fs12 text-muted cursor-pointer"
                          v-if="detail.interests"
                          @click="$bvModal.show('interests')"
                        >
                          {{ JSON.parse(detail.interests).length }}
                          {{
                            JSON.parse(detail.interests).length > 1
                              ? "interests"
                              : "interest"
                          }}
                        </span>
                      </b-card-text>
                    </b-card-body>
                  </div>
                </b-row>
              </b-card>
            </b-col>
            <b-col cols="12" class="px-4 mb-3">
              <b-card no-body class="border-0" style="">
                <b-row>
                  <b-card-body class="text-left w-100 pb-1">
                    <nav class="w-100">
                      <ul
                        id="navbar"
                        class="
                          d-flex
                          justify-content-around
                          text-decoration-none
                          list-unstyled
                        "
                      >
                        <li
                          class="h6 fs14 cursor-pointer mb-0"
                          :class="active == 1 ? 'active' : ''"
                          @click="active = 1"
                        >
                          Feeds
                        </li>
                        <li
                          class="h6 fs14 cursor-pointer mb-0"
                          :class="active == 2 ? 'active' : ''"
                          @click="active = 2"
                        >
                          Discussions
                        </li>
                        <li
                          class="h6 fs14 cursor-pointer mb-0"
                          :class="active == 3 ? 'active' : ''"
                          @click="active = 3"
                        >
                          Events
                        </li>
                      </ul>
                    </nav>
                  </b-card-body>
                </b-row>
              </b-card>
            </b-col>
            <b-col cols="12" class="px-4">
              <b-card no-body class="border-0 bg-transparent" style="">
                <b-row>
                  <b-card-body
                    class="text-left w-100 pb-1 pt-0 px-3"
                    v-if="active == 1"
                  >
                    <div>
                      <div v-if="feeds.length">
                        <div class="feed-content">
                          <div
                            v-for="(feed, index) in feeds"
                            :key="index"
                            class="border bg-white rounded mb-2"
                          >
                            <div class="d-flex mb-3 px-3 pt-3">
                              <div class="d-flex flex-1 text-left">
                                <div
                                  class="font-weight-bold mr-2 mb-1 feedname"
                                  v-if="feed.admin"
                                >
                                  <b-avatar
                                    class="mr-2"
                                    :src="feed.admin.profile"
                                  ></b-avatar>
                                  {{ feed.admin.name }}
                                </div>
                                <div
                                  class="font-weight-bold mr-2 mb-1 feedname"
                                  v-if="feed.user"
                                >
                                  <b-avatar
                                    class="mr-2"
                                    :src="feed.user.profile"
                                  ></b-avatar>
                                  {{ feed.user.name }}
                                </div>
                                <div
                                  class="font-weight-bold mr-2 mb-1 feedname"
                                  v-if="feed.facilitator"
                                >
                                  <b-avatar
                                    class="mr-2"
                                    :src="feed.facilitator.profile"
                                  ></b-avatar>
                                  {{ feed.facilitator.name }}
                                </div>
                              </div>

                              <b-dropdown
                                v-if="
                                  feed.facilitator &&
                                  feed.facilitator.id ==
                                    $store.getters.facilitator.id
                                "
                                size="sm"
                                variant="transparent"
                                no-caret
                                class="no-focus"
                              >
                                <template #button-content>
                                  <b-icon
                                    icon="three-dots"
                                    font-scale="1.4"
                                  ></b-icon>
                                </template>
                                <b-dropdown-item
                                  class="fs12"
                                  @click="drop(feed.id, index)"
                                  >Delete</b-dropdown-item
                                >
                              </b-dropdown>
                            </div>
                            <div class="text-left feed_text px-3 pb-3">
                              <span v-html="feed.message"></span><br />
                              <span v-if="feed.url" class="text-dark-green"
                                ><a :href="feed.url" target="_blank"
                                  >Click link</a
                                ></span
                              >
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
                                  controls
                                  width="100%"
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
                                  class="text-center p-3 bg-skills-grey"
                                >
                                  <b-icon
                                    icon="image"
                                    font-scale="3rem"
                                  ></b-icon>
                                </div>
                              </div>
                            </div>
                            <div
                              class="
                                interactions
                                text-left
                                px-3
                                py-3
                                border-bottom
                              "
                            >
                              <span class="mr-3 cursor-pointer">
                                <b-icon
                                  :icon="
                                    feed.stars.find(
                                      (item) =>
                                        item.star &&
                                        item.facilitator_id ==
                                          $store.getters.facilitator.id
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
                              <span class="mr-3 cursor-pointer"
                                ><b-icon
                                  :icon="
                                    feed.likes.find(
                                      (item) =>
                                        item.like &&
                                        item.facilitator_id ==
                                          $store.getters.facilitator.id
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
                                >View all
                                {{ feed.comments.length }} comments</span
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
                                    >
                                      {{ item.facilitator.name }}</span
                                    >
                                    <span>{{ item.comment }}</span>
                                  </div>
                                  <div>
                                    <span class="fs11">{{
                                      item.created_at | moment("ll")
                                    }}</span>
                                  </div>
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                      <div v-else class="text-center p-3 p-sm-5">
                        <b-img
                          class="mb-3"
                          :src="require('@/assets/images/creator.svg')"
                        ></b-img>
                        <div class="text-muted text-center">
                          No feed Available
                        </div>
                      </div>
                    </div>
                  </b-card-body>
                  <b-card-body v-if="active == 2" class="pt-0 px-3">
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
                            <b-dropdown
                              size="sm"
                              variant="transparent"
                              no-caret
                              class="no-focus drop"
                            >
                              <template #button-content>
                                <b-icon
                                  icon="three-dots"
                                  font-scale="1.4"
                                ></b-icon>
                              </template>
                              <b-dropdown-item
                                class="fs12"
                                @click="drop(item.id, index)"
                                >Delete</b-dropdown-item
                              >
                            </b-dropdown>
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
                                <span>{{ item.discussionmessage.length }}</span>
                                answers</span
                              >
                              <span class="mr-4"
                                ><b-icon icon="eye-fill" class="mr-1"></b-icon>
                                <span v-if="item.discussionview">{{
                                  item.discussionview.view || 0
                                }}</span>
                                <span v-else>{{ 0 }}</span> views</span
                              >
                            </div>
                            <div>
                              <span
                                v-if="item.type == 'public'"
                                @click="
                                  $router.push(`/learner/discussion/${item.id}`)
                                "
                                class="
                                  text-dark-green
                                  font-weight-bold
                                  cursor-pointer
                                "
                                >Join Discussion</span
                              >
                              <span
                                v-else
                                @click="joindiscussion(item)"
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
                            It appears you havent added any Discussion yet,
                          </h6>
                        </div>
                      </div>
                    </div>
                  </b-card-body>

                  <b-card-body v-if="active == 3" class="pt-0 px-3">
                    <div>
                      <div v-if="events.length" class="events">
                        <div
                          class="
                            border
                            rounded
                            text-left
                            mb-5
                            position-relative
                          "
                          v-for="(item, index) in events"
                          :key="item.id"
                        >
                          <div
                            class="
                              bg-lighter-green
                              px-3
                              py-3
                              text-left text-dark-green
                              d-flex
                              justify-content-between
                              align-items-center
                            "
                          >
                            <h5 class="text-capitalize mb-0 flex-1 fs16">
                              {{ item.title }}
                            </h5>
                            <span
                              @click="$router.push(`/learner/event/${item.id}`)"
                            >
                              <span class="fs15 cursor-pointer viewevent pl-2">
                                View Event
                              </span>
                              <b-icon icon="chevron-double-right"></b-icon>
                            </span>
                          </div>
                          <b-img
                            class="event_image"
                            fluid-grow
                            :src="item.cover"
                          ></b-img>

                          <div class="px-3 py-2 d-flex bg-white">
                            <div class="flex-1">
                              <p class="mb-1 text-muted fs15">
                                <b-icon
                                  icon="calendar2-check"
                                  class="mr-2 text-muted"
                                ></b-icon>
                                {{ item.schedule }}
                              </p>
                              <p class="mb-1 text-muted fs15">
                                <b-icon
                                  icon="people"
                                  class="mr-2 text-muted"
                                ></b-icon>
                                {{ item.eventattendance.length }} Attending
                              </p>
                              <div class="d-flex">
                                <p class="description text-muted">
                                  {{ item.description }}
                                </p>
                              </div>
                            </div>
                            <b-dropdown
                              v-if="
                                item.facilitator_id &&
                                item.facilitator_id ==
                                  $store.getters.facilitator.id
                              "
                              size="sm"
                              variant="transparent"
                              no-caret
                              class="no-focus"
                            >
                              <template #button-content>
                                <b-icon
                                  icon="three-dots-vertical"
                                  font-scale="1.4"
                                ></b-icon>
                              </template>
                              <b-dropdown-item class="fs13" @click="edit(item)"
                                >Edit</b-dropdown-item
                              >
                              <b-dropdown-item
                                class="fs13"
                                @click="drop(item.id, index)"
                                >Delete</b-dropdown-item
                              >
                            </b-dropdown>
                          </div>
                        </div>
                        <div
                          class="py-3 d-flex justify-content-between"
                          v-if="rows > 10"
                        >
                          <div class="fs12 text-muted">
                            Showing 1-10 of {{ events.length }} items
                          </div>
                          <b-pagination
                            pills
                            size="sm"
                            variant="dark-green"
                            align="right"
                            v-model="currentPage"
                            :total-rows="rows"
                            :per-page="perPage"
                          ></b-pagination>
                        </div>
                      </div>
                      <div v-else class="text-center admin_tab p-3 p-sm-5">
                        <div>
                          <b-img
                            :src="require('@/assets/images/creator.svg')"
                          ></b-img>
                          <h6 class="text-muted my-3 fs14">
                            It appears you have no event,
                            <br class="d-none d-sm-block" />
                          </h6>
                        </div>
                      </div>
                    </div>
                  </b-card-body>
                </b-row>
              </b-card>
            </b-col>
          </b-row>
        </b-col>
        <!-- <b-col cols="3">
          <Message
            class="d-none d-md-block"
            @getmessage="getmessage"
            :user="'learner'"
          />
        </b-col> -->
      </b-row>
    </b-container>
    <b-modal
      id="connections"
      scrollable
      size="sm"
      title="Connections"
      button-size="sm"
      hide-footer
      centered
    >
      <div>
        <div class="py-4">
          <div v-if="connections.length">
            <div class="d-flex align-items-center search bg-light mb-4">
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
              <b-icon icon="sliders"></b-icon>
            </div>

            <div class="connection_box">
              <div v-for="(item, id) in filteredConnections" :key="id">
                <div v-if="item.user_follower" class="d-flex">
                  <div class="d-flex align-items-center flex-1">
                    <b-avatar class="mr-2" size="1.6rem"></b-avatar>
                    <div style="line-height: 1.2">
                      <span class="fs13">{{ item.user_follower.name }}</span>
                      <br />
                      <span class="fs12 text-muted">{{
                        item.user_follower.email
                      }}</span>
                    </div>
                  </div>

                  <div>
                    <b-button
                      v-if="item.qualifications"
                      @click="addconnections(item.id, 'facilitator')"
                      size="sm"
                      variant="outline-dark-green"
                      class="rounded-pill fs11"
                      >Connect</b-button
                    >
                    <b-button
                      v-else
                      @click="addconnections(item.id, 'user')"
                      size="sm"
                      variant="outline-dark-green"
                      class="rounded-pill fs11"
                      >Connect</b-button
                    >
                  </div>
                </div>
                <div v-else class="d-flex">
                  <div class="d-flex align-items-center flex-1">
                    <b-avatar class="mr-2" size="1.6rem"></b-avatar>
                    <div style="line-height: 1.2">
                      <span class="fs13">{{
                        item.facilitator_follower.name
                      }}</span>
                      <br />
                      <span class="fs12 text-muted">{{
                        item.facilitator_follower.email
                      }}</span>
                    </div>
                  </div>

                  <!-- <div
                    v-if="
                      $store.getters.facilitator &&
                      $store.getters.facilitator.id == $route.params.id
                    "
                  >
                    <b-button
                      variant="lighter-green"
                      size="sm"
                      class="mr-3 rounded-pill fs11"
                      @click="
                        getmessage(
                          item.facilitator_follower.id,
                          item.facilitator_follower.name,
                          'facilitator',
                          item.facilitator_follower.profile
                        )
                      "
                      >Message</b-button
                    >
                  </div> -->
                  <div>
                    <b-button
                      v-if="item.qualifications"
                      @click="addconnections(item.id, 'facilitator')"
                      size="sm"
                      variant="outline-dark-green"
                      class="rounded-pill fs11"
                      >Connect</b-button
                    >
                    <b-button
                      v-else
                      @click="addconnections(item.id, 'user')"
                      size="sm"
                      variant="outline-dark-green"
                      class="rounded-pill fs11"
                      >Connect</b-button
                    >
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div v-else class="text-center">No connection available</div>
        </div>
      </div>
    </b-modal>
    <b-modal
      id="interests"
      size="sm"
      title="Interests"
      button-size="sm"
      footer-bg-variant="lighter-green"
      centered
      v-if="detail.interests"
      scrollable
      cancel-disabled
    >
      <div>
        <div class="text-center" v-if="JSON.parse(detail.interests).length">
          <div v-for="(interest, id) in JSON.parse(detail.interests)" :key="id">
            <b-button class="mb-2">
              {{ interest }}
            </b-button>
          </div>
        </div>
        <div v-else class="text-center">No interest available</div>
      </div>
      <template #modal-footer="{ ok }">
        <b-button size="sm" variant="dark-green" @click="ok()"> OK </b-button>
      </template>
    </b-modal>
    <!-- <Minichat
      class="minichats"
      :user="'learner'"
      :mini_info="mini_info"
      :open="open"
      :showAll="showAll"
      @togglechat="togglechat"
    /> -->
  </div>
</template>
<script>
// import Message from "../messagecomponent";
// import Minichat from "../minichat";
export default {
  data() {
    return {
      id: this.$route.params.id,
      detail: [],
      active: 1,
      search: "",
      currentPage: 1,
      rows: null,
      perPage: 10,
      feeds: [],
      connections: [],
      discussions: [],
      events: [],
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
    };
  },
  // components: {
  //   Message,
  //   Minichat
  // },
  computed: {
    filteredConnections() {
      if (!this.connections.length) {
        return [];
      }
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

    filterFeeds() {
      return this.feeds
        .filter((item) =>
          item.name.toLowerCase().includes(this.search.toLowerCase())
        )
        .slice(
          this.perPage * this.currentPage - this.perPage,
          this.perPage * this.currentPage
        );
    },
  },
  mounted() {
    this.getdiscussions();
    this.getinfo();
    this.getFeeds();
    this.getConnections();
    this.getEvents();
  },
  methods: {
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
    getinfo() {
      this.$http
        .get(
          `${this.$store.getters.url}/facilitator/info/${this.$route.params.id}`
        )
        .then((res) => {
          if (res.status == 200) {
            this.detail = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    getdiscussions() {
      this.$http
        .get(
          `${this.$store.getters.url}/facilitator/discussions/${this.$route.params.id}`
        )
        .then((res) => {
          if (res.status == 200) {
            this.discussions = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    togglechat() {
      this.mini_info = {
        id: "",
        name: "",
        type: "",
        profile: "",
      };
      this.open = false;
      this.showAll = false;
    },
    getmessage(id, name, type, profile) {
      this.mini_info.id = id;
      this.mini_info.name = name;
      this.mini_info.type = type;
      this.mini_info.profile = profile;
      this.open = true;
      this.showAll = true;
      this.$bvModal.hide("connections");
    },
    getFeeds() {
      this.$http
        .get(
          `${this.$store.getters.url}/facilitator/feeds/${this.$route.params.id}`
        )
        .then((res) => {
          if (res.status == 200) {
            this.feeds = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getEvents() {
      this.$http
        .get(
          `${this.$store.getters.url}/facilitator/events/${this.$route.params.id}`
        )
        .then((res) => {
          if (res.status == 200) {
            this.events = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getConnections() {
      this.$http
        .get(
          `${this.$store.getters.url}/facilitator/connections/${this.$route.params.id}`
        )
        .then((res) => {
          if (res.status == 200) {
            this.connections = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    async addconnections(id, type) {
      return this.$http
        .post(
          `${this.$store.getters.url}/connections`,
          { following_id: id, follow_type: type },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200 || res.status == 201) {
            this.$toast.success("Successful");
            this.getconnections();
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    vote(val) {
      var positive = val.filter((item) => item.vote).length;
      var negative = val.filter((item) => !item.vote).length;
      return Number(positive) - Number(negative);
    },
  },
};
</script>
<style scoped lang="scss">
.container {
  padding-top: 30px;
}
.shadow {
  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
  border-radius: 8px;
}
h4.card-title {
  font-size: 1.1rem;
}
.prof_img {
  width: 20%;
}
.prof_img img {
  width: 100%;
  height: 100%;
  object-fit: cover;
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
}
#navbar li:hover {
  border-color: var(--dark-green);
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
.main_text {
  display: -webkit-box;
  font-size: 14px;
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
.related_count {
  width: 60px;
  padding: 4px 6px;
  background: var(--lighter-green);
  font-size: 11px;
  border-radius: 4px;
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
</style>

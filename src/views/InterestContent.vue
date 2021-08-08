<template>
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
                    <div class="prof_img position-relative d-none d-sm-block">
                      <div class="discussion_overlay"></div>
                      <b-card-img
                        :style="{
                          backgroundColor: '',
                        }"
                        :src="currentinterests.image"
                        alt="Image"
                        class="rounded-0"
                      ></b-card-img>
                    </div>
                    <div class="text-left d-inline d-sm-none border-right p-2">
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
                    <div class="flex-1 p-2">
                      <div
                        class="
                          text-left text-capitalize
                          d-flex
                          align-items-center
                        "
                      >
                        <h6 class="mb-0">{{ currentinterests.value }}</h6>
                        <span class="px-1 text-muted">/</span>
                        <h6 class="text-muted mb-0 fs14">{{ subId }}</h6>
                      </div>
                    </div>
                  </div>
                  <hr class="mt-0" />
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
                        class="h6 fs14 cursor-pointer mb-0 text-muted"
                        :class="active == 4 ? 'active' : ''"
                        @click="active = 4"
                      >
                        People
                      </li>
                      <li
                        class="h6 fs14 cursor-pointer mb-0 text-muted"
                        :class="active == 1 ? 'active' : ''"
                        @click="active = 1"
                      >
                        Feed
                      </li>
                      <li
                        class="h6 fs14 cursor-pointer mb-0 text-muted"
                        :class="active == 2 ? 'active' : ''"
                        @click="active = 2"
                      >
                        Discussions
                      </li>
                      <li
                        class="h6 fs14 cursor-pointer mb-0 text-muted"
                        :class="active == 3 ? 'active' : ''"
                        @click="active = 3"
                      >
                        Courses
                      </li>
                    </ul>
                  </nav>
                </b-card-body>
              </b-card>
            </b-col>

            <b-col cols="12" class="px-1 px-sm-4">
              <b-card no-body class="border-0 bg-transparent rounded" style="">
                <b-card-body class="px-0">
                  <div v-if="active == 4">
                    <div v-if="users.length">
                      <b-row class="facilitators justify-content-start">
                        <b-col
                          cols="4"
                          class="mb-0 mb-sm-3 p-0-rem px-sm-3 py-sm-3"
                          v-for="(item, id) in users"
                          :key="id"
                        >
                          <div
                            v-if="item.qualifications"
                            class="position-relative cursor-pointer bg-white"
                            @click="$router.push(`/profile/f/${item.id}`)"
                          >
                            <div
                              class="facilitator shadow-sm position-relative"
                            >
                              <b-img
                                class="rounded-sm mb-4"
                                fluid-grow
                                :src="
                                  item.profile
                                    ? item.profile
                                    : require('@/assets/images/default.jpeg')
                                "
                                style="object-fit: cover"
                              ></b-img>
                              <div
                                class="f_name text-truncate text-truncate--1"
                              >
                                {{ item.name }}
                              </div>
                              <div
                                class="text-muted fs13 text-capitalize f_detail"
                              >
                                <span>
                                  {{
                                    item.age ? item.age + " years" : "N/a"
                                  }}</span
                                >
                                <span v-if="item.gender"
                                  >,
                                  {{ item.gender ? item.gender : "N/a" }}</span
                                >
                              </div>

                              <div
                                class="text-muted fs13 text-capitalize f_detail"
                              >
                                {{ item.state ? item.state : "Lagos" }},
                                {{ item.country ? item.country : "NG" }}
                              </div>
                              <div
                                class="text-muted fs12 text-capitalize f_detail"
                              >
                                {{
                                  item.interests
                                    ? JSON.parse(item.interests).length +
                                      " interests"
                                    : "0 intersts"
                                }},
                              </div>
                            </div>
                            <span class="hover_box"></span>
                          </div>
                          <div
                            class="position-relative cursor-pointer bg-white"
                            v-else
                            @click="$router.push(`/profile/u/${item.id}`)"
                          >
                            <div
                              class="facilitator shadow-sm position-relative"
                            >
                              <b-img
                                class="rounded-sm mb-4"
                                fluid-grow
                                :src="
                                  item.profile
                                    ? item.profile
                                    : require('@/assets/images/default.jpeg')
                                "
                                style="object-fit: cover"
                              ></b-img>
                              <div
                                class="f_name text-truncate text-truncate--1"
                              >
                                {{ item.name }}
                              </div>
                              <div
                                class="text-muted fs13 text-capitalize f_detail"
                              >
                                <span>
                                  {{
                                    item.age ? item.age + " years" : "N/a"
                                  }}</span
                                >
                                <span v-if="item.gender"
                                  >,
                                  {{ item.gender ? item.gender : "N/a" }}</span
                                >
                              </div>

                              <div
                                class="text-muted fs13 text-capitalize f_detail"
                              >
                                {{ item.state ? item.state : "Lagos" }},
                                {{ item.country ? item.country : "NG" }}
                              </div>
                              <div
                                class="text-muted fs12 text-capitalize f_detail"
                              >
                                {{
                                  item.interests
                                    ? JSON.parse(item.interests).length +
                                      " interests"
                                    : "0 intersts"
                                }},
                              </div>
                            </div>
                            <span class="hover_box"></span>
                          </div>
                        </b-col>
                      </b-row>
                      <div
                        class="py-3 d-flex justify-content-between"
                        v-if="rows > 10"
                      >
                        <div class="fs12 text-muted">
                          Showing 1-10 of {{ members.length }} items
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
                    <div v-else class="text-center p-3 p-sm-5">
                      <b-img
                        class="mb-3"
                        :src="require('@/assets/images/creator.svg')"
                      ></b-img>
                      <div class="text-muted text-center">
                        No User Available
                      </div>
                    </div>
                  </div>
                  <div
                    class="text-left w-100 pb-1 pt-0 px-0"
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
                                fs13
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
                                      class="comment_name mr-2"
                                      v-if="item.admin"
                                    >
                                      {{ item.admin.name }}</span
                                    >
                                    <span
                                      class="comment_name mr-2"
                                      v-if="item.user"
                                    >
                                      {{ item.user.name }}</span
                                    >
                                    <span
                                      class="comment_name mr-2"
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
                            <div
                              class="feed_time text-muted py-2 px-3 text-left"
                            >
                              {{ $moment(feed.created_at).fromNow() }}
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
                  </div>
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
                                @click="$router.push(`/feed/view/${feed.id}`)"
                                >View post</b-dropdown-item
                              >

                              <b-dropdown-item
                                class="fs12"
                                @click="drop(feed.id, index)"
                                v-if="
                                  feed.user &&
                                  feed.user.id == $store.getters.member.id
                                "
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
                                  $router.push(
                                    `/facilitator/discussion/${item.id}`
                                  )
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
                            No Discussion availbale
                          </h6>
                        </div>
                      </div>
                    </div>
                  </div>

                  <div v-if="active == 3" class="pt-0 px-0">
                    <div>
                      <div v-if="courses.length">
                        <b-container fluid class="main-course">
                          <b-row>
                            <b-col
                              cols="6"
                              :sm="sideOpen ? 4 : 3"
                              class="mb-3 side_box p-0-rem px-sm-3"
                              v-for="(item, index) in filteredCourse"
                              :key="index"
                            >
                              <div
                                class="course border cursor-pointer shadow-sm"
                                @click="showcourse(item)"
                              >
                                <div
                                  class="course_img"
                                  :style="{
                                    backgroundImage: `url(${
                                      item.cover
                                        ? item.cover
                                        : require('@/assets/images/default.png')
                                    })`,
                                  }"
                                ></div>
                                <div class="course_text">
                                  <div class="d-flex justify-content-between">
                                    <span
                                      class="
                                        px-2
                                        py-1
                                        rounded-pill
                                        text-white
                                        fs11
                                        course_badge
                                      "
                                      :style="{
                                        backgroundColor: JSON.parse(
                                          item.courseoutline.knowledge_areas
                                        ).color,
                                      }"
                                    >
                                      <b-icon
                                        class="mr-2"
                                        :icon="
                                          JSON.parse(
                                            item.courseoutline.knowledge_areas
                                          ).icon
                                        "
                                      ></b-icon>
                                      <span>{{
                                        JSON.parse(
                                          item.courseoutline.knowledge_areas
                                        ).value
                                      }}</span></span
                                    >
                                    <span class="text-capitalize fs11">{{
                                      item.type
                                    }}</span>
                                  </div>
                                  <div class="pt-3 pb-1 text-left">
                                    <h6
                                      class="
                                        text-capitalize
                                        overview-title
                                        text-truncate text-truncate--2
                                        mb-0
                                      "
                                    >
                                      {{ item.title }}
                                    </h6>
                                    <div
                                      class="
                                        fs13
                                        text-truncate text-truncate--2
                                        course_desc
                                      "
                                    >
                                      {{ item.description }}
                                    </div>
                                  </div>
                                  <div class="info fs11">
                                    <div class="d-flex">
                                      <div class="mr-2">
                                        <b-icon
                                          icon="people"
                                          class="mr-1"
                                        ></b-icon>
                                        <span
                                          >{{
                                            item.enroll ? item.enroll.count : 0
                                          }}+</span
                                        >
                                      </div>
                                      <div class="mr-3">
                                        <b-icon
                                          icon="eye"
                                          class="mr-1"
                                        ></b-icon>
                                        <span
                                          >{{
                                            item.viewcount
                                              ? item.viewcount.count
                                              : 0
                                          }}
                                          +</span
                                        >
                                      </div>
                                      <div>
                                        <b-icon
                                          icon="star-fill"
                                          style="color: gold"
                                          class="mr-1"
                                        ></b-icon>
                                        <span
                                          >{{ item.review.length }}
                                          <span class="d-none d-sm-inline"
                                            >reviews</span
                                          ></span
                                        >
                                      </div>
                                    </div>

                                    <b-avatar
                                      size="sm"
                                      class="course_avatar"
                                      variant="light"
                                      :src="item.cover"
                                    >
                                    </b-avatar>
                                  </div>
                                </div>
                              </div>
                            </b-col>
                          </b-row>
                          <div
                            class="p-3 d-flex justify-content-between"
                            v-if="rows > 10"
                          >
                            <div class="fs12 text-muted">
                              Showing
                              {{ perPage * currentPage - perPage + 1 }}-{{
                                perPage * currentPage
                              }}
                              of {{ courses.length }} items
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
                        </b-container>
                      </div>
                      <div v-else class="text-center admin_tab p-3 p-sm-5">
                        <div>
                          <b-img
                            :src="require('@/assets/images/creator.svg')"
                          ></b-img>
                          <h6 class="text-muted my-3 fs14">
                            No course available
                          </h6>
                        </div>
                      </div>
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
                <!-- <b-icon
                  icon="chevron-right"
                  font-scale=".7"
                  v-show="subId == sub.value"
                  :variant="subId == sub.value ? 'dark-green' : ''"
                ></b-icon> -->
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
            ><b-icon class="mr-1" icon="facebook"></b-icon> Facebook</b-button
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
            ><b-icon class="mr-1" icon="twitter"></b-icon> Twitter</b-button
          >
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
            Telegram</b-button
          >
        </ShareNetwork>
      </div>
    </b-modal>
    <b-modal id="mobile-course" centered hide-footer>
      <div
        v-if="!course"
        class="h-100 d-flex align-items-center justify-content-center"
      >
        <div class="text-center w-100">
          <b-img
            class="mb-3"
            :src="require('@/assets/images/book.png')"
          ></b-img>
          <br />
          <p class="text-muted">Select a Course to see Details</p>
        </div>
      </div>

      <div class="text-left py-4 p-2 bg-white" v-if="course">
        <div class="d-flex">
          <div class="course_title d-flex mb-3 flex-1">
            <b-iconstack font-scale="2.5" class="mr-2 mb-2">
              <b-icon
                stacked
                icon="circle-fill"
                :style="`color:${
                  JSON.parse(course.courseoutline.knowledge_areas).color
                }`"
              ></b-icon>
              <b-icon
                stacked
                :icon="JSON.parse(course.courseoutline.knowledge_areas).icon"
                scale="0.5"
                variant="light"
              ></b-icon>
            </b-iconstack>
            <div>
              <span class="title text-capitalize" v-if="course.title">
                {{ course.title }}
                <span class="text-muted" v-if="course.course_code">
                  ({{ course.course_code }})</span
                ></span
              >
              <br />
              <span class="course_time text-capitalize"
                ><b-icon icon="clock" class="mr-1"></b-icon>
                {{ course.courseoutline.duration }}</span
              >
              <br />
              <b-button
                size="sm"
                class="mt-2"
                variant="lighter-green"
                @click="addcourse"
                >Enroll</b-button
              >
            </div>
          </div>

          <b-img
            style="width: 80px; height: 90px; object-fit: cover"
            fluid
            :src="course.cover"
          ></b-img>
        </div>

        <div
          class="d-flex justify-content-between p-2 border-bottom mb-2 text-sm"
        >
          <span
            class="cursor-pointer d-flex align-items-center"
            :class="{ 'text-dark-green': toggleCourse == 1 }"
            @click="toggleCourse = 1"
          >
            <b-icon font-scale=".5rem" class="mr-1" icon="circle-fill"></b-icon>
            Info</span
          >
          <span
            class="cursor-pointer d-flex align-items-center"
            @click="toggleCourse = 2"
            :class="{ 'text-dark-green': toggleCourse == 2 }"
          >
            <b-icon font-scale=".5rem" class="mr-1" icon="circle-fill"></b-icon>
            Modules</span
          >
          <span
            class="cursor-pointer d-flex align-items-center"
            @click="toggleCourse = 3"
            :class="{ 'text-dark-green': toggleCourse == 3 }"
          >
            <b-icon font-scale=".5rem" class="mr-1" icon="circle-fill"></b-icon>
            General</span
          >
          <span
            class="cursor-pointer d-flex align-items-center"
            @click="toggleCourse = 4"
            :class="{ 'text-dark-green': toggleCourse == 4 }"
          >
            <b-icon font-scale=".5rem" class="mr-1" icon="circle-fill"></b-icon>
            Schedules</span
          >
        </div>

        <div v-if="toggleCourse == 1">
          <div class="mb-4 px-2 d-flex justify-content-between">
            <div>
              <h6 class="fs14">Course Access</h6>
              <p class="fs13 text-capitalize mb-1">
                {{ course.type }}
              </p>
              <p class="fs13" v-if="course.type !== 'free'">
                {{ course.amount }}
                {{ course.type == "group" ? "Participants" : "Naira" }}
              </p>
            </div>
            <div class="text-right">
              <div class="d-flex align-items-center">
                <b-icon
                  class="cursor-pointer"
                  font-scale=".9"
                  @click="sharelink(course.id)"
                  icon="share"
                ></b-icon>
              </div>
            </div>
          </div>
          <div class="mb-4 px-2">
            <h6 class="fs14">Course Description</h6>
            <p class="fs13">
              {{ course.description ? course.description : "None" }}
            </p>
          </div>
          <div class="mb-4 px-2">
            <h6 class="fs14 mb-1">Knowledge Area</h6>
            <p class="fs13 text-capitalize">
              {{
                course.courseoutline.knowledge_areas
                  ? JSON.parse(course.courseoutline.knowledge_areas).value
                  : "None"
              }}
            </p>
          </div>

          <div class="mb-4 px-2">
            <div class="" v-if="course.courseschedule.length">
              <b-row>
                <b-col cols="6">
                  <h6 class="fs14 font-weight-bold">Start date</h6>
                  <span class="fs14">{{
                    course.courseschedule[0].start_time | moment("MMM DD, YYYY")
                  }}</span>
                </b-col>
                <b-col cols="6">
                  <h6 class="fs14 font-weight-bold">End date</h6>
                  <span class="fs14">{{
                    course.courseschedule[0].end_time | moment("MMM DD, YYYY")
                  }}</span>
                </b-col>
              </b-row>
            </div>
          </div>

          <div class="mb-4 px-2">
            <h6 class="fs14">Additional Information</h6>
            <p class="fs13">
              {{
                course.courseoutline.additional_info
                  ? course.courseoutline.additional_info
                  : "None"
              }}
            </p>
          </div>
          <div class="mb-4 px-2">
            <h6 class="fs14">Certification</h6>
            <p class="fs13 text-capitalize">
              <b-icon
                :icon="
                  course.courseoutline.certification == 'yes'
                    ? 'check2-circle'
                    : 'x-circle'
                "
                variant="light-green"
              ></b-icon>
              {{ course.courseoutline.certification }}
            </p>
          </div>
          <div>
            <h6 class="mb-4 fs14 px-2">Course Files</h6>
            <div class="d-flex justify-content-between">
              <div class="d-flex text-danger">
                <b-img
                  class="mr-2 igm"
                  fluid-grow
                  :src="require('@/assets/images/video.png')"
                ></b-img>

                <span style="line-height: 1.2">
                  <span class="fs13">
                    {{ getmediacount(course.modules, "video") }}</span
                  >
                  <br />
                  <span class="fs13">Videos</span>
                </span>
              </div>
              <div class="d-flex" style="color: #f3994a">
                <b-img
                  fluid-grow
                  class="mr-2 igm"
                  :src="require('@/assets/images/file.png')"
                ></b-img>

                <span style="line-height: 1.2">
                  <span class="fs13">
                    {{ getmediacount(course.modules, "document") }}</span
                  >
                  <br />
                  <span class="fs13">Documents</span>
                </span>
              </div>
              <div class="d-flex text-success">
                <b-img
                  fluid-grow
                  class="mr-2 igm"
                  :src="require('@/assets/images/zip.png')"
                ></b-img>

                <span style="line-height: 1.2">
                  <span class="fs13">
                    {{ getmediacount(course.modules, "audio") }}</span
                  >
                  <br />
                  <span class="fs13">Audios</span>
                </span>
              </div>
            </div>
          </div>
        </div>
        <div v-if="toggleCourse == 2" class="h-100">
          <h6 class="fs14">Course Modules</h6>

          <div class="accordion" role="tablist" v-if="course.modules.length">
            <b-card
              no-body
              class="mb-4"
              v-for="(item, id) in course.modules"
              :key="id"
            >
              <b-card-header
                header-tag="header"
                class="p-1 bg-light"
                role="tab"
              >
                <div v-b-toggle="'module' + id" variant="info">
                  <b-icon icon="check2-circle" variant="light-green"></b-icon>
                  {{ item.module }}
                </div>
              </b-card-header>
              <b-collapse
                :id="'module' + id"
                accordion="my-accordion"
                role="tabpanel"
              >
                <b-card-body
                  v-for="(mod, index) in JSON.parse(item.modules)"
                  :key="index"
                >
                  <b-card-text class="d-flex text-capitalize"
                    ><span class="flex-1">{{ mod.title }}</span>
                    <span v-if="mod.file_type == 'video'"
                      ><b-icon icon="camera-video-fill"></b-icon
                    ></span>
                    <span v-else-if="mod.file_type == 'audio'"
                      ><b-icon icon="music-note-beamed"></b-icon
                    ></span>
                    <span v-else
                      ><b-icon
                        icon="file-earmark-richtext-fill"
                      ></b-icon> </span
                  ></b-card-text>
                  <h6 class="fs12 font-weight-bold mb-2">Overview</h6>
                  <b-card-text class="fs12">{{ mod.overview }}</b-card-text>
                </b-card-body>
              </b-collapse>
            </b-card>
          </div>
          <div class="" v-else>
            <div
              class="text-capitalize fs14 mb-2"
              v-for="(item, index) in JSON.parse(course.courseoutline.modules)"
              :key="index"
            >
              <b-icon icon="check2-circle" variant="light-green"></b-icon>
              {{ item }}
            </div>
          </div>
        </div>
        <div v-if="toggleCourse == 3" class="h-100 p-2">
          <div class="mb-4">
            <h6 class="fs14 mb-4">Overview</h6>

            <div class="fs13" v-html="course.courseoutline.overview"></div>
          </div>

          <div>
            <h6 class="fs14 mb-3">Faqs</h6>

            <div class="accordion" role="tablist">
              <b-card
                no-body
                class="mb-1"
                v-for="(item, id) in JSON.parse(course.courseoutline.faqs)"
                :key="id"
              >
                <b-card-header
                  header-tag="header"
                  class="p-1 bg-light"
                  role="tab"
                >
                  <div v-b-toggle="'file' + id" variant="info" class="fs13">
                    <b-icon
                      icon="question-circle-fill"
                      class="mr-2 text-light-green"
                    ></b-icon>
                    {{ item.question }}
                  </div>
                </b-card-header>
                <b-collapse
                  :id="'file' + id"
                  accordion="my-accordion"
                  role="tabpanel"
                >
                  <b-card-body>
                    <b-card-text class="px-0 fs13">
                      <b-icon
                        icon="check-circle-fill"
                        class="mr-2 text-light-green"
                      ></b-icon>
                      {{ item.answer }}</b-card-text
                    >
                  </b-card-body>
                </b-collapse>
              </b-card>
            </div>
          </div>
        </div>
        <div v-if="toggleCourse == 4" class="h-100 p-2">
          <h6 class="fs14 mb-3">Course Schedules</h6>
          <div>
            <b-row v-if="course.courseschedule.length">
              <b-col
                cols="12"
                class="mb-4 px-3 border-bottom"
                v-for="(item, index) in course.courseschedule"
                :key="index"
              >
                <div class="mb-1">
                  <span class="fs14 mr-2">Time: </span>
                  <span class="text-sm font-weight-bold">
                    {{ item.start_time | moment("LT") }}</span
                  >
                </div>
                <div class="mb-1">
                  <span class="fs14 mr-2">Date: </span>
                  <span class="text-sm font-weight-bold">
                    {{ item.start_time | moment("MMM DD, YYYY") }}</span
                  >
                </div>
                <div class="mb-1">
                  <span class="fs14 mr-2">Venue: </span>
                  <span class="text-sm font-weight-bold">
                    {{ item.venue ? item.venue : "None" }}</span
                  >
                </div>
                <div class="mb-1">
                  <span class="fs14 mr-2">Url: </span>
                  <span class="text-sm font-weight-bold">
                    {{ item.url ? item.url : "None" }}</span
                  >
                </div>
                <div>
                  <span class="fs14 mr-2">Facilitator: </span>
                  <span
                    class="text-sm font-weight-bold"
                    v-if="item.facilitator_id != null"
                    >{{
                      facilitators.find((val) => val.id == item.facilitator_id)
                        .name
                    }}</span
                  >
                  <span v-else class="text-sm">Unavailable</span>
                </div>
              </b-col>
            </b-row>
          </div>
        </div>
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
              <b-icon icon="plus" font-scale="1.4"></b-icon> Add email</b-button
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

      <b-button
        variant="dark-green"
        class="mobile-add btn-circle btn-raised shadow"
      >
        <b-icon
          icon="plus-circle"
          @click="toggleNav = !toggleNav"
          font-scale="2.5"
        ></b-icon
      ></b-button>
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
          <b-button size="sm" class="mb-2 mb-sm-0" variant="outline-dark-green"
            ><b-icon class="mr-1" icon="facebook"></b-icon> Facebook</b-button
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
          <b-button size="sm" class="mb-2 mb-sm-0" variant="outline-dark-green"
            ><b-icon class="mr-1" icon="twitter"></b-icon> Twitter</b-button
          >
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
            Whatsapp</b-button
          >
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
          <b-button size="sm" class="mb-2 mb-sm-0" variant="outline-dark-green"
            ><b-icon class="mr-1" icon="cursor-fill"></b-icon>
            Telegram</b-button
          >
        </ShareNetwork>
      </div>
    </b-modal>
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
      subId: null,
      detail: [],
      active: 4,
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
  },
  computed: {
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
    filter() {
      return this.courses.slice(
        this.perPage * this.currentPage - this.perPage,
        this.perPage * this.currentPage
      );
    },
    filteredCourse() {
      var title = this.filter.filter(
        (item) =>
          item.title.toLowerCase().includes(this.search.toLowerCase()) ||
          JSON.parse(item.courseoutline.knowledge_areas)
            .value.toLowerCase()
            .includes(this.search)
      );
      if (this.alpha) {
        title.sort((a, b) => {
          return a.title.localeCompare(b.title);
        });
      }
      var courseType;
      if (this.course_type == "free") {
        courseType = title.filter((item) => item.type == "free");
      } else if (this.course_type == "paid") {
        courseType = title.filter((item) => item.type == "paid");
      } else if (this.course_type == "group") {
        courseType = title.filter((item) => item.type == "group");
      } else {
        courseType = title;
      }

      if (this.recent) {
        return courseType.slice().reverse();
      }
      return courseType;
    },
  },

  methods: {
    sharenow(feed) {
      this.description = feed.message;
      this.link = `https://nzukoor.com/feed/view/${feed.id}?utf_medium=share`;
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
    getextension(fileName) {
      if (fileName) {
        var regex = new RegExp("[^.]+$");
        var extension = fileName.match(regex);

        return extension[0];
      }
    },

    getcontent() {
      this.$http
        .get(`${this.$store.getters.url}/get/interests/${this.subId}`)
        .then((res) => {
          if (res.status == 200) {
            this.getUsers();
            this.feeds = Object.values(res.data.feeds);
            this.courses = Object.values(res.data.courses);
            this.discussions = Object.values(res.data.discussions);

            this.showCourse = true;
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

      if (this.$store.getters.member.access_token) {
        this.$http
          .post(`${this.$store.getters.url}/send/invite`, this.inviteUsers, {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
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
  font-size: 1rem;
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
  overflow-y: scroll;
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

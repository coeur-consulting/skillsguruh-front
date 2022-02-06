<template>
  <div class="bg-light">
    <section class="explore_banner">
      <h1>About Nzukoor</h1>
    </section>
    <b-container class="pt-0 pt-sm-5">
      <b-row class="p-1 justify-content-between d-none d-sm-flex">
        <b-col cols="2">
          <span @click="$router.go(-1)" class="cursor-pointer back fs13">
            <span class="mr-2">
              <b-icon icon="arrow-left" class=""></b-icon
            ></span>
            <span class="d-none d-sm-inline">Back</span>
          </span>
        </b-col>
      </b-row>
      <b-row class="justify-content-center" v-if="showbio">
        <b-col sm="9">
          <b-row>
            <b-col cols="12" class="mb-0 rounded pt-sm-2 px-1 px-sm-4 pb-2">
              <b-card no-body class="border-0" style="">
                <b-row no-gutters class="">
                  <b-col cols="3" sm="3" class="top_h prof_img">
                    <b-img
                      :src="
                        detail.profile
                          ? detail.profile
                          : require('@/assets/images/default.jpeg')
                      "
                      alt="Image"
                      class="rounded-0"
                    ></b-img>
                  </b-col>
                  <b-col cols="9" sm="9" class="flex-1">
                    <b-card-body :title="detail.username" class="text-left">
                      <b-card-text class="mb-1">
                        <span class="fs14 text-muted">
                          {{
                            detail.bio ? detail.bio : "User bio unavailable "
                          }}</span
                        >
                      </b-card-text>
                      <b-card-text
                        class="d-flex align-items-center mb-0"
                        style="line-height: 1.1"
                      >
                        <span class="fs11 text-muted cursor-pointer mr-2">
                          {{
                            `${showInfo(
                              $store.getters.show_age,
                              detail.age
                            )} yrs, `
                          }}</span
                        >

                        <span
                          class="fs12 text-muted cursor-pointer"
                          style="line-height: 1.1"
                        >
                          <span v-if="detail.state">{{ detail.state }},</span>
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
                      <div class="d-flex align-items-center">
                        <div
                          v-if="$store.getters.member.id != detail.id"
                          class="mr-3"
                        >
                          <b-button
                            size="sm"
                            v-if="!checkconnection(detail)"
                            variant="outline-dark-green"
                            @click="addconnections(detail.id, 'user')"
                            >Connect</b-button
                          >
                          <b-button
                            size="sm"
                            v-if="checkconnection(detail)"
                            @click="removeconnections(detail)"
                            variant="dark-green"
                            >Connected</b-button
                          >
                        </div>
                        <b-icon
                          @click="
                            getmessage(
                              detail.id,
                              detail.username,
                              'user',
                              detail.profile,
                              0
                            )
                          "
                          icon="envelope"
                          font-scale="1.4"
                          class="text-muted"
                        ></b-icon>
                      </div>
                    </b-card-body>
                  </b-col>
                </b-row>
                <hr class="my-0" />
                <div class="d-flex">
                  <span
                    @click="$router.go(-1)"
                    class="
                      cursor-pointer
                      back
                      fs13
                      px-2
                      border-right
                      pt-2
                      d-sm-none
                    "
                  >
                    <span class="">
                      <b-icon icon="arrow-left" class=""></b-icon
                    ></span>
                  </span>
                  <nav class="w-100 flex-1 pt-2">
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
                        :class="active == 1 ? 'active' : 'text-muted'"
                        @click="active = 1"
                      >
                        Feed
                      </li>
                      <li
                        class="h6 fs14 cursor-pointer mb-0"
                        :class="active == 2 ? 'active' : 'text-muted'"
                        @click="active = 2"
                      >
                        Discussions
                      </li>
                      <li
                        class="h6 fs14 cursor-pointer mb-0"
                        :class="active == 3 ? 'active' : 'text-muted'"
                        @click="active = 3"
                      >
                        Events
                      </li>
                      <!-- <li
                        class="h6 fs14 cursor-pointer mb-0"
                        :class="active == 4 ? 'active' : 'text-muted'"
                        @click="active = 4"
                      >
                        Courses
                      </li> -->
                    </ul>
                  </nav>
                </div>
              </b-card>
            </b-col>

            <b-col cols="12" class="px-1 px-sm-4">
              <b-card-body
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
                              class="h6 mr-2 mb-1 feedname"
                              v-if="feed.admin"
                            >
                              <b-avatar
                                size="1.8rem"
                                class="mr-2"
                                :src="feed.admin.profile"
                              ></b-avatar>
                              {{ feed.admin.name }}
                            </div>
                            <div class="h6 mr-2 mb-1 feedname" v-if="feed.user">
                              <b-avatar
                                size="1.8rem"
                                class="mr-2"
                                :src="feed.user.profile"
                              ></b-avatar>
                              {{ feed.user.nausernameme }}
                            </div>
                            <div
                              class="h6mr-2 mb-1 feedname"
                              v-if="feed.facilitator"
                            >
                              <b-avatar
                                size="1.8rem"
                                class="mr-2"
                                :src="feed.facilitator.profile"
                              ></b-avatar>
                              {{ feed.facilitator.username }}
                            </div>
                          </div>
                        </div>
                        <div class="text-left feed_text px-3 pb-3">
                          <span v-html="feed.message"></span><br />
                          <span v-if="feed.url" class=""
                            ><a :href="feed.url" target="_blank"
                              >Click link</a
                            ></span
                          >
                        </div>
                        <div v-if="feed.media || feed.publicId">
                          <div
                            class="mb-4 position-relative w-100 media bg-dark"
                          >
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
                        <div class="interactions text-left px-3 py-2">
                          <span
                            class="mr-3 cursor-pointer"
                            @click="toggleLike(feed.id, index)"
                          >
                            <span class="mr-1">{{
                              feed.likes.filter(item => item.like).length
                            }}</span>
                            <b-icon
                              :icon="
                                feed.likes.find(
                                  item =>
                                    item.like &&
                                    item.user_id == $store.getters.member.id
                                )
                                  ? 'heart-fill'
                                  : 'heart'
                              "
                              class="text-danger"
                            ></b-icon>
                          </span>
                          <span class="mr-3">
                            <span class="mr-1">{{ feed.comments.length }}</span>
                            <b-icon icon="chat" class="mr-1"></b-icon>

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
                          class="liked_by px-3 border-bottom"
                          @click="showlikes(feed)"
                          v-html="getlikes(feed.likes)"
                        ></div>
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
                                  class="comment_name mr-2"
                                  v-if="item.admin"
                                >
                                  {{ item.admin.name }}</span
                                >
                                <span
                                  class="comment_name mr-2"
                                  v-if="item.user"
                                >
                                  {{ item.user.username }}</span
                                >

                                <span class="comment_text">{{
                                  item.comment
                                }}</span>
                              </div>
                              <div>
                                <span class="comment_mins">{{
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
                    <div class="text-muted text-center">No feed Available</div>
                  </div>
                </div>
              </b-card-body>
              <b-card-body v-if="active == 2" class="pt-0 px-0">
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
                            <b-icon icon="three-dots" font-scale="1.4"></b-icon>
                          </template>
                          <b-dropdown-item
                            class="fs12"
                            @click="drop(item.id, index)"
                            >Delete</b-dropdown-item
                          >
                        </b-dropdown>
                        <div class="side_dis">
                          <b-avatar
                            size="1.8rem"
                            v-if="item.creator == 'user'"
                            :src="item.user.profile"
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
                            class="text-muted"
                          ></b-icon>
                          <span v-if="item.discussionvote">
                            <span v-if="vote(item.discussionvote) > 0">+</span>
                            <span v-if="vote(item.discussionvote) < 0">-</span
                            >{{ vote(item.discussionvote) }}</span
                          >
                          <span v-else>0</span>

                          <b-icon
                            icon="caret-down-fill"
                            font-scale="1.2"
                            class="text-muted"
                          ></b-icon>
                        </div>
                        <div class="text-left next_dis">
                          <div class="main_text">
                            {{ item.description }}
                          </div>
                        </div>
                      </div>

                      <div class="bottom_bar d-flex justify-content-between">
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
                      </div>
                    </div>
                  </div>

                  <div v-else class="text-center admin_tab p-3 p-sm-5">
                    <div>
                      <b-img
                        :src="require('@/assets/images/creator.svg')"
                      ></b-img>
                      <h6 class="text-muted my-3 fs14">
                        No Discussion available
                      </h6>
                    </div>
                  </div>
                </div>
              </b-card-body>

              <b-card-body v-if="active == 3" class="pt-0 px-0">
                <div>
                  <div v-if="events.length" class="events">
                    <div
                      class="border rounded text-left mb-5 position-relative"
                      v-for="(item, index) in events"
                      :key="item.id"
                    >
                      <div
                        class="
                          bg-lighter-green
                          px-3
                          py-3
                          text-left
                          d-flex
                          justify-content-between
                          align-items-center
                        "
                      >
                        <h5 class="text-capitalize mb-0 flex-1 fs16">
                          {{ item.title }}
                        </h5>
                        <span
                          @click="$router.push(`/facilitator/event/${item.id}`)"
                        >
                          <span class="fs14 cursor-pointer viewevent pl-2">
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
                          <p class="mb-1 text-muted fs14">
                            <b-icon
                              icon="calendar2-check"
                              class="mr-2 text-muted"
                            ></b-icon>
                            {{ item.schedule }}
                          </p>
                          <p class="mb-1 text-muted fs14">
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
                        No event available
                        <br class="d-none d-sm-block" />
                      </h6>
                    </div>
                  </div>
                </div>
              </b-card-body>

              <b-card-body v-if="active == 4" class="pt-0 px-0">
                <div v-if="showCourse">
                  <b-container fluid class="main-course">
                    <b-row>
                      <b-col
                        cols="6"
                        sm="4 "
                        class="mb-3 side_box"
                        v-for="(item, index) in filteredCourse"
                        :key="index"
                      >
                        <div class="course border cursor-pointer shadow-sm">
                          <div
                            class="course_img"
                            :style="{
                              backgroundImage: `url(${
                                item.cover
                                  ? item.cover
                                  : require('@/assets/images/default.png')
                              })`
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
                                  ).color
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
                                  JSON.parse(item.courseoutline.knowledge_areas)
                                    .value
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
                                  <b-icon icon="people" class="mr-1"></b-icon>
                                  <span
                                    >{{
                                      item.enroll ? item.enroll.count : 0
                                    }}+</span
                                  >
                                </div>
                                <div class="mr-3">
                                  <b-icon icon="eye" class="mr-1"></b-icon>
                                  <span
                                    >{{
                                      item.viewcount ? item.viewcount.count : 0
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
                        Showing {{ perPage * currentPage - perPage + 1 }}-{{
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
                    <h6 class="text-muted my-3 fs14">No course available</h6>
                  </div>
                </div>
              </b-card-body>
            </b-col>
          </b-row>
        </b-col>
      </b-row>
      <b-row class="justify-content-center" v-else>
        <b-col sm="9">
          <b-row>
            <b-col cols="12" class="mb-0 rounded pt-sm-2 px-1 px-sm-4 pb-2">
              <b-card no-body class="border-0" style="">
                <b-row no-gutters class="">
                  <b-col cols="3" sm="3" class="top_h prof_img">
                    <b-img
                      :src="require('@/assets/images/default.jpeg')"
                      alt="Image"
                      class="rounded-0"
                    ></b-img>
                  </b-col>
                  <b-col cols="9" sm="9" class="flex-1">
                    <b-card-body title="User not found" class="text-left">
                    </b-card-body>
                  </b-col>
                </b-row>
              </b-card>
            </b-col>
          </b-row>
        </b-col>
      </b-row>
    </b-container>
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
                          <div
                            class="comment_name"
                            @click="
                              $router.push(`/me/profile/${item.user.username}`)
                            "
                          >
                            {{ item.user.username }}
                          </div>
                          <div class="comment_text">{{ item.comment }}</div>
                        </div>
                        <small
                          class="text-muted mr-2"
                          @click="handlereplycomment(item, index)"
                          >Reply
                        </small>

                        <small>
                          <b-icon
                            @click="likecomment(item.id, index)"
                            font-scale=".8"
                            :icon="
                              item.feedcommentlikes ? 'heart-fill' : 'heart'
                            "
                            :class="item.feedcommentlikes ? 'text-danger' : ''"
                          ></b-icon>
                        </small>
                      </div>
                      <div
                        class="p-2 bg-light rounded w-100"
                        v-if="item.feedcommentreplies.length"
                      >
                        <div class="text-muted fs12 font-weight-bold mb-1">
                          Replies
                        </div>
                        <div
                          class="d-flex mb-1"
                          v-for="(rep, id) in item.feedcommentreplies"
                          :key="id"
                        >
                          <b-avatar
                            class="mr-2 feedcommentavatar"
                            :src="rep.user.profile"
                          ></b-avatar>
                          <div class="d-flex align-items-start flex-1">
                            <p class="flex-1 mr-2">
                              <span
                                class="comment_name mr-1"
                                @click="
                                  $router.push(
                                    `/me/profile/${rep.user.username}`
                                  )
                                "
                              >
                                {{ rep.user.username }}
                              </span>
                              <span class="comment_text flex-1">{{
                                rep.message
                              }}</span>
                            </p>
                            <span
                              ><b-icon
                                @click="likecommentreply(rep.id, id, index)"
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
                      </div>
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

    <b-modal id="alllikes" hide-footer centered>
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
              v-for="(item, index) in alllikes.likes.filter(val => val.like)"
              :key="index"
            >
              <div class="flex-1">
                <div class="flex-1 pr-2">
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
                </div>
              </div>
            </b-col>
          </b-row>
        </div>
      </div>
    </b-modal>
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
                placeholder="Search username"
              ></b-form-input>
              <b-icon icon="sliders"></b-icon>
            </div>

            <div class="connection_box">
              <div v-for="(item, id) in filteredConnections" :key="id">
                <div v-if="item.user_follower" class="d-flex">
                  <div class="d-flex align-items-center flex-1">
                    <b-avatar class="mr-2" size="1.6rem"></b-avatar>
                    <div style="line-height: 1.2">
                      <span class="fs13">{{
                        item.user_follower.username
                      }}</span>
                    </div>
                  </div>

                  <div
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
                          item.user_follower.id,
                          item.user_follower.username,
                          'user',
                          item.user_follower.profile,
                          0
                        )
                      "
                      >Message</b-button
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
        <b-button variant="secondary" size="sm" @click="requestAccess"
          >Send a request</b-button
        >
      </div>
    </b-modal>

    <Minichat
      class="minichats"
      :user="'member'"
      :mini_info="mini_info"
      :open="open"
      :showAll="showAll"
      @togglechat="togglechat"
    />
  </div>
</template>
<script>
import Minichat from "@/components/minichat";
export default {
  data() {
    return {
      id: null,
      mini_info: {
        id: "",
        name: "",
        type: "",
        profile: ""
      },
      open: false,
      showAll: false,
      toggleMessage: false,
      detail: {},
      myconnections: [],
      discussion_id: null,
      active: 1,
      search: "",
      currentPage: 1,
      rows: null,
      perPage: 10,
      feeds: [],
      courses: [],
      connections: [],
      discussions: [],
      events: [],
      course_type: "",
      facilitators: [],
      recent: false,
      trending: false,
      alpha: false,
      allcomments: [],
      img_ext: ["jpg", "png", "jpeg", "gif"],
      vid_ext: ["mp4", "3gp"],
      aud_ext: ["mp3"],
      doc_ext: ["docx", "pdf", "ppt", "zip"],

      showCourse: false,
      auth: false,
      alllikes: null,
      showbio: false
    };
  },
  components: {
    Minichat
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
    },
    filteredCourse() {
      var title = this.courses
        .slice(
          this.perPage * this.currentPage - this.perPage,
          this.perPage * this.currentPage
        )
        .filter(
          item =>
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
        courseType = title.filter(item => item.type == "free");
      } else if (this.course_type == "paid") {
        courseType = title.filter(item => item.type == "paid");
      } else if (this.course_type == "group") {
        courseType = title.filter(item => item.type == "group");
      } else {
        courseType = title;
      }

      if (this.recent) {
        return courseType.slice().reverse();
      }
      return courseType;
    },
    filteredConnections() {
      if (!this.connections.length) {
        return [];
      }
      return this.connections.filter(item => {
        if (item.user_follower) {
          return item.user_follower.username
            .toLowerCase()
            .includes(this.search.toLowerCase());
        }
      });
    },

    filterFeeds() {
      return this.feeds
        .filter(item =>
          item.name.toLowerCase().includes(this.search.toLowerCase())
        )
        .slice(
          this.perPage * this.currentPage - this.perPage,
          this.perPage * this.currentPage
        );
    }
  },
  created() {
    if (localStorage.getItem("authMember")) {
      this.auth = true;
    }
    this.getinfo();
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
    async addconnections(id, type) {
      if (!this.auth) {
        this.$toast.error("Login to complete action");
        return;
      }
      return this.$http
        .post(
          `${this.$store.getters.url}/connections`,
          { following_id: id, follow_type: type },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`
            }
          }
        )
        .then(res => {
          if (res.status == 200 || res.status == 201) {
            this.$toast.success("Connected");
            this.getmyconnections();
            this.$store.dispatch("newConnection", {
              id,
              type,
              token: this.$store.getters.member.access_token
            });
          }
        })
        .catch(err => {
          this.$toast.error(err.response.data.message);
        });
    },
    async getmyconnections() {
      if (!this.auth) {
        return;
      }
      return this.$http
        .get(`${this.$store.getters.url}/connections`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`
          }
        })
        .then(res => {
          if (res.status == 200) {
            this.myconnections = res.data.filter(item => item.user_follower);
          }
        })
        .catch(err => {
          this.$toast.error(err.response.data.message);
        });
    },
    async removeconnections(user) {
      if (!this.auth) {
        this.$toast.error("Login to complete action");
        return;
      }
      var res = this.myconnections.find(item => {
        return item.user_follower.id == user.id;
      });

      this.$http
        .delete(`${this.$store.getters.url}/connections/${res.id}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`
          }
        })
        .then(res => {
          if (res.status == 200) {
            this.myconnections = res.data.filter(item => item.user_follower);
            this.$toast.success("Unfollowed");
            this.getmyconnections();
          }
        })
        .catch(err => {
          this.$toast.error(err.response.data.message);
        });
    },
    checkconnection(user) {
      if (!this.auth) {
        return;
      }
      var res = this.myconnections.some(item => {
        return item.user_follower.id == user.id;
      });
      return res;
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

    getinfo() {
      this.$http
        .get(
          `${this.$store.getters.url}/get/userprofile/${this.$route.params.username}`
        )
        .then(res => {
          if (res.status == 200) {
            if (res.data.message == "not found") {
              this.showbio = false;
              return;
            }
            this.showbio = true;
            this.detail = res.data.data;
            this.getFeeds();
            this.getConnections();
            this.getEvents();
            this.getdiscussions();
            this.getmyconnections();
          }
        })
        .catch(err => {
          this.$toast.error(err.response.data.message);
        });
    },

    getdiscussions() {
      if (this.$route.params.user == "f") {
        this.$http
          .get(
            `${this.$store.getters.url}/facilitator/discussions/${this.detail.id}`
          )
          .then(res => {
            if (res.status == 200) {
              this.discussions = res.data;
            }
          })
          .catch(err => {
            this.$toast.error(err.response.data.message);
          });
      } else {
        this.$http
          .get(`${this.$store.getters.url}/member/discussions/${this.detail.id}`)
          .then(res => {
            if (res.status == 200) {
              this.discussions = res.data;
            }
          })
          .catch(err => {
            this.$toast.error(err.response.data.message);
          });
      }
    },
    togglechat() {
      this.mini_info = {
        id: "",
        name: "",
        type: "",
        profile: ""
      };
      this.open = false;
      this.showAll = false;
    },
    getmessage(id, name, type, profile, index) {
      if (!this.auth) {
        this.$toast.error("Login to complete action");
        return;
      }

      this.mini_info.id = id;
      this.mini_info.name = name;
      this.mini_info.type = type;
      this.mini_info.profile = profile;
      this.mini_info.index = index;
      this.$store.dispatch("getChatter", this.mini_info);
      this.$bvModal.hide("connections");
    },
    getFeeds() {
      if (this.$route.params.user == "f") {
        this.$http
          .get(`${this.$store.getters.url}/facilitator/feeds/${this.detail.id}`)
          .then(res => {
            if (res.status == 200) {
              this.feeds = res.data;
            }
          })
          .catch(err => {
            this.$toast.error(err.response.data.message);
          });
      } else {
        this.$http
          .get(`${this.$store.getters.url}/member/feeds/${this.detail.id}`)
          .then(res => {
            if (res.status == 200) {
              this.feeds = res.data;
            }
          })
          .catch(err => {
            this.$toast.error(err.response.data.message);
          });
      }
    },
    getEvents() {
      if (this.$route.params.user == "f") {
        this.$http
          .get(
            `${this.$store.getters.url}/facilitator/events/${this.detail.id}`
          )
          .then(res => {
            if (res.status == 200) {
              this.events = res.data;
            }
          })
          .catch(err => {
            this.$toast.error(err.response.data.message);
          });
      }
    },
    getCourses() {
      if (this.$route.params.user == "f") {
        this.$http
          .get(
            `${this.$store.getters.url}/facilitator/courses/${this.detail.id}`
          )
          .then(res => {
            if (res.status == 200) {
              this.courses = res.data;
              this.showCourse = true;
            }
          })
          .catch(err => {
            this.$toast.error(err.response.data.message);
          });
      }
    },
    sortmodules(data) {
      if (!data.courseoutline) {
        return 0;
      }
      return JSON.parse(data.courseoutline.modules).length;
    },

    getConnections() {
      if (this.$route.params.user == "f") {
        this.$http
          .get(
            `${this.$store.getters.url}/facilitator/connections/${this.detail.id}`
          )
          .then(res => {
            if (res.status == 200) {
              this.connections = res.data;
            }
          })
          .catch(err => {
            this.$toast.error(err.response.data.message);
          });
      } else {
        this.$http
          .get(
            `${this.$store.getters.url}/member/connections/${this.detail.id}`
          )
          .then(res => {
            if (res.status == 200) {
              this.connections = res.data;
            }
          })
          .catch(err => {
            this.$toast.error(err.response.data.message);
          });
      }
    },
    requestAccess() {
      var data = {
        discussion_id: this.discussion_id
      };

      this.$http
        .post(`${this.$store.getters.url}/join-discussion`, data, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`
          }
        })
        .then(res => {
          if (res.status == 200) {
            this.$toast.info("Your request has been sent");
            this.$bvModal.hide("access");
          }
        })
        .catch(err => {
          this.$toast.error(err.response.data.message);
        });
    },
    joindiscussion(item) {
      this.$http
        .get(`${this.$store.getters.url}/discussion/private/${item.id}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`
          }
        })
        .then(res => {
          if (res.status == 200) {
            var result = res.data
              .map(item => item.facilitator_id)
              .includes(this.$store.getters.facilitator.id);

            if (result) {
              this.$router.push(`/facilitator/discussion/${item.id}`);
            } else {
              this.discussion_id = item.id;
              this.$bvModal.show("access");
            }
          }
        });
    },
    vote(val) {
      var positive = val.filter(item => item.vote).length;
      var negative = val.filter(item => !item.vote).length;
      return Number(positive) - Number(negative);
    }
  }
};
</script>
<style scoped lang="scss">
.container {
  max-width: 960px;
}
.shadow {
  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
  border-radius: 8px;
}
h4.card-title {
  font-size: 1.1rem;
  margin-bottom: 0.25rem;
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
  padding: 10px;
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
.btn-sm,
.btn-group-sm > .btn {
  padding: 0.25rem 0.5rem;
  font-size: 0.7rem !important;
  line-height: 1.4;
  border-radius: 0.2rem;
}
@media (max-width: 600px) {
  h4.card-title {
    font-size: 0.9rem;
  }
  nav ul li {
    font-size: 12px !important;
  }
  .btn-sm,
  .btn-group-sm > .btn {
    padding: 0.2rem 0.5rem;
    font-size: 0.65rem !important;
    line-height: 1.3;
    border-radius: 0.2rem;
  }
  p {
    margin-bottom: 1px;
  }
  .top_h {
    height: auto;
  }
}
</style>

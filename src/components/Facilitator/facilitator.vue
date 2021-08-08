<template>
  <div>
    <b-container fluid>
      <b-row>
        <b-col sm="8">
          <b-row>
            <b-col cols="12" class="mb-0 rounded pt-sm-2 px-1 px-sm-4 pb-2">
              <b-card no-body class="overflow-hidden border-0" style="">
                <b-row no-gutters>
                  <b-col cols="3" class="prof_img">
                    <b-card-img
                      width="15%"
                      :src="
                        detail.profile
                          ? detail.profile
                          : require('@/assets/images/default.jpeg')
                      "
                      alt="Image"
                      class="rounded-0"
                    ></b-card-img>
                  </b-col>
                  <b-col cols="9" class="flex-1">
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
                        v-if="detail.age || detail.state || detail.country"
                      >
                        <span
                          class="fs11 text-muted cursor-pointer mr-2"
                          v-if="detail.age"
                        >
                          {{ detail.age }} years ,</span
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
                      <div
                        v-if="
                          $route.params.user != 'f' ||
                          ($route.params.user == 'f' &&
                            $store.getters.facilitator.id != $route.params.id)
                        "
                      >
                        <b-button
                          size="sm"
                          v-if="
                            $route.params.user == 'f' &&
                            !checkconnection(detail)
                          "
                          variant="outline-dark-green"
                          @click="addconnections(detail.id, 'facilitator')"
                          >Connect</b-button
                        >
                        <b-button
                          size="sm"
                          v-if="
                            $route.params.user == 'u' &&
                            !checkconnection(detail)
                          "
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
                    </b-card-body>
                  </b-col>
                </b-row>
              </b-card>
            </b-col>
            <b-col cols="12" class="px-1 px-sm-4 mb-3">
              <b-card no-body class="border-0" style="">
                <b-row>
                  <b-card-body class="text-left w-100 pb-0">
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
                          Feed
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
                        <li
                          class="h6 fs14 cursor-pointer mb-0"
                          :class="active == 4 ? 'active' : ''"
                          @click="active = 4"
                        >
                          Courses
                        </li>
                      </ul>
                    </nav>
                  </b-card-body>
                </b-row>
              </b-card>
            </b-col>
            <b-col cols="12" class="px-1 px-sm-4">
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
                                <div
                                  class="h6 mr-2 mb-1 feedname"
                                  v-if="feed.user"
                                >
                                  <b-avatar
                                    size="1.8rem"
                                    class="mr-2"
                                    :src="feed.user.profile"
                                  ></b-avatar>
                                  {{ feed.user.name }}
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
                                size="1.8rem"
                                v-if="item.creator == 'admin'"
                                :src="item.admin.profile"
                              ></b-avatar>
                              <b-avatar
                                size="1.8rem"
                                v-if="item.creator == 'user'"
                                :src="item.user.profile"
                              ></b-avatar>
                              <b-avatar
                                size="1.8rem"
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
                            No Discussion available
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
                              @click="
                                $router.push(`/facilitator/event/${item.id}`)
                              "
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
                            No event available
                            <br class="d-none d-sm-block" />
                          </h6>
                        </div>
                      </div>
                    </div>
                  </b-card-body>

                  <b-card-body v-if="active == 4" class="pt-0 px-3">
                    <div v-if="showCourse">
                      <b-container fluid class="main-course">
                        <b-row>
                          <b-col
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
                                <div class="border-bottom pt-3 text-left">
                                  <h6
                                    class="
                                      font-weight-bold
                                      text-capitalize
                                      overview-title
                                    "
                                  >
                                    {{ item.title }}
                                  </h6>
                                  <div
                                    class="fs13 overview"
                                    v-html="item.courseoutline.overview"
                                  ></div>
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
                                      <b-icon icon="eye" class="mr-1"></b-icon>
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
                                        >{{ item.review.length }} reviews</span
                                      >
                                    </div>
                                  </div>

                                  <b-avatar
                                    size="sm"
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
                        <h6 class="text-muted my-3 fs14">
                          No course available
                        </h6>
                      </div>
                    </div>
                  </b-card-body>
                </b-row>
              </b-card>
            </b-col>
          </b-row>
        </b-col>
        <b-col class="d-none d-sm-block" cols="3">
          <Message
            class="d-none d-md-block"
            @getmessage="getmessage"
            :user="'facilitator'"
          />
        </b-col>
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
                          item.user_follower.name,
                          'user',
                          item.user_follower.profile
                        )
                      "
                      >Message</b-button
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
                          item.facilitator_follower.id,
                          item.facilitator_follower.name,
                          'facilitator',
                          item.facilitator_follower.profile
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
    <Minichat
      class="minichats"
      :user="'facilitator'"
      :mini_info="mini_info"
      :open="open"
      :showAll="showAll"
      @togglechat="togglechat"
    />
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
  </div>
</template>
<script>
import Message from "../messagecomponent";
import Minichat from "../minichat";
export default {
  data() {
    return {
      id: this.$route.params.id,
      myconnections: [],
      detail: [],
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
      showCourse: false,
      showProfile: false,
    };
  },
  components: {
    Message,
    Minichat,
  },
  computed: {
    filteredCourse() {
      var title = this.courses
        .slice(
          this.perPage * this.currentPage - this.perPage,
          this.perPage * this.currentPage
        )
        .filter(
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
  created() {},
  mounted() {
    this.getmyconnections().then(() => {
      this.getdiscussions();
      this.getinfo();
      this.getFeeds();
      this.getConnections();
      this.getEvents();
    });
  },
  methods: {
    async addconnections(id, type) {
      return this.$http
        .post(
          `${this.$store.getters.url}/connections`,
          { following_id: id, follow_type: type },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200 || res.status == 201) {
            this.$toast.success("Connected");
            this.getmyconnections();
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
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
    getinfo() {
      if (this.$route.params.user == "f") {
        this.getCourses();
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
      } else {
        this.$http
          .get(
            `${this.$store.getters.url}/member/info/${this.$route.params.id}`
          )
          .then((res) => {
            if (res.status == 200) {
              this.detail = res.data;
            }
          })
          .catch((err) => {
            this.$toast.error(err.response.data.message);
          });
      }
    },

    getdiscussions() {
      if (this.$route.params.user == "f") {
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
      } else {
        this.$http
          .get(
            `${this.$store.getters.url}/member/discussions/${this.$route.params.id}`
          )
          .then((res) => {
            if (res.status == 200) {
              this.discussions = res.data;
            }
          })
          .catch((err) => {
            this.$toast.error(err.response.data.message);
          });
      }
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
      if (this.$route.params.user == "f") {
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
      } else {
        this.$http
          .get(
            `${this.$store.getters.url}/member/feeds/${this.$route.params.id}`
          )
          .then((res) => {
            if (res.status == 200) {
              this.feeds = res.data;
            }
          })
          .catch((err) => {
            this.$toast.error(err.response.data.message);
          });
      }
    },
    getEvents() {
      if (this.$route.params.user == "f") {
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
      }
    },
    getCourses() {
      if (this.$route.params.user == "f") {
        this.$http
          .get(
            `${this.$store.getters.url}/facilitator/courses/${this.$route.params.id}`
          )
          .then((res) => {
            if (res.status == 200) {
              this.courses = res.data;
              this.showCourse = true;
            }
          })
          .catch((err) => {
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
      } else {
        this.$http
          .get(
            `${this.$store.getters.url}/member/connections/${this.$route.params.id}`
          )
          .then((res) => {
            if (res.status == 200) {
              this.connections = res.data;
            }
          })
          .catch((err) => {
            this.$toast.error(err.response.data.message);
          });
      }
    },
    requestAccess() {
      var data = {
        discussion_id: this.discussion_id,
      };

      this.$http
        .post(`${this.$store.getters.url}/join-discussion`, data, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.$toast.info("Your request has been sent");
            this.$bvModal.hide("access");
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    joindiscussion(item) {
      if (
        item.facilitator &&
        item.facilitator.id == this.$store.getters.facilitator.id
      ) {
        this.$router.push(`/facilitator/discussion/${item.id}`);
      } else {
        this.$http
          .get(`${this.$store.getters.url}/discussion/private/${item.id}`, {
            headers: {
              Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
            },
          })
          .then((res) => {
            if (res.status == 200) {
              var result = res.data
                .map((item) => item.facilitator_id)
                .includes(this.$store.getters.facilitator.id);

              if (result) {
                this.$router.push(`/facilitator/discussion/${item.id}`);
              } else {
                this.discussion_id = item.id;
                this.$bvModal.show("access");
              }
            }
          });
      }
    },
    async getmyconnections() {
      return this.$http
        .get(`${this.$store.getters.url}/connections`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.myconnections = res.data;
            this.showProfile = true;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    async removeconnections(user) {
      var res = this.myconnections.find((item) => {
        if (this.$route.params.user == "f") {
          return item.facilitator_follower.id == user.id;
        }

        if (this.$route.params.user == "u") {
          return item.user_follower.id == user.id;
        }
      });

      this.$http
        .delete(`${this.$store.getters.url}/connections/${res.id}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.myconnections = res.data;
            this.$toast.success("Unfollowed");
            this.getmyconnections();
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    checkconnection(user) {
      var res = this.myconnections.find((item) => {
        if (this.$route.params.user == "f" && item.facilitator_follower) {
          return item.facilitator_follower.id == user.id;
        }

        if (this.$route.params.user == "u" && item.user_follower) {
          return item.user_follower.id == user.id;
        }
      });

      return res;
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
.container-fluid {
  padding-top: 30px;
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
.course {
  height: 350px;
  position: relative;
  background: white;
  border-radius: 8px;
  overflow: hidden;
}
.course_img {
  height: 45%;
  width: 100%;

  border-radius: 8px;
  background-repeat: no-repeat;
  background-size: cover;
}
.course_text {
  height: 55%;
  padding: 10px;
}
.info {
  display: flex;
  justify-content: space-between;
  padding: 10px 0;
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
    font-size: 0.5rem !important;
    line-height: 1.3;
    border-radius: 0.2rem;
  }
  p {
    margin-bottom: 1px;
  }
}
</style>

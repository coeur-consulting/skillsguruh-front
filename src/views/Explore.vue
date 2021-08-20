<template>
  <div class="main_c text-left pt-md-5">
    <section class="top_bg"></section>

    <div class="bg-white">
      <section>
        <b-container class="pb-5">
          <b-row class="justify-content-around p-2 py-sm-5">
            <b-col cols="4">
              <span
                class="d-flex align-items-center justify-content-start tpp"
                @click="$router.push('/explore/members')"
              >
                <b-img
                  class="mr-2 tp"
                  size="2.5rem"
                  src="/img/member.png"
                ></b-img>
                <span>
                  <span class="">{{ users.length }}+</span> <br />
                  <span class="">Happy Members</span>
                </span>
              </span>
            </b-col>
            <b-col cols="4">
              <span
                class="d-flex align-items-center tpp"
                @click="$router.push('/explore/courses')"
              >
                <b-img
                  class="mr-2 tp"
                  size="2.5rem"
                  src="/img/program.png"
                ></b-img>
                <span>
                  <span class="">{{ courses.length }}+</span> <br />
                  <span class="">Online Courses</span>
                </span>
              </span>
            </b-col>
            <b-col cols="4">
              <span
                class="d-flex align-items-center justify-content-end tpp"
                @click="$router.push('/explore/facilitators')"
              >
                <b-img class="mr-2 tp" size="2.5rem" src="/img/grp.png"></b-img>
                <span>
                  <span class="">{{ facilitators.length }}+</span>
                  <br />
                  <span class="">Facilitators Onboard</span>
                </span>
              </span>
            </b-col>
          </b-row>
        </b-container>
      </section>
      <section class="py-3 py-sm-4 mb-2 mb-sm-5">
        <b-container>
          <b-row>
            <b-col class="mb-3">
              <div>
                <div class="d-flex justify-content-center trending">
                  <h2 class="mb-5">
                    <span> Trending Discussions</span>
                  </h2>
                </div>
              </div>
            </b-col>
          </b-row>
          <b-row class="py-4 d-none d-sm-flex" v-if="trending.length">
            <b-col
              sm="4"
              class="mb-2"
              v-for="(item, id) in trending.slice(0, 3)"
              :key="id"
            >
              <div
                class="discussion_container position-relative"
                @click="$router.push(`/explore/discussion/${item.id}`)"
              >
                <div class="p-4 dicussion_overlay position-relative">
                  <b-avatar
                    v-if="item.admin"
                    :src="item.admin.profile"
                    class="mr-3 discussion_avatar"
                  ></b-avatar>
                  <b-avatar
                    v-if="item.user"
                    :src="item.user.profile"
                    class="mr-3 discussion_avatar"
                  ></b-avatar>
                  <b-avatar
                    v-if="item.facilitator"
                    :src="item.facilitator.profile"
                    class="mr-3 discussion_avatar"
                  ></b-avatar>
                  <div class="discussion_name" v-if="item.admin">
                    {{ item.admin.name }}
                  </div>

                  <div class="discussion_name" v-if="item.facilitator">
                    {{ item.facilitator.username }}
                  </div>
                  <div class="discussion_name" v-if="item.user">
                    {{ item.user.username }}
                  </div>
                  <div class="fs11 mb-3">
                    <!-- {{ $moment(item.created_at).fromNow() }} -->
                  </div>
                  <div class="discussion_title">
                    {{ item.name }}
                  </div>

                  <span class="position-absolute discussion_badge">
                    <b-badge
                      class="text-white d-flex align-items-center"
                      :style="{
                        backgroundColor: JSON.parse(item.category).color,
                      }"
                    >
                      <b-icon
                        icon="circle-fill"
                        class="mr-1"
                        font-scale=".5"
                      ></b-icon>
                      {{ JSON.parse(item.category).value }}</b-badge
                    >
                  </span>

                  <div
                    class="comment_carousel"
                    v-if="item.discussionmessage.length"
                  >
                    <VueSlickCarousel
                      :arrows="false"
                      :vertical="true"
                      :slidesToShow="2"
                      :slidesToScroll="1"
                      :autoplay="true"
                      :autoplaySpeed="5000"
                    >
                      <div
                        v-for="(message, idx) in item.discussionmessage"
                        :key="idx"
                        class="comment_container mb-3 shadow-sm"
                      >
                        <div class="rounded overflow-hidden d-flex">
                          <div class="comment_image">
                            <b-img
                              v-if="message.admin"
                              :src="
                                message.admin.proflle
                                  ? message.admin.profile
                                  : require('@/assets/images/default.jpeg')
                              "
                            ></b-img>
                            <b-img
                              v-if="item.facilitator"
                              :src="
                                message.facilitator.proflle
                                  ? message.facilitator.profile
                                  : require('@/assets/images/default.jpeg')
                              "
                            ></b-img>
                            <b-img
                              v-if="message.user"
                              :src="
                                message.user.proflle
                                  ? message.user.profile
                                  : require('@/assets/images/default.jpeg')
                              "
                            ></b-img>
                          </div>
                          <div class="comment_box">
                            <div class="comment_name" v-if="message.admin">
                              {{ message.admin.name }}
                            </div>
                            <div
                              class="comment_name"
                              v-if="message.facilitator"
                            >
                              {{ message.facilitator.username }}
                            </div>
                            <div class="comment_name" v-if="message.user">
                              {{ message.user.username }}
                            </div>
                            <div class="comment_details">
                              <span
                                >{{ message.discussionmessagecomment.length }}
                                <b-icon
                                  icon="chat-left-dots-fill"
                                  font-scale=".85"
                                ></b-icon
                              ></span>
                            </div>
                            <div
                              class="
                                comment_text
                                text-truncate text-truncate--2
                              "
                              v-html="message.message"
                            ></div>
                          </div>
                        </div>
                      </div>
                    </VueSlickCarousel>
                  </div>
                </div>
              </div>
            </b-col>
          </b-row>
          <div class="py-4 d-sm-none px-3">
            <carousel :perPage="1">
              <slide
                v-for="(item, id) in trending.slice(0, 6)"
                :key="id"
                class="px-2"
              >
                <div
                  class="discussion_container position-relative"
                  @click="$router.push(`/explore/discussion/${item.id}`)"
                >
                  <div class="p-4 dicussion_overlay position-relative">
                    <b-avatar
                      v-if="item.admin"
                      :src="item.admin.profile"
                      class="mr-3 discussion_avatar"
                    ></b-avatar>
                    <b-avatar
                      v-if="item.user"
                      :src="item.user.profile"
                      class="mr-3 discussion_avatar"
                    ></b-avatar>
                    <b-avatar
                      v-if="item.facilitator"
                      :src="item.facilitator.profile"
                      class="mr-3 discussion_avatar"
                    ></b-avatar>
                    <div class="discussion_name" v-if="item.admin">
                      {{ item.admin.name }}
                    </div>

                    <div class="discussion_name" v-if="item.facilitator">
                      {{ item.facilitator.username }}
                    </div>
                    <div class="discussion_name" v-if="item.user">
                      {{ item.user.username }}
                    </div>

                    <div class="discussion_title">
                      {{ item.name }}
                    </div>

                    <span class="position-absolute discussion_badge">
                      <b-badge
                        class="text-white d-flex align-items-center"
                        :style="{
                          backgroundColor: JSON.parse(item.category).color,
                        }"
                      >
                        <b-icon
                          icon="circle-fill"
                          class="mr-1"
                          font-scale=".5"
                        ></b-icon>
                        {{ JSON.parse(item.category).value }}</b-badge
                      >
                    </span>

                    <div
                      class="comment_carousel"
                      v-if="item.discussionmessage.length"
                    >
                      <div
                        v-for="(message, idx) in item.discussionmessage"
                        :key="idx"
                        class="
                          rounded
                          d-flex
                          comment_container
                          mb-3
                          overflow-hidden
                        "
                      >
                        <div class="comment_image">
                          <b-img
                            v-if="message.admin"
                            :src="
                              message.admin.proflle
                                ? message.admin.profile
                                : require('@/assets/images/default.jpeg')
                            "
                          ></b-img>
                          <b-img
                            v-if="message.facilitator"
                            :src="
                              message.facilitator.proflle
                                ? message.facilitator.profile
                                : require('@/assets/images/default.jpeg')
                            "
                          ></b-img>
                          <b-img
                            v-if="message.user"
                            :src="
                              message.user.proflle
                                ? message.user.profile
                                : require('@/assets/images/default.jpeg')
                            "
                          ></b-img>
                        </div>
                        <div class="comment_box">
                          <div class="comment_name" v-if="message.admin">
                            {{ message.admin.name }}
                          </div>
                          <div class="comment_name" v-if="message.facilitator">
                            {{ message.facilitator.username }}
                          </div>
                          <div class="comment_name" v-if="message.user">
                            {{ message.user.username }}
                          </div>
                          <div class="comment_details">
                            <!-- <span class="mr-2">{{
                              $moment(message.created_at).fromNow()
                            }}</span> -->
                            <span
                              >{{ message.discussionmessagecomment.length }}
                              <b-icon
                                icon="chat-left-dots-fill"
                                font-scale=".85"
                              ></b-icon
                            ></span>
                          </div>
                          <div
                            class="comment_text text-truncate text-truncate--2"
                            v-html="message.message"
                          ></div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </slide>
            </carousel>
          </div>
        </b-container>
        <div class="text-center mt-0 mt-md-5 pt-md-5">
          <small
            @click="$router.push('/explore/discussions')"
            class="cursor-pointer text-dark-green"
            >View all {{ discussions.length }} discussions
            <b-icon font-scale=".85" icon="chevron-right"></b-icon
          ></small>
        </div>
      </section>
      <section class="py-3 py-sm-5">
        <b-container>
          <div class="d-flex justify-content-center trending mb-5">
            <h2 class="">
              <span> Popular Feed</span>
            </h2>
          </div>

          <b-row>
            <b-col sm="7" class="mb-4 mb-sm-0">
              <div v-if="showFeeds">
                <div v-if="filteredFeeds.length">
                  <div
                    v-for="(feed, index) in filteredFeeds"
                    :key="index"
                    class="border bg-white rounded-8 mb-3 shadow-sm"
                  >
                    <div class="d-flex mb-3 px-2 px-sm-3 pt-3">
                      <div class="flex-1 text-left">
                        <div class="mr-2 mb-1 feedname" v-if="feed.admin">
                          <b-avatar
                            size="1.8rem"
                            class="mr-2"
                            :src="feed.admin.profile"
                          ></b-avatar>
                          <div>
                            <div style="line-height: 1.2">
                              {{ feed.admin.username }} <br />
                            </div>
                            <small
                              v-if="feed.admin.state"
                              class="
                                text-muted
                                font-weight-normal
                                text-capitalize
                              "
                              >{{ feed.admin.state }}</small
                            >
                          </div>
                        </div>
                        <div class="mr-2 mb-1 feedname" v-if="feed.user">
                          <b-avatar
                            size="1.8rem"
                            class="mr-2"
                            :src="feed.user.profile"
                          ></b-avatar>
                          <span
                            @click="$router.push(`/profile/u/${feed.user.id}`)"
                            class="hover_green"
                          >
                            <div style="line-height: 1.2">
                              {{ feed.user.username }}
                            </div>
                            <small
                              v-if="feed.user.state"
                              class="
                                text-muted
                                font-weight-normal
                                text-capitalize
                              "
                              >{{ feed.user.state }}</small
                            >
                          </span>
                        </div>
                        <div class="mr-2 mb-1 feedname" v-if="feed.facilitator">
                          <b-avatar
                            size="1.8rem"
                            class="mr-2"
                            :src="feed.facilitator.profile"
                          ></b-avatar>
                          <span
                            class="hover_green"
                            @click="
                              $router.push(`/profile/f/${feed.facilitator.id}`)
                            "
                          >
                            <div style="line-height: 1.2">
                              {{ feed.facilitator.username }}
                            </div>
                            <small
                              v-if="feed.facilitator.state"
                              class="
                                text-muted
                                font-weight-normal
                                text-capitalize
                              "
                              >{{ feed.facilitator.state }}</small
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
                          <b-icon icon="three-dots" font-scale="1.4"></b-icon>
                        </template>
                        <b-dropdown-item
                          class="fs12"
                          @click="$router.push(`/explore/feed/view/${feed.id}`)"
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
                    </div>

                    <!-- <div v-if="feed.media || feed.publicId">
                      <div class="mb-4 position-relative w-100 media bg-dark">
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
                          @click="toggleLike(feed.id, index)"
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
                          @click="toggleLike(feed.id, index)"
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
                    </div> -->
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
                            v-for="(tag, id) in JSON.parse(feed.tags)"
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
                    <div class="interactions text-left px-3 py-2">
                      <span
                        class="mr-3 cursor-pointer"
                        @click="toggleStar(feed.id, index)"
                      >
                        <b-icon
                          :icon="
                            feed.stars.find(
                              (item) =>
                                item.star &&
                                item.user_id == $store.getters.member.id
                            )
                              ? 'star-fill'
                              : 'star'
                          "
                          class="text-blue mr-1"
                        ></b-icon>
                        <span>{{
                          feed.stars.filter((item) => item.star).length
                        }}</span>
                      </span>
                      <span
                        class="mr-3 cursor-pointer"
                        @click="toggleLike(feed.id, index)"
                        ><b-icon
                          :icon="
                            feed.likes.find(
                              (item) =>
                                item.like &&
                                item.user_id == $store.getters.member.id
                            )
                              ? 'heart-fill'
                              : 'heart'
                          "
                          class="text-danger mr-1"
                        ></b-icon>
                        <span>{{
                          feed.likes.filter((item) => item.like).length
                        }}</span>
                      </span>
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
                      class="liked_by px-3 border-bottom"
                      @click="showlikes(feed)"
                      v-html="getlikes(feed.likes)"
                    ></div>
                    <div
                      class="comments px-3 pt-2 border-bottom text-left"
                      style="line-height: 1.2"
                      v-if="feed.comments.length"
                    >
                      <span
                        v-if="feed.comments.length"
                        @click="showcomments(feed)"
                        class="comment_header cursor-pointer"
                        >View {{ feed.comments.length }}
                        {{
                          feed.comments.length > 1 ? "comments" : "comment"
                        }}</span
                      >
                      <div class="all_comment">
                        <div
                          class="comment d-flex text-left mb-1"
                          v-for="item in feed.comments.slice(0, 2)"
                          :key="item.id"
                        >
                          <div class="flex-1 pr-2">
                            <span class="comment_name mr-2" v-if="item.admin">
                              {{ item.admin.name }}</span
                            >
                            <span
                              class="comment_name mr-2 hover_green"
                              @click="
                                $router.push(`/profile/u/${item.user.id}`)
                              "
                              v-if="item.user"
                            >
                              {{ item.user.username }}</span
                            >
                            <span
                              class="comment_name mr-2 hover_green"
                              @click="
                                $router.push(
                                  `/profile/f/${item.facilitator.id}`
                                )
                              "
                              v-if="item.facilitator"
                            >
                              {{ item.facilitator.username }}</span
                            >

                            <span class="comment_text">{{ item.comment }}</span>
                          </div>
                          <div>
                            <!-- <span class="comment_mins"
                              >{{ $moment(item.created_at).fromNow() }}
                            </span> -->
                          </div>
                        </div>
                      </div>
                    </div>

                    <div class="interact text-left pb-1 px-2">
                      <b-input-group class="mt-1">
                        <template #append>
                          <b-input-group-text
                            class="border-0 bg-transparent d-block"
                            ><span
                              @click="addcomment(feed.id, index, feed.comment)"
                              class="
                                text-dark-green
                                cursor-pointer
                                comment_post
                              "
                              >Post</span
                            ></b-input-group-text
                          >
                        </template>
                        <template #prepend class="d-none d-md-block">
                          <b-input-group-text
                            class="border-0 bg-transparent d-none d-md-block"
                          >
                            <emoji-picker
                              @emoji="insertcomment"
                              :id="feed.id"
                              :index="index"
                              :search="search"
                            >
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
                                    <input
                                      type="text"
                                      v-model="search"
                                      v-focus
                                    />
                                  </div>
                                  <div>
                                    <div
                                      v-for="(emojiGroup, category) in emojis"
                                      :key="category"
                                    >
                                      <h5>{{ category }}</h5>
                                      <div class="emojis">
                                        <span
                                          v-for="(
                                            emoji, emojiName
                                          ) in emojiGroup"
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
                          size="sm"
                          autocomplete="off"
                          autocorrect="off"
                          rows="1"
                          v-model="feed.comment"
                          placeholder="Add comment"
                          class="border-0 no-focus"
                        ></b-form-input>
                      </b-input-group>
                    </div>
                    <!-- <div
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
                    </div> -->
                  </div>
                  <div class="text-center mt-2">
                    <router-link to="/explore/feeds" class="text-dark-green"
                      ><small
                        >View all feed
                        <b-icon
                          font-scale=".85"
                          icon="chevron-right"
                        ></b-icon></small
                    ></router-link>
                  </div>
                </div>
                <div v-else class="text-center admin_tab p-3 p-sm-5">
                  <div>
                    <b-img
                      :src="require('@/assets/images/creator.svg')"
                    ></b-img>
                    <h6 class="text-muted my-3 fs14">
                      It appears you have no feed,
                      <br class="d-none d-sm-block" />
                    </h6>
                  </div>
                </div>
              </div>
              <div v-else class="p-3">
                <div class="w-100 mb-3">
                  <div class="w-100">
                    <div class="mb-3">
                      <b-skeleton-img no-aspect height="250px"></b-skeleton-img>
                    </div>
                    <b-skeleton animation="wave" width="85%"></b-skeleton>
                    <b-skeleton animation="wave" width="35%"></b-skeleton>
                  </div>
                </div>
              </div>
            </b-col>
            <b-col sm="4" class="px-3">
              <div class="text-left">
                <h6 class="mb-4 fs12 text-dark-green">
                  Trending in Last 24hrs
                </h6>
                <div v-if="trendingFeed.length" class="pb-3">
                  <div
                    v-for="(item, id) in trendingFeed.slice(0, 3)"
                    :key="id"
                    class="mb-3"
                  >
                    <div
                      class="trending_name cursor-pointer"
                      @click="$router.push(`/explore/feed/${item.name}`)"
                    >
                      {{ item.name }}
                    </div>
                    <div class="trending_count text-muted">
                      {{ item.count }} posts about this
                    </div>
                  </div>
                </div>
                <div v-else class="text-center text-muted">Unavailable</div>
              </div>
            </b-col>
          </b-row>
        </b-container>
      </section>

      <section class="text-center mb-5 pt-4 py-sm-5">
        <b-container>
          <div class="d-flex justify-content-center trending mb-5">
            <h2 class="">
              <span> Explore Interests</span>
            </h2>
          </div>

          <p class="px-2 px-sm--5">
            Select your interest to connect with your tribe right away
          </p>
          <b-row class="py-2 justify-content-center justify-content-sm-around">
            <b-col
              v-for="(item, id) in interests"
              :key="id"
              class="mb-5 cursor-pointer"
              cols="4"
              sm="2"
              md="3"
              ><b-img
                :src="item.image"
                @click="$router.push(`/explore/interests/${item.id}`)"
                class="mb-2 interest"
              ></b-img>
              <h6 class="interest text-center w-100">
                {{ item.value }}
              </h6></b-col
            >
          </b-row>
        </b-container>
      </section>
      <section class="py-5">
        <b-container>
          <div class="d-flex justify-content-center trending mb-5">
            <h2 class="">
              <span> Popular Courses</span>
            </h2>
          </div>

          <b-row class="justify-content-start pb-1" v-if="courses.length">
            <b-col cols="12" class="mb-sm-4 px-sm-4">
              <carousel
                :perPage="2"
                :scrollPerPage="true"
                :paginationEnabled="true"
                :spacePadding="8"
                :perPageCustom="[
                  [600, 2],
                  [768, 3],
                ]"
                v-if="courses.length"
              >
                <slide
                  class="p-2 pr-3"
                  v-for="item in courses.slice(0, 6)"
                  :key="item.id"
                >
                  <div class="shadow-sm">
                    <div
                      class="course border rounded overflow-hidden"
                      @click="
                        $router.push(`/explore/courses?course_id=${item.id}`)
                      "
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
                      <div class="course_text bg-white p-2 p-sm-3">
                        <div class="d-flex justify-content-between">
                          <span
                            class="
                              px-2
                              py-1
                              rounded-pill
                              text-white
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
                                JSON.parse(item.courseoutline.knowledge_areas)
                                  .icon
                              "
                            ></b-icon>
                            <span>{{
                              JSON.parse(item.courseoutline.knowledge_areas)
                                .value
                            }}</span></span
                          >
                          <span class="text-capitalize course_type">{{
                            item.type
                          }}</span>
                        </div>
                        <div class="pt-2 pb-1">
                          <h6
                            class="
                              overview-title
                              text-truncate text-truncate--2
                            "
                          >
                            {{ item.title }}
                          </h6>
                          <div
                            class="
                              text-truncate text-truncate--2
                              course_description
                            "
                          >
                            {{ item.description }}
                          </div>
                        </div>
                        <div class="info fs12">
                          <div class="d-flex">
                            <div class="mr-3">
                              <b-icon icon="people" class="mr-1"></b-icon>
                              <span>{{ item.count }}+</span>
                            </div>
                            <div>
                              <b-icon
                                icon="star-fill"
                                style="color: gold"
                                class="mr-1"
                              ></b-icon>
                              <span>{{ item.review.length }} reviews</span>
                            </div>
                          </div>

                          <b-avatar
                            size="sm"
                            variant="light"
                            :src="item.cover"
                            class="course_avatar"
                          >
                          </b-avatar>
                        </div>
                      </div>
                    </div>
                  </div>
                </slide>
              </carousel>
            </b-col>
          </b-row>

          <div class="text-center text-dark-green fs12">
            <span
              @click="$router.push('/explore/courses')"
              class="cursor-pointer"
              >Load more...</span
            >
          </div>
        </b-container>
      </section>
      <section class="py-3 py-sm-5">
        <b-container>
          <div class="d-flex justify-content-center">
            <div class="trending">
              <h2 class="mb-5">
                <span> Events</span>
              </h2>
            </div>
          </div>

          <div v-if="showEvents">
            <div
              class="events"
              v-if="events.filter((item) => item.status !== 'expired').length"
            >
              <carousel
                :perPage="1"
                :paginationEnabled="true"
                :autoplay="true"
                :speed="1000"
                :autoplayTimeout="5000"
                :loop="true"
                class="p-sm-3"
              >
                <slide
                  v-for="item in events
                    .filter((item) => item.status !== 'expired')
                    .slice(0, 4)"
                  :key="item.id"
                  class="p-3"
                >
                  <div class="shadow-sm">
                    <div
                      class="
                        border
                        bg-white
                        rounded
                        text-left
                        position-relative
                        overflow-hidden
                      "
                    >
                      <b-img
                        fluid-grow
                        :src="item.cover"
                        class="event_img"
                      ></b-img>
                      <div class="px-3 py-3">
                        <p class="mb-1 schedule">
                          <b-icon icon="calendar2-check" class="mr-2"></b-icon>

                          {{ item.schedule }}
                        </p>
                        <p class="mb-1 attending">
                          <b-icon icon="people" class="mr-2"></b-icon>
                          {{ item.eventattendance.length }} Attending
                        </p>
                        <div class="d-flex">
                          <p class="description text-truncate text-truncate--2">
                            {{ item.description }}
                          </p>
                        </div>
                      </div>
                      <div
                        class="
                          bg-light
                          px-3
                          py-3
                          text-left text-dark
                          d-flex
                          justify-content-between
                        "
                      >
                        <div
                          class="
                            event_title
                            text-capitalize text-dark
                            mb-0
                            text-left
                          "
                        >
                          {{ item.title }}
                        </div>
                        <span
                          class="cursor-pointer"
                          @click="$router.push(`/explore/event/${item.id}`)"
                        >
                          <span
                            class="viewevent d-none d-sm-inline text-dark-green"
                          >
                            View Event
                          </span>
                          <b-icon
                            font-scale=".85"
                            icon="chevron-right"
                          ></b-icon>
                        </span>
                      </div>
                    </div>
                  </div>
                </slide>
              </carousel>

              <div class="px-2">
                <router-link to="/events" class="text-dark-green"
                  ><small
                    >View all events
                    <b-icon
                      font-scale=".85"
                      icon="chevron-right"
                    ></b-icon></small
                ></router-link>
              </div>
            </div>
            <div v-else class="text-center admin_tab p-3 p-sm-5">
              <div>
                <b-img :src="require('@/assets/images/creator.svg')"></b-img>
                <h6 class="text-muted my-3 fs14">
                  It appears there are no events available
                </h6>
              </div>
            </div>
          </div>
          <div v-else class="p-3">
            <div class="w-100 mb-3">
              <div class="w-100">
                <div class="mb-3">
                  <b-skeleton-img no-aspect height="250px"></b-skeleton-img>
                </div>
                <b-skeleton animation="wave" width="85%"></b-skeleton>
                <b-skeleton animation="wave" width="35%"></b-skeleton>
              </div>
            </div>
          </div>
        </b-container>
      </section>
    </div>
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

                <!-- <div class="date fs11">
                  {{ alllikes.created_at | moment("ll") }}
                </div> -->
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
                    @click="$router.push(`/member/profile/u/${item.user.id}`)"
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
                        {{ item.facilitator.nausernameme }}
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

                <!-- <div class="date fs11">
                  {{ allcomments.created_at | moment("ll") }}
                </div> -->
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
                    <!-- <span class="comment_mins pl-2">{{
                      $moment(item.created_at).fromNow()
                    }}</span> -->
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
                    <!-- <span class="comment_mins pl-2">{{
                      $moment(item.created_at).fromNow()
                    }}</span> -->
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
                    <!-- <span class="comment_mins pl-2">{{
                      $moment(item.created_at).fromNow()
                    }}</span> -->
                  </div>
                </div>
              </div>
            </div>
            <div></div>
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
import Interests from "@/components/helpers/category.js";
import SubInterests from "@/components/helpers/subcategory.js";
import EmojiPicker from "@/components/emoji/EmojiPicker";
import VueSlickCarousel from "vue-slick-carousel";
import "vue-slick-carousel/dist/vue-slick-carousel.css";
// optional style for arrows & dots
import "vue-slick-carousel/dist/vue-slick-carousel-theme.css";

export default {
  data() {
    return {
      link: "",
      description: "",
      allcomments: [],
      img_ext: ["jpg", "png", "jpeg", "gif"],
      vid_ext: ["mp4", "3gp", "flv", "mov"],
      aud_ext: ["mp3", "aac"],
      doc_ext: ["docx", "pdf", "ppt", "zip"],
      comment: {
        comment: "",
        id: "",
      },
      search: "",
      showEnrolled: false,
      courses: [],
      showConnect: false,
      showDiscussion: false,
      courseShown: "toprated",
      mostenrolledcourse: [],
      facilitators: [],
      users: [],
      events: [],
      discussions: [],
      showEvents: false,
      interests: [],
      SubInterests: [],
      contributors: [],
      showFeeds: false,
      trendingFeed: [],
      feeds: [],
      auth: false,
      alllikes: null,
      toggleOn: null,
    };
  },
  directives: {
    focus: {
      inserted(el) {
        el.focus();
      },
    },
  },
  mounted() {
    if (
      localStorage.getItem("authMember") ||
      localStorage.getItem("authFacilitator")
    ) {
      this.auth = true;
    }
    this.gettrendingfeeds();
    this.mostenrolled();
    this.getcourses();
    this.getmembers();
    this.getevents();
    this.getfacilitators();
    this.getdiscussions();
    this.getcontributors();
    this.getTrendingFeeds();
    this.interests = Interests;
    this.SubInterests = SubInterests;
  },
  components: {
    EmojiPicker,
    VueSlickCarousel,
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
    trending() {
      return this.discussions
        .filter((item) => item.type == "public")
        .sort((a, b) => {
          return (
            (b.discussionview ? b.discussionview.view : 0) -
            (a.discussionview ? a.discussionview.view : 0)
          );
        });
    },
    filterContributors() {
      return this.contributors
        .slice()
        .sort((a, b) => {
          return b.count - a.count;
        })
        .slice(0, 5);
    },
    filteredFeeds() {
      return this.feeds.slice(0, 3);
    },
  },
  methods: {
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
    sharenow(feed) {
      this.description = this.toText(feed.message);
      this.link = `https://nzukoor.com/explore/feed/view/${feed.id}?utf_medium=share`;
      this.$bvModal.show("share");
    },
    loadCourse() {
      this.course = this.courses.find(
        (item) => item.id == this.$route.query.course_id
      );
    },
    mostenrolled() {
      this.$http
        .get(`${this.$store.getters.url}/guest/mostenrolled`)
        .then((res) => {
          if (res.status == 200) {
            this.mostenrolledcourse = res.data;
          }
        });
    },
    getcontributors() {
      this.$http.get(`${this.$store.getters.url}/contributors`).then((res) => {
        if (res.status == 200) {
          this.contributors = res.data;
        }
      });
    },
    // getprograms() {
    //   this.$http.get(`${this.$store.getters.url}/guest/courses`).then((res) => {
    //     if (res.status == 200) {
    //       this.courses = res.data;
    //     }
    //   });
    // },
    getTrendingFeeds() {
      this.$http
        .get(`${this.$store.getters.url}/guest/trending/feeds`)
        .then((res) => {
          if (res.status == 200) {
            this.trendingFeed = res.data;
          }
        });
    },
    gettrendingfeeds() {
      this.$http
        .get(`${this.$store.getters.url}/trending/feeds`)
        .then((res) => {
          if (res.status == 201 || res.status == 200) {
            this.feeds = res.data.data;
            this.showFeeds = true;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getcourses() {
      this.$http
        .get(`${this.$store.getters.url}/guest/courses`)
        .then((res) => {
          if (res.status == 200) {
            this.courses = res.data;
            this.showCourse = true;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getmembers() {
      this.$http.get(`${this.$store.getters.url}/get/members`).then((res) => {
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
    insertfeed(emoji) {
      this.feed.message += emoji + "";
    },
    insertcomment(emoji, id, index) {
      if (this.filteredFeeds[index].comment == null) {
        this.filteredFeeds[index].comment = "";
      }
      this.filteredFeeds[index].comment += emoji + "";
    },
    addcomment(id, index, comment) {
      if (!comment) {
        this.$toast.info("Cannot be empty");
        return;
      }

      if (!this.auth) {
        this.$toast.info("Login to complete action");
        return;
      }
      this.comment.id = id;
      this.comment.comment = comment;

      this.$http
        .post(`${this.$store.getters.url}/feed-comments`, this.comment, {
          headers: {
            Authorization: `Bearer ${this.usertoken.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.$toast.success("Comment updated ");
            this.filteredFeeds[index].comments.unshift(res.data);
            this.filteredFeeds[index].comment = "";

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
    toggleLike(id, index) {
      if (!this.auth) {
        this.$toast.info("Login to complete action");
        return;
      }
      this.$http
        .post(
          `${this.$store.getters.url}/feed-likes`,
          { id },
          {
            headers: {
              Authorization: `Bearer ${this.usertoken.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 201) {
            this.likeimage(index);
            this.filteredFeeds[index].likes.push(res.data);
          }
          if (res.status == 200) {
            this.likeimage(index);
            this.filteredFeeds[index].likes.map((item) => {
              if (this.$store.getters.facilitator.access_token) {
                if (item.facilitator_id == this.$store.getters.facilitator.id) {
                  return (item.like = res.data.like);
                }
              }
              if (this.$store.getters.member.access_token) {
                if (item.user_id == this.$store.getters.member.id) {
                  return (item.like = res.data.like);
                }
              }
            });
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    toggleStar(id, index) {
      if (!this.auth) {
        this.$toast.info("Login to complete action");
        return;
      }
      this.$http
        .post(
          `${this.$store.getters.url}/feed-stars`,
          { id },
          {
            headers: {
              Authorization: `Bearer ${this.usertoken.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 201) {
            this.filteredFeeds[index].stars.push(res.data);
          }
          if (res.status == 200) {
            this.filteredFeeds[index].stars.map((item) => {
              if (this.$store.getters.facilitator.access_token) {
                if (item.facilitator_id == this.$store.getters.facilitator.id) {
                  return (item.like = res.data.like);
                }
              }
              if (this.$store.getters.member.access_token) {
                if (item.user_id == this.$store.getters.member.id) {
                  return (item.like = res.data.like);
                }
              }
            });
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getevents() {
      this.$http.get(`${this.$store.getters.url}/guest/events`).then((res) => {
        if (res.status == 200) {
          this.events = res.data;
          this.showEvents = true;
        }
      });
    },
    getdiscussions() {
      this.$http
        .get(`${this.$store.getters.url}/guest/discussions`)
        .then((res) => {
          if (res.status == 200) {
            this.discussions = res.data;
          }
        });
    },
  },
};
</script>

<style scoped lang="scss">
.main_c {
  /* The image used */
  background-image: url("../assets/images/mountain.svg");

  /* Set a specific height */
  min-height: 100vh;

  /* Create the parallax scrolling effect */
  background-attachment: fixed;
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
}
.top_bg {
  height: 400px;
  background-image: url("../assets/images/people.svg");
  background-position: center;
  background-repeat: no-repeat;
  background-size: contain;
}
.mywhite {
  background: #f7f8fa;
}
.trending {
  h2 span {
    position: relative;
  }
  h2 span::after {
    content: "";
    background-image: url("../assets/images/landing/mustard-brush.png");
    position: absolute;
    width: 150px;
    height: 20px;
    background-size: 150px 20px;
    background-repeat: no-repeat;
    bottom: -24px;
    right: 50%;
    margin-right: -75px;
  }
  > p {
    width: 35%;
    margin: 0 auto;
  }
}

.events {
  border-radius: 8px;
  overflow: hidden;
}
.event_img {
  height: 400px;
  object-fit: cover;
}
.tpp {
  cursor: pointer;
  font-weight: 500;
}
.discussion_container {
  height: 265px;
  color: #fff;
  border-radius: 10px;

  background-image: url("/img/fac1.jpg");
}
.dicussion_overlay {
  width: 100%;
  height: 100%;
  background: rgba($color: #000000, $alpha: 0.54);
  border-radius: 10px;
}
.discussion_avatar {
  margin-bottom: 6px;
}
.discussion_badge {
  top: 15px;
  right: 15px;
  z-index: 2;
}
.discussion_name {
  font-size: 0.85rem;
  margin-bottom: 2px;
}
.discussion_title {
  text-align: center;
  font-size: 1.1rem;
  font-weight: 500;
  line-height: 1.4;
  margin-bottom: 1rem;
}
.comment_container {
  background: #fff;
  border-radius: 10px;
  max-height: 90px;
}
.comment_image {
  width: 25%;
  background: #f7f7f7;
}
.comment_image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.comment_box {
  width: 75%;
  padding: 10px;
}
.comment_name {
  font-size: 0.7rem;
  color: rgba($color: #000000, $alpha: 0.64);
}
.comment_text {
  font-size: 0.7rem;
  color: rgba($color: #000000, $alpha: 0.64);
  max-height: 34px;
  overflow: hidden;
}
.comment_text.text-truncate p {
  display: -webkit-box !important;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  white-space: normal;
}
.comment_details {
  font-size: 0.6rem;
  color: rgba($color: #000000, $alpha: 0.54);
}
.tag_badge {
  font-size: 0.6rem;
  color: white;
}
.event_title {
  font-size: 1.05rem;
  font-weight: 500;
}
@media (max-width: 768px) {
  .trending {
    h2 {
      font-size: 1.3rem;
    }
  }
  .top_bg {
    height: 150px;
  }
  .interest {
    width: 40px;
  }
  .event_title {
    font-size: 0.85rem;
  }
  h6 {
    font-size: 14px;
  }
  .tpp span span {
    font-size: 0.7rem;
    line-height: 1.3;
  }
  .tpp span {
    line-height: 1;
  }
  .tp {
    width: 30px;
  }
  .trending {
    font-size: 0.85rem;
  }
  .discussion_container {
    min-width: 320px;
    margin-bottom: 4.1rem;
  }
  .comment_carousel {
    overflow-y: auto;
    max-height: 200px;
    -ms-overflow-style: none; /* IE and Edge */
    scrollbar-width: none; /* Firefox */
  }
  .comment_carousel::-webkit-scrollbar {
    display: none;
  }
  .event_img {
    height: 200px;
    object-fit: cover;
  }
  p.description,
  p.attending,
  p.schedule {
    font-size: 13px;
    color: rgba($color: #000000, $alpha: 0.54);
  }
  h6.interest {
    font-size: 0.74rem;
  }
}
</style>

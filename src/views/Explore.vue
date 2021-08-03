<template>
  <div class="main_c text-left">
    <div class="position-relative">
      <div class="stbg">
        <div class="bg_overlay">
          <h1 class="text-white font-weight-bold">Explore Interest</h1>
        </div>
      </div>
    </div>
    <b-container class="pb-5">
      <b-row class="justify-content-around p-2 p-sm-5 my-5">
        <b-col cols="4">
          <span class="d-flex align-items-center tpp">
            <b-img class="mr-2 tp" size="2.5rem" src="/img/learner.png"></b-img>
            <span>
              <span class="font-weight-bold">{{ users.length }}+</span> <br />
              <span class="font-weight-bold">Happy Learner</span>
            </span>
          </span>
        </b-col>
        <b-col cols="4">
          <span class="d-flex align-items-center tpp">
            <b-img class="mr-2 tp" size="2.5rem" src="/img/program.png"></b-img>
            <span>
              <span class="font-weight-bold">{{ courses.length }}+</span> <br />
              <span class="font-weight-bold">Online Programs</span>
            </span>
          </span>
        </b-col>
        <b-col cols="4">
          <span class="d-flex align-items-center tpp">
            <b-img class="mr-2 tp" size="2.5rem" src="/img/grp.png"></b-img>
            <span>
              <span class="font-weight-bold">{{ facilitators.length }}+</span>
              <br />
              <span class="font-weight-bold">Facilitators Onboard</span>
            </span>
          </span>
        </b-col>
      </b-row>
      <section class="py-5">
        <h4 class="mb-3 font-weight-bold text-center text-sm-left">
          Most Popular Courses
        </h4>
        <b-row
          class="justify-content-start pt-5 pb-1"
          v-if="mostenrolledcourse.length"
        >
          <b-col
            sm="4"
            class="mb-4 px-4 d-none d-sm-block"
            v-for="item in mostenrolledcourse.slice(0, 6)"
            :key="item.id"
          >
            <div
              class="course shadow-sm"
              @click="
                $router.push(`/explore/courses?course_id=${item.course.id}`)
              "
            >
              <div
                class="course_img"
                :style="{
                  backgroundImage: `url(${
                    item.course.cover
                      ? item.course.cover
                      : require('@/assets/images/default.png')
                  })`,
                }"
              ></div>
              <div class="course_text">
                <div class="d-flex justify-content-between">
                  <span
                    v-if="item.course.courseoutline"
                    class="p-2 rounded-pill text-white fs11"
                    :style="{
                      backgroundColor: JSON.parse(
                        item.course.courseoutline.knowledge_areas
                      ).color,
                    }"
                  >
                    <b-icon
                      class="mr-2"
                      :icon="
                        JSON.parse(item.course.courseoutline.knowledge_areas)
                          .icon
                      "
                    ></b-icon>
                    <span>{{
                      JSON.parse(item.course.courseoutline.knowledge_areas)
                        .value
                    }}</span></span
                  >
                  <span class="text-capitalize fs13">{{
                    item.course.type
                  }}</span>
                </div>
                <div class="border-bottom pt-2 pb-1">
                  <h6
                    class="
                      text-truncate text-truncate--2
                      mb-0
                      font-weight-bold
                      text-capitalize
                      overview-title
                    "
                  >
                    {{ item.course.title }}
                  </h6>

                  <div
                    v-if="item.course.courseoutline"
                    class="fs13 text-truncate text-truncate--2"
                    v-html="item.course.courseoutline.overview"
                  ></div>
                </div>
                <div class="info fs12">
                  <div class="d-flex">
                    <div class="mr-3">
                      <b-icon icon="people" class="mr-1"></b-icon>
                      <span>{{ item.count }}+</span>
                    </div>
                    <div class="mr-3">
                      <b-icon icon="eye" class="mr-1"></b-icon>
                      <span
                        >{{
                          item.course.viewcount
                            ? item.course.viewcount.count
                            : 0
                        }}
                        +</span
                      >
                    </div>
                    <div>
                      <b-icon icon="star-fill" class="mr-1"></b-icon>
                      <span>{{ item.course.review.length }} reviews</span>
                    </div>
                  </div>

                  <b-avatar size="sm" variant="light" :src="item.course.cover">
                  </b-avatar>
                </div>
              </div>
            </div>
          </b-col>
          <b-col cols="12" class="mb-4 px-sm-4 d-sm-none">
            <carousel
              :scrollPerPage="true"
              :perPage="1"
              :paginationEnabled="true"
            >
              <slide
                class="mb-4 px-4"
                v-for="item in mostenrolledcourse.slice(0, 6)"
                :key="item.id"
              >
                <div
                  class="course shadow-sm"
                  @click="
                    $router.push(`/explore/courses?course_id=${item.course.id}`)
                  "
                >
                  <div
                    class="course_img"
                    :style="{
                      backgroundImage: `url(${
                        item.course.cover
                          ? item.course.cover
                          : require('@/assets/images/default.png')
                      })`,
                    }"
                  ></div>
                  <div class="course_text">
                    <div class="d-flex justify-content-between">
                      <span
                        v-if="item.course.courseoutline"
                        class="p-2 rounded-pill text-white fs11"
                        :style="{
                          backgroundColor: JSON.parse(
                            item.course.courseoutline.knowledge_areas
                          ).color,
                        }"
                      >
                        <b-icon
                          class="mr-2"
                          :icon="
                            JSON.parse(
                              item.course.courseoutline.knowledge_areas
                            ).icon
                          "
                        ></b-icon>
                        <span>{{
                          JSON.parse(item.course.courseoutline.knowledge_areas)
                            .value
                        }}</span></span
                      >
                      <span class="text-capitalize fs13">{{
                        item.course.type
                      }}</span>
                    </div>
                    <div class="border-bottom pt-2 pb-1">
                      <h6
                        class="
                          text-truncate text-truncate--2
                          mb-0
                          font-weight-bold
                          text-capitalize
                          overview-title
                        "
                      >
                        {{ item.course.title }}
                      </h6>

                      <div
                        v-if="item.course"
                        class="fs13 text-truncate text-truncate--2"
                      >
                        {{ item.course.description }}
                      </div>
                    </div>
                    <div class="info fs12">
                      <div class="d-flex">
                        <div class="mr-3">
                          <b-icon icon="people" class="mr-1"></b-icon>
                          <span>{{ item.count }}+</span>
                        </div>
                        <div class="mr-3">
                          <b-icon icon="eye" class="mr-1"></b-icon>
                          <span
                            >{{
                              item.course.viewcount
                                ? item.course.viewcount.count
                                : 0
                            }}
                            +</span
                          >
                        </div>
                        <div>
                          <b-icon icon="star-fill" class="mr-1"></b-icon>
                          <span>{{ item.course.review.length }} reviews</span>
                        </div>
                      </div>

                      <b-avatar
                        size="sm"
                        variant="light"
                        :src="item.course.cover"
                      >
                      </b-avatar>
                    </div>
                  </div>
                </div>
              </slide>
            </carousel>
          </b-col>
        </b-row>

        <div class="text-center text-dark-green">
          <span @click="$router.push('/explore/courses')" class="cursor-pointer"
            >Load more...</span
          >
        </div>
      </section>
      <section class="text-center mb-5 py-5">
        <h4 class="mb-4">Explore Interest</h4>

        <p class="px-2 px-sm--5">
          There are several interest to be explored from health,
          entreprenuership, lifestyle , connection explore different areas of
          interest that can help improve your business skills
        </p>

        <b-row class="py-4">
          <b-col
            class="mb-5 cursor-pointer"
            cols="4"
            sm="2"
            @click="$router.push('/interests/Literature')"
            ><b-img src="/img/one.png" class="mb-2 interest"></b-img>
            <h6 class="font-weight-bold">Literature</h6></b-col
          >
          <b-col class="mb-5 cursor-pointer" cols="4" sm="2"
            ><b-img
              src="/img/two.png"
              @click="$router.push('/interests/Politics')"
              class="mb-2 interest"
            ></b-img>
            <h6 class="font-weight-bold">Politics</h6>
          </b-col>
          <b-col class="mb-5 cursor-pointer" cols="4" sm="2"
            ><b-img
              src="/img/three.png"
              @click="$router.push('/interests/Sports')"
              class="mb-2 interest"
            ></b-img>
            <h6 class="font-weight-bold">Sports</h6></b-col
          >
          <b-col class="mb-5 cursor-pointer" cols="4" sm="2"
            ><b-img
              src="/img/four.png"
              @click="$router.push('/interests/Marketing')"
              class="mb-2 interest"
            ></b-img>
            <h6 class="font-weight-bold">Marketing</h6></b-col
          >
          <b-col class="mb-5 cursor-pointer" cols="4" sm="2"
            ><b-img
              src="/img/five.png"
              @click="$router.push('/interests/Health')"
              class="mb-2 interest"
            ></b-img>
            <h6 class="font-weight-bold">Health</h6></b-col
          >
          <b-col class="mb-5 cursor-pointer" cols="4" sm="2"
            ><b-img
              src="/img/six.png"
              @click="$router.push('/interests/Tech')"
              class="mb-2 interest"
            ></b-img>
            <h6 class="font-weight-bold">Tech</h6></b-col
          >
          <b-col class="mb-5 cursor-pointer" cols="4" sm="2"
            ><b-img
              src="/img/seven.png"
              @click="$router.push('/interests/Gaming')"
              class="mb-2 interest"
            ></b-img>
            <h6 class="font-weight-bold">Gaming</h6></b-col
          >
          <b-col class="mb-5 cursor-pointer" cols="4" sm="2"
            ><b-img
              src="/img/eight.png"
              @click="$router.push('/interests/Entrepreneurship')"
              class="mb-2 interest"
            ></b-img>
            <h6 class="font-weight-bold">Entrepreneurship</h6></b-col
          >
          <b-col class="mb-5 cursor-pointer" cols="4" sm="2"
            ><b-img
              src="/img/nine.png"
              @click="$router.push('/interests/News')"
              class="mb-2 interest"
            ></b-img>
            <h6 class="font-weight-bold">News</h6></b-col
          >
          <b-col class="mb-5 cursor-pointer" cols="4" sm="2"
            ><b-img
              src="/img/ten.png"
              @click="$router.push('/interests/Community')"
              class="mb-2 interest"
            ></b-img>
            <h6 class="font-weight-bold">Community</h6></b-col
          >
          <b-col class="mb-5 cursor-pointer" cols="4" sm="2"
            ><b-img
              src="/img/eleven.png"
              @click="$router.push('/interests/Art')"
              class="mb-2 interest"
            ></b-img>
            <h6 class="font-weight-bold">Art</h6>
          </b-col>
          <b-col class="mb-5 cursor-pointer" cols="4" sm="2"
            ><b-img
              src="/img/twelve.png"
              @click="$router.push('/interests/Law')"
              class="mb-2 interest"
            ></b-img>
            <h6 class="font-weight-bold">Law</h6></b-col
          >
        </b-row>
      </section>
      <section class="py-3 py-sm-5 mb-2 mb-sm-5">
        <b-row>
          <b-col sm="7" class="mb-3">
            <div class="d-flex justify-content-between">
              <div>
                <h6 class="font-weight-bold">Trending Discussions</h6>
                <small
                  @click="$router.push('/discussions')"
                  class="cursor-pointer"
                  >View all {{ discussions.length }} discussions</small
                >
              </div>
              <div>
                <b-button
                  size="sm"
                  @click="$router.push('/discussions')"
                  variant="dark-green"
                  >View discussions</b-button
                >
              </div>
            </div>
            <div class="py-5" v-if="trending.length">
              <div
                class="d-flex mb-2"
                v-for="(item, id) in trending.slice(0, 5)"
                :key="id"
              >
                <div class="d-flex w-75 pr-4">
                  <b-avatar
                    v-if="item.admin"
                    :src="item.admin.profile"
                    class="mr-3"
                    size="3rem"
                  ></b-avatar>
                  <b-avatar
                    v-if="item.user"
                    :src="item.user.profile"
                    class="mr-3"
                    size="3rem"
                  ></b-avatar>
                  <b-avatar
                    v-if="item.facilitator"
                    :src="item.facilitator.profile"
                    class="mr-3"
                    size="3rem"
                  ></b-avatar>
                  <div class="line-1">
                    <span
                      class="fs14 font-weight-bold cursor-pointer"
                      @click="$router.push(`/discussion/${item.id}`)"
                      >{{ item.name }}</span
                    >
                    <br />
                    <span class="text-muted fs11" v-if="item.admin"
                      ><span class="mr-2">{{ item.admin.name }}</span>
                      <span class="mr-2">{{
                        $moment(item.created_at).fromNow()
                      }}</span>
                      <br />
                      <span
                        >{{ item.discussionmessage.length }} replies</span
                      ></span
                    >
                    <span class="text-muted fs11" v-if="item.user"
                      ><span class="mr-2">{{ item.user.name }}</span>
                      <span class="mr-2">{{
                        $moment(item.created_at).fromNow()
                      }}</span>
                      <span
                        >{{ item.discussionmessage.length }} replies</span
                      ></span
                    >
                    <span class="text-muted fs11" v-if="item.facilitator"
                      ><span class="mr-2">{{ item.facilitator.name }}</span>
                      <span class="mr-2">{{
                        $moment(item.created_at).fromNow()
                      }}</span>
                      <span
                        >{{ item.discussionmessage.length }} replies</span
                      ></span
                    >
                  </div>
                </div>
                <div class="w-25" v-if="item.discussionmessage.length">
                  <b-avatar-group size="30px">
                    <span
                      v-for="(item, idx) in item.discussionmessage.slice(0, 3)"
                      :key="idx"
                      style="
                        width: 30px;
                        margin-left: calc(-4.5px);
                        margin-right: calc(-4.5px);
                      "
                    >
                      <b-avatar
                        v-if="item.admin"
                        :src="item.admin.profile"
                      ></b-avatar>
                      <b-avatar
                        v-if="item.user"
                        :src="item.user.profile"
                      ></b-avatar>
                      <b-avatar
                        v-if="item.facilitator"
                        :src="item.facilitator.profile"
                      ></b-avatar>
                    </span>
                  </b-avatar-group>
                </div>
              </div>
            </div>
          </b-col>
          <b-col sm="5">
            <h6 class="mb-2 font-weight-bold">Top Contributors</h6>
            <p class="">
              See our users who have been active contibutors to discussions
            </p>
            <div v-if="filterContributors.length">
              <div
                class="d-flex w-75 pr-4 mb-3"
                v-for="(item, id) in filterContributors"
                :key="id"
              >
                <b-avatar
                  v-if="item.admin"
                  :src="item.admin.profile"
                  class="mr-3"
                  size="2.3rem"
                ></b-avatar>
                <b-avatar
                  v-if="item.user"
                  :src="item.user.profile"
                  class="mr-3"
                  size="2.3rem"
                ></b-avatar>
                <b-avatar
                  v-if="item.facilitator"
                  :src="item.facilitator.profile"
                  class="mr-3"
                  size="2.3rem"
                ></b-avatar>
                <div v-if="item.admin" class="line-height-1_2">
                  <span class="fs14 font-weight-bold">{{
                    item.admin.name
                  }}</span>
                  <br />
                  <span class="text-muted fs11"
                    >{{ item.count }} contributions</span
                  >
                </div>
                <div v-if="item.facilitator" class="line-height-1_2">
                  <span
                    class="fs14 font-weight-bold"
                    @click="$router.push(`/profile/f/${item.facilitator.id}`)"
                    >{{ item.facilitator.name }}</span
                  >
                  <br />
                  <span class="text-muted fs11"
                    >{{ item.count }} contributions</span
                  >
                </div>
                <div v-if="item.user" class="line-height-1_2">
                  <span
                    class="fs14 font-weight-bold"
                    @click="$router.push(`/profile/u/${item.user.id}`)"
                    >{{ item.user.name }}</span
                  >
                  <br />
                  <span class="text-muted fs11"
                    >{{ item.count }} contributions</span
                  >
                </div>
              </div>
            </div>
          </b-col>
        </b-row>
      </section>
      <section class="py-3 py-sm-5">
        <b-row>
          <b-col sm="8" class="mb-4 mb-sm-0">
            <div class="d-flex justify-content-between">
              <h6 class="mb-5 font-weight-bold">Feeds</h6>
              <router-link to="/feeds" class="text-dark-green"
                ><small>View all feeds</small></router-link
              >
            </div>

            <div v-if="showFeeds">
              <div v-if="feeds.length">
                <div
                  v-for="(feed, index) in feeds.slice(0, 4)"
                  :key="index"
                  class="border bg-white rounded-8 mb-2"
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
                            {{ feed.admin.name }} <br />
                          </div>
                          <small
                            v-if="feed.admin.state"
                            class="text-muted font-weight-normal"
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
                            {{ feed.user.name }}
                          </div>
                          <small
                            v-if="feed.user.state"
                            class="text-muted font-weight-normal"
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
                            {{ feed.facilitator.name }}
                          </div>
                          <small
                            v-if="feed.facilitator.state"
                            class="text-muted font-weight-normal"
                            >{{ feed.facilitator.state }}</small
                          >
                        </span>
                      </div>
                    </div>
                    <b-dropdown
                      v-if="
                        feed.user && feed.user.id == $store.getters.learner.id
                      "
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
                          feed.user && feed.user.id == $store.getters.learner.id
                        "
                        >Delete</b-dropdown-item
                      >
                    </b-dropdown>
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
                        <cld-transformation
                          width="auto"
                          height="500"
                          aspect_ratio="16:9"
                          crop="fill"
                        />
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
                            class="fs10 text-dark-green"
                            size="sm"
                            variant="lighter-green"
                            >{{ tag.text }}</b-badge
                          >
                        </b-col>
                      </b-row>
                    </div>
                  </div>
                  <div class="interactions text-left px-3 py-2 border-bottom">
                    <span class="mr-3 cursor-pointer">
                      <b-icon
                        :icon="
                          feed.stars.find(
                            (item) =>
                              item.star &&
                              item.user_id == $store.getters.learner.id
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
                    <span class="mr-3 cursor-pointer"
                      ><b-icon
                        :icon="
                          feed.likes.find(
                            (item) =>
                              item.like &&
                              item.user_id == $store.getters.learner.id
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
                  </div>
                  <div
                    class="comments px-3 pt-2 border-bottom text-left"
                    v-if="feed.comments.length"
                  >
                    <span
                      v-if="feed.comments.length"
                      class="comment_header mb-2 cursor-pointer"
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
                            @click="$router.push(`/profile/u/${item.user.id}`)"
                            v-if="item.user"
                          >
                            {{ item.user.name }}</span
                          >
                          <span
                            class="comment_name mr-2 hover_green"
                            @click="
                              $router.push(`/profile/f/${item.facilitator.id}`)
                            "
                            v-if="item.facilitator"
                          >
                            {{ item.facilitator.name }}</span
                          >

                          <span class="comment_text">{{ item.comment }}</span>
                        </div>
                        <div>
                          <span class="comment_mins"
                            >{{ $moment(item.created_at).fromNow() }}
                          </span>
                        </div>
                      </div>
                    </div>
                  </div>

                  <div class="interact text-left px-3 pb-1">
                    <b-input-group class="mt-1">
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
                      <template #prepend class="d-none d-md-block">
                        <b-input-group-text
                          class="border-0 bg-transparent d-none d-md-block"
                        >
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
                        size="sm"
                        autocomplete="off"
                        autocorrect="off"
                        rows="1"
                        v-model="comment.comment"
                        placeholder="Add comment"
                        class="border-0 no-focus"
                      ></b-form-input>
                    </b-input-group>
                  </div>
                </div>
                <div class="text-center mt-2">
                  <router-link to="/feeds" class="text-dark-green"
                    ><small>View all feeds</small></router-link
                  >
                </div>
              </div>
              <div v-else class="text-center admin_tab p-3 p-sm-5">
                <div>
                  <b-img :src="require('@/assets/images/creator.svg')"></b-img>
                  <h6 class="text-muted my-3 fs14">
                    It appears you have no event,
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
          <b-col sm="4" class="p-3">
            <div class="text-left">
              <h6 class="mb-3 fs12">Trending in Last 24hrs</h6>
              <div v-if="trendingFeed.length" class="py-3">
                <div
                  v-for="(item, id) in trendingFeed.slice(0, 20)"
                  :key="id"
                  class="mb-3"
                >
                  <div
                    class="trending_name"
                    @click="$router.push(`/feed/${item.name}`)"
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
      </section>
      <section class="py-3 py-sm-5">
        <div class="d-flex justify-content-between">
          <h6 class="mb-5 font-weight-bold">Upcoming Events</h6>
          <router-link to="/events" class="text-dark-green"
            ><small>View all events</small></router-link
          >
        </div>

        <div v-if="showEvents">
          <div class="events" v-if="events.length">
            <carousel
              :perPage="1"
              :paginationEnabled="true"
              :autoplay="true"
              :speed="1000"
              :autoplayTimeout="5000"
              :loop="true"
              class="p-3"
            >
              <slide
                v-for="item in events
                  .filter((item) => item.status == 'pending')
                  .slice(0, 5)"
                :key="item.id"
                class="bg-white"
              >
                <div class="border rounded text-left position-relative shadow">
                  <b-img fluid-grow :src="item.cover" class="event_img"></b-img>
                  <div class="px-3 py-3">
                    <p class="mb-2">
                      <b-icon icon="calendar2-check" class="mr-2"></b-icon>
                      {{ item.schedule }}
                    </p>
                    <p class="mb-1">
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
                    <h4 class="text-capitalize text-dark mb-0 text-left">
                      {{ item.title }}
                    </h4>
                    <span
                      class="cursor-pointer"
                      @click="$router.push(`/event/${item.id}`)"
                    >
                      <span class="viewevent d-none d-sm-inline">
                        View Event
                      </span>
                      <b-icon icon="chevron-double-right"></b-icon>
                    </span>
                  </div>
                </div>
              </slide>
            </carousel>
          </div>
          <div v-else class="text-center admin_tab p-3 p-sm-5">
            <div>
              <b-img :src="require('@/assets/images/creator.svg')"></b-img>
              <h6 class="text-muted my-3 fs14">
                It appears you have no event,
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
      </section>
    </b-container>
  </div>
</template>
<script>
import interest from "@/components/insight.js";
import EmojiPicker from "vue-emoji-picker";
export default {
  data() {
    return {
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
      interest: [],
      contributors: [],
      showFeeds: false,
      trendingFeed: [],
      feeds: [],
    };
  },
  mounted() {
    this.getfeeds();
    this.mostenrolled();
    this.getprograms();
    this.getlearners();
    this.getevents();
    this.getfacilitators();
    this.getdiscussions();
    this.getcontributors();
    this.getTrendingFeeds();
    this.interest = interest;
  },
  components: {
    EmojiPicker,
  },
  computed: {
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
  },
  methods: {
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
    getprograms() {
      this.$http.get(`${this.$store.getters.url}/guest/courses`).then((res) => {
        if (res.status == 200) {
          this.courses = res.data;
        }
      });
    },
    getTrendingFeeds() {
      this.$http
        .get(`${this.$store.getters.url}/guest/trending/feeds`)
        .then((res) => {
          if (res.status == 200) {
            this.trendingFeed = res.data;
          }
        });
    },
    getfeeds() {
      this.$http
        .get(`${this.$store.getters.url}/guest/feeds?page=${this.page}`)
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
    getlearners() {
      this.$http
        .get(`${this.$store.getters.url}/guest/learners`)
        .then((res) => {
          if (res.status == 200) {
            this.users = res.data;
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

        return extension[0];
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
    insertcomment(emoji) {
      this.comment.comment += emoji + "";
    },
    post() {
      // this.$router.push("/login");
      this.$toast.info("Login to continue");
    },
    addcomment() {
      // this.$router.push("/login");
      this.$toast.info("Login to continue");
    },
    toggleLike() {
      // this.$router.push("/login");
      this.$toast.info("Login to continue");
    },
    toggleStar() {
      // this.$router.push("/login");
      this.$toast.info("Login to continue");
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
.stbg {
  width: 100%;
  height: 250px;
  background-repeat: no-repeat;
  background-image: linear-gradient(to right, #388087 0%, #388087 100%),
    url("/img/explore_banner.jpg");
  background-blend-mode: overlay;
  background-size: cover;
  background-position: center;
}
.bg_overlay {
  height: 250px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(56, 128, 135, 0.85);
}
.main_c {
  background: #f7f7f7;
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
.events {
  border-radius: 8px;
  overflow: hidden;
}
.event_img {
  height: 400px;
  object-fit: cover;
}
@media (max-width: 600px) {
  .interest {
    width: 40px;
  }
  h6 {
    font-size: 14px;
  }
  .tpp span span {
    font-size: 12px;
    line-height: 1.3;
  }
  .tpp span {
    line-height: 1;
  }
  .tp {
    width: 30px;
  }
}
</style>

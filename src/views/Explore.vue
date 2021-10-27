<template>
  <div class="main_c text-left">
    <section class="explore_banner">
      <h1>Get N-circled</h1>
    </section>

    <div class="bg-white position-relative">
      <div class="explore_info">
        <b-container>
          <b-row>
            <b-col md="4" class="mb-4 mb-md-0">
              <div class="explore_box shadow rounded">
                <p class="font-weight-bold">Explore</p>
                <b-img
                  :src="require('@/assets/images/spaceman.svg')"
                  alt="exlplore"
                ></b-img>

                <p>
                  Discover people, knowledge and opportunities across interets.
                </p>
              </div>
            </b-col>
            <b-col md="4" class="mb-4 mb-md-0">
              <div class="explore_box shadow rounded">
                <p class="font-weight-bold">Engage</p>
                <b-img
                  :src="require('@/assets/images/switch.svg')"
                  alt="engage"
                ></b-img>

                <p>Connect with your tribe and feel right at home.</p>
              </div>
            </b-col>
            <b-col md="4" class="mb-4 mb-md-0">
              <div class="explore_box shadow rounded">
                <p class="font-weight-bold">Evolve</p>
                <b-img
                  :src="require('@/assets/images/connection.svg')"
                  alt="evolve"
                ></b-img>

                <p>
                  Nothing better than a tribe that grows together. Share, learn
                  and soar
                </p>
              </div>
            </b-col>
          </b-row>
        </b-container>
      </div>
      <div class="spacer"></div>
      <section class="py-5">
        <b-container>
          <div class="text-center trending mb-5">
            <h2 class="mb-5">
              <span> Popular Tribes</span>
            </h2>
            <p>Find your tribe and feel right at home.</p>
          </div>

          <b-container>
            <b-row class="d-none d-md-flex">
              <b-col
                sm="4"
                v-for="(n, id) in tribes.slice(0, 6)"
                :key="id"
                class="mb-4"
              >
                <b-popover :target="`popover-${id}`" triggers="hover">
                  <template #title> {{ n.name }} </template>
                  <p class="fs13 text-capitalize mb-2">
                    Access :
                    <span v-if="n.type == 'free'">{{ n.type }}</span>
                    <span v-else>{{ n.amount | currencyFormat }}</span>
                  </p>
                  <p class="fs13" style="min-width: 150px">
                    {{ n.description }}
                  </p>
                  <p class="fs14 text-muted mb-1">
                    <font-awesome-icon :icon="myusers" size="1x" class="icon" />
                    {{ n.users }}
                  </p>
                  <b-button
                    v-if="n.type == 'free'"
                    block
                    variant="dark-green"
                    size="sm"
                    @click="entertribe(n.id)"
                  >
                    {{ n.isMember ? "Engage" : "Join" }}</b-button
                  >
                  <div v-else>
                    <b-button
                      v-if="n.isMember"
                      block
                      variant="dark-green"
                      size="sm"
                      @click="entertribe(n.id)"
                    >
                      <font-awesome-icon :icon="signIn"
                    /></b-button>
                    <b-button
                      v-else
                      block
                      variant="dark-green"
                      size="sm"
                      @click="purchase(n.id)"
                    >
                      <font-awesome-icon :icon="signIn"
                    /></b-button>
                  </div>
                </b-popover>
                <div class="tribe_box rounded" :id="`popover-${id}`">
                  <div
                    class="
                      d-flex
                      align-items-center
                      justify-content-center
                      rounded
                    "
                  >
                    <span class="tribe_name text-white">{{ n.name }}</span>
                  </div>

                  <div
                    class="
                      d-flex
                      justify-content-between
                      align-items-center
                      bg-white
                      tribe_member_container
                    "
                  >
                    <span class="d-flex align-items-center fs14">
                      <span class="mr-1">{{ n.users }}</span>
                      <span class="">
                        {{ n.users > 1 ? "members" : "member" }}</span
                      >
                    </span>
                  </div>
                  <span class="tribe_circle cursor-pointer">
                    <b-avatar size="lg" :src="n.cover"></b-avatar>
                  </span>
                </div>
              </b-col>
            </b-row>
            <b-row class="d-md-none">
              <b-col>
                <carousel
                  :perPage="2"
                  :scrollPerPage="true"
                  :paginationEnabled="true"
                  :spacePadding="15"
                  :perPageCustom="[
                    [600, 2],
                    [768, 3],
                  ]"
                  v-if="tribes.length"
                >
                  <slide
                    v-for="(n, id) in tribes.slice(0, 6)"
                    :key="id"
                    class="mb-4 px-1"
                  >
                    <b-popover :target="`popoverm-${id}`" triggers="hover">
                      <template #title> {{ n.name }} tribe</template>

                      <p class="fs13">{{ n.description }}</p>
                      <p class="fs13 text-muted mb-1">{{ n.users }} users</p>
                      <!-- <p class="fs13 text-muted mb-1">
                        {{ n.discussions.length }} discussions
                      </p>

                      <p class="fs13 text-muted mb-3">
                        {{ n.events.length }} active events
                      </p> -->
                      <b-button
                        block
                        variant="lighter-green"
                        size="sm"
                        @click="entertribe(n.id)"
                        >Join</b-button
                      >
                    </b-popover>
                    <div class="tribe_box rounded" :id="`popoverm-${id}`">
                      <div
                        class="d-flex align-items-center justify-content-center"
                      >
                        <span class="tribe_name text-white">{{ n.name }}</span>
                      </div>

                      <div
                        class="
                          d-flex
                          justify-content-between
                          align-items-center
                          bg-white
                          tribe_member_container
                        "
                      >
                        <span class="d-flex align-items-center">
                          <span class="mr-1">{{ n.users }}</span>
                          <span> {{ n.users > 1 ? "members" : "member" }}</span>
                        </span>
                      </div>
                      <span class="tribe_circle cursor-pointer">
                        <b-avatar :src="n.cover"></b-avatar>
                      </span>
                    </div>
                  </slide>
                </carousel>
              </b-col>
            </b-row>
          </b-container>

          <div class="text-center text-dark-green fs12">
            <span
              @click="$router.push('/explore/community')"
              class="cursor-pointer"
              >Load more...</span
            >
          </div>
        </b-container>
      </section>
      <section class="py-3 py-sm-4 mb-2 mb-sm-5">
        <b-container>
          <b-row>
            <b-col class="mb-3">
              <div>
                <div class="text-center trending">
                  <h2 class="mb-5">
                    <span> Trending Discussions</span>
                  </h2>
                  <p>
                    Stay informed and lend your voice to trending issues and
                    discussions. Your tribe needs you!
                  </p>
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
                @click="$router.push(`/member/explore/discussion/${item.id}`)"
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
                        backgroundColor: item.category.color,
                      }"
                    >
                      <b-icon
                        icon="circle-fill"
                        class="mr-1"
                        font-scale=".5"
                      ></b-icon>
                      {{ item.category.value }}</b-badge
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
            <carousel :perPage="1" class="mob-carousel">
              <slide
                v-for="(item, id) in trending.slice(0, 6)"
                :key="id"
                class="px-2"
              >
                <div
                  class="discussion_container position-relative"
                  @click="$router.push(`/member/explore/discussion/${item.id}`)"
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
                          backgroundColor: item.category.color,
                        }"
                      >
                        <b-icon
                          icon="circle-fill"
                          class="mr-1"
                          font-scale=".5"
                        ></b-icon>
                        {{ item.category.value }}</b-badge
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
                          shadow-sm
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
            @click="$router.push('/member/explore/discussions')"
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
              <span> Popular Posts</span>
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
                        <div class="mr-2 mb-1 feedname" v-if="feed.user">
                          <b-avatar
                            size="1.8rem"
                            class="mr-2"
                            :src="feed.user.profile"
                          ></b-avatar>
                          <span
                            @click="
                              $router.push(
                                `/member/profile/${feed.user.username}`
                              )
                            "
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
                          >View</b-dropdown-item
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
                    <div class="interactions text-left px-3 py-2">
                      <span
                        class="mr-2 cursor-pointer"
                        @click="toggleLike(feed.id, index)"
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
                          class="mr-1"
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
                                $router.push(`/profile/${item.user.username}`)
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
                            <div>
                              <small>
                                <b-icon
                                  class="mr-2"
                                  :icon="
                                    item.feedcommentlikes
                                      ? 'heart-fill'
                                      : 'heart'
                                  "
                                  :class="
                                    item.feedcommentlikes ? 'text-danger' : ''
                                  "
                                ></b-icon>
                              </small>
                            </div>
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
                    <router-link to="/member/feeds" class="text-dark-green"
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
          <div class="text-center trending mb-3">
            <h2 class="mb-5">
              <span> Explore Interests</span>
            </h2>
            <p>
              Discover people, knowledge and opportunities across interests.
            </p>
          </div>

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
                        <p
                          class="mb-1 schedule font-weight-bold"
                          v-if="item.tribe"
                        >
                          {{ item.tribe.name }} tribe
                        </p>
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
                <router-link to="/explore/events" class="text-dark-green"
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
                              $router.push(
                                `/member/profile/${item.user.username}`
                              )
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
                            @click="likecomment(item.id, index, item.user.id)"
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
                                    `/member/profile/${rep.user.username}`
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
                                :icon="
                                  rep.feedcommentreplylikes
                                    ? 'heart-fill'
                                    : 'heart'
                                "
                                :class="
                                  rep.feedcommentreplylikes ? 'text-danger' : ''
                                "
                                @click="
                                  likecommentreply(
                                    rep.id,
                                    id,
                                    index,
                                    rep.user.id
                                  )
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
              v-for="(item, index) in alllikes.likes.filter((val) => val.like)"
              :key="index"
            >
              <div class="flex-1">
                <div class="flex-1 pr-2">
                  <div class="d-flex mb-1" v-if="item.user">
                    <div
                      class="d-flex flex-1"
                      @click="
                        $router.push(`/member/profile/${item.user.username}`)
                      "
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
    <b-modal id="replycomment" hide-footer>
      <template #modal-title>
        <div
          class="font-weight-bold"
          v-if="replycomment"
          v-html="replycomment.comment"
        ></div>
      </template>
      <b-textarea class="mb-3" v-model="commentreply"> </b-textarea>
      <b-button variant="dark-green" @click="postreply" size="sm"
        >Reply</b-button
      >
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
import { faUsers, faSignInAlt } from "@fortawesome/free-solid-svg-icons";
export default {
  data() {
    return {
      report_id: null,
      report_type: null,
      index: null,
      replycomment: null,
      commentreply: "",
      signIn: faSignInAlt,
      myusers: faUsers,
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
      tribes: [],
      showTribes: false,
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
    this.gettribes();
    this.getmembers();
    this.getevents();
    this.getfacilitators();
    this.getdiscussions();
    this.getcontributors();
    // this.getTrendingFeeds();
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
    isMember(arr) {
      return arr.some((item) => item.id == this.$store.getters.member.id);
    },
    entertribe(id) {
      if (!this.auth) {
        this.$toast.error("login to access");
        return;
      }
      var details = {
        tribe_id: id,
        user: this.$store.getters.member,
      };
      localStorage.removeItem("tribe");
      localStorage.setItem("tribe", id);
      this.$store.dispatch("checkTribe", details).then((res) => {
        if (res.status == 200 && res.data.message == "found") {
          window.location.href = `/member/tribe/discussions/${id}`;
        } else {
          this.$bvModal
            .msgBoxConfirm("Do you wish to join this tribe?")
            .then((val) => {
              if (val) {
                this.$store.dispatch("joinTribe", details).then((res) => {
                  if (res.status == 200 && res.data.message == "successful") {
                    this.$toast.success("Joined successfully");
                    window.location.href = `/member/tribe/discussions/${id}`;
                  }
                });
              }
            });
        }
      });
    },
    purchase(id) {
      this.$router.push(`/member/order?id=${id}&type_payment=tribe`);
    },
    likeimage(index) {
      this.toggleOn = index;

      setTimeout(() => {
        this.toggleOn = null;
      }, 1500);
    },
    likecomment(id, index, userId) {
      if (!this.auth) {
        this.$toast.error("login to access");
        return;
      }
      if (this.$store.getters.member.id != userId) {
        return;
      }
      this.$http
        .post(
          `${this.$store.getters.url}/feed/comment/like`,
          { feed_comment_id: id },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.data === "success") {
            this.allcomments.comments[index].feedcommentlikes = res.data;
          } else {
            this.allcomments.comments[index].feedcommentlikes = null;
          }

          this.gettrendingfeeds();
        });
    },
    likecommentreply(id, index, idx, userId) {
      if (!this.auth) {
        this.$toast.error("login to access");
        return;
      }
      if (this.$store.getters.member.id != userId) {
        return;
      }
      this.$http
        .post(
          `${this.$store.getters.url}/feed/comment/reply/like`,
          { feed_comment_reply_id: id },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.data === "success") {
            this.allcomments.comments[idx].feedcommentreplies[
              index
            ].feedcommentreplylikes = res.data;
          } else {
            this.allcomments.comments[idx].feedcommentreplies[
              index
            ].feedcommentreplylikes = null;
          }
        });
    },
    postreply() {
      if (!this.commentreply) {
        this.$toast.info("Cannot be empty");
        return;
      }
      var data = {
        feed_comment_id: this.replycomment.id,
        message: this.commentreply,
        feed_id: this.replycomment.feed_id,
      };

      this.$http
        .post(`${this.$store.getters.url}/feed/comment/reply`, data, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.$toast.success("Reply successful ");

            this.gettrendingfeeds();

            this.allcomments.comments[
              this.comment_index
            ].feedcommentreplies.unshift(res.data);
            this.commentreply = "";
            this.$bvModal.hide("replycomment");
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    handlereplycomment(comment, comment_index) {
      this.replycomment = comment;
      this.comment_index = comment_index;

      this.$bvModal.show("replycomment");
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
    gettribes() {
      this.$http
        .get(`${this.$store.getters.url}/guest/tribes`)
        .then((res) => {
          if (res.status == 200) {
            this.tribes = res.data;
            this.showTribes = true;
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
            this.gettrendingfeeds();
            this.filteredFeeds[index].comment = " ";

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
.container {
  max-width: 1000px;
}
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

.explore_info {
  position: absolute;
  z-index: 2;
  width: 100%;
  top: -2%;
  width: 100%;
}
.explore_box {
  height: 300px;
  width: 100%;
  background: white;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  padding: 15px;
  text-align: center;
  img {
    width: 40%;
    margin-bottom: 20px;
  }
  p {
    font-weight: 500;
    font-size: 15px;
  }
}
.spacer {
  height: 260px;
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
  p {
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
  .explore_info {
    position: relative;
    padding-top: 30px;
    width: 80%;
    margin: 0 auto;
  }
  .spacer {
    height: 30px;
  }
  .explore_box {
    height: auto;
    img {
      width: 35%;
    }
    p {
      font-weight: 500;
      font-size: 13px;
    }
  }
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

/* eslint-disable no-unused-vars */
<template>
  <b-container fluid class="px-0 px-sm-4">
    <div class="pb-5 pt-sm-4">
      <b-modal id="feed" hide-footer centered title="Create feed" size="md">
        <div class="mb-4">
          <div class="wrapper mb-2">
            <div class="w-100 d-flex commentreply_container">
              <a-mentions
                v-model="feed.message"
                :placeholder="
                  'What\'s on your mind ' + $store.getters.member.username + '?'
                "
                class="mb-3 commentreply w-100 rounded border-0"
              >
                <a-mentions-option
                  v-for="(item, id) in connections"
                  :key="id"
                  :value="item"
                >
                  {{ item }}
                </a-mentions-option>
              </a-mentions>
            </div>
          </div>
          <emoji-picker
            class="d-none d-md-block"
            @emoji="insertfeed"
            :search="search"
          >
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
            <div slot="emoji-picker" slot-scope="{ emojis, insert }">
              <div class="emoji-picker">
                <div class="emoji-picker__search">
                  <input type="text" v-model="search" v-focus />
                </div>
                <div>
                  <div v-for="(emojiGroup, category) in emojis" :key="category">
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
        <div>
          <h6 class="text-muted fs11 mb-2">Add tags</h6>
          <multi-select
            :options="options"
            :selected-options="feed.tags"
            placeholder="Choose tag"
            @select="onSelect"
          >
          </multi-select>
        </div>
        <div class="d-flex justify-content-around event_video my-4">
          <div @click="showFeedUpload('image', true)">
            <b-img
              :src="require('@/assets/images/event.svg')"
              width="18px"
              class="mr-1 cursor-pointer"
            ></b-img>
            <span class="cursor-pointer"> Image</span>
          </div>
          <div @click="showFeedUpload('video', false)">
            <b-img
              :src="require('@/assets/images/youtube.svg')"
              width="18px"
              class="mr-1 cursor-pointer"
            ></b-img>
            <span class="cursor-pointer"> Video</span>
          </div>
        </div>

        <div
          class="d-flex justify-content-around my-3 border rounded"
          v-if="isShown"
        >
          <multi-upload
            @getUploads="getUploads"
            :type="type"
            :isMultiple="isMultiple"
            :id="type"
          >
          </multi-upload>
        </div>
        <b-button @click="post" block variant="dark-green" :disabled="disabled"
          >Post</b-button
        >
      </b-modal>

      <b-modal id="feededit" hide-footer centered title="Edit feed" size="md">
        <div class="mb-4">
          <div class="wrapper mb-2">
            <div class="w-100 d-flex commentreply_container">
              <a-mentions
                v-model="feed.message"
                :placeholder="
                  'What\'s on your mind ' + $store.getters.member.username + '?'
                "
                class="mb-3 commentreply w-100 rounded border-0"
              >
                <a-mentions-option
                  v-for="(item, id) in connections"
                  :key="id"
                  :value="item"
                >
                  {{ item }}
                </a-mentions-option>
              </a-mentions>
            </div>
          </div>
          <emoji-picker
            class="d-none d-md-block"
            @emoji="insertfeed"
            :search="search"
          >
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
            <div slot="emoji-picker" slot-scope="{ emojis, insert }">
              <div class="emoji-picker">
                <div class="emoji-picker__search">
                  <input type="text" v-model="search" v-focus />
                </div>
                <div>
                  <div v-for="(emojiGroup, category) in emojis" :key="category">
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

        <b-button
          @click="updatepost"
          :disabled="disabled"
          block
          variant="dark-green"
          >Update post</b-button
        >
      </b-modal>

      <b-modal id="allcomments" hide-footer centered size="md">
        <template #modal-title>
          <div
            class="font-weight-bold"
            v-if="allcomments.length"
            v-html="commentFeed"
          ></div>
        </template>
        <div class="comments" v-if="allcomments.length">
          <label for="">Comments</label>
          <div class="comments">
            <div
              class="comment d-flex text-left mb-2"
              v-for="(item, index) in allcomments"
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
                                  `/me/profile/${item.user.username}`
                                )
                              "
                            >
                              {{ item.user.username }}
                            </div>
                            <div
                              class="comment_text"
                              :id="item.comment"
                              v-if="item.comment"
                              v-html="$options.filters.tagsfilter(item.comment)"
                            ></div>
                          </div>
                          <div class="d-flex justify-content-between">
                            <span
                              ><small
                                class="text-muted mr-2 cursor-pointer"
                                @click="handlereplycomment(item, index)"
                                >Reply
                              </small>

                              <small class="mini_like">
                                <span class="mr-1">{{
                                  item.likeCount ? item.likeCount : ""
                                }}</span>
                                <b-icon
                                  :icon="item.isLiked ? 'heart-fill' : 'heart'"
                                  class="cursor-pointer text-danger"
                                  v-b-tooltip.hover
                                  title="Like comment"
                                  @click="
                                    likecomment(item.id, index, commentUser.id)
                                  "
                                ></b-icon> </small
                            ></span>
                            <span>
                              <small v-if="item.replyCount" class="mr-2"
                                >{{ item.replyCount }}
                                {{
                                  item.replyCount > 1 ? "replies" : "reply"
                                }}</small
                              >
                              <b-icon
                                icon="trash"
                                v-if="$store.getters.member.id === item.user_id"
                                @click="dropcomment(item.id, index)"
                              ></b-icon>
                            </span>
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
                  <div
                    class="p-2 bg-light rounded w-100"
                    v-if="item.replyCount"
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
                            <div class="d-flex align-items-center flex-1">
                              <p class="flex-1 mr-2 mb-1">
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
                                <span
                                  class="comment_text flex-1"
                                  v-if="rep.message"
                                  v-html="
                                    $options.filters.tagsfilter(rep.message)
                                  "
                                ></span>
                              </p>
                              <span class="mr-2 mini_like">
                                <span class="mr-2">{{
                                  rep.likeCount ? rep.likeCount : ""
                                }}</span>
                                <b-icon
                                  v-b-tooltip.hover
                                  title="Like reply"
                                  :icon="rep.isLiked ? 'heart-fill' : 'heart'"
                                  class="text-danger"
                                  @click="likecommentreply(rep.id, index, id)"
                                  font-scale=".8"
                                ></b-icon
                              ></span>
                              <b-icon
                                icon="trash"
                                v-if="$store.getters.member.id === rep.user_id"
                                @click="dropcommentreply(rep.id, index, id)"
                              ></b-icon>
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
                v-for="(item, index) in alllikes.likes.filter(
                  (val) => val.like
                )"
                :key="index"
              >
                <div class="flex-1">
                  <div class="flex-1 pr-2">
                    <div class="d-flex mb-1" v-if="item.user">
                      <div
                        class="d-flex flex-1"
                        @click="
                          $router.push(`/me/profile/${item.user.username}`)
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
      <b-container>
        <b-row>
          <b-col class="px-0">
            <div class="border bg-white py-3 px-2 p-sm-4 rounded-8 mb-1">
              <div class="d-flex align-items-center mb-3">
                <b-avatar
                  class="mr-2"
                  size="2.4rem"
                  :src="$store.getters.member.profile"
                ></b-avatar>

                <b-form-input
                  class="rounded-pill stat cursor-pointer"
                  size="lg"
                  readonly
                  @click="$bvModal.show('feed')"
                  :placeholder="
                    'What\'s on your mind ' +
                    $store.getters.member.username +
                    '?'
                  "
                ></b-form-input>
              </div>

              <div class="d-flex justify-content-around event_video">
                <div @click="toggleFeedAdd('image', true)">
                  <b-img
                    :src="require('@/assets/images/event.svg')"
                    width="18px"
                    class="mr-1 cursor-pointer"
                  ></b-img>
                  <span class="cursor-pointer"> Image</span>
                </div>
                <div @click="toggleFeedAdd('video', false)">
                  <b-img
                    :src="require('@/assets/images/youtube.svg')"
                    width="18px"
                    class="mr-1 cursor-pointer"
                  ></b-img>
                  <span class="cursor-pointer"> Video</span>
                </div>
                <Feelings user="member" @handleChange="handleChange">
                  <b-img
                    :src="require('@/assets/images/feeling.png')"
                    width="18px"
                    class="mr-1 cursor-pointer"
                  ></b-img>
                  <span class="cursor-pointer"> Expressions</span>
                </Feelings>
              </div>
            </div>
            <div>
              <Suggestions user="member" />
            </div>

            <div class="d-flex justify-content-center justify-content-md-end">
              <div class="d-flex align-items-center pl-3 mb-1">
                <div
                  class="pr-2 fs12 cursor-pointer"
                  :class="feedShown == 'recent' ? '' : 'text-muted'"
                  @click="feedShown = 'recent'"
                >
                  Recent
                </div>
                <span class="text-muted"> |</span>
                <div
                  class="pl-2 pr-2 fs12 cursor-pointer"
                  :class="feedShown == 'trending' ? '' : 'text-muted'"
                  @click="feedShown = 'trending'"
                >
                  Trending
                </div>
                <span class="text-muted"> |</span>
                <div
                  class="pl-2 fs12 cursor-pointer"
                  :class="feedShown == 'custom' ? '' : 'text-muted'"
                  @click="feedShown = 'custom'"
                >
                  Custom
                </div>
              </div>
            </div>

            <div v-if="showFeeds">
              <div v-if="filteredFeeds.length">
                <div class="feed-content">
                  <div
                    v-for="(feed, index) in filteredFeeds"
                    :key="index"
                    class="border bg-white rounded-8 mb-3 feed_contain"
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
                              $router.push(`/me/profile/${feed.user.username}`)
                            "
                            class="hover_green mr-1"
                          >
                            <div style="line-height: 1.2">
                              {{ feed.user.username }}
                            </div>
                            <small
                              v-if="feed.user.state"
                              class="text-muted font-weight-normal"
                              >{{ feed.user.state }}</small
                            >
                          </span>
                          <small class="text-muted fs10" v-if="feed.isEdited"
                            >Edited</small
                          >
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
                            font-scale="1.2"
                          ></b-icon>
                        </template>
                        <b-dropdown-item
                          class="fs12"
                          @click="$router.push(`/me/feed/${feed.id}`)"
                          >View</b-dropdown-item
                        >
                        <b-dropdown-item
                          v-if="
                            feed.message &&
                            feed.user &&
                            feed.user.id == $store.getters.member.id
                          "
                          class="fs12"
                          @click="feededit(feed, index)"
                          >Edit</b-dropdown-item
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
                        <b-dropdown-item
                          class="fs12"
                          v-if="feed.user.id !== $store.getters.member.id"
                          @click="handleReport(feed.id, 'feed')"
                          >Report post</b-dropdown-item
                        >
                      </b-dropdown>
                    </div>

                    <div v-if="feed.media && feed.media.length">
                      <div class="mb-4 position-relative w-100 media bg-white">
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
                        <b-carousel
                          v-if="feed.mediaType === 'image'"
                          id="carousel-fade"
                          style="text-shadow: 0px 0px 2px #000"
                          indicators
                          :interval="0"
                          class="w-100"
                        >
                          <b-carousel-slide
                            v-for="(item, id) in feed.media"
                            :key="id"
                            background="#fff"
                          >
                            <template #img>
                              <img
                                @dblclick.self="toggleLike(feed.id, index)"
                                class="w-100"
                                height="420"
                                :src="item"
                                alt="image"
                              />
                            </template>
                          </b-carousel-slide>
                        </b-carousel>
                        <video
                          @dblclick.self="toggleLike(feed.id, index)"
                          v-if="feed.mediaType === 'video'"
                          controls
                          width="100%"
                          height="420"
                          :src="feed.media[0]"
                        ></video>
                      </div>
                    </div>
                    <div class="text-left feed_text px-3">
                      <div
                        v-if="feed.message"
                        class="mb-1"
                        v-html="$options.filters.tagsfilter(feed.message)"
                      ></div>

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
                    <div class="interactions text-left px-3 py-1">
                      <span
                        class="mr-2 cursor-pointer d-flex align-items-center"
                        @click="toggleLike(feed.id, index)"
                      >
                        <b-icon
                          v-b-tooltip.hover
                          title="Like post"
                          font-scale="1.3"
                          :icon="feed.isLiked ? 'heart-fill' : 'heart'"
                          class="text-danger"
                        ></b-icon>
                      </span>

                      <span class="mr-3">
                        <b-icon
                          font-scale="1.3"
                          icon="chat"
                          class="mr-1"
                        ></b-icon>
                        <span
                          ><span>{{
                            feed.commentCount ? feed.commentCount : ""
                          }}</span></span
                        >
                      </span>
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
                    <div class="d-flex align-items-center">
                      <span
                        v-if="feed.likesCount"
                        class="liked_by px-3 border-bottom"
                        @click="showlikes(feed)"
                        v-html="getlikes(feed.likesCount)"
                      ></span>
                    </div>

                    <div
                      class="comments px-3 pt-2 text-left"
                      style="line-height: 1.6"
                      v-if="feed.commentCount"
                    >
                      <div class="all_comment mb-1">
                        <span
                          v-if="feed.comments.length"
                          class="comment_header cursor-pointer"
                          @click="getfeedcomments(feed)"
                        >
                          View {{ feed.commentCount }}
                          {{ feed.commentCount > 1 ? "comments" : "comment" }}
                        </span>
                        <div
                          class="comment d-flex text-left"
                          style="line-height: 1.2"
                          v-for="(item, idx) in feed.comments.slice(0, 2)"
                          :key="item.id"
                        >
                          <div class="flex-1 pr-2 mb-1" style="line-height: 1">
                            <span
                              class="comment_name mr-2 hover_green"
                              @click="
                                $router.push(
                                  `/me/profile/${item.user.username}`
                                )
                              "
                              v-if="item.user"
                            >
                              {{ item.user.username }}</span
                            >

                            <span
                              class="comment_text"
                              v-if="item.comment"
                              v-html="$options.filters.tagsfilter(item.comment)"
                            ></span>
                          </div>
                          <div>
                            <small class="mini_like">
                              <span class="mr-1">{{
                                item.likeCount ? item.likeCount : ""
                              }}</span>
                              <b-icon
                                class="mr-2 text-danger"
                                :icon="item.isLiked ? 'heart-fill' : 'heart'"
                                @click="
                                  likefeedcomment(
                                    item.id,
                                    index,
                                    idx,
                                    feed.user.id
                                  )
                                "
                              ></b-icon>
                            </small>
                            <span class="comment_mins"
                              >{{ $moment(item.created_at).fromNow() }}
                            </span>
                          </div>
                        </div>
                      </div>
                    </div>

                    <div class="interact text-left border">
                      <b-input-group class="">
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
                        <template #prepend class="">
                          <b-input-group-text class="border-0 bg-transparent">
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
                        <a-mentions
                          v-model="feed.comment"
                          type="text"
                          autocomplete="off"
                          placeholder="Leave a comment "
                          class="border-0 no-focus rounded-pill bg-light"
                        >
                          <a-mentions-option
                            v-for="(item, id) in connections"
                            :key="id"
                            :value="item"
                          >
                            {{ item }}
                          </a-mentions-option>
                        </a-mentions>
                      </b-input-group>
                    </div>
                    <div
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
                    </div>
                  </div>
                  <infinite-loading
                    @infinite="infiniteHandler"
                  ></infinite-loading>
                </div>
              </div>
              <div v-else class="text-center p-3 p-sm-4">No feed Available</div>
            </div>
            <div v-else class="p-3 p-sm-4">
              <div class="d-flex w-100 mb-3 box">
                <div class="mr-2">
                  <b-skeleton type="avatar"></b-skeleton>
                </div>
                <div class="w-100">
                  <div class="mb-3">
                    <b-skeleton-img no-aspect height="150px"></b-skeleton-img>
                  </div>
                  <b-skeleton animation="wave" width="85%"></b-skeleton>
                  <b-skeleton animation="wave" width="35%"></b-skeleton>
                </div>
              </div>
              <div class="d-flex w-100 mb-3 box">
                <div class="mr-2">
                  <b-skeleton type="avatar"></b-skeleton>
                </div>
                <div class="w-100">
                  <div class="mb-3">
                    <b-skeleton-img no-aspect height="150px"></b-skeleton-img>
                  </div>
                  <b-skeleton animation="wave" width="85%"></b-skeleton>
                  <b-skeleton animation="wave" width="35%"></b-skeleton>
                </div>
              </div>
              <div class="d-flex w-100 mb-3 box">
                <div class="mr-2">
                  <b-skeleton type="avatar"></b-skeleton>
                </div>
                <div class="w-100">
                  <div class="mb-3">
                    <b-skeleton-img no-aspect height="150px"></b-skeleton-img>
                  </div>
                  <b-skeleton animation="wave" width="85%"></b-skeleton>
                  <b-skeleton animation="wave" width="35%"></b-skeleton>
                </div>
              </div>
            </div>
          </b-col>
        </b-row>
      </b-container>
    </div>

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
          v-if="replycomment.comment"
          v-html="$options.filters.tagsfilter(replycomment.comment)"
        ></div>
      </template>
      <!-- <b-textarea class="mb-3" v-model="commentreply"> </b-textarea> -->
      <div class="w-100 d-flex commentreply_container">
        <a-mentions
          v-model="commentreply"
          placeholder="Reply comment"
          class="mb-3 commentreply w-100"
        >
          <a-mentions-option
            v-for="(item, id) in connections"
            :key="id"
            :value="item"
          >
            {{ item }}
          </a-mentions-option>
        </a-mentions>
      </div>

      <b-button
        variant="dark-green"
        :disabled="disabled"
        @click="postreply"
        size="sm"
        >Reply</b-button
      >
    </b-modal>
    <b-modal
      id="report"
      size="sm"
      centered
      hide-footer
      title="Why are you reporting?"
    >
      <report :id="report_id" :type="report_type"></report>
    </b-modal>
  </b-container>
</template>

<script>
import EmojiPicker from "@/components/emoji/EmojiPicker";
import Feelings from "@/components/feelings";
import MultiUpload from "@/components/uploader";
import { MultiSelect } from "vue-search-select";
import Interest from "../helpers/subcategory.js";
import Report from "@/components/helpers/report";
import Suggestions from "@/components/suggestions.vue";
import ViewMore from "@/components/Member/components/viewmore";
import "ant-design-vue/dist/antd.css";
export default {
  data() {
    return {
      isShown: false,
      disabled: false,
      isMultiple: null,
      type: "image",
      report_id: null,
      report_type: null,
      index: null,
      replycomment: null,
      commentreply: "",
      toggleOn: null,
      link: "",
      description: "",
      recentfeeds: [],
      trendingfeeds: [],
      customfeeds: [],
      feedShown: "recent",
      options: [],
      searchText: "", // If value is falsy, reset searchText & searchItem
      items: [],
      lastSelectItem: {},
      open: false,
      feeds: [],
      search: "",
      allcomments: [],
      commentFeed: null,
      commentUser: null,
      feed: {
        media: [],
        message: "",
        publicId: "",
        tags: [],
        mediaType: "",
      },
      img_ext: ["jpg", "png", "jpeg", "gif"],
      vid_ext: ["mp4", "3gp", "flv", "mov"],
      aud_ext: ["mp3", "aac"],
      doc_ext: ["docx", "pdf", "ppt", "zip"],
      comment: {
        comment: "",
        id: "",
      },
      mini_info: {
        id: "",
        name: "",
        type: "",
        profile: "",
      },
      showFeeds: false,
      page: 1,
      alllikes: null,
      counter: 0,
      comment_index: null,
      value: "@afc163",
    };
  },
  components: {
    // Message,
    EmojiPicker,
    MultiSelect,
    Suggestions,
    Feelings,
    Report,
    ViewMore,
    MultiUpload,
  },
  created() {
    this.$store.dispatch("GET_CONNECTIONS");
    var channel = this.$pusher.subscribe("addfeed");

    channel.bind("addfeed", (data) => {
      this.filteredFeeds.unshift(data.message);
    });
    this.options = Interest.map((item) => {
      item.text = item.value;

      return item;
    });
  },
  computed: {
    connections() {
      return this.$store.getters.connections.map((item) => item.username);
    },
    filteredFeeds() {
      if (this.feedShown == "recent" && this.recentfeeds.length) {
        return this.recentfeeds;
      }
      if (this.feedShown == "trending" && this.trendingfeeds.length) {
        return this.trendingfeeds;
      }
      if (this.feedShown == "custom" && this.customfeeds.length) {
        return this.customfeeds;
      }

      return [];
    },
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
  },
  mounted() {
    this.getcustomfeeds();
    this.gettrendingfeeds();
    this.getrecentfeeds();
  },
  watch: {
    feedShown: "toggleFeeds",
  },
  directives: {
    focus: {
      inserted(el) {
        el.focus();
      },
    },
  },
  methods: {
    showFeedUpload(type, multiple) {
      this.type = type;
      this.isMultiple = multiple;
      this.feed.mediaType = type;
      this.isShown = true;
    },
    onSelectM(option) {
      console.log("select", option);
    },
    onChange(value) {
      console.log("Change:", value);
    },

    toggleFeedAdd(type, multiple) {
      this.type = type;
      this.isMultiple = multiple;
      this.feed.mediaType = type;
      this.$bvModal.show("feed");
    },
    getfeedcomments(feed) {
      this.$http
        .get(`${this.$store.getters.url}/feed/comments/${feed.id}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.allcomments = res.data.data;
            this.commentFeed = feed.message;
            this.commentUser = feed.user;
            this.$bvModal.show("allcomments");
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    handleReport(id, type) {
      this.report_type = type;
      this.report_id = id;
      this.$bvModal.show("report");
    },
    checkpost(word) {
      var res = word.substring(0, 4);

      if (res !== "<div") {
        return true;
      }
    },
    likefeedcomment(id, index, idx) {
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
            this.filteredFeeds[index].comments[idx].isLiked = true;
          } else {
            this.filteredFeeds[index].comments[idx].isLiked = false;
          }

          this.getcustomfeeds();
          this.gettrendingfeeds();
          this.getrecentfeeds();
        });
    },
    likecomment(id, index) {
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
            this.allcomments[index].isLiked = true;
          } else {
            this.allcomments[index].isLiked = false;
          }

          this.getcustomfeeds();
          this.gettrendingfeeds();
          this.getrecentfeeds();
        });
    },
    likecommentreply(id, index, idx) {
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
            this.allcomments[index].feedcommentreplies[idx].isLiked = true;
          } else {
            this.allcomments[index].feedcommentreplies[idx].isLiked = null;
          }
        });
    },
    postreply() {
      if (!this.commentreply) {
        this.$toast.info("Cannot be empty");
        return;
      }
      this.disabled = true;
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
            this.disabled = false;
            this.$toast.success("Reply successful ");

            this.getcustomfeeds();
            this.gettrendingfeeds();
            this.getrecentfeeds();
            this.allcomments[this.comment_index].feedcommentreplies.unshift(
              res.data
            );
            this.commentreply = "";
            this.$bvModal.hide("replycomment");
          }
        })
        .catch((err) => {
          this.disabled = false;
          this.$toast.error(err.response.data.message);
        });
    },
    handlereplycomment(comment, comment_index) {
      this.replycomment = comment;
      this.comment_index = comment_index;

      this.$bvModal.show("replycomment");
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
    handleChange() {},
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
      return item > 1
        ? `${item} people liked this post`
        : `${item} person liked this post`;
    },
    toggle(id) {
      console.log("🚀 ~ file: feeds.vue ~ line 967 ~ toggle ~ id", id);
    },
    toggleFeeds() {
      if (this.feedShown == "recent") {
        this.getrecentfeeds();
      }
      if (this.feedShown == "custom") {
        this.getcustomfeeds();
      }
      if (this.feedShown == "trending") {
        this.gettrendingfeeds();
      }
    },
    sharenow(feed) {
      this.description = this.toText(feed.message);
      this.link = `https://nzukoor.com/me/feed/${feed.id}?utf_medium=share`;
      this.$bvModal.show("share");
    },
    infiniteHandler($state) {
      this.$http
        .get(`${this.$store.getters.url}/feeds?page=${this.page}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.data.data.length) {
            this.page += 1;
            this.feeds.push(...res.data.data);
            $state.loaded();
          } else {
            $state.complete();
          }
        });
    },
    onSelect(items, lastSelectItem) {
      this.feed.tags = items;
      this.lastSelectItem = lastSelectItem;
    },
    // deselect option
    reset() {
      this.tags = []; // reset
    },
    showcomments(feed) {
      this.allcomments = feed;
      this.$bvModal.show("allcomments");
    },
    getextension(fileName) {
      if (fileName && fileName.length) {
        var regex = new RegExp("[^.]+$");
        var extension = fileName.match(regex);

        return extension[0].toLowerCase();
      }
    },
    getUpload(val) {
      if (!this.vid_ext.includes(this.getextension(val.secure_url))) {
        this.$toast.error("Unsupported content type !");
        return;
      }

      this.feed.media.push(val.secure_url);
    },

    getUploads(val) {
      this.feed.media = val;
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
    getmyfeeds() {
      this.$http
        .get(`${this.$store.getters.url}/get/feeds/tags`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201 || res.status == 200) {
            this.feedTags = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    gettrendingfeeds() {
      this.$http
        .get(`${this.$store.getters.url}/trending/feeds`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201 || res.status == 200) {
            this.trendingfeeds = res.data.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getcustomfeeds() {
      this.$http
        .get(`${this.$store.getters.url}/custom/feeds`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201 || res.status == 200) {
            if (res.data !== "empty") {
              this.customfeeds = res.data.data;
            }
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getrecentfeeds() {
      this.$http
        .get(`${this.$store.getters.url}/recent/feeds`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201 || res.status == 200) {
            if (res.data !== "empty") {
              this.recentfeeds = res.data.data;
            }

            this.showFeeds = true;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    post() {
      if (!this.feed.message && !this.feed.media) {
        return;
      }
      this.disabled = true;
      this.$http
        .post(`${this.$store.getters.url}/feeds`, this.feed, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201 || res.status == 200) {
            this.$toast.success("Feed Updated ");
            this.$bvModal.hide("feed");
            // this.feeds.unshift(res.data);
            this.disabled = false;
            this.isShown = false;
            this.feed = {
              media: "",
              message: "",
              publicId: "",
              tags: [],
            };
          }
        })
        .catch((err) => {
          this.disabled = false;
          this.$toast.error(err.response.data.message);
        });
    },
    updatepost() {
      this.disabled = true;
      this.$http
        .put(`${this.$store.getters.url}/feeds/${this.feed.id}`, this.feed, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Feed Updated ");
            this.disabled = false;
            this.filteredFeeds[this.index].message = res.data.message;
            this.$bvModal.hide("feededit");
            this.feed = {
              media: "",
              message: "",
              publicId: "",
              tags: [],
            };
          }
        })
        .catch((err) => {
          this.disabled = false;
          this.$toast.error(err.response.data.message);
        });
    },
    addcomment(id, index, comment) {
      if (!comment) {
        this.$toast.info("Cannot be empty");
        return;
      }
      this.disabled = true;
      this.comment.id = id;
      this.comment.comment = comment;

      this.$http
        .post(`${this.$store.getters.url}/feed-comments`, this.comment, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.disabled = false;
            this.$toast.success("Comment updated ");

            this.filteredFeeds[index].comments.unshift(res.data);
            this.filteredFeeds[index].commentCount = res.data.feedCommentCount;
            this.filteredFeeds[index].comment = "";

            this.comment = {
              comment: "",
              id: "",
            };
          }
        })
        .catch((err) => {
          this.disabled = false;
          this.$toast.error(err.response.data.message);
        });
    },
    toggleLike(id, index) {
      this.disabled = true;
      this.$http
        .post(
          `${this.$store.getters.url}/feed-likes`,
          { id },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 201 || res.status == 200) {
            this.disabled = false;
            this.likeimage(index);
            this.filteredFeeds[index].isLiked = res.data.like;
            this.filteredFeeds[index].likes = res.data.feed.likes;
            if (res.data.like) {
              this.filteredFeeds[index].likesCount++;
            } else {
              this.filteredFeeds[index].likesCount--;
            }
          }
        })
        .catch((err) => {
          this.disabled = false;
          this.$toast.error(err.response.data.message);
        });
    },

    feededit(feed, index) {
      this.index = index;
      this.feed.message = feed.message;
      this.feed.id = feed.id;
      this.feed.media = feed.media;
      this.feed.publicId = feed.publicId;
      this.feed.tags = feed.tags;
      this.$bvModal.show("feededit");
    },
    drop(id, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/feeds/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.member.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success("Feed deleted");
                this.filteredFeeds.splice(index, 1);
              }
            })
            .catch((err) => {
              this.$toast.error(err.response.data.message);
            });
        }
      });
    },
    dropcomment(id, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/feed-comments/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.member.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success("Removed");
                this.allcomments.splice(index, 1);
                this.getcustomfeeds();
                this.getrecentfeeds();
              }
            })
            .catch((err) => {
              this.$toast.error(err.response.data.message);
            });
        }
      });
    },
    dropcommentreply(id, idx, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/feed/comment/reply/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.member.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success(" deleted");
                this.getcustomfeeds();
                this.getrecentfeeds();
                this.allcomments[idx].feedcommentreplies.splice(index, 1);
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
<style scoped lang="scss">
.container {
  max-width: 1000px;
}
.stat {
  height: 50px;
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
}
.emoji-invoker:hover {
  transform: scale(1.1);
}
.emoji-invoker > svg {
}
.emoji-invoker2 {
  width: 1.5rem;
  height: 1.5rem;
  border-radius: 50%;
  cursor: pointer;
  transition: all 0.2s;
}
.emoji-invoker2:hover {
  transform: scale(1.1);
}
.emoji-invoker2 > svg {
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
  // top: 40px;
  // right: -150px;
}
.emoji-picker.picker {
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
  top: unset;
  // bottom: 60px;
  // right: -150px;
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

.rounded-8 {
  border-radius: 8px;
}
.feed-content {
}
.event {
  width: 80%;
  margin: 0 auto;
}

.profile {
  line-height: 1.2;
}
.name {
  font-size: 14px;
}
.date {
  font-size: 12px;
  color: rgba($color: #000000, $alpha: 0.44);
}

.form-control.no-focus:focus {
  outline: none !important;
  box-shadow: unset;
}
// .form-control.no-focus {
//   font-size: 13px;
// }
.comment_header {
  font-size: 12px;
  color: rgba($color: #000000, $alpha: 0.44);
}
.comment {
  font-size: 12px;
  color: rgba($color: #000000, $alpha: 0.64);
}

.search {
  background: #fbfbfb;
  border-radius: 8px;
}
.search-bg {
  background: #fbfbfb;
}

.edit_button {
  display: none;
}
.media:hover .edit_button {
  display: block;
}
</style>

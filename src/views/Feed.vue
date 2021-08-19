/* eslint-disable no-unused-vars */
<template>
  <b-container fluid class="px-0 px-sm 4 bg-light">
    <div class="pb-5 pt-sm-4">
      <b-modal
        no-close-on-backdrop
        id="feed"
        hide-footer
        centered
        title="Create feed"
        size="md"
      >
        <div class="mb-4">
          <div class="wrapper mb-2">
            <b-form-textarea
              rows="4"
              class="rounded border-0"
              v-model="feed.message"
              placeholder="Whats on your mind today?"
            ></b-form-textarea>
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

        <div class="mb-4 position-relative media border rounded">
          <FeedUpload
            @getUpload="getUpload"
            :id="'edit'"
            class="position-absolute edit_button"
          >
            <div class="bg-lighter-green fs12 px-3 py-1 rounded cursor-pointer">
              Edit
            </div>
          </FeedUpload>
          <b-img
            v-if="feed.media && img_ext.includes(getextension(feed.media))"
            fluid-grow
            :src="feed.media"
            style="object-fit: contain"
          ></b-img>

          <video
            width="100%"
            v-if="feed.media && vid_ext.includes(getextension(feed.media))"
            :src="feed.media"
            class="fluid-grow"
            controls
          ></video>
          <div
            v-if="feed.media && doc_ext.includes(getextension(feed.media))"
            class="text-center p-3 p-sm-4 bg-skills-grey"
          >
            <b-icon icon="image" font-scale="3rem"></b-icon>
          </div>
        </div>
        <div class="d-flex justify-content-around my-3 border rounded p-2">
          <div>
            <FeedUpload @getUpload="getUpload" :id="'image'">
              <b-img
                :src="require('@/assets/images/event.svg')"
                width="18px"
                class="mr-1 cursor-pointer ev"
              ></b-img>
              <span class="ev">Image</span>
            </FeedUpload>
          </div>
          <div>
            <FeedUpload @getUpload="getUpload" :id="'video'">
              <b-img
                :src="require('@/assets/images/youtube.svg')"
                width="18px"
                class="mr-1 cursor-pointer ev"
              ></b-img
              ><span class="ev">Video</span>
            </FeedUpload>
          </div>
          <div>
            <FeedUpload @getUpload="getUpload" :id="'event'">
              <b-img
                :src="require('@/assets/images/advert.svg')"
                width="18px"
                class="mr-1 cursor-pointer ev"
              ></b-img>
              <span class="ev">Event</span>
            </FeedUpload>
          </div>
        </div>
        <b-button @click="post" block variant="dark-green">Post</b-button>
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
                  <span class="name" v-if="allcomments.admin">{{
                    allcomments.admin.name
                  }}</span>
                  <span class="name" v-if="allcomments.user">{{
                    allcomments.user.name
                  }}</span>
                  <span class="name" v-if="allcomments.facilitator">{{
                    allcomments.facilitator.name
                  }}</span>
                  <br />
                  <span class="date fs11">{{
                    allcomments.created_at | moment("ll")
                  }}</span>
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
      <b-container>
        <div class="mb-3 d-none d-sm-block text-left">
          <span @click="$router.go(-1)" class="cursor-pointer back">
            <span class="mr-2">
              <b-icon icon="arrow-left" class=""></b-icon
            ></span>
            <span>Back</span>
          </span>
        </div>
        <b-row class="justify-content-center">
          <b-col sm="8" class="px-0 text-left">
            <div class="border bg-white py-3 px-2 p-sm-4 rounded-8 mb-4">
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
                  placeholder="Whats on your mind today? "
                ></b-form-input>
              </div>

              <div class="d-flex justify-content-around event_video">
                <div @click="$bvModal.show('feed')">
                  <b-img
                    :src="require('@/assets/images/event.svg')"
                    width="18px"
                    class="mr-1 cursor-pointer"
                  ></b-img>
                  <span>Image</span>
                </div>
                <div @click="$bvModal.show('feed')">
                  <b-img
                    :src="require('@/assets/images/youtube.svg')"
                    width="18px"
                    class="mr-1 cursor-pointer"
                  ></b-img>
                  <span class="ev">Media</span>
                </div>
                <div @click="$bvModal.show('feed')">
                  <b-img
                    :src="require('@/assets/images/advert.svg')"
                    width="18px"
                    class="mr-1 cursor-pointer"
                  ></b-img>
                  <span class="ev">Event</span>
                </div>
              </div>
            </div>

            <div v-if="showFeeds">
              <div>
                <div class="feed-content">
                  <div
                    v-for="(feed, index) in feeds"
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
                              {{ feed.user.username }}
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
                              {{ feed.facilitator.username }}
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
                    </div>

                    <div v-if="feed.media || feed.publicId">
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
                          @dblclick="toggleLike(feed.id, index)"
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
                          @dblclick="toggleLike(feed.id, index)"
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
                              >{{ tag }}</b-badge
                            >
                          </b-col>
                        </b-row>
                      </div>
                    </div>
                    <div class="interactions text-left px-3 py-2 border-bottom">
                      <span
                        class="mr-3 cursor-pointer"
                        @click="toggleStar(feed.id, index)"
                      >
                        <b-icon
                          :icon="
                            feed.stars.find(
                              item =>
                                item.star &&
                                item.user_id == $store.getters.member.id
                            )
                              ? 'star-fill'
                              : 'star'
                          "
                          class="text-blue mr-1"
                        ></b-icon>
                        <span>{{
                          feed.stars.filter(item => item.star).length
                        }}</span>
                      </span>
                      <span
                        class="mr-3 cursor-pointer"
                        @click="toggleLike(feed.id, index)"
                        ><b-icon
                          :icon="
                            feed.likes.find(
                              item =>
                                item.like &&
                                item.user_id == $store.getters.member.id
                            )
                              ? 'heart-fill'
                              : 'heart'
                          "
                          class="text-danger mr-1"
                        ></b-icon>
                        <span>{{
                          feed.likes.filter(item => item.like).length
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
                          class="mr-1"
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
                            <span class="comment_mins"
                              >{{ $moment(item.created_at).fromNow() }}
                            </span>
                          </div>
                        </div>
                      </div>
                    </div>

                    <div class="interact text-left py-1">
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
                                          v-for="(emoji,
                                          emojiName) in emojiGroup"
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
                          autocomplete="off"
                          autocorrect="off"
                          v-model="feed.comment"
                          placeholder="Add comment"
                          class="border-0 no-focus"
                        ></b-form-input>
                      </b-input-group>
                    </div>
                    <div class="feed_time text-muted py-2 px-3 text-left">
                      {{ $moment(feed.created_at).fromNow() }}
                    </div>
                  </div>
                  <infinite-loading
                    @infinite="infiniteHandler"
                  ></infinite-loading>
                </div>
              </div>
              <!-- <div v-else class="text-center p-3 p-sm-4">No feed Available</div> -->
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
          <b-col sm="4" class="px-0 p-sm-4">
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
      </b-container>
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
                  {{ alllikes.user.name }}
                </div>
                <div class="name" v-if="alllikes.facilitator">
                  {{ alllikes.facilitator.name }}
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
            v-for="(item, index) in alllikes.likes.filter(val => val.like)"
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
  </b-container>
</template>

<script>
import EmojiPicker from "@/components/emoji/EmojiPicker";
import FeedUpload from "@/components/feedupload";
import { MultiSelect } from "vue-search-select";
import Interest from "@/components/helpers/subcategory.js";
export default {
  data() {
    return {
      link: "",
      description: "",
      recentfeeds: [],
      trendingFeed: [],
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
      feed: {
        media: "",
        message: "",
        publicId: "",
        tags: []
      },
      img_ext: ["jpg", "png", "jpeg", "gif"],
      vid_ext: ["mp4", "3gp", "flv", "mov"],
      aud_ext: ["mp3", "aac"],
      doc_ext: ["docx", "pdf", "ppt", "zip"],
      comment: {
        comment: "",
        id: ""
      },
      mini_info: {
        id: "",
        name: "",
        type: "",
        profile: ""
      },
      showFeeds: false,
      page: 1,
      alllikes: null,
      toggleOn: null
    };
  },
  components: {
    EmojiPicker,
    FeedUpload,
    MultiSelect
  },
  watch: {
    $route: "getSpecificFeeds"
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
    }
  },
  mounted() {
    if (
      localStorage.getItem("authMember") ||
      localStorage.getItem("authFacilitator")
    ) {
      this.auth = true;
    }
    this.getSpecificFeeds();
    this.getTrendingFeeds();
  },
  created() {
    this.options = Interest.map(item => {
      item.text = item.value;

      return item;
    });
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
              : first.user.name
          } </span>`;
          return result;
        }
        if (first.facilitator) {
          result = `<span>Liked by ${
            this.useraccess == "facilitator" &&
            this.$store.getters.facilitator.id == first.facilitator.id
              ? "you"
              : first.facilitator.name
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
              result = `Liked by  ${first.user.name} and  ${arr.length - 1} ${
                arr.length - 1 > 1 ? "others" : "other"
              } `;
              return result;
            }
            if (first.facilitator) {
              result = `Liked by  ${first.facilitator.name} and  ${arr.length -
                1} ${arr.length - 1 > 1 ? "others" : "other"} `;
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
              result = `Liked by  ${first.user.name} and  ${arr.length - 1} ${
                arr.length - 1 > 1 ? "others" : "other"
              } `;
              return result;
            }
            if (first.facilitator) {
              result = `Liked by  ${first.facilitator.name} and  ${arr.length -
                1} ${arr.length - 1 > 1 ? "others" : "other"} `;
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
              result = `Liked by  ${first.user.name} and  ${arr.length - 1} ${
                arr.length - 1 > 1 ? "others" : "other"
              } `;
              return result;
            }
            if (first.facilitator) {
              result = `Liked by  ${first.facilitator.name} and  ${arr.length -
                1} ${arr.length - 1 > 1 ? "others" : "other"} `;
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
    getTrendingFeeds() {
      this.$http
        .get(`${this.$store.getters.url}/guest/trending/feeds`)
        .then(res => {
          if (res.status == 200) {
            this.trendingFeed = res.data;
          }
        });
    },
    getSpecificFeeds() {
      this.$http
        .get(
          `${this.$store.getters.url}/guest/trending/feed/${this.$route.params.interest}`
        )
        .then(res => {
          if (res.status == 200) {
            this.feeds = res.data.data;
            this.showFeeds = true;
          }
        });
    },

    infiniteHandler($state) {
      this.$http
        .get(
          `${this.$store.getters.url}/guest/trending/feed/${this.$route.params.interest}?page=${this.page}`
        )
        .then(res => {
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
      if (fileName) {
        var regex = new RegExp("[^.]+$");
        var extension = fileName.match(regex);

        return extension[0].toLowerCase();
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
    post() {
      if (!this.feed.message && !this.feed.media) {
        this.$toast.info("Cannot be empty");
        return;
      }
      if (!this.auth) {
        this.$toast.info("Login to complete action");
        return;
      }
      this.$http
        .post(`${this.$store.getters.url}/feeds`, this.feed, {
          headers: {
            Authorization: `Bearer ${this.usertoken.access_token}`
          }
        })
        .then(res => {
          if (res.status == 201 || res.status == 200) {
            this.$toast.success("Feed Updated ");
            this.$bvModal.hide("feed");
            // this.feeds.unshift(res.data);

            this.feed = {
              media: "",
              message: "",
              publicId: "",
              tags: []
            };
          }
        })
        .catch(err => {
          this.$toast.error(err.response.data.message);
        });
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
            Authorization: `Bearer ${this.usertoken.access_token}`
          }
        })
        .then(res => {
          if (res.status == 201) {
            this.$toast.success("Comment updated ");

            this.filteredFeeds[index].comments.unshift(res.data);
            this.filteredFeeds[index].comment = "";

            this.comment = {
              comment: "",
              id: ""
            };
          }
        })
        .catch(err => {
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
              Authorization: `Bearer ${this.usertoken.access_token}`
            }
          }
        )
        .then(res => {
          if (res.status == 201) {
            this.likeimage(index);
            this.feeds[index].likes.push(res.data);
          }
          if (res.status == 200) {
            this.likeimage(index);
            this.filteredFeeds[index].likes.map(item => {
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
        .catch(err => {
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
              Authorization: `Bearer ${this.usertoken.access_token}`
            }
          }
        )
        .then(res => {
          if (res.status == 201) {
            this.feeds[index].stars.push(res.data);
          }
          if (res.status == 200) {
            this.filteredFeeds[index].stars.map(item => {
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
        .catch(err => {
          this.$toast.error(err.response.data.message);
        });
    },
    drop() {}
  }
};
</script>
<style scoped lang="scss">
.container {
  max-width: 960px;
}
::placeholder {
  text-align: left;
}
.stat {
  height: 50px;
}
.wrapper {
  position: relative;
  width: 100%;
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
  fill: #b1c6d0;
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
  top: 40px;
  right: -150px;
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
  bottom: 60px;
  right: -150px;
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
.event div {
  font-size: 14px;
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
.form-control.no-focus {
  font-size: 13px;
}
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

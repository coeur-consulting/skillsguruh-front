/* eslint-disable no-unused-vars */
<template>
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
            rows="3"
            class="rounded stat border-0"
            size="lg"
            v-model="feed.message"
            :placeholder="
              'Whats on your mind ' + $store.getters.facilitator.name + '?'
            "
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
          <div class="bg-lighter-green fs12 px-2 py-1 rounded cursor-pointer">
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
          controls
          width="100%"
          v-if="feed.media && vid_ext.includes(getextension(feed.media))"
          :src="feed.media"
          class="fluid-grow"
        ></video>
        <div
          v-if="feed.media && doc_ext.includes(getextension(feed.media))"
          class="text-center p-3 bg-skills-grey"
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
              class="mr-1 cursor-pointer"
            ></b-img>
            Image
          </FeedUpload>
        </div>
        <div>
          <FeedUpload @getUpload="getUpload" :id="'video'">
            <b-img
              :src="require('@/assets/images/youtube.svg')"
              width="18px"
              class="mr-1 cursor-pointer"
            ></b-img
            >Video
          </FeedUpload>
        </div>
        <div>
          <FeedUpload @getUpload="getUpload" :id="'event'">
            <b-img
              :src="require('@/assets/images/advert.svg')"
              width="18px"
              class="mr-1 cursor-pointer"
            ></b-img>
            Event
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
                        {{ item.user.name }}
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
                        {{ item.facilitator.name }}
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
      <b-row>
        <b-col sm="8" class="px-0">
          <div class="border bg-white py-3 px-2 p-sm-4 rounded-8 mb-4">
            <div class="d-flex align-items-center mb-3">
              <b-avatar size="1.8rem" class="mr-3"></b-avatar>

              <b-form-input
                class="rounded-pill stat cursor-pointer"
                size="lg"
                readonly
                @click="$bvModal.show('feed')"
                :placeholder="
                  'Whats on your mind ' + $store.getters.facilitator.name + '?'
                "
              ></b-form-input>
            </div>

            <div class="d-flex justify-content-around event">
              <div @click="$bvModal.show('feed')">
                <b-img
                  :src="require('@/assets/images/event.svg')"
                  width="18px"
                  class="mr-1 cursor-pointer"
                ></b-img>
                Image
              </div>
              <div @click="$bvModal.show('feed')">
                <b-img
                  :src="require('@/assets/images/youtube.svg')"
                  width="18px"
                  class="mr-1 cursor-pointer"
                ></b-img
                >Video
              </div>
              <div @click="$bvModal.show('feed')">
                <b-img
                  :src="require('@/assets/images/advert.svg')"
                  width="18px"
                  class="mr-1 cursor-pointer"
                ></b-img>
                Event
              </div>
            </div>
          </div>
          <div class="d-flex justify-content-end">
            <div class="d-flex align-items-center pl-3 mb-3">
              <div
                class="pr-2 fs12 font-weight-bold cursor-pointer"
                :class="feedShown == 'recent' ? '' : 'text-muted'"
                @click="feedShown = 'recent'"
              >
                Recent
              </div>
              <span class="text-muted"> |</span>
              <div
                class="pl-2 pr-2 fs12 font-weight-bold cursor-pointer"
                :class="feedShown == 'trending' ? '' : 'text-muted'"
                @click="feedShown = 'trending'"
              >
                Trending
              </div>
              <span class="text-muted"> |</span>
              <div
                class="pl-2 fs12 font-weight-bold cursor-pointer"
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
                  class="border bg-white rounded mb-2"
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
                          @click="
                            $router.push(
                              `/facilitator/profile/u/${feed.user.id}`
                            )
                          "
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
                            $router.push(
                              `/facilitator/profile/f/${feed.facilitator.id}`
                            )
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
                        feed.facilitator &&
                        feed.facilitator.id == $store.getters.facilitator.id
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
                        <cld-transformation width="auto" crop="scale" />
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
                    <span
                      class="mr-3 cursor-pointer"
                      @click="toggleStar(feed.id, index)"
                    >
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
                    </span>
                    <span
                      class="mr-3 cursor-pointer"
                      @click="toggleLike(feed.id, index)"
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
                              $router.push(
                                `/facilitator/profile/u/${item.user.id}`
                              )
                            "
                            v-if="item.user"
                          >
                            {{ item.user.name }}</span
                          >
                          <span
                            class="comment_name mr-2 hover_green"
                            @click="
                              $router.push(
                                `/facilitator/profile/f/${item.facilitator.id}`
                              )
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
                <infinite-loading
                  @infinite="infiniteHandler"
                ></infinite-loading>
              </div>
            </div>
            <div v-else class="text-center p-3">No feed Available</div>
          </div>
          <div v-else class="p-3">
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
        <Message
          class="d-none d-md-block"
          @getmessage="getmessage"
          :user="'facilitator'"
        />
      </b-row>

      <div class="minichats">
        <Minichat :user="'facilitator'" />
      </div>
    </b-container>
  </div>
</template>
<script>
import EmojiPicker from "vue-emoji-picker";
import FeedUpload from "../feedupload";
import Minichat from "../minichat";
import Message from "../messagecomponent";
import { MultiSelect } from "vue-search-select";
import Interest from "../helpers/subcategory.js";
export default {
  data() {
    return {
      feedShown: "recent",
      recentfeeds: [],
      trendingfeeds: [],
      customfeeds: [],
      options: [],
      searchText: "", // If value is falsy, reset searchText & searchItem
      items: [],
      lastSelectItem: {},
      open: false,
      feeds: [],
      search: "",
      allcomments: [],
      showFeeds: false,
      feed: {
        media: "",
        message: "",
        publicId: "",
        tags: [],
      },
      img_ext: ["jpg", "png", "jpeg", "gif"],
      vid_ext: ["mp4", "3gp"],
      aud_ext: ["mp3"],
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
      page: 1,
    };
  },
  components: {
    Minichat,
    Message,
    EmojiPicker,
    FeedUpload,
    MultiSelect,
  },
  created() {
    var channel = this.$pusher.subscribe("addfeed");

    channel.bind("addfeed", (data) => {
      this.feeds.unshift(data.message);
    });
    this.options = Interest.map((item) => {
      var res = {};
      res.text = item.value;
      res.value = item.value;
      res.color = item.color;
      res.icon = item.icon;
      return res;
    });
  },
  computed: {
    filteredFeeds() {
      var feeds = [];
      if (this.feedShown == "recent") {
        feeds = this.recentfeeds;
      }
      if (this.feedShown == "trending") {
        feeds = this.trendingfeeds;
      }
      if (this.feedShown == "custom") {
        feeds = this.customfeeds;
      }

      return feeds;
    },
  },
  mounted() {
    // this.getfeeds();
    // this.getmyfeeds();
    this.getcustomfeeds();
    this.gettrendingfeeds();
    this.getrecentfeeds();
  },
  methods: {
    gettrendingfeeds() {
      this.$http
        .get(`${this.$store.getters.url}/trending/feeds`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
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
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201 || res.status == 200) {
            this.customfeeds = res.data.data;
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
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201 || res.status == 200) {
            this.recentfeeds = res.data.data;
            this.showFeeds = true;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    infiniteHandler($state) {
      this.$http
        .get(`${this.$store.getters.url}/feeds?page=${this.page}`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
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
    getmyfeeds() {
      this.$http
        .get(`${this.$store.getters.url}/get/feeds/tags`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
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
    onSelect(items, lastSelectItem) {
      console.log(
        "🚀 ~ file: feeds.vue ~ line 720 ~ onSelect ~ lastSelectItem",
        lastSelectItem
      );
      console.log("🚀 ~ file: feeds.vue ~ line 720 ~ onSelect ~ items", items);
      this.feed.tags = items;
      this.lastSelectItem = lastSelectItem;
    },
    // deselect option
    reset() {
      this.feed.tags = []; // reset
    },
    getmessage(id, name, type, profile) {
      this.mini_info.id = id;
      this.mini_info.name = name;
      this.mini_info.type = type;
      this.mini_info.profile = profile;
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

    getfeeds() {
      this.$http
        .get(`${this.$store.getters.url}/feeds`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
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
    post() {
      this.$http
        .post(`${this.$store.getters.url}/feeds`, this.feed, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201 || res.status == 200) {
            this.$toast.success("Feed Updated ");
            this.$bvModal.hide("feed");

            this.feed = {
              media: "",
              message: "",
              publicId: "",
              tags: [],
            };
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    addcomment(id, index) {
      if (!this.comment.comment) {
        this.$toast.info("Type a comment ");
        return;
      }
      this.comment.id = id;

      this.$http
        .post(`${this.$store.getters.url}/feed-comments`, this.comment, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.$toast.success("Comment updated ");
            // this.$bvModal.hide("feed");

            this.feeds[index].comments.unshift(res.data);

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
      this.$http
        .post(
          `${this.$store.getters.url}/feed-likes`,
          { id },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 201) {
            this.feeds[index].likes.push(res.data);
          }
          if (res.status == 200) {
            this.feeds[index].likes.map((item) => {
              if (item.admin_id == this.$store.getters.facilitator.id) {
                return (item.like = res.data.like);
              }
            });
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    toggleStar(id, index) {
      this.$http
        .post(
          `${this.$store.getters.url}/feed-stars`,
          { id },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 201) {
            this.feeds[index].stars.push(res.data);
          }
          if (res.status == 200) {
            this.feeds[index].stars.map((item) => {
              if (item.admin_id == this.$store.getters.facilitator.id) {
                return (item.star = res.data.star);
              }
            });
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    drop(id, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/feeds/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success("Feed deleted");
                this.feeds.splice(index, 1);
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
  font-size: 0.8rem;
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

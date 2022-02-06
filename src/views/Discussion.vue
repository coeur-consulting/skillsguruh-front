/* eslint-disable vue/no-unused-vars */
<template>
  <div>
    <section class="explore_banner">
      <h1>Explore Discussion</h1>
    </section>
    <div class="bg-light">
      <b-container class="py-sm-5">
        <b-row v-if="showdiscussion">
          <b-col class="px-0 px-sm-3" sm="8">
            <div class="bg-white py-4 rounded">
              <div class="main_content text-left">
                <div class="d-flex justify-content-between">
                  <span class="crumbs">
                    <span
                      @click="$router.go(-1)"
                      class="pl-3 cursor-pointer back text-dark-green"
                    >
                      <span class="mr-2">
                        <b-icon icon="arrow-left" class=""></b-icon
                      ></span>
                      <span>Back</span>
                    </span>
                    / <span>{{ discussion.tribe.name }}</span></span
                  >
                </div>
                <div class="content px-2 py-3 pt-4 pb-3">
                  <div class="top_dis d-flex align-items-center mb-2">
                    <div class="side_dis">
                      <b-avatar
                        class="starter"
                        :src="discussion.user.profile"
                        v-if="discussion.user"
                        @click="
                          $router.push(
                            `/me/profile/${discussion.user.username}`
                          )
                        "
                      ></b-avatar>
                    </div>
                    <div class="text-left next_dis">
                      <div class="title h4 mb-1 d-flex">
                        <span class="mr-2 flex-1">{{ discussion.name }}</span
                        ><span>
                          <text-to-speech
                            :text="thread"
                            :voice="voices"
                          ></text-to-speech
                        ></span>
                      </div>
                      <div class="asked">
                        Created
                        {{ $moment(discussion.created_at).fromNow() }}
                      </div>
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
                        @click="addvote"
                        icon="caret-up-fill"
                        font-scale="1.2"
                        class="cursor-pointer"
                      ></b-icon>
                      <span v-if="discussion.discussionvote">{{ vote }}</span>
                      <span v-else>0</span>
                      <b-icon
                        @click="dropvote"
                        icon="caret-down-fill"
                        font-scale="1.2"
                        class="cursor-pointer"
                      ></b-icon>
                    </div>
                    <div class="text-left next_dis">
                      <div class="main_desc_text">
                        {{ discussion.description }}
                      </div>
                      <div class="mt-2">
                        <b-row class="justify-content-start px-2">
                          <b-col
                            class="px-1"
                            cols="auto"
                            v-for="(tag, id) in discussion.tags"
                            :key="id"
                          >
                            <b-badge
                              variant="lighter-green"
                              class="text-dark fs10 font-weight-normal"
                              >{{ tag.value }}</b-badge
                            ></b-col
                          >
                        </b-row>
                      </div>
                    </div>
                  </div>

                  <div
                    class="
                      bottom_bar
                      d-flex
                      justify-content-between
                      mb-4
                      discussion_title
                    "
                  >
                    <div>
                      <span class="mr-3 dis_set"
                        ><b-icon icon="chat" class="mr-1"></b-icon>
                        <span v-if="posts"> {{ posts.length }}</span>
                        <span v-else>0</span> replies</span
                      >
                      <span class="mr-3 dis_set"
                        ><b-icon icon="eye-fill" class="mr-1"></b-icon>
                        <span v-if="views"> {{ views }}</span>
                        <span v-else>0</span> views</span
                      >
                    </div>
                    <div class="dis_set">
                      <span> by </span>

                      <span
                        v-if="discussion.user"
                        class="cursor-pointer text-dark-green hover_green"
                        @click="
                          $router.push(
                            `/me/profile/${discussion.user.username}`
                          )
                        "
                        >{{ discussion.user.username }}</span
                      >
                    </div>
                  </div>
                  <div class="text-right" v-if="posts.length">
                    <b-button-group>
                      <b-button
                        @click="toggleview = 'recent'"
                        :variant="
                          toggleview == 'recent' ? 'dark' : 'outline-dark'
                        "
                        size="sm"
                        >Newest</b-button
                      >
                      <b-button
                        :variant="
                          toggleview == 'oldest' ? 'dark' : 'outline-dark'
                        "
                        @click="toggleview = 'oldest'"
                        size="sm"
                        >Oldest</b-button
                      >
                      <b-button
                        :variant="
                          toggleview == 'comments' ? 'dark' : 'outline-dark'
                        "
                        @click="toggleview = 'comments'"
                        size="sm"
                        >Most</b-button
                      >
                    </b-button-group>
                  </div>
                  <div v-if="posts" v-chat-scroll>
                    <div
                      class="bottom_bar mb-3 position-relative"
                      v-for="(item, index) in filteredDiscussion"
                      :key="index"
                    >
                      <span v-if="item.message" class="text2speech">
                        <text-to-speech
                          :text="toText(item.message)"
                          :voice="voices"
                        ></text-to-speech>
                      </span>
                      <div>
                        <p
                          class="discusion_text"
                          v-if="item.message"
                          :inner-html.prop="toText(item.message) | tagsfilter"
                        ></p>
                        <div
                          class="text-center"
                          v-if="
                            item.attachment &&
                            img_ext.includes(getextension(item.attachment))
                          "
                        >
                          <div class="image">
                            <a
                              download=""
                              target="_blank"
                              :href="item.attachment"
                            >
                              <cld-image
                                v-if="item.publicId"
                                :publicId="item.publicId"
                                width="250"
                                crop="fill"
                              >
                                <cld-transformation radius="20" />
                              </cld-image>
                            </a>
                          </div>
                        </div>

                        <div class="document text-center mb-2" v-else>
                          <a
                            download=""
                            target="_blank"
                            :href="item.attachment"
                          >
                            <div
                              v-if="
                                item.attachment &&
                                vid_ext.includes(getextension(item.attachment))
                              "
                              class="p-1 rounded cursor-pointer"
                            >
                              <cld-video
                                class="mx-auto"
                                controls
                                v-if="item.publicId"
                                :publicId="item.publicId"
                                width="250"
                                crop="fill"
                              >
                                <cld-transformation />
                              </cld-video>
                            </div>
                            <div
                              v-if="
                                item.attachment &&
                                aud_ext.includes(getextension(item.attachment))
                              "
                              class="
                                p-1
                                bg-lighter-green
                                d-flex
                                align-items-center
                                rounded
                                cursor-pointer
                              "
                            >
                              <cld-video
                                controls
                                v-if="item.publicId"
                                :publicId="item.publicId"
                                crop="fill"
                              >
                                <cld-transformation />
                              </cld-video>
                            </div>
                            <div
                              v-if="
                                item.attachment &&
                                doc_ext.includes(getextension(item.attachment))
                              "
                              class="
                                p-1
                                bg-lighter-green
                                d-flex
                                align-items-center
                                rounded
                                cursor-pointer
                              "
                            >
                              <div
                                class="
                                  bg-dark-green
                                  text-center
                                  rounded
                                  p-2
                                  mr-3
                                "
                              >
                                <b-icon
                                  icon="file-earmark-ruled-fill"
                                  variant="white"
                                  font-scale="2rem"
                                ></b-icon>
                              </div>
                              <div
                                class="
                                  d-flex
                                  align-items-center
                                  p-2
                                  justify-content-center
                                  text-dark
                                  fs15
                                "
                              >
                                Download File
                              </div>
                            </div>
                          </a>
                        </div>
                      </div>

                      <div
                        class="
                          d-flex
                          justify-content-between
                          align-items-center
                        "
                      >
                        <div class="d-flex align-items-center">
                          <span class="">
                            <b-avatar
                              size="sm"
                              :src="item.admin.profile"
                              v-if="item.admin"
                              class="mr-1 member"
                            ></b-avatar>
                            <b-avatar
                              size="sm"
                              :src="item.user.profile"
                              v-if="item.user"
                              class="mr-1 member"
                            ></b-avatar>
                            <b-avatar
                              size="sm"
                              :src="item.facilitator.profile"
                              v-if="item.facilitator"
                              class="mr-1 member"
                            ></b-avatar>
                          </span>
                          <span v-if="item.admin" class="fs13 cursor-pointer">{{
                            item.admin.name
                          }}</span>
                          <span
                            c
                            v-if="item.user"
                            @click="
                              $router.push(
                                `/me/profile/${item.user.username}`
                              )
                            "
                            class="fs13 cursor-pointer hover_green"
                            >{{ item.user.username }}</span
                          >
                          <span
                            v-if="item.facilitator"
                            @click="
                              $router.push(
                                `/me/profile/f/${item.facilitator.id}`
                              )
                            "
                            class="fs13 cursor-pointer hover_green"
                            >{{ item.facilitator.username }}</span
                          >
                        </div>
                        <span> {{ $moment(item.created_at).fromNow() }}</span>
                      </div>
                      <div
                        class="
                          mt-3
                          mb-2
                          text-right
                          d-flex
                          justify-content-between
                        "
                      >
                        <span>
                          <small
                            class="mr-2"
                            v-if="item.discussionmessagecomment.length"
                            >{{ item.discussionmessagecomment.length }}
                            {{
                              item.discussionmessagecomment.length > 1
                                ? "comments"
                                : "comment"
                            }}</small
                          >
                        </span>
                        <small
                          class="cursor-pointer"
                          @click="addmessagecomment(item, index)"
                        >
                          <b-icon icon="arrow-counterclockwise"></b-icon> Reply
                        </small>
                      </div>
                      <div
                        class="
                          bg-white
                          rounded
                          p-3
                          message_comment
                          position-relative
                        "
                        v-if="item.discussionmessagecomment.length"
                      >
                        <span class="mytext">
                          <text-to-speech
                            :text="replies(item.discussionmessagecomment)"
                            :voice="voices"
                          ></text-to-speech
                        ></span>
                        <div
                          v-for="(
                            reply, index
                          ) in item.discussionmessagecomment.slice(0, 2)"
                          :key="index"
                          class="mb-1 d-flex align-items-start"
                        >
                          <div class="d-flex flex-1">
                            <b-avatar
                              v-if="reply.admin"
                              size="sm"
                              :src="reply.admin.profile"
                              class="mr-1 message_comment_avatar"
                            ></b-avatar>
                            <b-avatar
                              v-if="reply.facilitator"
                              size="sm"
                              :src="reply.facilitator.profile"
                              class="mr-1 message_comment_avatar"
                            ></b-avatar>
                            <b-avatar
                              v-if="reply.user"
                              size="sm"
                              :src="reply.user.profile"
                              class="mr-1 message_comment_avatar"
                            ></b-avatar>
                            <span
                              ><span
                                v-if="reply.admin"
                                class="message_comment_name mr-1"
                                >{{ reply.admin.name }}</span
                              >
                              <span
                                v-if="reply.facilitator"
                                class="message_comment_name mr-1"
                                >{{ reply.facilitator.username }}</span
                              >
                              <span
                                v-if="reply.user"
                                @click="
                                  $router.push(
                                    `/me/profile/${reply.user.username}`
                                  )
                                "
                                class="message_comment_name mr-1"
                                >{{ reply.user.username }}</span
                              >
                              <span
                                class="message_comment_text"
                                v-html="
                                  $options.filters.tagsfilter(reply.message)
                                "
                              >
                              </span
                            ></span>
                          </div>
                          <div class="text-right">
                            <span class="message_comment_date">{{
                              $moment(reply.created_at).fromNow()
                            }}</span>
                          </div>
                        </div>
                        <small
                          v-if="item.discussionmessagecomment.length > 3"
                          class="cursor-pointer mr-2"
                          @click="viewmessagecomment(item)"
                          >View all comments
                        </small>
                      </div>
                    </div>
                    <div
                      class="py-2 d-flex justify-content-end"
                      v-if="rows > 10"
                    >
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
                </div>
                <div class="py-1 px-3 text-post">
                  <b-form @submit.prevent="post" class="wrapper">
                    <b-form-group>
                      <editor
                        api-key="0faxd6jp8vlrnoj74njdtskkywu2nqvbuta5scv42arkdczq"
                        @keyup.enter="post"
                        class="regular-input mb-4"
                        placeholder="Start typing here.."
                        v-model="info.message"
                        :init="{
                          height: 150,
                          menubar: false,
                          content_style: font,
                          font_formats: 'Poppins',
                          plugins: [
                            '  lists link  charmap   anchor',
                            'searchreplace visualblocks code fullscreen',
                            '  table paste code',

                          ],

                          toolbar:
                            ' styleselect | bold italic | \
           alignleft aligncenter alignright alignjustify | \
           bullist numlist  ',
                        }"
                      />
                    </b-form-group>

                    <div class="d-flex justify-content-between">
                      <div class="d-none d-md-block">
                        <emoji-picker @emoji="insert" :search="search">
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
                          <div
                            slot="emoji-picker"
                            slot-scope="{ emojis, insert }"
                          >
                            <div class="emoji-picker">
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
                      </div>
                      <div
                        class="
                          d-flex
                          justify-content-between
                          align-items-center
                          w-100
                        "
                      >
                        <div class="share text-left">
                          <span
                            class="mr-3 fs12 cursor-pointer"
                            @click="$bvModal.show('share')"
                            >Share
                            <b-icon icon="share-fill" font-scale=".9"></b-icon
                          ></span>
                          <span
                            class="fs12 cursor-pointer"
                            @click="$bvModal.show('invite')"
                            >Invite
                            <b-icon
                              icon="person-plus-fill"
                              font-scale=".9"
                            ></b-icon
                          ></span>
                        </div>
                        <div class="d-flex align-items-center">
                          <Attachment @getUpload="getUpload" class="" />
                          <speech-to-text
                            class="mx-2"
                            @getText="getText"
                          ></speech-to-text>
                          <b-button variant="dark-green" size="sm" type="submit"
                            >Reply</b-button
                          >
                        </div>
                      </div>
                    </div>
                  </b-form>
                </div>
              </div>
            </div>
          </b-col>
          <b-col sm="4" class="d-none d-md-block">
            <div class="bg-white p-4 rounded">
              <div class="py-3 text-left related_quest border" v-if="related">
                <h6 class="mb-3 px-3">Related Discussions</h6>
                <div v-for="item in related" :key="item.id">
                  <div
                    class="d-flex p-2 px-3 cursor-pointer"
                    v-if="item.type == 'public'"
                    @click="joindiscussion(item)"
                  >
                    <div v-if="item.discussionmessage.length">
                      <div>
                        <div class="mr-3 related_count">
                          {{ item.discussionmessage.length }}
                        </div>
                      </div>
                    </div>
                    <div class="related text-left">{{ item.name }}</div>
                  </div>
                  <div
                    class="d-flex p-2 px-3"
                    v-else
                    @click="$bvModal.show('access')"
                  >
                    <div>
                      <div class="mr-3 related_count">
                        {{ item.discussionmessage.length }}
                      </div>
                    </div>
                    <div class="related text-left">{{ item.name }}</div>
                  </div>
                </div>
              </div>
            </div>
          </b-col>
        </b-row>
        <div v-else class="p-5">
          <div class="d-flex w-100 mb-3">
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

          <div class="d-flex w-100 mb-3">
            <div class="mr-1 mb-3">
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
          <div class="d-flex w-100 mb-3">
            <div class="mr-1 mb-3">
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
      </b-container>
      <b-modal id="access" title="Request Access" hide-footer centered>
        <div class="text-center">
          <p class="mb-4 fs16">Do you wish to join this discussion?</p>
          <b-button
            variant="outline-dark"
            class="mr-3"
            size="sm"
            @click="$bvModal.hide('access')"
            >Cancel</b-button
          >
          <b-button variant="dark" size="sm" @click="requestAccess"
            >Send a request</b-button
          >
        </div>
      </b-modal>
      <b-modal no-close-on-backdrop id="share" hide-footer centered size="lg">
        <div class="p-2 text-center">
          <h6 class="font-weight-bold mb-3">Share Invite</h6>
          <ShareNetwork
            v-if="discussion.name"
            class="mr-3"
            network="facebook"
            :url="link"
            title="DISCUSSION INVITATION"
            :description="`I just joined a discussion, ${discussion.name.toUpperCase()}  on Nzukoor and I’d like to hear your thoughts. Lets discuss!`"
            quote="Nzukoor"
            hashtags="Nzukoor,  Social learning"
          >
            <b-button variant="outline-dark-green"
              ><b-icon class="mr-1" icon="facebook"></b-icon>
              <span class="d-none d-md-block">Facebook</span></b-button
            >
          </ShareNetwork>
          <ShareNetwork
            v-if="discussion.name"
            class="mr-3"
            network="twitter"
            :url="link"
            title="DISCUSSION INVITATION"
            :description="`I just joined a discussion, ${discussion.name.toUpperCase()}  on Nzukoor and I’d like to hear your thoughts. Lets discuss!`"
            quote="Nzukoor"
            hashtags="Nzukoor,  Social learning"
          >
            <b-button variant="outline-dark-green"
              ><b-icon class="mr-1" icon="twitter"></b-icon>
              <span class="d-none d-md-block">Twitter</span>
            </b-button>
          </ShareNetwork>
          <ShareNetwork
            v-if="discussion.name"
            class="mr-3"
            network="whatsApp"
            :url="link"
            title="DISCUSSION INVITATION"
            :description="`I just joined a discussion, ${discussion.name.toUpperCase()}  on Nzukoor and I’d like to hear your thoughts. Lets discuss!`"
            quote="Nzukoor"
            hashtags="Nzukoor,  Social learning"
          >
            <b-button variant="outline-dark-green">
              <b-iconstack>
                <b-icon
                  stacked
                  icon="circle-fill"
                  variant="dark-green"
                ></b-icon>
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
            v-if="discussion.name"
            class="mr-3"
            network="Telegram"
            :url="link"
            title="DISCUSSION INVITATION"
            :description="`I just joined a discussion, ${discussion.name.toUpperCase()}  on Nzukoor and I’d like to hear your thoughts. Lets discuss!`"
            quote="Nzukoor"
            hashtags="Nzukoor,  Social learning"
          >
            <b-button variant="outline-dark-green"
              ><b-icon class="mr-1" icon="cursor-fill"></b-icon>
              <span class="d-none d-md-block">Telegram</span>
            </b-button>
          </ShareNetwork>
          <b-button variant="outline-dark-green" @click="addToFeed">
            <b-icon icon="rss-fill" variant="dark-green"></b-icon>

            <span class="d-none d-md-block">Feeds</span></b-button
          >
        </div>
      </b-modal>

      <b-modal no-close-on-backdrop id="invite" size="sm" centered hide-footer>
        <div class="box text-center">
          <h6 class="text-center">Invite your friends</h6>
          <div class="mb-4">
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
                  v-model="item.email"
                  placeholder="Enter email address"
                ></b-form-input>
              </b-input-group>
            </div>
            <div class="text-center mt-3">
              <b-button
                size="sm"
                class="mr-3 py-1 px-2 fs12"
                variant="lighter-green"
                @click="addinvite"
              >
                <b-icon icon="plus" font-scale="1.4"></b-icon> Add
                email</b-button
              >
              <b-button
                size="sm"
                variant="dark-green"
                class="fs12 py-1 px-2"
                @click="sendinvite(discussion.name)"
                :disabled="isDisabled"
              >
                Send Invite
              </b-button>
            </div>
          </div>
          <div class="connections p-3 border rounded" v-if="auth">
            <h6 class="mb-3 fs13 text-left">Connections</h6>
            <div
              class="px-2 py-1 d-flex align-items-center search bg-light mb-3"
            >
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
            </div>
            <div v-for="(item, id) in filteredConnections" :key="id">
              <div
                v-if="item.user_follower"
                class="d-flex align-items-end mb-4"
              >
                <b-form-checkbox
                  size="sm"
                  v-model="emails"
                  :value="item.user_follower.email"
                >
                  <div class="d-flex align-items-center flex-1">
                    <b-avatar class="mr-2" size="1.3rem"></b-avatar>
                    <div class="text-left" style="line-height: 1.1">
                      <span class="fs12">{{
                        item.user_follower.username
                      }}</span>
                    </div>
                  </div>
                </b-form-checkbox>
              </div>
              <div v-else class="d-flex align-items-end mb-4">
                <b-form-checkbox
                  size="sm"
                  :value="item.facilitator_follower.email"
                  v-model="emails"
                >
                  <div class="d-flex align-items-center flex-1">
                    <b-avatar class="mr-2" size="1.3rem"></b-avatar>
                    <div>
                      <span>{{ item.facilitator_follower.username }}</span>
                    </div>
                  </div>
                </b-form-checkbox>
              </div>
            </div>
          </div>
        </div>
      </b-modal>
      <b-modal id="media" centered hide-footer>
        <div class="text-center">
          <cld-image
            v-if="
              info.attachment && img_ext.includes(getextension(info.attachment))
            "
            :publicId="info.publicId"
            width="250"
            crop="fill"
          >
            <cld-transformation radius="20" />
          </cld-image>

          <cld-video
            controls
            v-if="
              info.attachment && vid_ext.includes(getextension(info.attachment))
            "
            :publicId="info.publicId"
          >
            <cld-transformation height="200" width="300" crop="crop" />
          </cld-video>
          <b-input-group class="mt-1 bg-light">
            <template #append>
              <b-input-group-text class="border-0 bg-transparent">
                <b-icon
                  @click="post"
                  font-scale="1"
                  icon="cursor-fill"
                  class="text-dark cursor-pointer"
                ></b-icon>
              </b-input-group-text>
            </template>
            <template #prepend>
              <b-input-group-text
                class="border-0 bg-transparent d-none d-md-block"
                ><span class=""
                  ><b-icon
                    icon="emoji-smile-fill"
                    class="text-dark cursor-pointer"
                    font-scale="1"
                  ></b-icon></span
              ></b-input-group-text>
            </template>
            <b-form-input
              @keyup.enter="post"
              v-model="info.message"
              autocomplete="off"
              autocorrect="off"
              placeholder="Enter caption"
              class="border-0 no-focus rounded-pill fs13"
            ></b-form-input>
          </b-input-group>
        </div>
      </b-modal>
      <b-modal id="addcomment" centered hide-footer>
        <div v-html="comment_message"></div>
        <b-form @submit.prevent="replyPost" class="">
          <b-form-group>
            <b-form-textarea
              @keyup.enter="replyPost"
              class="regular-input mb-4"
              placeholder="Start typing here.."
              v-model="reply.message"
            ></b-form-textarea>
          </b-form-group>

          <div class="d-flex align-items-center justify-content-end">
            <div class="mr-2">
              <emoji-picker @emoji="insertReply" :search="search">
                <div
                  class=""
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
                      <div
                        v-for="(emojiGroup, category) in emojis"
                        :key="category"
                      >
                        <h5>{{ category }}</h5>
                        <div class="emojis">
                          <span
                            v-for="(emoji, emojiName) in emojiGroup"
                            :key="emojiName"
                            @click="insert(emoji, 'reply')"
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
            <b-button variant="dark-green" size="sm" type="submit"
              >Reply</b-button
            >
          </div>
        </b-form>
      </b-modal>
      <b-modal
        id="allcomment"
        title="Comments"
        centered
        hide-footer
        v-if="comments"
      >
        <div>
          <div class="d-flex align-items-center">
            <span class="">
              <b-avatar
                size="sm"
                :src="comments.admin.profile"
                v-if="comments.admin"
                class="mr-1 member"
              ></b-avatar>
              <b-avatar
                size="sm"
                :src="comments.user.profile"
                v-if="comments.user"
                class="mr-1 member"
              ></b-avatar>
              <b-avatar
                size="sm"
                :src="comments.facilitator.profile"
                v-if="comments.facilitator"
                class="mr-1 member"
              ></b-avatar>
            </span>
            <span v-if="comments.admin" class="fs12 cursor-pointer">{{
              comments.admin.name
            }}</span>
            <span
              v-if="comments.user"
              @click="$router.push(`/profile/${comments.user.username}`)"
              class="fs12 cursor-pointer hover_green"
              >{{ comments.user.username }}</span
            >
            <span
              v-if="comments.facilitator"
              @click="$router.push(`/profile/f/${comments.facilitator.id}`)"
              class="fs12 cursor-pointer hover_green"
              >{{ comments.facilitator.username }}</span
            >
          </div>
          <div
            v-if="comments.message"
            v-html="$options.filters.tagsfilter(comments.message)"
          ></div>
          <div
            v-for="(reply, index) in comments.discussionmessagecomment"
            :key="index"
            class="mb-1 d-flex align-items-start"
          >
            <div class="d-flex flex-1">
              <b-avatar
                v-if="reply.admin"
                size="sm"
                :src="reply.admin.profile"
                class="mr-1 message_comment_avatar"
              ></b-avatar>
              <b-avatar
                v-if="reply.facilitator"
                size="sm"
                :src="reply.facilitator.profile"
                class="mr-1 message_comment_avatar"
              ></b-avatar>
              <b-avatar
                v-if="reply.user"
                size="sm"
                :src="reply.user.profile"
                class="mr-1 message_comment_avatar"
              ></b-avatar>
              <span
                ><span v-if="reply.admin" class="message_comment_name mr-1">{{
                  reply.admin.name
                }}</span>
                <span
                  v-if="reply.facilitator"
                  class="message_comment_name mr-1"
                  >{{ reply.facilitator.username }}</span
                >
                <span v-if="reply.user" class="message_comment_name mr-1">{{
                  reply.user.username
                }}</span>
                <span class="message_comment_text">
                  {{ reply.message }}
                </span></span
              >
            </div>
            <div class="text-right">
              <span class="message_comment_date">{{
                $moment(reply.created_at).fromNow()
              }}</span>
            </div>
          </div>
        </div>
      </b-modal>
    </div>

    <div class="tribe_join animated animate_fadeIn" v-show="toggleJoin">
      <div class="position-absolute p-3 p-md-5  rounded bg-white">
        <span class="cancel"  @click="toggleJoin = !toggleJoin">
          <b-icon
            icon="x"
            class="text-white"

          ></b-icon>
        </span>
        <div class="mb-4 text-center font-weight-bold text-dark-green">
          OOPS! You need to join this tribe to post a reply
        </div>

        <div
          class="d-flex flex-column flex-md-row text-left"
          v-if="discussion.tribe"
        >
          <b-avatar
            class="mb-4 mb-md-0 mr-md-3"
            :src="discussion.tribe.cover"
            size="4rem"
          ></b-avatar>
          <span>
            <span class="font-weight-bold">{{ discussion.tribe.name }}</span>
            <br />
            <span>{{ discussion.tribe.description }}</span>
          </span>
        </div>
        <div class="mt-4 text-right">
          <b-button @click="jointribe"
            >Join Tribe <b-icon icon="arrow-right"></b-icon
          ></b-button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import EmojiPicker from "vue-emoji-picker";
import Attachment from "@/components/miniupload";
import Editor from "@tinymce/tinymce-vue";
import SpeechToText from "@/components/speechToText";
import TextToSpeech from "@/components/textToSpeech";

export default {
  data() {
    return {
      isDisabled: false,
      toggleJoin: false,
      description: "",
      members: [],
      auth: false,
      index: null,
      img_ext: ["jpg", "png", "jpeg", "gif"],
      vid_ext: ["mp4", "3gp"],
      aud_ext: ["mp3"],
      doc_ext: ["docx", "pdf", "ppt", "zip"],
      discussion: {},

      link: "",
      info: {
        attachment: "",
        message: "",
        discussion_id: null,
        publicId: null,
      },
      myviews: null,
      search: "",
      feed: {},
      inviteUsers: {
        title: "",
        users: [],
      },
      connections: [],
      emails: [],
      play: "",

      record: "",
      showdiscussion: false,
      comment_message: "",
      reply: {
        message: "",
        message_id: null,
        discussion_id: null,
      },
      currentPage: 1,
      rows: null,
      perPage: 10,
      comments: {},
      toggleview: "recent",
      font: "@import url('https://fonts.googleapis.com/css2?family=Open+Sans&family=Poppins:ital,wght@0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,200&display=swap');body{font-family:Poppins;font-size:13px}",
    };
  },
  components: {
    EmojiPicker,
    Attachment,
    SpeechToText,
    TextToSpeech,
    Editor,
  },
  created() {
    this.link =
      "https://nzukoor.com/g/discussion/" + this.$route.params.id;

    // var channel = this.$pusher.subscribe("adddiscussion");

    // channel.bind("adddiscussion", (data) => {
    //   this.$toast.success("Posted");
    //   this.discussion.discussionmessage.unshift(data.message);
    // });
    if (localStorage.getItem("authMember")) {
      this.auth = true;
    }
  },
  mounted() {
    this.getdiscussion();
    this.getconnections();
  },
  computed: {
    useraccess() {
      var token = null;
      if (localStorage.getItem("authAdmin")) {
        return this.$store.getters.admin;
      }
      if (localStorage.getItem("authFacilitator")) {
        return this.$store.getters.facilitator;
      }
      if (localStorage.getItem("authMember")) {
        return this.$store.getters.member;
      }
      return token;
    },
    filteredDiscussion() {
      var res = this.posts.slice();
      if (this.toggleview == "recent") {
        return res.slice(
          this.perPage * this.currentPage - this.perPage,
          this.perPage * this.currentPage
        );
      }
      if (this.toggleview == "oldest") {
        return res
          .reverse()
          .slice(
            this.perPage * this.currentPage - this.perPage,
            this.perPage * this.currentPage
          );
      }
      return res
        .sort((a, b) => {
          return (
            Number(b.discussionmessagecomment.length) -
            Number(a.discussionmessagecomment.length)
          );
        })
        .slice(
          this.perPage * this.currentPage - this.perPage,
          this.perPage * this.currentPage
        );
    },
    thread() {
      var thread = this.discussion.discussionmessage.map((item) => {
        if (item.admin) {
          return `${item.admin.name}, ${this.toText(item.message)} ... `;
        }
        if (item.facilitator) {
          return `${item.facilitator.username}, ${this.toText(
            item.message
          )} ... `;
        }
        if (item.user) {
          return `${item.user.username}, ${this.toText(item.message)} ... `;
        }
      });
      if (this.discussion.admin) {
        thread.unshift(
          `${this.discussion.name} by ${this.discussion.admin.name} . ${this.discussion.description} ... `
        );
      }
      if (this.discussion.facilitator) {
        thread.unshift(
          `${this.discussion.name} by ${this.discussion.facilitator.username}. ${this.discussion.description} ... `
        );
      }
      if (this.discussion.user) {
        thread.unshift(
          `${this.discussion.name} by ${this.discussion.user.username}. ${this.discussion.description} ... `
        );
      }
      return thread.toString();
    },
    voices() {
      return this.$store.getters.voices[
        Number(this.$store.getters.member.voice)
      ];
    },
    related() {
      if (!this.discussion.related) {
        return [];
      }
      return this.discussion.related.filter(
        (item) => Number(item.id) != Number(this.$route.params.id)
      );
    },
    posts() {
      return this.discussion.discussionmessage;
    },
    views() {
      return this.discussion.discussionview;
    },
    vote() {
      return this.discussion.discussionvote;
    },
    filteredConnections() {
      return this.connections.filter((item) => {
        if (item.user_follower) {
          return item.user_follower.name
            .toLowerCase()
            .includes(this.search.toLowerCase());
        }
      });
    },
  },
  methods: {
    jointribe() {
      if (!this.auth) {
        this.$router.push(
          `/login?tribe_id=${this.discussion.tribe.id}&discussion_id=${this.discussion.id}&type=join_tribe`
        );
      } else {
        this.entertribe(this.discussion.tribe.id);
      }
    },
    entertribe(id) {
      var details = {
        tribe_id: id,
        user: this.$store.getters.member,
      };

      this.$store.dispatch("checkTribe", details).then((res) => {
        if (res.status == 200 && res.data.message == "found") {
          window.location.href = `/me/tribe/${this.discussion.tribe_id}/discussion/${this.discussion.id}`;
        } else {
          this.$bvModal
            .msgBoxConfirm("Do you wish to join this tribe?")
            .then((val) => {
              if (val) {
                this.$store.dispatch("joinTribe", details).then((res) => {
                  if (res.status == 200 && res.data.message == "successful") {
                    this.$toast.success("Joined successfully");
                    window.location.href = `/me/tribe/${this.discussion.tribe_id}/discussion/${this.discussion.id}`;
                  }
                });
              }
            });
        }
      });
    },
    drop(id) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(
              `${this.$store.getters.url}/discussions/${id}`,

              {
                headers: {
                  Authorization: `Bearer ${this.$store.getters.member.access_token}`,
                },
              }
            )
            .then((res) => {
              if (res.status == 200) {
                this.$router.go(-1);
              }
            })
            .catch((err) => {
              this.$toast.error(err.response.data.message);
            });
        }
      });
    },
    getmembers() {
      this.$http
        .get(
          `${this.$store.getters.url}/get/discussion/mes/${this.$route.params.id}`
        )
        .then((res) => {
          this.members = res.data;
        });
    },

    requestAccess() {
      var data = {
        discussion_id: this.discussion.id,
      };

      this.$http
        .post(`${this.$store.getters.url}/join-discussion`, data, {
          headers: {
            Authorization: `Bearer ${this.useraccess.access_token}`,
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
      if (!this.useraccess) {
        this.$router.push("/login?redirect=%2Fexplore%2Fcommunity");
      }
      if (
        (item.user && item.user.id == this.$store.getters.member.id) ||
        (item.facilitator &&
          item.facilitator_id.id == this.$store.getters.facilitator.id)
      ) {
        this.$router.push(`/discussion/${item.id}`);
      } else {
        this.$http
          .get(`${this.$store.getters.url}/discussion/private/${item.id}`, {
            headers: {
              Authorization: `Bearer ${this.useraccess.access_token}`,
            },
          })
          .then((res) => {
            if (res.status == 200) {
              var result;
              if (item.user) {
                result = res.data
                  .map((item) => item.user_id)
                  .includes(this.useraccess.id);
              }
              if (item.facilitator) {
                result = res.data
                  .map((item) => item.facilitator_id)
                  .includes(this.useraccess.id);
              }
              if (result) {
                this.$router.push(`/discussion/${item.id}`);
              } else {
                this.discussion_id = item.id;
                this.$bvModal.show("access");
              }
            }
          });
      }
    },
    refresh() {
      this.getdiscussion;
    },
    addmessagecomment(val, index) {
      this.index = index;
      this.reply.message_id = val.id;
      this.comment_message = val.message;
      this.$bvModal.show("addcomment");
    },
    viewmessagecomment(val) {
      this.comments = val;
      this.$bvModal.show("allcomment");
    },
    replies(val) {
      var thread = val.map((item) => {
        if (item.admin) {
          return `${item.admin.name}, ${item.message}...  `;
        }
        if (item.facilitator) {
          return `${item.facilitator.username}, ${item.message}...  `;
        }
        if (item.user) {
          return `${item.user.username}, ${item.message}...  `;
        }
      });

      return thread.toString();
    },
    replyPost() {
      if (!this.auth) {
        this.toggleJoin = true;
        return;
      }
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
    getText(res) {
      this.info.message = `${this.info.message} ${res}`;
    },
    getconnections() {
      if (!this.auth) {
        return;
      }
      this.$http
        .get(`${this.$store.getters.url}/connections`, {
          headers: {
            Authorization: `Bearer ${this.useraccess.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.connections = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    addToFeed() {
      if (!this.auth) {
        this.$toast.info("Login to post");
        return;
      }
      this.feed = {
        tags: [],
        message:
          "I just started a discussion, " +
          this.discussion.name.toUpperCase() +
          " and I’d like to hear your thoughts",
        url: "https://nzukoor.com/g/discussion/" + this.discussion.id,
      };
      this.$http
        .post(`${this.$store.getters.url}/feeds`, this.feed, {
          headers: {
            Authorization: `Bearer ${this.useraccess.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201 || res.status == 200) {
            this.$toast.success("Added to feeds ");
            this.$bvModal.hide("share");

            this.feed = {
              media: "",
              message: "",
            };
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    sendinvite() {
      this.isDisabled = true;
      var emails = this.emails.map((item) => {
        return {
          email: item,
        };
      });
      this.inviteUsers.title = this.discussion.name;
      this.inviteUsers.id = this.discussion.id;
      this.inviteUsers.users = this.inviteUsers.users.concat(emails);
      this.$http
        .post(
          `${this.$store.getters.url}/guest/send/discussion/invite`,
          this.inviteUsers
        )
        .then((res) => {
          if (res.status == 200) {
            this.isDisabled = false;
            this.$toast.success("Invite Sent");
            this.$bvModal.hide("invite");
            this.inviteUsers = {
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
          this.isDisabled = false;
        });
    },
    addinvite() {
      this.inviteUsers.users.push({
        email: "",
      });
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

      this.info.attachment = val.secure_url;
      this.info.publicId = val.public_id;
      this.$bvModal.show("media");
    },
    insert(emoji) {
      this.info.message += " " + emoji;
    },
    insertReply(emoji) {
      this.reply.message += " " + emoji;
    },

    getdiscussion() {
      this.$http
        .get(
          `${this.$store.getters.url}/guest/discussions/${this.$route.params.id}`
        )
        .then((res) => {
          if (res.status == 200) {
            this.discussion = res.data;

            this.rows = res.data.discussionmessage.length;
            window.document.title = `${res.data.name} | Nzukoor`;
            this.showdiscussion = true;
            if (
              this.discussion.user &&
              this.$store.getters.member &&
              this.discussion.user.id == this.$store.getters.member.id
            ) {
              this.description = `I just started a discussion, *${this.discussion.name}*  on Nzukoor and I’d like to hear your thoughts.  Let's discuss!`;
            } else {
              this.description = `I just joined a discussion, *${this.discussion.name}*  on Nzukoor and I’d like to hear your thoughts. Let's discuss!`;
            }
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    post() {
      this.toggleJoin = true;
    },
    addview() {
      if (!this.auth) {
        return;
      }
      this.$http
        .get(`${this.$store.getters.url}/add-view/${this.$route.params.id}`, {
          headers: {
            Authorization: `Bearer ${this.useraccess.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200 || res.status == 201) {
            this.myviews = res.data.view;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    getvote() {
      if (!this.auth) {
        return;
      }
      this.$http
        .get(`${this.$store.getters.url}/votes/${this.$route.params.id}`, {
          headers: {
            Authorization: `Bearer ${this.useraccess.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.topvote = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    addvote() {
      if (!this.auth) {
        this.$toast.info("Login to complete action");
        return;
      }
      this.$http
        .post(
          `${this.$store.getters.url}/votes`,
          { id: this.$route.params.id, vote: 1 },
          {
            headers: {
              Authorization: `Bearer ${this.useraccess.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 201) {
            this.discussion.discussionvote.push(res.data);
          }
          if (res.status == 200) {
            this.discussion.discussionvote.map((item) => {
              if (
                this.$store.getters.member.id &&
                item.user_id == this.$store.getters.member.id
              ) {
                return (item.vote = res.data.vote);
              }
              if (
                this.$store.getters.facilitator.id &&
                item.facilitator_id == this.$store.getters.facilitator.id
              ) {
                return (item.vote = res.data.vote);
              }
            });
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    dropvote() {
      if (!this.auth) {
        this.$toast.info("Login to complete action");
        return;
      }
      this.$http
        .post(
          `${this.$store.getters.url}/votes`,
          { id: this.$route.params.id, vote: 0 },
          {
            headers: {
              Authorization: `Bearer ${this.useraccess.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 201) {
            this.discussion.discussionvote.push(res.data);
          }
          if (res.status == 200) {
            this.discussion.discussionvote.map((item) => {
              if (
                this.$store.getters.member.id &&
                item.user_id == this.$store.getters.member.id
              ) {
                return (item.vote = res.data.vote);
              }
              if (
                this.$store.getters.facilitator.id &&
                item.facilitator_id == this.$store.getters.facilitator.id
              ) {
                return (item.vote = res.data.vote);
              }
            });
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
  },
  directives: {
    focus: {
      inserted(el) {
        el.focus();
      },
    },
  },
};
</script>

<style scoped lang="scss">
.image {
  width: 80%;
  height: auto;
  margin: 0 auto;
}
.wrapper {
  position: relative;
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
  z-index: 9;
}
.emoji-invoker:hover {
  transform: scale(1.1);
}
.emoji-invoker > svg {
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
  bottom: 10rem;
  right: 0;
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

.top_header div {
  font-size: 14px;
  color: rgba($color: #000000, $alpha: 0.54);
  position: relative;
  padding: 10px 12px;
  cursor: pointer;
  text-transform: capitalize;
}
.top_header div::after {
  content: "";
  position: absolute;
  bottom: 0;
  width: 100%;
  border-bottom: 2px solid transparent;
  left: 0;
}
.top_header div:hover::after {
  border-color: var(--dark-green);
}
.top_header div.active::after {
  border-color: var(--dark-green);
}
.top_header div.active {
  color: var(--dark-green);
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

.document {
  width: 40%;
  margin: 10px auto;
}
@media (max-width: 600px) {
  .document {
    width: 100%;
    margin: 10px auto;
  }
  .btn-sm,
  .btn-group-sm > .btn {
    padding: 0.25rem 0.5rem;
    font-size: 0.75rem;
    line-height: 1.5;
    border-radius: 0.2rem;
  }
}
.crumbs {
  font-size: 0.8rem;
}
</style>

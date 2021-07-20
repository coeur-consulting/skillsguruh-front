<template>
  <div>
    <b-container fluid class="">
      <b-row v-if="courses.length" class="h-100">
        <b-col :md="sideOpen ? 8 : 12" class="my_courses main_box bg-light">
          <div
            class="d-flex flex-column flex-sm-row justify-content-between py-4"
          >
            <div class="">
              <h4>Courses</h4>
            </div>
            <div
              class="
                text-sm-right
                d-flex
                align-items-center
                justify-content-center
              "
            >
              <b-icon
                class="mr-3"
                :icon="alpha ? 'sort-alpha-up' : 'sort-alpha-down'"
                @click="alpha = !alpha"
              ></b-icon>

              <b-icon
                class="mr-3"
                icon="funnel"
                @click="$bvModal.show('filter')"
              ></b-icon>
              <div class="search">
                <b-input-group class="topbar_search bg-white">
                  <b-form-input
                    placeholder="Search by title, interest"
                    class="no-focus border-0"
                    type="search"
                    aria-label="Text input "
                    v-model="search"
                  ></b-form-input>
                  <b-input-group-append is-text>
                    <b-iconstack font-scale="1.4" class="">
                      <b-icon
                        stacked
                        icon="circle-fill"
                        variant="lighter-green"
                      ></b-icon>
                      <b-icon
                        stacked
                        icon="search"
                        scale="0.5"
                        variant="dark-green"
                      ></b-icon>
                    </b-iconstack>
                  </b-input-group-append>
                </b-input-group>
              </div>
            </div>
          </div>
          <div v-if="showCourse">
            <b-container fluid class="main-course">
              <b-row>
                <b-col
                  :sm="sideOpen ? 4 : 3"
                  class="mb-3 side_box"
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
                          class="px-2 py-1 rounded-pill text-white fs11"
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
                            JSON.parse(item.courseoutline.knowledge_areas).value
                          }}</span></span
                        >
                        <span class="text-capitalize fs11">{{
                          item.type
                        }}</span>
                      </div>
                      <div class="pt-3 pb-1 text-left">
                        <h6
                          class="
                            font-weight-bold
                            text-capitalize
                            overview-title
                            text-truncate text-truncate--2
                            mb-0
                          "
                        >
                          {{ item.title }}
                        </h6>
                        <div
                          class="fs13 text-truncate text-truncate--2"
                          v-html="item.courseoutline.overview"
                        ></div>
                      </div>
                      <div class="info fs11">
                        <div class="d-flex">
                          <div class="mr-2">
                            <b-icon icon="people" class="mr-1"></b-icon>
                            <span
                              >{{ item.enroll ? item.enroll.count : 0 }}+</span
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
                            <span>{{ item.review.length }} reviews</span>
                          </div>
                        </div>

                        <b-avatar size="sm" variant="light" :src="item.cover">
                        </b-avatar>
                      </div>
                    </div>
                  </div>
                </b-col>
              </b-row>
              <div class="p-3 d-flex justify-content-between" v-if="rows > 10">
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
          <b-row v-else>
            <b-col sm="4" class="mb-4">
              <div class="mb-3"><b-skeleton-img></b-skeleton-img></div>
              <b-skeleton
                animation="fade"
                class="mb-2"
                width="65%"
              ></b-skeleton>
              <b-skeleton
                animation="fade"
                class="mb-2"
                width="55%"
              ></b-skeleton>
              <b-skeleton animation="fade" width="59%"></b-skeleton>
            </b-col>
            <b-col sm="4" class="mb-4">
              <div class="mb-3"><b-skeleton-img></b-skeleton-img></div>
              <b-skeleton
                animation="fade"
                class="mb-2"
                width="65%"
              ></b-skeleton>
              <b-skeleton
                animation="fade"
                class="mb-2"
                width="55%"
              ></b-skeleton>
              <b-skeleton animation="fade" width="59%"></b-skeleton>
            </b-col>
            <b-col sm="4" class="mb-4">
              <div class="mb-3"><b-skeleton-img></b-skeleton-img></div>
              <b-skeleton
                animation="fade"
                class="mb-2"
                width="65%"
              ></b-skeleton>
              <b-skeleton
                animation="fade"
                class="mb-2"
                width="55%"
              ></b-skeleton>
              <b-skeleton animation="fade" width="59%"></b-skeleton>
            </b-col>
            <b-col sm="4" class="mb-4">
              <div class="mb-3"><b-skeleton-img></b-skeleton-img></div>
              <b-skeleton
                animation="fade"
                class="mb-2"
                width="65%"
              ></b-skeleton>
              <b-skeleton
                animation="fade"
                class="mb-2"
                width="55%"
              ></b-skeleton>
              <b-skeleton animation="fade" width="59%"></b-skeleton>
            </b-col>
            <b-col sm="4" class="mb-4">
              <div class="mb-3"><b-skeleton-img></b-skeleton-img></div>
              <b-skeleton
                animation="fade"
                class="mb-2"
                width="65%"
              ></b-skeleton>
              <b-skeleton
                animation="fade"
                class="mb-2"
                width="55%"
              ></b-skeleton>
              <b-skeleton animation="fade" width="59%"></b-skeleton>
            </b-col>
            <b-col sm="4" class="mb-4">
              <div class="mb-3"><b-skeleton-img></b-skeleton-img></div>
              <b-skeleton
                animation="fade"
                class="mb-2"
                width="65%"
              ></b-skeleton>
              <b-skeleton
                animation="fade"
                class="mb-2"
                width="55%"
              ></b-skeleton>
              <b-skeleton animation="fade" width="59%"></b-skeleton>
            </b-col>
            <b-col sm="4" class="mb-4">
              <div class="mb-3"><b-skeleton-img></b-skeleton-img></div>
              <b-skeleton
                animation="fade"
                class="mb-2"
                width="65%"
              ></b-skeleton>
              <b-skeleton
                animation="fade"
                class="mb-2"
                width="55%"
              ></b-skeleton>
              <b-skeleton animation="fade" width="59%"></b-skeleton>
            </b-col>
            <b-col sm="4" class="mb-4">
              <div class="mb-3"><b-skeleton-img></b-skeleton-img></div>
              <b-skeleton
                animation="fade"
                class="mb-2"
                width="65%"
              ></b-skeleton>
              <b-skeleton
                animation="fade"
                class="mb-2"
                width="55%"
              ></b-skeleton>
              <b-skeleton animation="fade" width="59%"></b-skeleton>
            </b-col>
            <b-col sm="4" class="mb-4">
              <div class="mb-3"><b-skeleton-img></b-skeleton-img></div>
              <b-skeleton
                animation="fade"
                class="mb-2"
                width="65%"
              ></b-skeleton>
              <b-skeleton
                animation="fade"
                class="mb-2"
                width="55%"
              ></b-skeleton>
              <b-skeleton animation="fade" width="59%"></b-skeleton>
            </b-col>
          </b-row>
        </b-col>
        <b-col md="4" v-show="sideOpen" class="sidebar toggleSide h-100">
          <span @click="sideOpen = !sideOpen" class="sideopen">
            <b-icon :icon="sideOpen ? 'arrow-right' : 'arrow-left'"></b-icon>
          </span>
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
                    :icon="
                      JSON.parse(course.courseoutline.knowledge_areas).icon
                    "
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
              class="
                d-flex
                justify-content-between
                p-2
                border-bottom
                mb-2
                text-sm
              "
            >
              <span
                class="cursor-pointer d-flex align-items-center"
                :class="{ 'text-dark-green': toggleCourse == 1 }"
                @click="toggleCourse = 1"
              >
                <b-icon
                  font-scale=".5rem"
                  class="mr-1"
                  icon="circle-fill"
                ></b-icon>
                Info</span
              >
              <span
                class="cursor-pointer d-flex align-items-center"
                @click="toggleCourse = 2"
                :class="{ 'text-dark-green': toggleCourse == 2 }"
              >
                <b-icon
                  font-scale=".5rem"
                  class="mr-1"
                  icon="circle-fill"
                ></b-icon>
                Modules</span
              >
              <span
                class="cursor-pointer d-flex align-items-center"
                @click="toggleCourse = 3"
                :class="{ 'text-dark-green': toggleCourse == 3 }"
              >
                <b-icon
                  font-scale=".5rem"
                  class="mr-1"
                  icon="circle-fill"
                ></b-icon>
                General</span
              >
              <span
                class="cursor-pointer d-flex align-items-center"
                @click="toggleCourse = 4"
                :class="{ 'text-dark-green': toggleCourse == 4 }"
              >
                <b-icon
                  font-scale=".5rem"
                  class="mr-1"
                  icon="circle-fill"
                ></b-icon>
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
                      font-scale="1.15"
                      class="ml-auto mr-3 cursor-pointer"
                      @click="sharecourse(course.id)"
                      icon="person-plus-fill"
                    ></b-icon>
                    <b-icon
                      class="cursor-pointer"
                      font-scale="1.15"
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
                        course.courseschedule[0].start_time
                          | moment("MMM DD, YYYY")
                      }}</span>
                    </b-col>
                    <b-col cols="6">
                      <h6 class="fs14 font-weight-bold">End date</h6>
                      <span class="fs14">{{
                        course.courseschedule[0].end_time
                          | moment("MMM DD, YYYY")
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
                      class="mr-2"
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
                      class="mr-2"
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
                      class="mr-2"
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

              <div
                class="accordion"
                role="tablist"
                v-if="course.modules.length"
              >
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
                      <b-icon
                        icon="check2-circle"
                        variant="light-green"
                      ></b-icon>
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
                  v-for="(item, index) in JSON.parse(
                    course.courseoutline.modules
                  )"
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
                          facilitators.find(
                            (val) => val.id == item.facilitator_id
                          ).name
                        }}</span
                      >
                      <span v-else class="text-sm">Unavailable</span>
                    </div>
                  </b-col>
                </b-row>
              </div>
            </div>
          </div>
        </b-col>
      </b-row>
      <b-row v-else>
        <b-col class="empty rounded p-5 text-center">
          <h2 class="mb-3 px-3 text-muted">No Course Available</h2>
          <b-img
            class="mb-4 px-3"
            :src="require('@/assets/images/creator.svg')"
          ></b-img>
          <p class="mb-3">There appears to be no course available</p>
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
          :description="`I enrolled for the course, ${course.title.toUpperCase()} on SkillsGuruh and I think you'd like it. Join me`"
          quote="SkillsGuruh"
          hashtags="SkillsGuruh,  Social learning"
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
          :description="`I enrolled for the course, ${course.title.toUpperCase()} on SkillsGuruh and I think you'd like it. Join me`"
          quote="SkillsGuruh"
          hashtags="SkillsGuruh,  Social learning"
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
          :description="`I enrolled for the course, ${course.title.toUpperCase()} on SkillsGuruh and I think you'd like it. Join me`"
          quote="SkillsGuruh"
          hashtags="SkillsGuruh,  Social learning"
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
          :description="`I enrolled for the course, ${course.title.toUpperCase()} on SkillsGuruh and I think you'd like it. Join me`"
          quote="SkillsGuruh"
          hashtags="SkillsGuruh,  Social learning"
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
  </div>
</template>
<script>
export default {
  data() {
    return {
      sideOpen: true,
      facilitators: [],
      courses: [],
      search: "",
      link: "",
      message: "",
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
      type: 1,
      newmodule: "",
      toggleCourse: 1,
      alpha: false,
      showCourse: false,
      course_type: "",
      recent: false,
      trending: false,
      currentPage: 1,
      rows: null,
      perPage: 12,
    };
  },
  mounted() {
    this.getcourses();
    this.getfacilitators();
  },
  computed: {
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
    addcount(id) {
      this.$http.get(`${this.$store.getters.url}/course/view/${id}`);
    },
    addcourse() {
      this.$toast.info("Register to enroll");
      this.$router.push(
        `/register/?invite=${this.$route.query.invite}&course_id=${this.$route.query.course_id}`
      );
    },
    sharelink(id) {
      this.link = `https://skillsguruh.com/explore/courses/?course=${encodeURIComponent(
        this.course.title.trim()
      )}&course_id=${id}`;
      this.$bvModal.show("share");
    },
    loadCourse() {
      this.course = this.courses.find(
        (item) => item.id == this.$route.query.course_id
      );
      if (window.innerWidth < 600) {
        this.$bvModal.show("mobile-course");
      }
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
      this.sideOpen = true;
      this.addcount(val.id);
      if (window.innerWidth < 600) {
        this.$bvModal.show("mobile-course");
      }
    },
    sortmodules(data) {
      if (!data.courseoutline) {
        return 0;
      }
      return JSON.parse(data.courseoutline.modules).length;
    },
    getcourses() {
      this.$http
        .get(`${this.$store.getters.url}/guest/courses`)
        .then((res) => {
          if (res.status == 200) {
            this.courses = res.data;
            this.showCourse = true;
            this.rows = res.data.length;
          if (this.$route.query.course_id) {
               this.loadCourse();
          }
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
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
      this.message = `https://skillsguruh.com/explore/courses?course_id=${id}`;
      this.$bvModal.show("sharecourse");
    },
    sendinvite(title) {
      this.inviteUsers.title = title;
      this.inviteUsers.url = this.message;

      if (this.$store.getters.learner.access_token) {
        this.$http
          .post(`${this.$store.getters.url}/send/invite`, this.inviteUsers, {
            headers: {
              Authorization: `Bearer ${this.$store.getters.learner.access_token}`,
            },
          })
          .then((res) => {
            if (res.status == 200) {
              this.$toast.success("Invite Sent");
              this.$bvModal.hide("sharecourse");
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
            this.$toasted.error("Sending failed!");
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
            this.$toasted.error("Sending failed!");
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
            this.$toasted.error("Sending failed!");
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
.container-fluid {
  height: 100vh;
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
  height: 8rem;
  object-fit: cover;
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
@media (max-width: 600px) {
  h4,
  h5 {
    font-size: 1.15rem;
  }
}
</style>

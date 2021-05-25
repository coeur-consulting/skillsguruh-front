<template>
  <div>
    <b-modal
      size="lg"
      id="addcourse"
      centered
      hide-footer
      title="Create a new course"
    >
      <b-form @submit.prevent="createcourse">
        <div class="mb-3 border-bottom">
          <b-container class="pb-2 d-flex align-items-center">
            <span
              class="mr-5 d-flex align-items-center fs13 cursor-pointer"
              :class="{ 'text-dark-green': type == 1 }"
              @click="type = 1"
              ><b-icon
                icon="circle-fill"
                class="mr-1"
                font-scale=".45rem"
              ></b-icon>
              General</span
            >
            <span
              class="mr-5 d-flex align-items-center fs13 cursor-pointer"
              :class="{ 'text-dark-green': type == 2 }"
              @click="type = 2"
              ><b-icon
                icon="circle-fill"
                class="mr-1"
                font-scale=".45rem"
              ></b-icon>
              Course Outline</span
            >
            <span
              class="d-flex align-items-center fs13 cursor-pointer"
              :class="{ 'text-dark-green': type == 3 }"
              @click="type = 3"
            >
              <b-icon
                icon="circle-fill"
                class="mr-1"
                font-scale=".45rem"
              ></b-icon
              >Course Schedule</span
            >
          </b-container>
        </div>
        <b-container v-show="type == 1">
          <b-form-row>
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="Course title">
                <b-form-input
                  placeholder="Enter course title"
                  v-model="detail.general.title"
                ></b-form-input>
              </b-form-group>
            </b-col>
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="Course code (optional)">
                <b-form-input
                  v-model="detail.general.code"
                  placeholder="Enter course code (optional)"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-form-row>
          <b-form-row>
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="Course Description">
                <b-form-textarea
                  v-model="detail.general.description"
                  rows="5"
                  placeholder="Enter Description"
                ></b-form-textarea>
              </b-form-group>
            </b-col>
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="Course Cover">
                <Upload @getUpload="getUpload">
                  <div class="text-center">
                    <b-icon icon="image" font-scale="6rem"></b-icon>
                  </div>
                </Upload>
              </b-form-group>
            </b-col>
          </b-form-row>
        </b-container>
        <b-container v-show="type == 2">
          <b-form-row class="px-1">
            <b-col class="mb-2 px-3">
              <b-form-group label="Overview">
                <b-textarea
                  rows="3"
                  v-model="detail.outline.overview"
                ></b-textarea>
              </b-form-group>
            </b-col>
          </b-form-row>
          <b-form-row class="px-1">
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="Knowledge area">
                <b-form-select
                  class="text-capitalize"
                  v-model="detail.outline.knowledge_area"
                >
                  <b-form-select-option
                    :value="ins"
                    v-for="(ins, id) in insight"
                    :key="id"
                    >{{ ins }}</b-form-select-option
                  >
                </b-form-select>
              </b-form-group>
            </b-col>
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="Duration">
                <b-form-input
                  v-model="detail.outline.duration"
                  placeholder="Enter course duration"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-form-row>
          <div>
            <div class="mb-3 px-3">
              <div class="border rounded p-2">
                <b-form-group label="Modules">
                  <b-input-group class="addmodule mb-3">
                    <b-form-input v-model="newmodule"></b-form-input>
                    <b-input-group-append>
                      <b-button variant="dark-green" @click="addmodule"
                        >Add module</b-button
                      >
                    </b-input-group-append>
                  </b-input-group>

                  <div>
                    <b-row>
                      <b-col
                        v-for="(item, id) in detail.outline.modules"
                        :key="id"
                        sm="6"
                      >
                        <div
                          class="border rounded bg-lighter-green px-5 py-2 mb-2"
                        >
                          <span class="mr-4 text-capitalize">{{ item }}</span>
                          <b-icon
                            icon="x"
                            @click="detail.outline.modules.splice(id, 1)"
                          ></b-icon>
                        </div>
                      </b-col>
                    </b-row>
                  </div>
                </b-form-group>
              </div>
            </div>
          </div>

          <div class="px-3 mb-3">
            <div class="p-2 border rounded">
              <label class="d-flex justify-content-between">
                <span>Faqs</span>
                <div>
                  <b-button size="sm" @click="addfaq">Add</b-button>
                </div>
              </label>
              <b-form-row>
                <b-col
                  sm="6"
                  v-for="(item, id) in detail.outline.faqs"
                  :key="id"
                  class="d-flex"
                >
                  <b-form-group class="flex-1">
                    <div class="mb-1">
                      <b-form-input
                        placeholder="Enter question"
                        v-model="item.question"
                      ></b-form-input>
                    </div>
                    <div>
                      <b-form-input
                        placeholder="Enter answer"
                        v-model="item.answer"
                      ></b-form-input>
                    </div>
                  </b-form-group>
                  <div class="ml-1">
                    <b-button
                      size="sm"
                      @click="detail.outline.faqs.splice(id, 1)"
                      ><b-icon icon="x"></b-icon
                    ></b-button>
                  </div>
                  <div></div>
                </b-col>
              </b-form-row>
            </div>
          </div>

          <b-form-row class="px-1">
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="certification">
                <b-form-row>
                  <b-col sm="3">
                    <b-form-radio
                      size="sm"
                      value="yes"
                      v-model="detail.outline.certification"
                      >Yes</b-form-radio
                    >
                  </b-col>
                  <b-col>
                    <b-form-radio
                      size="sm"
                      v-model="detail.outline.certification"
                      value="no"
                      sm="3"
                      >No</b-form-radio
                    ></b-col
                  >
                </b-form-row>
              </b-form-group>
            </b-col>
            <b-col sm="6" class="mb-3 px-3"> </b-col>
          </b-form-row>
          <b-form-row>
            <b-col class="mb-3 px-3">
              <b-form-group label="Additional Note">
                <b-form-textarea
                  v-model="detail.outline.additional_info"
                  rows="2"
                  placeholder="Enter Description"
                ></b-form-textarea>
              </b-form-group>
            </b-col>
          </b-form-row>
        </b-container>
        <b-container v-show="type == 3">
          <div
            class="border p-3 rounded mb-3"
            v-for="(item, id) in detail.schedule"
            :key="id"
          >
            <b-form-row>
              <b-col sm="6" class="mb-3 px-3">
                <b-form-group label="Facilitator">
                  <b-form-select v-model="item.facilitator_id">
                    <b-form-select-option :value="null"
                      >None</b-form-select-option
                    >
                    <b-form-select-option
                      :value="item.id"
                      v-for="(item, id) in facilitators"
                      :key="id"
                      >{{ item.name }}</b-form-select-option
                    ></b-form-select
                  >
                </b-form-group>
              </b-col>
              <b-col sm="6" class="mb-3 px-3">
                <b-form-group label="Url (optional)">
                  <b-form-input
                    v-model="item.url"
                    placeholder="Enter url link"
                  ></b-form-input>
                </b-form-group>
              </b-col>
            </b-form-row>
            <b-form-row>
              <b-col sm="6" class="mb-3 px-3">
                <b-form-group label="Start time">
                  <vc-date-picker
                    placeholder="Choose start time"
                    v-model="item.start_time"
                    mode="dateTime"
                    :is24hr="false"
                  >
                  </vc-date-picker>
                </b-form-group>
              </b-col>
              <b-col sm="6" class="mb-3 px-3">
                <b-form-group label="End time">
                  <vc-date-picker
                    placeholder="Choose start time"
                    v-model="item.end_time"
                    mode="dateTime"
                    :is24hr="false"
                  >
                  </vc-date-picker>
                </b-form-group>
              </b-col>
            </b-form-row>
            <div>
              <b-button
                variant="outline-dark-green"
                class="my-2 mr-2"
                size="sm"
                @click="detail.schedule.splice(id, 1)"
                v-if="detail.schedule.length > 1"
                >Delete schedule</b-button
              >
              <b-button
                variant="dark-green"
                class="my-2"
                size="sm"
                @click="addschedule"
                v-if="detail.schedule.length == id + 1"
                >Add new schedule</b-button
              >
            </div>
          </div>
        </b-container>
        <div class="text-center py-3">
          <b-button
            size="lg"
            class="px-5"
            type="button"
            @click="type++"
            v-show="type <= 2"
            variant="secondary"
            >Next</b-button
          >
          <b-button
            size="lg"
            class="px-5"
            type="submit"
            v-show="type === 3"
            variant="secondary"
            >Create course</b-button
          >
        </div>
      </b-form>
    </b-modal>
    <b-modal size="lg" id="update" centered hide-footer title="Update  course">
      <b-form @submit.prevent="updatecourse">
        <div class="mb-3 border-bottom">
          <b-container class="pb-2 d-flex align-items-center">
            <span
              class="mr-5 d-flex align-items-center fs13 cursor-pointer"
              :class="{ 'text-dark-green': type == 1 }"
              @click="type = 1"
              ><b-icon
                icon="circle-fill"
                class="mr-1"
                font-scale=".45rem"
              ></b-icon>
              General</span
            >
            <span
              class="mr-5 d-flex align-items-center fs13 cursor-pointer"
              :class="{ 'text-dark-green': type == 2 }"
              @click="type = 2"
              ><b-icon
                icon="circle-fill"
                class="mr-1"
                font-scale=".45rem"
              ></b-icon>
              Course Outline</span
            >
            <span
              class="d-flex align-items-center fs13 cursor-pointer"
              :class="{ 'text-dark-green': type == 3 }"
              @click="type = 3"
            >
              <b-icon
                icon="circle-fill"
                class="mr-1"
                font-scale=".45rem"
              ></b-icon
              >Course Schedule</span
            >
          </b-container>
        </div>
        <b-container v-show="type == 1">
          <b-form-row>
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="Course title">
                <b-form-input
                  placeholder="Enter course title"
                  v-model="detail.general.title"
                ></b-form-input>
              </b-form-group>
            </b-col>
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="Course code (optional)">
                <b-form-input
                  v-model="detail.general.code"
                  placeholder="Enter course code (optional)"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-form-row>
          <b-form-row>
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="Course Description">
                <b-form-textarea
                  v-model="detail.general.description"
                  rows="5"
                  placeholder="Enter Description"
                ></b-form-textarea>
              </b-form-group>
            </b-col>
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="Course Cover">
                <Upload @getUpload="getUpload">
                  <div class="text-center">
                    <b-icon icon="image" font-scale="6rem"></b-icon>
                  </div>
                </Upload>
              </b-form-group>
            </b-col>
          </b-form-row>
        </b-container>
        <b-container v-show="type == 2">
          <b-form-row class="px-1">
            <b-col class="mb-2 px-3">
              <b-form-group label="Overview">
                <b-textarea
                  rows="3"
                  v-model="detail.outline.overview"
                ></b-textarea>
              </b-form-group>
            </b-col>
          </b-form-row>
          <b-form-row class="px-1">
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="Knowledge area">
                <b-form-select
                  class="text-capitalize"
                  v-model="detail.outline.knowledge_area"
                >
                  <b-form-select-option
                    :value="ins"
                    v-for="(ins, id) in insight"
                    :key="id"
                    >{{ ins }}</b-form-select-option
                  >
                </b-form-select>
              </b-form-group>
            </b-col>
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="Duration">
                <b-form-input
                  v-model="detail.outline.duration"
                  placeholder="Enter course duration"
                ></b-form-input>
              </b-form-group>
            </b-col>
          </b-form-row>
          <div>
            <div class="mb-3 px-3">
              <div class="border rounded p-2">
                <b-form-group label="Modules">
                  <b-input-group class="addmodule mb-3">
                    <b-form-input v-model="newmodule"></b-form-input>
                    <b-input-group-append>
                      <b-button variant="dark-green" @click="addmodule"
                        >Add module</b-button
                      >
                    </b-input-group-append>
                  </b-input-group>

                  <div>
                    <b-row>
                      <b-col
                        v-for="(item, id) in detail.outline.modules"
                        :key="id"
                        sm="6"
                      >
                        <div
                          class="border rounded bg-lighter-green px-5 py-2 mb-2"
                        >
                          <span class="mr-4 text-capitalize">{{ item }}</span>
                          <b-icon
                            icon="x"
                            @click="detail.outline.modules.splice(id, 1)"
                          ></b-icon>
                        </div>
                      </b-col>
                    </b-row>
                  </div>
                </b-form-group>
              </div>
            </div>
          </div>

          <div class="px-3 mb-3">
            <div class="p-2 border rounded">
              <label class="d-flex justify-content-between">
                <span>Faqs</span>
                <div>
                  <b-button size="sm" @click="addfaq">Add</b-button>
                </div>
              </label>
              <b-form-row>
                <b-col
                  sm="6"
                  v-for="(item, id) in detail.outline.faqs"
                  :key="id"
                  class="d-flex"
                >
                  <b-form-group class="flex-1">
                    <div class="mb-1">
                      <b-form-input
                        placeholder="Enter question"
                        v-model="item.question"
                      ></b-form-input>
                    </div>
                    <div>
                      <b-form-input
                        placeholder="Enter answer"
                        v-model="item.answer"
                      ></b-form-input>
                    </div>
                  </b-form-group>
                  <div class="ml-1">
                    <b-button
                      size="sm"
                      @click="detail.outline.faqs.splice(id, 1)"
                      ><b-icon icon="x"></b-icon
                    ></b-button>
                  </div>
                  <div></div>
                </b-col>
              </b-form-row>
            </div>
          </div>

          <b-form-row class="px-1">
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="certification">
                <b-form-row>
                  <b-col sm="3">
                    <b-form-radio
                      size="sm"
                      value="yes"
                      v-model="detail.outline.certification"
                      >Yes</b-form-radio
                    >
                  </b-col>
                  <b-col>
                    <b-form-radio
                      size="sm"
                      v-model="detail.outline.certification"
                      value="no"
                      sm="3"
                      >No</b-form-radio
                    ></b-col
                  >
                </b-form-row>
              </b-form-group>
            </b-col>
            <b-col sm="6" class="mb-3 px-3"> </b-col>
          </b-form-row>
          <b-form-row>
            <b-col class="mb-3 px-3">
              <b-form-group label="Additional Note">
                <b-form-textarea
                  v-model="detail.outline.additional_info"
                  rows="2"
                  placeholder="Enter Description"
                ></b-form-textarea>
              </b-form-group>
            </b-col>
          </b-form-row>
        </b-container>
        <b-container v-show="type == 3">
          <div
            class="border p-3 rounded mb-3"
            v-for="(item, id) in detail.schedule"
            :key="id"
          >
            <b-form-row>
              <b-col sm="6" class="mb-3 px-3">
                <b-form-group label="Day">
                  <b-form-select v-model="item.day">
                    <b-form-select-option value="monday"
                      >Monday</b-form-select-option
                    >
                    <b-form-select-option value="tuesday"
                      >Tuesday</b-form-select-option
                    >
                    <b-form-select-option value="wednesday"
                      >Wednesday</b-form-select-option
                    >
                    <b-form-select-option value="thursday"
                      >Thursday</b-form-select-option
                    >
                    <b-form-select-option value="friday"
                      >Friday</b-form-select-option
                    >
                    <b-form-select-option value="saturday"
                      >Saturday</b-form-select-option
                    >
                    <b-form-select-option value="sunday"
                      >Sunday</b-form-select-option
                    >
                  </b-form-select>
                </b-form-group>
              </b-col>
              <b-col sm="6" class="mb-3 px-3">
                <b-form-group label="Facilitator">
                  <b-form-select v-model="item.facilitator_id">
                    <b-form-select-option
                      :value="item.id"
                      v-for="(item, id) in facilitators"
                      :key="id"
                      >{{ item.name }}</b-form-select-option
                    ></b-form-select
                  >
                </b-form-group>
              </b-col>
            </b-form-row>
            <b-form-row>
              <b-col sm="6" class="mb-3 px-3">
                <b-form-group label="Start time">
                  <vc-date-picker
                    placeholder="Choose end time"
                    v-model="item.start_time"
                    mode="dateTime"
                    :is24hr="false"
                  >
                  </vc-date-picker>
                </b-form-group>
              </b-col>
              <b-col sm="6" class="mb-3 px-3">
                <b-form-group label="End time">
                  <vc-date-picker
                    placeholder="Choose end time"
                    v-model="item.end_time"
                    mode="dateTime"
                    :is24hr="false"
                  >
                  </vc-date-picker>
                </b-form-group>
              </b-col>
            </b-form-row>
            <div>
              <b-button
                variant="outline-dark-green"
                class="my-2 mr-2"
                size="sm"
                @click="detail.schedule.splice(id, 1)"
                v-if="detail.schedule.length > 1"
                >Delete schedule</b-button
              >
              <b-button
                variant="dark-green"
                class="my-2"
                size="sm"
                @click="addschedule"
                v-if="detail.schedule.length == id + 1"
                >Add new schedule</b-button
              >
            </div>
          </div>
        </b-container>
        <div class="text-center py-3">
          <b-button
            size="lg"
            class="px-5"
            type="button"
            @click="type++"
            v-show="type <= 2"
            variant="secondary"
            >Next</b-button
          >
          <b-button
            size="lg"
            class="px-5"
            type="submit"
            v-show="type === 3"
            variant="secondary"
            >Update course</b-button
          >
        </div>
      </b-form>
    </b-modal>
    <b-container fluid class="pr-sm-0">
      <div class="d-flex justify-content-between p-3">
        <div class="">
          <h4>Courses</h4>
        </div>
        <div v-if="courses.length" class="text-right">
          <b-button variant="dark-green" @click="$bvModal.show('addcourse')"
            >Create new course</b-button
          >
        </div>
      </div>

      <b-row v-if="courses.length">
        <b-col sm="8" class="my_courses">
          <b-row>
            <b-col
              sm="4"
              class="mb-3"
              v-for="(course, index) in courses"
              :key="index"
            >
              <div
                class="bg-white shadow-sm p-3 text-left h-100 cursor-pointer position-relative"
                @click="showcourse(course)"
              >
                <b-dropdown
                  size="sm"
                  variant="transparent"
                  no-caret
                  class="no-focus dots"
                >
                  <template #button-content>
                    <b-icon
                      icon="three-dots-vertical"
                      class="position-absolute"
                    ></b-icon>
                  </template>

                  <b-dropdown-item class="fs12" @click="edit(course)"
                    >Edit</b-dropdown-item
                  >
                  <b-dropdown-item class="fs12" @click="drop(course.id, index)"
                    >Delete</b-dropdown-item
                  >
                </b-dropdown>

                <b-iconstack font-scale="2.5" class="mr-2 mb-2">
                  <b-icon
                    stacked
                    icon="circle-fill"
                    variant="lighter-green"
                  ></b-icon>
                  <b-icon
                    stacked
                    icon="person-badge-fill"
                    scale="0.5"
                    variant="dark-green"
                  ></b-icon>
                </b-iconstack>
                <div class="course_title mb-3">{{ course.title }}</div>
                <div
                  class="course_fac d-flex align-items-start mb-2 text-capitalize"
                  v-if="sortfacilitators(course).length"
                >
                  <b-icon icon="display" class="text-muted mr-2"></b-icon>
                  <span class="fs13">
                    {{ sortfacilitators(course).join(" ") }}</span
                  >
                </div>
                <div v-for="(time, id) in course.courseschedule" :key="id">
                  <div class="course_time d-flex mb-2 text-capitalize">
                    <b-icon icon="calendar" class="text-muted mr-2 e"></b-icon>
                    <div class="mb-2">
                      <div class="fs14 text-capitalize mb-1">
                        {{ time.day }}
                      </div>

                      <div class="fs13">
                        {{ time.start_time | moment("ll") }} -
                        {{ time.end_time | moment("ll") }}
                      </div>
                    </div>
                  </div>
                </div>
                <div v-if="course" class="course_modules mb-3 py-2 fs13">
                  <b-icon icon="layers" class="text-muted mr-2"></b-icon>
                  <span class="fs13"> {{ sortmodules(course) }}</span>
                  Modules
                </div>

                <div class="d-flex justify-content-between fs13">
                  <span>Progress</span><span>50%</span>
                </div>
                <b-progress
                  :value="50"
                  :max="100"
                  show-value
                  height=".8rem"
                  class="mb-3"
                  variant="dark-green"
                ></b-progress>
              </div>
            </b-col>
          </b-row>
        </b-col>
        <b-col sm="4" class="pl-3 h-100">
          <div v-if="!course" class="sidebar bg-white">
            <div class="text-center w-100">
              <b-img
                class="mb-3"
                :src="require('@/assets/images/book.png')"
              ></b-img>
              <br />
              <p class="text-muted">Select a Course to see Details</p>
            </div>
          </div>

          <div class="text-left py-4 p-3 bg-white" v-if="course">
            <div class="d-flex">
              <div class="course_title d-flex mb-3 flex-1">
                <b-iconstack font-scale="2.5" class="mr-2 mb-2">
                  <b-icon
                    stacked
                    icon="circle-fill"
                    variant="lighter-green"
                  ></b-icon>
                  <b-icon
                    stacked
                    icon="person-badge-fill"
                    scale="0.5"
                    variant="dark-green"
                  ></b-icon>
                </b-iconstack>
                <div>
                  <span class="title text-capitalize" v-if="course.title">
                    {{ course.title }}</span
                  >
                  <br />
                  <span class="course_time text-capitalize"
                    ><b-icon icon="clock" class="mr-1"></b-icon>
                    {{ course.courseoutline.duration }}</span
                  >
                </div>
              </div>

              <b-img style="width: 80px" fluid :src="course.cover"></b-img>
            </div>
            <div
              class="d-flex justify-content-between p-3 border-bottom mb-2 text-sm"
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
                Resources</span
              >
            </div>

            <div v-if="toggleCourse == 1">
              <div class="mb-3 px-3">
                <h6 class="fs14">Course Description</h6>
                <p class="fs13">
                  {{ course.description }}
                </p>
              </div>
              <div class="mb-3 px-3">
                <h6 class="fs14 mb-1">Knowledge Area</h6>
                <p class="fs13 text-capitalize">
                  {{ course.courseoutline.knowledge_areas }}
                </p>
              </div>

              <div class="mb-3">
                <div
                  class="d-flex justify-content-around mb-1 px-3"
                  v-for="(item, index) in course.courseschedule"
                  :key="index"
                >
                  <b-col cols="5" class="border-right ti">
                    <span class="fs14">Time</span> <br />
                    <span class="text-sm">
                      {{ item.start_time | moment("LT") }}</span
                    >
                  </b-col>

                  <b-col cols="7" class="ti">
                    <span class="fs14">Facilitator</span> <br />
                    <span class="text-sm" v-if="item.facilitator_id != null">{{
                      facilitators.find((val) => val.id == item.facilitator_id)
                        .name
                    }}</span>
                    <span v-else class="text-sm">Unavailable</span>
                  </b-col>
                </div>
              </div>

              <div class="mb-3 px-3">
                <h6 class="fs14">Additional Information</h6>
                <p class="fs13">
                  {{ course.courseoutline.additional_info }}
                </p>
              </div>
              <div class="mb-3 px-3">
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
                <h6 class="mb-3 fs14 px-3">Course Files</h6>
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
            <div v-if="toggleCourse == 3" class="h-100 p-3">
              <div class="mb-4">
                <h6 class="fs14 mb-3">Overview</h6>

                <p class="fs13">{{ course.courseoutline.overview }}</p>
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
                      <div v-b-toggle="'file' + id" variant="info">
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
                        <b-card-text class="px-0">
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
            <div v-if="toggleCourse == 4" class="h-100 p-3">
              <h6 class="fs14 mb-3">Module Resources</h6>

              <div
                class="accordion"
                role="tablist"
                v-if="course.modules.length"
              >
                <b-card
                  no-body
                  class=""
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
                        <span>{{ mod.file_type }}</span></b-card-text
                      >
                      <h6 class="fs12 font-weight-bold mb-2">Overview</h6>
                      <b-card-text class="fs12">{{ mod.overview }}</b-card-text>
                    </b-card-body>
                  </b-collapse>
                </b-card>
              </div>
              <div class="p-4 text-muted text-center" v-else>
                No resource available
              </div>
            </div>
          </div>
        </b-col>
      </b-row>
      <b-row v-else>
        <b-col class="empty rounded p-5 text-center">
          <h2 class="mb-3 px-3 text-muted">No Course Available</h2>
          <b-img
            class="mb-3 px-3"
            :src="require('@/assets/images/creator.svg')"
          ></b-img>
          <p class="mb-3">
            There appears to be no course available <br />
            please create a new course by clicking the button below
          </p>
          <b-button @click="$bvModal.show('addcourse')" variant="dark-green"
            >Create new course</b-button
          >
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>
<script>
import Upload from "@/components/feedupload.vue";
import Insight from "../insight.js";
export default {
  data() {
    return {
      insight: [],
      courses: [],
      course: null,
      type: 1,
      newmodule: "",
      facilitators: [],
      toggleCourse: 1,
      detail: {
        general: {
          title: "",
          code: "",
          description: "",
          cover: "",
        },
        outline: {
          overview: "",
          knowledge_area: "",
          duration: "",
          modules: [],
          faqs: [
            {
              question: "",
              answer: "",
            },
          ],
          certification: null,
          additional_info: "",
        },
        schedule: [
          {
            type: "course",
            event_type: "class",
            url: "",
            day: "",
            start_time: "",
            end_time: "",
            facilitator_id: null,
          },
        ],
      },
    };
  },
  components: {
    Upload,
  },
  mounted() {
    this.getcourses();
    this.getfacilitators();
    this.insight = Insight;
  },
  methods: {
    getmediacount(arr, media) {
      var newarr = [];
      if (!arr.length) {
        return 0;
      }
      arr.forEach((val) => {
        JSON.parse(val.modules).forEach((item) => {
          if (item.file_type.toLowerCase() == media.toLowerCase()) {
            newarr.push(item);
          }
        });
      });

      return newarr.length;
    },
    showcourse(val) {
      this.course = val;
    },
    sortmodules(data) {
      if (!data.courseoutline) {
        return 0;
      }
      return JSON.parse(data.courseoutline.modules).length;
    },
    sortfacilitators(data) {
      if (!data.courseschedule) {
        return "Unavailable";
      }
      var schedule = data.courseschedule;
      var newArr = schedule.map((val) => {
        if (val.facilitator_id) {
          var fac = this.facilitators.find(
            (item) => item.id == val.facilitator_id
          );
          if (fac) {
            return fac.name;
          }
        }
      });

      return [...new Set(newArr)];
    },
    sorttimes(data) {
      if (!data.courseschedule) {
        return "Unavailable";
      }
      var schedule = data.courseschedule;
      return schedule.map((item) => {
        var res = ` ${item.day} ${this.$moment(
          new Date("2021-05-18 " + item.start_time)
        ).format("LT")}`;
        return res;
      });
    },
    getUpload(val) {
      this.detail.general.cover = val;
    },
    addschedule() {
      this.detail.schedule.push({
        day: "",
        url: "",
        start_time: "",
        end_time: "",
        facilitator_id: null,
      });
    },
    addmodule() {
      if (!this.newmodule) {
        this.$toast.info("Cannot be empty!");
        return;
      }
      this.detail.outline.modules.push(this.newmodule);
      this.newmodule = "";
    },

    addfaq() {
      this.detail.outline.faqs.push({
        question: "",
        answer: "",
      });
    },

    getfacilitators() {
      this.$http
        .get(`${this.$store.getters.url}/admin-get-facilitators`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.facilitators = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    getcourses() {
      this.$http
        .get(`${this.$store.getters.url}/courses`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.courses = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    createcourse() {
      this.$http
        .post(`${this.$store.getters.url}/courses`, this.detail, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.$toast.success("Course created");
            this.courses.unshift(res.data);
            this.$bvModal.hide("addcourse");
            this.detail = {
              general: {
                title: "",
                code: "",
                description: "",
                cover: "",
              },
              outline: {
                overview: "",
                knowledge_area: "",
                duration: "",
                modules: [],
                faqs: [
                  {
                    question: "",
                    answer: "",
                  },
                ],
                certification: null,
                additional_info: "",
              },
              schedule: [
                {
                  type: "course",
                  event_type: "class",
                  url: "",
                  day: "",
                  start_time: "",
                  end_time: "",
                  facilitator_id: null,
                },
              ],
            };
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    edit(val) {
      this.detail = {
        general: {
          title: val.title,
          code: val.code,
          description: val.description,
          cover: val.cover,
        },
        outline: {
          overview: val.courseoutline.overview,
          knowledge_area: val.courseoutline.knowledge_areas,
          duration: val.courseoutline.duration,
          modules: JSON.parse(val.courseoutline.modules),
          faqs: JSON.parse(val.courseoutline.faqs),
          certification: val.courseoutline.certification,
          additional_info: val.courseoutline.additional_info,
        },
        schedule: val.courseschedule,
      };
      this.$bvModal.show("update");
    },
    updatecourse() {
      this.$http
        .put(
          `${this.$store.getters.url}/courses/${this.course.id}`,
          this.detail,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Update successful");
            this.$bvModal.hide("update");
            this.getcourses();
            this.type = 1;
            this.detail = {
              general: {
                title: "",
                code: "",
                description: "",
                cover: "",
              },
              outline: {
                overview: "",
                knowledge_area: "",
                duration: "",
                modules: [],
                faqs: [
                  {
                    question: "",
                    answer: "",
                  },
                ],
                certification: null,
                additional_info: "",
              },
              schedule: [
                {
                  type: "course",
                  event_type: "class",
                  url: "",
                  day: "",
                  start_time: "",
                  end_time: "",
                  facilitator_id: null,
                },
              ],
            };
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
            .delete(`${this.$store.getters.url}/courses/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success("Removed successfully");
                this.courses.splice(index, 1);
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
.empty {
  min-height: 600px;
}
.ti {
  line-height: 1.2;
}
.sidebar {
  background-color: white;
  height: 79vh;
  display: flex;
  align-items: center;
}
.course_title {
  font-weight: 500;
}
.course_fac {
  font-size: 14px;
  color: rgba($color: #000000, $alpha: 0.4);
}
.course_time {
  font-size: 14px;
  color: rgba($color: #000000, $alpha: 0.4);
}
.course_modules {
  font-size: 14px;
  color: rgba($color: #000000, $alpha: 0.4);
}
p {
  color: rgba($color: #000000, $alpha: 0.54);
}
.text-sm {
  font-size: 13px;
  color: rgba($color: #000000, $alpha: 0.5);
}
.my_courses {
  height: 85vh;
  overflow: auto;
}
.addmodule {
  width: 400px;
}
.dots {
  position: absolute;
  top: 20px;
  right: 10px;
}
</style>

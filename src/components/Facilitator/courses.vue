<template>
  <div>
    <b-modal
      no-close-on-backdrop
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
              class="mr-5 d-flex align-items-center fs13 cursor-pointer"
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
                  required
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
              <b-form-group label="Course Type">
                <b-form-radio-group
                  size="sm"
                  id="radio-group-2"
                  v-model="detail.general.type"
                  name="radio-sub-component"
                >
                  <b-form-radio value="paid">Paid</b-form-radio>
                  <b-form-radio value="group">Group</b-form-radio>
                </b-form-radio-group>
              </b-form-group>
            </b-col>
            <b-col
              sm="6"
              class="mb-3 px-3"
              v-if="detail.general.type == 'paid'"
            >
              <b-form-group label="Course amount">
                <b-form-input
                  size="sm"
                  type="number"
                  v-model="detail.general.amount"
                  placeholder=""
                ></b-form-input>
              </b-form-group>
            </b-col>

            <b-col
              sm="6"
              class="mb-3 px-3"
              v-if="detail.general.type == 'group'"
            >
              <b-form-group label="No of participants">
                <b-form-select
                  size="sm"
                  required
                  v-model="detail.general.amount"
                >
                  <b-form-select-option :value="null"
                    >Select a number</b-form-select-option
                  >
                  <b-form-select-option v-for="n in 100" :key="n" :value="n">{{
                    n
                  }}</b-form-select-option>
                </b-form-select>
              </b-form-group>
            </b-col>
          </b-form-row>
          <b-form-row>
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="Course Description">
                <b-form-textarea
                  required
                  v-model="detail.general.description"
                  rows="5"
                  placeholder="Enter Description"
                ></b-form-textarea>
              </b-form-group>
            </b-col>
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="Course Cover">
                <Upload
                  @getUpload="getUpload"
                  :id="'image'"
                  :type="'image'"
                  :file_type="'image'"
                >
                  <div class="text-center">
                    <b-icon
                      icon="image"
                      class="text-muted"
                      font-scale="6rem"
                    ></b-icon>
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
                <editor
                  api-key="0faxd6jp8vlrnoj74njdtskkywu2nqvbuta5scv42arkdczq"
                  v-model="detail.outline.overview"
                  :init="{
                    height: 150,
                    menubar: false,

                    toolbar: ' formatselect | bold italic '
                  }"
                />
              </b-form-group>
            </b-col>
          </b-form-row>
          <b-form-row class="px-1">
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="Knowledge area">
                <b-form-select
                  required
                  class="text-capitalize"
                  v-model="detail.outline.knowledge_area"
                >
                  <b-form-select-option
                    :value="ins"
                    v-for="(ins, id) in insight"
                    :key="id"
                    >{{ ins.value }}</b-form-select-option
                  >
                </b-form-select>
              </b-form-group>
            </b-col>
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="Duration">
                <b-form-input
                  required
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
                      <draggable
                        v-model="detail.outline.modules"
                        v-bind="dragOptions"
                        :move="onMove"
                        @start="isDragging = true"
                        @end="isDragging = false"
                        class=""
                      >
                        <transition-group
                          type="transition"
                          :name="'flip-list'"
                          class="d-flex flex-wrap"
                        >
                          <b-col
                            v-for="(item, id) in detail.outline.modules"
                            :key="id + 1"
                            cols="auto"
                          >
                            <div
                              class="
                                rounded-pill
                                module_border
                                mb-2
                                d-flex
                                justify-content-between
                                align-items-center
                              "
                            >
                              <div class="fs14 px-3 py-1">
                                {{ item.module }}
                              </div>
                              <div
                                class="module_border_left text-center py-1 px-1"
                              >
                                <b-icon
                                  icon="x"
                                  @click="detail.outline.modules.splice(id, 1)"
                                ></b-icon>
                              </div>
                            </div>
                          </b-col>
                        </transition-group>
                      </draggable>
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
                <span>
                  <b-button size="sm" @click="addfaq">Add</b-button>
                </span>
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
              <b-form-group label="Certification">
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
          <div class="mb-3" v-for="(item, id) in detail.schedule" :key="id">
            <div
              class="
                border
                p-3
                rounded
                d-flex
                justify-content-between
                shadow-sm
                bg-light
              "
              v-if="id != current_schedule"
            >
              <div>
                <span class="mr-3"
                  >Start :
                  {{
                    item.start_time | moment("dddd, MMMM D YYYY, h:mm a")
                  }}</span
                >
                <br />
                <span class="mr-3"
                  >End :
                  {{
                    item.end_time | moment("dddd, MMMM D YYYY, h:mm a")
                  }}</span
                >
              </div>
              <div>
                <b-iconstack
                  font-scale="1.3"
                  class="mr-2"
                  @click="current_schedule = id"
                >
                  <b-icon stacked icon="circle-fill" variant="warning"></b-icon>
                  <b-icon icon="pencil" stacked scale="0.5"></b-icon>
                </b-iconstack>

                <b-iconstack
                  font-scale="1.3"
                  v-if="detail.schedule.length > 1"
                  @click="detail.schedule.splice(id, 1)"
                >
                  <b-icon stacked icon="circle-fill" variant="danger"></b-icon>
                  <b-icon
                    icon="trash2-fill"
                    stacked
                    scale="0.5"
                    variant="white"
                  ></b-icon>
                </b-iconstack>
              </div>
            </div>
            <div v-if="id == current_schedule" class="bg-light">
              <div class="text-right px-3">
                <b-icon
                  icon="chevron-up"
                  @click="current_schedule = null"
                ></b-icon>
              </div>
              <b-form-row>
                <b-col sm="6" class="mb-3 px-3">
                  <b-form-group label="Choose Facilitator">
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
              </b-form-row>
              <b-form-row>
                <b-col sm="6" class="mb-3 px-3">
                  <b-form-group label="Venue">
                    <b-form-input
                      v-model="item.venue"
                      placeholder="Enter course Venue"
                    ></b-form-input>
                  </b-form-group>
                </b-col>
                <b-col sm="6" class="mb-3 px-3">
                  <b-form-group label="Url(optional)">
                    <b-form-input
                      v-model="item.url"
                      type="url"
                      placeholder="Enter url link (optional)"
                    ></b-form-input>
                  </b-form-group>
                </b-col>
              </b-form-row>

              <b-form-row>
                <b-col class="mb-3 px-3">
                  <b-form-group label="Choose modules">
                    <b-form-checkbox
                      v-if="detail.outline.modules.length"
                      size="sm"
                      @change="selectall(id, item.all, detail.outline.modules)"
                      v-model="item.all"
                      >Select all</b-form-checkbox
                    >
                    <b-form-checkbox-group
                      id="checkbox-group-1"
                      v-model="item.modules"
                      :options="detail.outline.modules"
                      name="modules"
                      value-field="module"
                      text-field="module"
                    ></b-form-checkbox-group>
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
                      <template v-slot="{ inputValue, inputEvents }">
                        <input
                          class="
                            px-2
                            py-1
                            border
                            rounded
                            focus:outline-none
                            focus:border-blue-300
                          "
                          :value="inputValue"
                          v-on="inputEvents"
                        />
                      </template>
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
                      <template v-slot="{ inputValue, inputEvents }">
                        <input
                          class="
                            px-2
                            py-1
                            border
                            rounded
                            focus:outline-none
                            focus:border-blue-300
                          "
                          :value="inputValue"
                          v-on="inputEvents"
                        />
                      </template>
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
              </div>
            </div>
          </div>
          <div class="text-center">
            <b-icon
              icon="plus-circle-fill"
              variant="dark-green"
              class="my-2"
              font-scale="1.4"
              @click="addschedule"
            ></b-icon>
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
            :disabled="disable"
            >Create course</b-button
          >
        </div>
      </b-form>
    </b-modal>
    <b-modal no-close-on-backdrop id="filter" hide-footer centered>
      <div>
        <div>
          <h6 class="">Sort by</h6>
          <b-form-group label="Category">
            <b-form-radio-group v-model="course_type">
              <b-form-radio value="">General</b-form-radio>

              <b-form-radio value="paid">Paid</b-form-radio>
              <b-form-radio value="group">Group</b-form-radio>
            </b-form-radio-group>
          </b-form-group>
          <b-form-group>
            <b-form-checkbox v-model="recent">Recent</b-form-checkbox>
            <b-form-checkbox v-model="trending">Trending</b-form-checkbox>
          </b-form-group>
        </div>
      </div>
    </b-modal>
    <b-modal
      no-close-on-backdrop
      size="lg"
      id="update"
      centered
      hide-footer
      title="Update  course"
    >
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
              class="mr-5 d-flex align-items-center fs13 cursor-pointer"
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
                  required
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
              <b-form-group label="Course Type">
                <b-form-radio-group
                  size="sm"
                  id="radio-group-2"
                  v-model="detail.general.type"
                  name="radio-sub-component"
                >
                  <b-form-radio value="paid">Paid</b-form-radio>
                  <b-form-radio value="group">Group</b-form-radio>
                </b-form-radio-group>
              </b-form-group>
            </b-col>
            <b-col
              sm="6"
              class="mb-3 px-3"
              v-if="detail.general.type == 'paid'"
            >
              <b-form-group label="Course amount">
                <b-form-input
                  size="sm"
                  type="number"
                  v-model="detail.general.amount"
                  placeholder=""
                ></b-form-input>
              </b-form-group>
            </b-col>

            <b-col
              sm="6"
              class="mb-3 px-3"
              v-if="detail.general.type == 'group'"
            >
              <b-form-group label="No of participants">
                <b-form-select
                  size="sm"
                  required
                  v-model="detail.general.amount"
                >
                  <b-form-select-option :value="null"
                    >Select a number</b-form-select-option
                  >
                  <b-form-select-option v-for="n in 100" :key="n" :value="n">{{
                    n
                  }}</b-form-select-option>
                </b-form-select>
              </b-form-group>
            </b-col>
          </b-form-row>
          <b-form-row>
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="Course Description">
                <b-form-textarea
                  required
                  v-model="detail.general.description"
                  rows="5"
                  placeholder="Enter Description"
                ></b-form-textarea>
              </b-form-group>
            </b-col>
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="Course Cover">
                <Upload
                  @getUpload="getUpload"
                  :id="'image'"
                  :type="'image'"
                  :file_type="'image'"
                  :image="detail.general.cover"
                >
                  <div class="text-center">
                    <b-icon
                      icon="image"
                      class="text-muted"
                      font-scale="6rem"
                    ></b-icon>
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
                <editor
                  api-key="0faxd6jp8vlrnoj74njdtskkywu2nqvbuta5scv42arkdczq"
                  v-model="detail.outline.overview"
                  :init="{
                    height: 150,
                    menubar: false,

                    toolbar: ' formatselect | bold italic  '
                  }"
                />
              </b-form-group>
            </b-col>
          </b-form-row>
          <b-form-row class="px-1">
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="Knowledge area">
                <b-form-select
                  class="text-capitalize"
                  v-model="detail.outline.knowledge_area"
                  required
                >
                  <b-form-select-option
                    :value="ins"
                    v-for="(ins, id) in insight"
                    :key="id"
                    >{{ ins.value }}</b-form-select-option
                  >
                </b-form-select>
              </b-form-group>
            </b-col>
            <b-col sm="6" class="mb-3 px-3">
              <b-form-group label="Duration">
                <b-form-input
                  required
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
                      <draggable
                        v-model="detail.outline.modules"
                        v-bind="dragOptions"
                        :move="onMove"
                        @start="isDragging = true"
                        @end="isDragging = false"
                        class=""
                      >
                        <transition-group
                          type="transition"
                          :name="'flip-list'"
                          class="d-flex flex-wrap"
                        >
                          <b-col
                            v-for="(item, id) in detail.outline.modules"
                            :key="id + 1"
                            cols="auto"
                          >
                            <div
                              class="
                                rounded-pill
                                module_border
                                mb-2
                                d-flex
                                justify-content-between
                                align-items-center
                              "
                            >
                              <div class="fs14 px-3 py-1">
                                {{ item.module }}
                              </div>
                              <div
                                class="module_border_left text-center py-1 px-1"
                              >
                                <b-icon
                                  icon="x"
                                  @click="detail.outline.modules.splice(id, 1)"
                                ></b-icon>
                              </div>
                            </div>
                          </b-col>
                        </transition-group>
                      </draggable>
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
              <b-form-group label="Certification">
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
          <div class="mb-3" v-for="(item, id) in detail.schedule" :key="id">
            <div
              class="
                border
                p-3
                rounded
                d-flex
                justify-content-between
                shadow-sm
                bg-light
              "
              v-if="id != current_schedule"
            >
              <div>
                <span class="mr-3"
                  >Start :
                  {{
                    item.start_time | moment("dddd, MMMM D YYYY, h:mm a")
                  }}</span
                >
                <br />
                <span class="mr-3"
                  >End :
                  {{
                    item.end_time | moment("dddd, MMMM D YYYY, h:mm a")
                  }}</span
                >
              </div>
              <div>
                <b-iconstack
                  font-scale="1.3"
                  class="mr-2"
                  @click="current_schedule = id"
                >
                  <b-icon stacked icon="circle-fill" variant="warning"></b-icon>
                  <b-icon icon="pencil" stacked scale="0.5"></b-icon>
                </b-iconstack>

                <b-iconstack
                  font-scale="1.3"
                  v-if="detail.schedule.length > 1"
                  @click="detail.schedule.splice(id, 1)"
                >
                  <b-icon stacked icon="circle-fill" variant="danger"></b-icon>
                  <b-icon
                    icon="trash2-fill"
                    stacked
                    scale="0.5"
                    variant="white"
                  ></b-icon>
                </b-iconstack>
              </div>
            </div>
            <div v-if="id == current_schedule" class="bg-light">
              <div class="text-right px-3">
                <b-icon
                  icon="chevron-up"
                  @click="current_schedule = null"
                ></b-icon>
              </div>
              <b-form-row>
                <b-col sm="6" class="mb-3 px-3">
                  <b-form-group label="Choose Facilitator">
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
              </b-form-row>
              <b-form-row>
                <b-col sm="6" class="mb-3 px-3">
                  <b-form-group label="Venue">
                    <b-form-input
                      v-model="item.venue"
                      placeholder="Enter course Venue"
                    ></b-form-input>
                  </b-form-group>
                </b-col>
                <b-col sm="6" class="mb-3 px-3">
                  <b-form-group label="Url(optional)">
                    <b-form-input
                      v-model="item.url"
                      type="url"
                      placeholder="Enter url link (optional)"
                    ></b-form-input>
                  </b-form-group>
                </b-col>
              </b-form-row>

              <b-form-row>
                <b-col class="mb-3 px-3">
                  <b-form-group label="Choose modules">
                    <b-form-checkbox
                      v-if="detail.outline.modules.length"
                      size="sm"
                      @change="selectall(id, item.all, detail.outline.modules)"
                      v-model="item.all"
                      >Select all</b-form-checkbox
                    >
                    <b-form-checkbox-group
                      id="checkbox-group-1"
                      v-model="item.modules"
                      :options="detail.outline.modules"
                      name="modules"
                      value-field="module"
                      text-field="module"
                    ></b-form-checkbox-group>
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
                      <template v-slot="{ inputValue, inputEvents }">
                        <input
                          class="
                            px-2
                            py-1
                            border
                            rounded
                            focus:outline-none
                            focus:border-blue-300
                          "
                          :value="inputValue"
                          v-on="inputEvents"
                        />
                      </template>
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
                      <template v-slot="{ inputValue, inputEvents }">
                        <input
                          class="
                            px-2
                            py-1
                            border
                            rounded
                            focus:outline-none
                            focus:border-blue-300
                          "
                          :value="inputValue"
                          v-on="inputEvents"
                        />
                      </template>
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
              </div>
            </div>
          </div>
          <div class="text-center">
            <b-icon
              icon="plus-circle-fill"
              variant="dark-green"
              class="my-2"
              font-scale="1.4"
              @click="addschedule"
            ></b-icon>
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
            :disabled="disable"
            >Update course</b-button
          >
        </div>
      </b-form>
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
          :description="
            `I created a course titled,  ${course.title.bold()}, on SkillsGuruh. Check it out here`
          "
          quote="SkillsGuruh"
          hashtags="SkillsGuruh,  Social learning"
        >
          <b-button size="sm" class="mb-2 mb-sm-0" variant="outline-dark-green"
            ><b-icon class="mr-1" icon="facebook"></b-icon> Facebook</b-button
          >
        </ShareNetwork>
        <ShareNetwork
          class="mr-3"
          network="twitter"
          :url="link"
          title="COURSE INVITATION"
          :description="
            `I created a course titled,  ${course.title.bold()}, on SkillsGuruh. Check it out here`
          "
          quote="SkillsGuruh"
          hashtags="SkillsGuruh,  Social learning"
        >
          <b-button size="sm" class="mb-2 mb-sm-0" variant="outline-dark-green"
            ><b-icon class="mr-1" icon="twitter"></b-icon> Twitter</b-button
          >
        </ShareNetwork>
        <ShareNetwork
          class="mr-3"
          network="whatsApp"
          :url="link"
          title="COURSE INVITATION"
          :description="
            `I created a course titled,  ${course.title.bold()}, on SkillsGuruh. Check it out here`
          "
          quote="SkillsGuruh"
          hashtags="SkillsGuruh,  Social learning"
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
            Whatsapp</b-button
          >
        </ShareNetwork>
        <ShareNetwork
          class="mr-3"
          network="Telegram"
          :url="link"
          title="COURSE INVITATION"
          :description="
            `I created a course titled,  ${course.title.bold()}, on SkillsGuruh. Check it out here`
          "
          quote="SkillsGuruh"
          hashtags="SkillsGuruh,  Social learning"
        >
          <b-button size="sm" class="mb-2 mb-sm-0" variant="outline-dark-green"
            ><b-icon class="mr-1" icon="cursor-fill"></b-icon>
            Telegram</b-button
          >
        </ShareNetwork>

        <b-button
          size="sm"
          class="mb-2 mb-sm-0"
          variant="outline-dark-green"
          @click="addToFeed"
        >
          <b-icon icon="rss-fill" variant="dark-green"></b-icon>

          Feeds</b-button
        >
      </div>
    </b-modal>
    <b-container fluid class="pr-sm-0">
      <div>
        <b-row v-if="courses.length">
          <b-col :md="sideOpen ? 8 : 12" class="my_courses main_box">
            <div class="d-block d-sm-flex justify-content-between py-3">
              <div class="">
                <h4>Courses</h4>
              </div>

              <div
                class="
                  text-sm-right
                  d-flex
                  align-items-center
                  justify-content-center justify-content-sm-end
                  mr-sm-3
                  px-3
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
                    <b-input-group-append>
                      <b-button
                        class="d-none d-sm-block"
                        variant="dark-green"
                        @click="$bvModal.show('addcourse')"
                        >Add course</b-button
                      >
                      <b-button
                        class="d-sm-none"
                        variant="dark-green"
                        @click="$bvModal.show('addcourse')"
                        ><b-icon icon="plus"></b-icon
                      ></b-button>
                    </b-input-group-append>
                  </b-input-group>
                </div>
              </div>
            </div>
            <b-container fluid v-if="showCourse">
              <b-row>
                <b-col
                  :sm="sideOpen ? 4 : 3"
                  class="mb-4 side_box"
                  v-for="(course, index) in filteredCourse"
                  :key="index"
                >
                  <div
                    class="
                      shadow-sm
                      p-3
                      bg-white
                      text-left
                      h-100
                      cursor-pointer
                      position-relative
                      d-flex
                      flex-column
                    "
                    @click="showcourse(course)"
                  >
                    <div class="flex-1">
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

                        <!-- <b-dropdown-item
                      class="fs12"
                      @click="
                        $router.push(
                          `/facilitator/outlines?showing=${course.title}`
                        )
                      "
                      >View outline</b-dropdown-item
                    > -->
                        <b-dropdown-item
                          class="fs12"
                          @click="
                            $router.push(
                              `/facilitator/modules/${course.id}?showing=${course.title}`
                            )
                          "
                          >Add resources</b-dropdown-item
                        >

                        <b-dropdown-item class="fs12" @click="edit(course)"
                          >Edit course info</b-dropdown-item
                        >
                        <b-dropdown-item
                          class="fs12"
                          @click="drop(course.id, index)"
                          >Drop course</b-dropdown-item
                        >
                      </b-dropdown>

                      <b-iconstack font-scale="2.5" class="mr-2 mb-2">
                        <b-icon
                          stacked
                          icon="circle-fill"
                          :style="
                            `color:${
                              JSON.parse(course.courseoutline.knowledge_areas)
                                .color
                            }`
                          "
                        ></b-icon>
                        <b-icon
                          stacked
                          :icon="
                            JSON.parse(course.courseoutline.knowledge_areas)
                              .icon
                          "
                          scale="0.5"
                          variant="light"
                        ></b-icon>
                      </b-iconstack>

                      <div class="course_title cours_tit mb-1">
                        {{ course.title }}
                      </div>
                      <div class="mb-3">
                        <span
                          class="
                            fs13
                            overview
                            text-truncate text-truncate--2
                            text-muted
                          "
                        >
                          {{ course.description }}</span
                        >
                      </div>
                      <div
                        class="
                          course_fac
                          d-flex
                          align-items-center
                          mb-1
                          text-capitalize
                          fs13
                        "
                        v-if="sortfacilitators(course).length == 1"
                      >
                        <b-icon
                          icon="display"
                          variant="dark-green"
                          class="text-muted mr-2"
                        ></b-icon>
                        <span class="fs13">
                          {{ sortfacilitators(course).join(" ") }}</span
                        >
                      </div>
                      <div
                        class="
                          course_fac
                          d-flex
                          align-items-center
                          mb-1
                          text-capitalize
                          fs13
                        "
                        v-else
                      >
                        <b-icon
                          icon="display"
                          variant="dark-green"
                          class="text-muted mr-2"
                        ></b-icon>
                        <span class="fs13"> Multiple Facilitators</span>
                      </div>

                      <div
                        class="
                          course_time
                          d-flex
                          text-capitalize
                          align-items-center
                          mb-1
                          fs13
                        "
                      >
                        <b-icon
                          icon="calendar"
                          variant="dark-green"
                          class="text-muted mr-2"
                        ></b-icon>
                        <div class="">
                          <div class="text-capitalize">
                            {{ course.courseoutline.duration }}
                          </div>
                        </div>
                      </div>

                      <div
                        v-if="course"
                        class="course_modules align-items-center mb-1 fs13"
                      >
                        <b-icon
                          icon="layers"
                          variant="dark-green"
                          class="text-muted mr-1"
                        ></b-icon>
                        <span class="fs13"> {{ sortmodules(course) }}</span>
                        Modules
                      </div>
                      <div>
                        <span
                          class="fs13 text-muted d-flex justify-content-between"
                          ><span
                            ><b-icon
                              class="mr-2"
                              :icon="
                                course.type == 'free'
                                  ? 'unlock-fill'
                                  : 'lock-fill'
                              "
                            ></b-icon>
                            <span class="text-capitalize">{{
                              course.type
                            }}</span></span
                          >
                          <span v-if="course.type == 'paid'">
                            {{ course.amount | currencyFormat }}</span
                          >
                        </span>
                      </div>
                    </div>

                    <div class="pt-3">
                      <div class="d-flex justify-content-between fs13">
                        <span>Resources upload</span
                        ><span
                          >{{
                            Math.floor(
                              getProgress(
                                course.courseoutline.modules,
                                course.modules
                              )
                            ) || 0
                          }}%</span
                        >
                      </div>
                      <b-progress
                        :value="
                          Math.floor(
                            getProgress(
                              course.courseoutline.modules,
                              course.modules
                            )
                          )
                        "
                        :max="100"
                        show-value
                        height=".8rem"
                        class="mb-3"
                        variant="dark-green"
                      ></b-progress>
                    </div>
                  </div>
                </b-col>
              </b-row>
              <div class="py-3 d-flex justify-content-between" v-if="rows > 12">
                <div class="fs12 text-muted">
                  Showing 1-10 of {{ filteredCourse.length }} items
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

          <b-col md="4" v-show="sideOpen" class="sidebar toggleSide">
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
                      :style="
                        `color:${
                          JSON.parse(course.courseoutline.knowledge_areas).color
                        }`
                      "
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
                    <span class="title" v-if="course.title">
                      {{ course.title }}
                      <span class="text-muted fs13" v-if="course.course_code">
                        ({{ course.course_code }})</span
                      ></span
                    >
                    <br />
                    <span class="course_time text-capitalize"
                      ><b-icon icon="clock" class="mr-1"></b-icon>
                      {{ course.courseoutline.duration }}</span
                    >
                  </div>
                </div>

                <b-img
                  style="width: 60px; height: 70px; object-fit: cover"
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
                  <div class="w-100">
                    <h6 class="fs14">Course Access</h6>
                    <div class="d-flex justify-content-between">
                      <div>
                        <p class="fs13 text-capitalize mb-1">
                          {{ course.type }}
                        </p>
                        <p class="fs13" v-if="course.type !== 'free'">
                          <span v-if="course.type == 'paid'">
                            {{ course.amount | currencyFormat }}</span
                          >
                          <span v-if="course.type == 'group'">
                            {{ course.amount }}</span
                          >
                          {{ course.type == "group" ? "Participants" : "" }}
                        </p>
                      </div>
                      <div class="text-right">
                        <div class="d-flex align-items-center">
                          <b-icon
                            font-scale="1.15"
                            class="ml-auto mr-3"
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
                  </div>
                </div>
                <div class="mb-3 px-2">
                  <h6 class="fs14">Course Description</h6>
                  <p class="fs13">
                    {{ course.description ? course.description : "None" }}
                  </p>
                </div>
                <div class="mb-3 px-2">
                  <h6 class="fs14 mb-1">Knowledge Area</h6>
                  <p class="fs13 text-capitalize">
                    {{
                      course.courseoutline.knowledge_areas
                        ? JSON.parse(course.courseoutline.knowledge_areas).value
                        : "None"
                    }}
                  </p>
                </div>

                <div class="mb-3 px-2">
                  <div class="" v-if="course.courseschedule.length">
                    <b-row>
                      <b-col cols="6">
                        <h6 class="fs14">Start</h6>
                        <span class="fs14">{{
                          course.courseschedule[0].start_time
                            | moment("MMM DD, YYYY")
                        }}</span>
                      </b-col>
                      <b-col cols="6">
                        <h6 class="fs14">End</h6>
                        <span class="fs14">{{
                          course.courseschedule[0].end_time
                            | moment("MMM DD, YYYY")
                        }}</span>
                      </b-col>
                    </b-row>
                  </div>
                </div>

                <div class="mb-3 px-2">
                  <h6 class="fs14">Additional Information</h6>
                  <p class="fs13">
                    {{
                      course.courseoutline.additional_info
                        ? course.courseoutline.additional_info
                        : "None"
                    }}
                  </p>
                </div>
                <div class="mb-3 px-2">
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
                  <h6 class="mb-3 fs14 px-2">Course Files</h6>
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

                <div
                  class="accordion"
                  role="tablist"
                  v-if="course.modules.length"
                >
                  <b-card
                    no-body
                    class="mb-1"
                    v-for="(item, id) in JSON.parse(
                      course.courseoutline.modules
                    )"
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
                      <div
                        v-if="
                          course.modules.some(
                            i => i.module.toLowerCase() == item.toLowerCase()
                          )
                        "
                      >
                        <b-card-body
                          v-for="(mod, index) in JSON.parse(
                            course.modules.find(
                              i => i.module.toLowerCase() == item.toLowerCase()
                            ).modules
                          )"
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
                          <b-card-text class="fs12">{{
                            mod.overview
                          }}</b-card-text>
                        </b-card-body>
                      </div>
                      <div v-else>
                        <b-card-body>
                          <b-card-text>N/A</b-card-text>
                        </b-card-body>
                      </div>
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
                    {{ item.module }}
                  </div>
                </div>
              </div>
              <div v-if="toggleCourse == 3" class="h-100 p-2">
                <div class="mb-4">
                  <h6 class="fs14 mb-3">Overview</h6>

                  <div
                    class="fs13"
                    v-html="course.courseoutline.overview"
                  ></div>
                </div>

                <div>
                  <h6 class="fs14 mb-3">Faqs</h6>

                  <div class="accordion" role="tablist">
                    <b-card
                      no-body
                      class="mb-1"
                      v-for="(item, id) in JSON.parse(
                        course.courseoutline.faqs
                      )"
                      :key="id"
                    >
                      <b-card-header
                        header-tag="header"
                        class="p-1 bg-light"
                        role="tab"
                      >
                        <div
                          v-b-toggle="'file' + id"
                          variant="info"
                          class="fs13"
                        >
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
                      class="mb-3 px-3 border-bottom"
                      v-for="(item, index) in course.courseschedule"
                      :key="index"
                    >
                      <div class="mb-1">
                        <span class="fs14 mr-2">Time: </span>
                        <span class="text-sm">
                          {{ item.start_time | moment("LT") }}</span
                        >
                      </div>
                      <div class="mb-1">
                        <span class="fs14 mr-2">Date: </span>
                        <span class="text-sm">
                          {{ item.start_time | moment("MMM DD, YYYY") }}</span
                        >
                      </div>
                      <div class="mb-1">
                        <span class="fs14 mr-2">Venue: </span>
                        <span class="text-sm">
                          {{ item.venue ? item.venue : "None" }}</span
                        >
                      </div>
                      <div class="mb-1">
                        <span class="fs14 mr-2">Url: </span>
                        <span class="text-sm">
                          {{ item.url ? item.url : "None" }}</span
                        >
                      </div>
                      <div>
                        <span class="fs14 mr-2">Facilitator: </span>
                        <span
                          class="text-sm"
                          v-if="item.facilitator_id != null"
                          >{{
                            facilitators.find(
                              val => val.id == item.facilitator_id
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
            <h2 class="mb-3 px-2 text-muted">No Course Available</h2>
            <b-img
              class="mb-3 px-2"
              :src="require('@/assets/images/creator.svg')"
            ></b-img>
            <p class="mb-3">
              There appears to be no course available <br />
              please create a new course by clicking the button below
            </p>
            <b-button @click="$bvModal.show('addcourse')" variant="dark-green"
              >Add course</b-button
            >
          </b-col>
        </b-row>
      </div>
    </b-container>
    <b-modal id="mobile-course" centered hide-footer>
      <div class="">
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
                  :style="
                    `color:${
                      JSON.parse(course.courseoutline.knowledge_areas).color
                    }`
                  "
                ></b-icon>
                <b-icon
                  stacked
                  :icon="JSON.parse(course.courseoutline.knowledge_areas).icon"
                  scale="0.5"
                  variant="light"
                ></b-icon>
              </b-iconstack>
              <div>
                <span class="title" v-if="course.title">
                  {{ course.title }}
                  <span class="text-muted fs13" v-if="course.course_code">
                    ({{ course.course_code }})</span
                  ></span
                >
                <br />
                <span class="course_time text-capitalize"
                  ><b-icon icon="clock" class="mr-1"></b-icon>
                  {{ course.courseoutline.duration }}</span
                >
              </div>
            </div>

            <b-img
              style="width: 60px; height: 70px; object-fit: cover"
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
              <div class="w-100">
                <h6 class="fs14">Course Access</h6>
                <div class="d-flex justify-content-between">
                  <div>
                    <p class="fs13 text-capitalize mb-1">
                      {{ course.type }}
                    </p>
                    <p class="fs13" v-if="course.type !== 'free'">
                      <span v-if="course.type == 'paid'">
                        {{ course.amount | currencyFormat }}</span
                      >
                      <span v-if="course.type == 'group'">
                        {{ course.amount }}</span
                      >
                      {{ course.type == "group" ? "Participants" : "" }}
                    </p>
                  </div>
                  <div class="text-right">
                    <div class="d-flex align-items-center">
                      <b-icon
                        font-scale="1.15"
                        class="ml-auto mr-3"
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
              </div>
            </div>
            <div class="mb-3 px-2">
              <h6 class="fs14">Course Description</h6>
              <p class="fs13">
                {{ course.description ? course.description : "None" }}
              </p>
            </div>
            <div class="mb-3 px-2">
              <h6 class="fs14 mb-1">Knowledge Area</h6>
              <p class="fs13 text-capitalize">
                {{
                  course.courseoutline.knowledge_areas
                    ? JSON.parse(course.courseoutline.knowledge_areas).value
                    : "None"
                }}
              </p>
            </div>

            <div class="mb-3 px-2">
              <div class="" v-if="course.courseschedule.length">
                <b-row>
                  <b-col cols="6">
                    <h6 class="fs14">Start</h6>
                    <span class="fs14">{{
                      course.courseschedule[0].start_time
                        | moment("MMM DD, YYYY")
                    }}</span>
                  </b-col>
                  <b-col cols="6">
                    <h6 class="fs14">End</h6>
                    <span class="fs14">{{
                      course.courseschedule[0].end_time | moment("MMM DD, YYYY")
                    }}</span>
                  </b-col>
                </b-row>
              </div>
            </div>

            <div class="mb-3 px-2">
              <h6 class="fs14">Additional Information</h6>
              <p class="fs13">
                {{
                  course.courseoutline.additional_info
                    ? course.courseoutline.additional_info
                    : "None"
                }}
              </p>
            </div>
            <div class="mb-3 px-2">
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
              <h6 class="mb-3 fs14 px-2">Course Files</h6>
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

            <div class="accordion" role="tablist" v-if="course.modules.length">
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
                    <b-card-text class="d-flex"
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
                {{ item.module }}
              </div>
            </div>
          </div>
          <div v-if="toggleCourse == 3" class="h-100 p-2">
            <div class="mb-4">
              <h6 class="fs14 mb-3">Overview</h6>

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
                  class="mb-3 px-3 border-bottom"
                  v-for="(item, index) in course.courseschedule"
                  :key="index"
                >
                  <div class="mb-1">
                    <span class="fs14 mr-2">Time: </span>
                    <span class="text-sm">
                      {{ item.start_time | moment("LT") }}</span
                    >
                  </div>
                  <div class="mb-1">
                    <span class="fs14 mr-2">Date: </span>
                    <span class="text-sm">
                      {{ item.start_time | moment("MMM DD, YYYY") }}</span
                    >
                  </div>
                  <div class="mb-1">
                    <span class="fs14 mr-2">Venue: </span>
                    <span class="text-sm">
                      {{ item.venue ? item.venue : "None" }}</span
                    >
                  </div>
                  <div class="mb-1">
                    <span class="fs14 mr-2">Url: </span>
                    <span class="text-sm">
                      {{ item.url ? item.url : "None" }}</span
                    >
                  </div>
                  <div>
                    <span class="fs14 mr-2">Facilitator: </span>
                    <span class="text-sm" v-if="item.facilitator_id != null">{{
                      facilitators.find(val => val.id == item.facilitator_id)
                        .name
                    }}</span>
                    <span v-else class="text-sm">Unavailable</span>
                  </div>
                </b-col>
              </b-row>
            </div>
          </div>
        </div>
      </div>
    </b-modal>
  </div>
</template>
<script>
import Upload from "@/components/fileupload.vue";
import Insight from "../insight.js";
import Editor from "@tinymce/tinymce-vue";
import draggable from "vuedraggable";
export default {
  data() {
    return {
      editable: true,
      isDragging: false,
      delayedDragging: false,
      sideOpen: true,
      current_schedule: 0,
      search: "",
      insight: [],
      courses: [],
      course: null,
      type: 1,
      link: "",

      inviteUsers: {
        code: "",
        title: "",
        url: "",
        users: [
          {
            email: ""
          }
        ]
      },
      disable: false,
      message: "",
      newmodule: "",
      facilitators: [],
      toggleCourse: 1,
      showCourse: false,
      detail: {
        general: {
          title: "",
          code: "",
          description: "",
          cover: "",
          type: "group",
          amount: null
        },
        outline: {
          overview: "",
          knowledge_area: "",
          duration: "",
          modules: [],
          faqs: [
            {
              question: "",
              answer: ""
            }
          ],
          certification: null,
          additional_info: ""
        },
        schedule: [
          {
            all: false,
            type: "course",
            event_type: "class",
            url: "",
            venue: "",
            day: "monday",
            modules: [],
            start_time: new Date(),
            end_time: new Date(),
            facilitator_id: null
          }
        ]
      },

      course_type: "",
      recent: false,
      trending: false,
      alpha: false,
      currentPage: 1,
      rows: null,
      perPage: 12
    };
  },
  components: {
    Upload,
    Editor,
    draggable
  },
  mounted() {
    this.getcourses();
    this.getfacilitators();
    this.insight = Insight;
    this.$root.$on("bv::modal::hide", (bvEvent, modalId) => {
      if (modalId == "addcourse" || modalId == "update") {
        this.type = 1;
      }
    });
  },
  watch: {
    isDragging(newValue) {
      if (newValue) {
        this.delayedDragging = true;
        return;
      }
      this.$nextTick(() => {
        this.delayedDragging = false;
      });
    }
  },
  computed: {
    dragOptions() {
      return {
        animation: 0,
        group: "description",
        disabled: !this.editable,
        ghostClass: "ghost"
      };
    },
    filteredCourse() {
      var title = this.courses
        .slice(
          this.perPage * this.currentPage - this.perPage,
          this.perPage * this.currentPage
        )
        .filter(
          item =>
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
        courseType = title.filter(item => item.type == "free");
      } else if (this.course_type == "paid") {
        courseType = title.filter(item => item.type == "paid");
      } else if (this.course_type == "group") {
        courseType = title.filter(item => item.type == "group");
      } else {
        courseType = title;
      }

      if (this.recent) {
        return courseType.slice().reverse();
      }
      return courseType;
    }
  },
  methods: {
    onMove({ relatedContext, draggedContext }) {
      const relatedElement = relatedContext.element;
      const draggedElement = draggedContext.element;
      return (
        (!relatedElement || !relatedElement.fixed) && !draggedElement.fixed
      );
    },

    selectall(id, val, arr) {
      if (val) {
        this.detail.schedule[id].modules = arr.map(item => item.module);
      } else {
        this.detail.schedule[id].modules = [];
      }
    },
    addinvite() {
      this.inviteUsers.users.push({
        email: ""
      });
    },
    onCopy: function(e) {
      alert("You just copied the following text to the clipboard: " + e.text);
    },
    onError: function(e) {
      alert("Failed to copy the text to the clipboard");
      console.log(e);
    },
    sendinvite(title) {
      this.inviteUsers.title = title;
      this.inviteUsers.url = this.message;
      this.$http
        .post(`${this.$store.getters.url}/send/invite`, this.inviteUsers, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`
          }
        })
        .then(res => {
          if (res.status == 200) {
            this.$toast.success("Invite Sent");
            this.$bvModal.hide("courselink");
            this.inviteUsers = {
              code: "",
              title: "",
              users: [
                {
                  email: ""
                }
              ]
            };
          }
        })
        .catch(() => {
          this.$toasted.error("Sending failed!");
        });
    },
    sharecourse(id) {
      this.message = `https://skillsguruh.com/explore/courses?course_id=${id}`;
      this.$bvModal.show("sharecourse");
    },
    addToFeed() {
      this.feed = {
        media: this.course.cover,
        message:
          "I created a course titled, " +
          this.course.title.bold() +
          ", Check it out here",
        url:
          "https://skillsguruh.com/learner/courses/?course_id=" + this.course.id
      };
      this.$http
        .post(`${this.$store.getters.url}/feeds`, this.feed, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`
          }
        })
        .then(res => {
          if (res.status == 201 || res.status == 200) {
            this.$toast.success("Added to feeds ");
            this.$bvModal.hide("share");

            this.feed = {
              media: "",
              message: ""
            };
          }
        })
        .catch(err => {
          this.$toast.error(err.response.data.message);
        });
    },
    sharelink(id) {
      this.link = `https://skillsguruh.com/explore/courses/?course_id=${id}`;

      this.$bvModal.show("share");
    },
    getProgress(a, b) {
      var count = 0;

      var modules = JSON.parse(a);

      var resources = b;

      modules.forEach(mod => {
        var val = resources.filter(item => item.module == mod.module).length;

        if (val) {
          count++;
        }
      });

      return (count / modules.length) * 100;
    },

    getmediacount(arr, media) {
      var newarr = [];
      if (!arr.length) {
        return 0;
      }
      if (media == "document") {
        arr.forEach(val => {
          JSON.parse(val.modules).forEach(item => {
            if (
              item.file_type.toLowerCase() == media.toLowerCase() ||
              item.file_type.toLowerCase() == "worksheet"
            ) {
              newarr.push(item);
            }
          });
        });
      } else {
        arr.forEach(val => {
          JSON.parse(val.modules).forEach(item => {
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
    sortfacilitators(data) {
      if (!data.courseschedule) {
        return "Unavailable";
      }
      var schedule = data.courseschedule;
      var newArr = schedule.map(val => {
        if (val.facilitator_id) {
          var fac = this.facilitators.find(
            item => item.id == val.facilitator_id
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
      return schedule.map(item => {
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
        all: false,
        type: "course",
        event_type: "class",
        url: "",
        venue: "",
        day: "monday",
        modules: [],
        start_time: new Date(),
        end_time: new Date(),
        facilitator_id: null
      });
      this.current_schedule = this.detail.schedule.length - 1;
    },
    addmodule() {
      if (!this.newmodule) {
        this.$toast.info("Cannot be empty!");
        return;
      }
      this.detail.outline.modules.push({
        fixed: false,
        module: this.newmodule
      });
      this.newmodule = "";
    },

    addfaq() {
      this.detail.outline.faqs.push({
        question: "",
        answer: ""
      });
    },

    getfacilitators() {
      this.$http
        .get(`${this.$store.getters.url}/facilitators`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`
          }
        })
        .then(res => {
          if (res.status == 200) {
            this.facilitators = res.data;
          }
        })
        .catch(err => {
          this.$toast.error(err.response.data.message);
        });
    },

    getcourses() {
      this.$http
        .get(`${this.$store.getters.url}/courses`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`
          }
        })
        .then(res => {
          if (res.status == 200) {
            this.courses = res.data;
            this.showCourse = true;
            this.rows = res.data.length;
          }
        })
        .catch(err => {
          this.$toast.error(err.response.data.message);
        });
    },
    createcourse() {
      this.disable = true;
      this.$http
        .post(`${this.$store.getters.url}/courses`, this.detail, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`
          }
        })
        .then(res => {
          if (res.status == 201) {
            this.$toast.success("Course created");
            this.disable = false;
            this.courses.unshift(res.data);
            this.$bvModal.hide("addcourse");
            this.detail = {
              general: {
                title: "",
                code: "",
                description: "",
                cover: "",
                type: "group",
                amount: null
              },
              outline: {
                overview: "",
                knowledge_area: "",
                duration: "",
                modules: [],
                faqs: [
                  {
                    question: "",
                    answer: ""
                  }
                ],
                certification: null,
                additional_info: ""
              },
              schedule: [
                {
                  all: false,
                  type: "course",
                  event_type: "class",
                  url: "",
                  venue: "",
                  day: "monday",
                  modules: [],
                  start_time: new Date(),
                  end_time: new Date(),
                  facilitator_id: null
                }
              ]
            };
          }
        })
        .catch(err => {
          this.disable = false;
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
          type: val.type,
          amount: val.amount
        },
        outline: {
          overview: val.courseoutline.overview,
          knowledge_area: JSON.parse(val.courseoutline.knowledge_areas),
          duration: val.courseoutline.duration,
          modules: JSON.parse(val.courseoutline.modules),
          faqs: JSON.parse(val.courseoutline.faqs),
          certification: val.courseoutline.certification,
          additional_info: val.courseoutline.additional_info
        },
        schedule: val.courseschedule.map(item => {
          return {
            id: item.id,
            all: item.all,
            type: item.type,
            event_type: item.event_type,
            url: item.url,
            venue: item.venue,
            day: item.day,
            modules: JSON.parse(item.modules),
            start_time: item.start_time,
            end_time: item.end_time,
            facilitator_id: item.facilitator_id
          };
        })
      };

      this.$bvModal.show("update");
    },
    updatecourse() {
      this.disable = true;
      this.$http
        .put(
          `${this.$store.getters.url}/courses/${this.course.id}`,
          this.detail,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`
            }
          }
        )
        .then(res => {
          if (res.status == 200) {
            this.$toast.success("Update successful");
            this.$bvModal.hide("update");
            this.disable = false;
            this.getcourses();
            this.type = 1;
            this.detail = {
              general: {
                title: "",
                code: "",
                description: "",
                cover: "",
                type: "group",
                cost: ""
              },
              outline: {
                overview: "",
                knowledge_area: "",
                duration: "",
                modules: [],
                faqs: [
                  {
                    question: "",
                    answer: ""
                  }
                ],
                certification: null,
                additional_info: ""
              },
              schedule: [
                {
                  all: false,
                  type: "course",
                  event_type: "class",
                  url: "",
                  venue: "",
                  day: "monday",
                  modules: [],
                  start_time: new Date(),
                  end_time: new Date(),
                  facilitator_id: null
                }
              ]
            };
          }
        })
        .catch(err => {
          this.disable = false;
          this.$toast.error(err.response.data.message);
        });
    },
    drop(id, index) {
      this.$bvModal.msgBoxConfirm("Are you sure").then(val => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/courses/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`
              }
            })
            .then(res => {
              if (res.status == 200) {
                this.$toast.success("Removed successfully");
                this.courses.splice(index, 1);
              }
            })
            .catch(err => {
              this.disable = false;
              this.$toast.error(err.response.data.message);
            });
        }
      });
    }
  }
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
  height: calc(100vh - 80px);
  position: fixed;
  right: 0;
  width: 25%;
  overflow-y: scroll;
}
.main_box {
  transition: 0.5s;
}

.course_title {
  font-weight: 500;
}
.course_fac {
  font-size: 13px;
  color: rgba($color: #000000, $alpha: 0.4);
}
.course_time {
  font-size: 13px;
  color: rgba($color: #000000, $alpha: 0.4);
}
.course_modules {
  font-size: 13px;
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
.igm {
  width: 30px !important;
  height: auto;
  object-fit: contain;
}
.sideopen {
  position: absolute;
  top: 0;
  left: 0;
  padding: 2px 4px;
  background: var(--lighter-green);
  color: #333;
  font-size: 13px;
  cursor: pointer;
}
@media (max-width: 600px) {
  .search {
    width: 75%;
  }
}
</style>

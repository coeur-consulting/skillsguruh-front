<template>
  <div>
    <b-container class="px-3 px-sm-0">
      <b-row>
        <b-col sm="9">
          <b-row class="mb-4 mb-sm-5">
            <b-col class="position-relative" v-if="showEvent">
              <carousel
                :perPage="1"
                :paginationEnabled="false"
                :autoplay="true"
                :speed="1000"
                :autoplayTimeout="5000"
                :loop="true"
                v-if="comingevents.length"
              >
                <slide v-for="item in comingevents" :key="item.id">
                  <div
                    class="
                      box
                      top_box
                      flex-sm-row flex-column-reverse
                      p-0
                      position-relative
                    "
                  >
                    <div
                      class="upcoming text-capitalize"
                      :class="{
                        'bg-dark': item.status == 'ongoing',
                        'bg-danger': item.status == 'expired',
                        'bg-info': item.status == 'pending',
                      }"
                    >
                      {{ item.status }} event
                    </div>
                    <b-col sm="5" class="h-100">
                      <div
                        class="
                          p-3
                          d-flex
                          flex-column
                          justify-content-center
                          h-100
                        "
                      >
                        <div
                          class="mb-3 h3 fs16 text-dark-green"
                          v-if="item.title"
                        >
                          {{ item.title }}
                        </div>
                        <div class="mb-1 fs13 overview">
                          {{ item.description }}
                        </div>
                        <div class="mb-1 fs13">
                          Duration : {{ item.schedule }}
                        </div>
                        <div class="mb-1 fs12">
                          Time : {{ item.start | moment("ll") }} -
                          {{ item.end | moment("ll") }}
                        </div>

                        <div class="mt-3">
                          <b-button
                            v-if="
                              $moment().isBefore(item.start) ||
                              $moment().isAfter(item.end)
                            "
                            pill
                            size="sm"
                            variant="outline-dark-green"
                            @click="
                              $router.push(`/administrator/event/${item.id}`)
                            "
                            >View Event</b-button
                          >
                          <div v-else>
                            <b-button
                              class="mr-3"
                              pill
                              size="sm"
                              variant="outline-dark-green"
                              @click="
                                $router.push(`/administrator/event/${item.id}`)
                              "
                              >View Event</b-button
                            >
                            <a :href="item.url" target="_blank">
                              <b-button
                                pill
                                size="sm"
                                variant="lighter-green"
                                class="text-dark-green"
                                >Attend event</b-button
                              ></a
                            >
                          </div>
                        </div>
                      </div>
                    </b-col>
                    <b-col sm="7" class="text-right p-0 brad">
                      <b-img :src="item.cover" fluid-grow></b-img>
                    </b-col>
                  </div>
                </slide>
              </carousel>
              <div class="box top_box flex-row p-0" v-else>
                <h3 class="text-muted py-5 text-center">
                  No Upcoming Event Available !
                </h3>
              </div>
            </b-col>
            <b-col class="w-100" v-else>
              <div class="box p-4">
                <b-row class="w-100">
                  <b-col cols="4">
                    <div class="p-1">
                      <b-skeleton animation="wave" width="100%"></b-skeleton>
                      <b-skeleton animation="wave" width="25%"></b-skeleton>
                    </div>
                    <div class="p-1">
                      <b-skeleton animation="wave" width="100%"></b-skeleton>
                      <b-skeleton animation="wave" width="25%"></b-skeleton>
                    </div>
                    <div class="p-1">
                      <b-skeleton animation="wave" width="100%"></b-skeleton>
                      <b-skeleton animation="wave" width="25%"></b-skeleton>
                    </div>
                  </b-col>

                  <b-col cols="8" class="">
                    <b-skeleton-img no-aspect height="150px"></b-skeleton-img>
                  </b-col>
                </b-row>
              </div>
            </b-col>
          </b-row>

          <b-row v-if="showTable">
            <b-col>
              <div class="box" v-if="schedules.length">
                <div
                  class="
                    d-flex
                    justify-content-between
                    align-items-center
                    p-3
                    w-100
                    border-bottom
                  "
                >
                  <b-button
                    size="sm"
                    variant="dark-green"
                    @click="$bvModal.show('addopen')"
                    ><b-icon icon="plus"></b-icon
                  ></b-button>
                  <span>{{ new Date() | moment("LL") }}</span>
                </div>

                <div class="w-100 p-3">
                  <b-table-simple responsive borderless>
                    <b-tbody>
                      <b-tr v-for="day in days" :key="day">
                        <b-th
                          sticky-column
                          class="text-capitalize"
                          v-if="daySchedule(day).length"
                          >{{ day }}</b-th
                        >
                        <b-td v-if="daySchedule(day).length">
                          <div class="d-flex tabl">
                            <b-card
                              no-body
                              v-for="(item, id) in daySchedule(day)"
                              :key="id"
                              class="mr-3 text-white"
                              style="width: 250px"
                              :style="{
                                'background-color': item.customData.color,
                              }"
                            >
                              <b-card-header
                                class="
                                  d-flex
                                  justify-content-between
                                  w-100
                                  align-items-center
                                  px-3
                                "
                              >
                                <span
                                  class="
                                    text-capitalize
                                    font-weight-bold
                                    schedule_type
                                  "
                                  >{{ item.customData.type }}</span
                                >
                                <div
                                  class="
                                    rounded-pill
                                    px-2
                                    py-1
                                    bg-light
                                    schedule_dates
                                  "
                                >
                                  {{
                                    duration(item.dates.start, item.dates.end)
                                  }}
                                </div>
                              </b-card-header>
                              <b-card-text
                                class="text-white schedule_title mb-1 px-3"
                                v-if="item.customData.title"
                              >
                                {{ item.customData.title }}
                              </b-card-text>
                              <b-card-text
                                class="text-white schedule_date mb-1 px-3"
                              >
                                {{
                                  item.customData.facilitator
                                    ? item.customData.facilitator
                                    : "N/A"
                                }}
                              </b-card-text>
                              <b-card-text
                                class="text-white schedule_date mb-1 px-3"
                              >
                                {{ item.dates.start | moment("LT") }}
                              </b-card-text>

                              <b-card-footer
                                class="
                                  schedule_date
                                  d-flex
                                  text-white
                                  justify-content-between
                                  py-1
                                  px-3
                                "
                                v-if="item.dates.start"
                              >
                                {{ item.dates.start | moment(" MMMM Do") }}
                                <span class="mx-3">-</span>
                                {{ item.dates.end | moment(" MMMM Do") }}
                              </b-card-footer>
                            </b-card>
                          </div>
                        </b-td>
                      </b-tr>
                    </b-tbody>
                  </b-table-simple>
                </div>
              </div>
              <div class="box text-center p-3 w-100" v-else>
                <div class="mx-auto">
                  <b-img :src="require('@/assets/images/creator.svg')"></b-img>
                  <h6 class="text-muted my-3 fs14">
                    It appears you havent added any Schedule yet,
                    <br class="d-none d-sm-block" />

                    Have you set up your courses ?
                    <span
                      ><router-link
                        class="text-dark-green"
                        to="/administrator/courses?action=setupcourse"
                        >Set up Now</router-link
                      ></span
                    >
                    <br />
                    If You have <br />
                    <b-button
                      variant="dark-green"
                      class="mt-4"
                      size="sm"
                      @click="$bvModal.show('addopen')"
                      >Add a schedule now
                    </b-button>
                  </h6>
                </div>
              </div>
            </b-col>
          </b-row>

          <div class="box p-5" v-else>
            <b-skeleton-table
              :rows="5"
              :columns="3"
              :table-props="{ bordered: true, striped: true }"
            ></b-skeleton-table>
          </div>
        </b-col>

        <b-col sm="3" class="text-left">
          <div class="turn_over_box">
            <div class="tob_1 mb-4">
              <vc-calendar
                class="custom-calendar max-w-full"
                :masks="masks"
                :attributes="attributes"
                disable-page-swipe
                is-expanded
                title-position="left"
              >
                <template #day-popover="{ dayTitle, attributes }">
                  <div class="text-xs text-gray-300 font-semibold text-center">
                    {{ dayTitle }}
                  </div>
                  <popover-row
                    v-for="attr in attributes"
                    :key="attr.key"
                    :attribute="attr"
                    class="border-bottom pb-2"
                  >
                    <div>
                      <p class="mb-1 text-capitalize">
                        {{ attr.customData.title }}
                      </p>
                      <p class="fs11 mb-0 text-capitalize">
                        <span class="mr-2"> {{ attr.customData.type }} </span>
                      </p>
                    </div>
                  </popover-row>
                </template>
              </vc-calendar>
            </div>
            <div class="tob_2">
              <div class="d-flex align-items-center p-3">
                <h6 class="flex-1">Today schedule</h6>
                <b-form-select class="border-0" style="width: 100px" size="sm">
                  <b-form-select-option value="">Today</b-form-select-option>
                </b-form-select>
              </div>
              <div class="schedule" v-if="showschedule">
                <div v-if="todaySchedule().length">
                  <div
                    class="p-3 border-bottom"
                    v-for="(item, id) in todaySchedule()"
                    :key="id"
                  >
                    <div class="course_title d-flex mb-3 fs13">
                      <b-iconstack font-scale="1.5" class="mr-3">
                        <b-icon
                          stacked
                          icon="circle-fill"
                          variant="lighter-green"
                        ></b-icon>
                        <b-icon
                          stacked
                          icon="calendar"
                          scale="0.5"
                          variant="dark-green"
                        ></b-icon>
                      </b-iconstack>
                      <div>
                        <span
                          class="title font-weight-bold"
                          v-if="item.customData.title"
                        >
                          {{ item.customData.title }}</span
                        >
                      </div>
                    </div>
                    <div>
                      <span class="fs12"
                        ><b-icon icon="clock" class="mr-2"></b-icon>
                        <span
                          >{{ item.dates.start | moment("LT") }}
                          -
                          {{ item.dates.end | moment("LT") }}</span
                        ></span
                      >
                    </div>
                    <div>
                      <span class="fs12"
                        ><b-icon icon="calendar3" class="mr-2"></b-icon>
                        <span>Today</span></span
                      >
                    </div>
                    <div class="mb-3">
                      <span class="fs12"
                        ><b-icon icon="person" class="mr-2"></b-icon>
                        <span>{{ item.customData.facilitator }}</span></span
                      >
                    </div>

                    <div class="text-right">
                      <a :href="item.customData.url" target="_blank">
                        <b-button
                          block
                          variant="lighter-green"
                          class="text-dark-green"
                          >Attend
                        </b-button></a
                      >
                    </div>
                  </div>
                </div>
                <div v-else class="p-4 text-center">
                  <p class="text-muted">Nothing Scheduled Today</p>
                </div>
              </div>

              <div v-else class="p-4">
                <div class="p-1">
                  <b-skeleton animation="wave" width="100%"></b-skeleton>
                  <b-skeleton animation="wave" width="25%"></b-skeleton>
                </div>
                <div class="p-1">
                  <b-skeleton animation="wave" width="100%"></b-skeleton>
                  <b-skeleton animation="wave" width="25%"></b-skeleton>
                </div>
                <div class="p-1">
                  <b-skeleton animation="wave" width="100%"></b-skeleton>
                  <b-skeleton animation="wave" width="25%"></b-skeleton>
                </div>
              </div>
            </div>
          </div>
        </b-col>
      </b-row>
    </b-container>
    <b-modal
      no-close-on-backdrop
      id="add"
      hide-footer
      centered
      size="lg"
      title="Add Schedule"
    >
      <b-container>
        <b-row v-if="schedule_num == 3">
          <b-col>
            <b-form @submit.prevent="addevent" class="event">
              <div>
                <b-form-row class="mb-2">
                  <b-col sm="12" class="pr-sm-3">
                    <b-form-group label="Event name">
                      <b-form-input
                        size="lg"
                        v-model="event.title"
                        required
                        placeholder="Enter event name"
                      ></b-form-input>
                    </b-form-group>
                  </b-col>
                </b-form-row>
                <b-form-row class="mb-2">
                  <b-col sm="6" class="pr-sm-3">
                    <b-form-group label="Event Duration">
                      <b-form-input
                        size="lg"
                        required
                        v-model="event.duration"
                        placeholder="Enter event duration.. e.g 2 weeks"
                      ></b-form-input>
                    </b-form-group>
                  </b-col>
                  <b-col sm="6" class="pr-sm-3">
                    <b-form-group label="Event venue">
                      <b-form-input
                        size="lg"
                        v-model="event.venue"
                        required
                        placeholder="Enter event venue"
                      ></b-form-input>
                    </b-form-group>
                  </b-col>
                </b-form-row>

                <b-form-row class="mb-2">
                  <b-col sm="12" class="pr-sm-3">
                    <b-form-group label="Event Description">
                      <b-form-textarea
                        size="lg"
                        v-model="event.description"
                        required
                        placeholder="Describe this event"
                      ></b-form-textarea>
                    </b-form-group>
                  </b-col>
                </b-form-row>

                <b-form-row class="mb-2">
                  <b-col cols="6" class="pr-sm-3">
                    <b-form-group label="Event Start">
                      <vc-date-picker
                        placeholder="Choose start time"
                        v-model="event.start"
                        mode="dateTime"
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
                  <b-col cols="6" class="pr-sm-3">
                    <b-form-group label="Event End">
                      <vc-date-picker
                        placeholder="Choose end time"
                        v-model="event.end"
                        mode="dateTime"
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
                <b-form-row class="mb-2">
                  <b-col sm="6" class="pr-sm-3">
                    <b-form-group label="Event type">
                      <b-form-select
                        v-model="event.type"
                        required
                        placeholder="Choose type of event"
                      >
                        <b-form-select-option value=""
                          >Choose event type</b-form-select-option
                        >
                        <b-form-select-option value="seminar"
                          >Seminar</b-form-select-option
                        >
                      </b-form-select>
                    </b-form-group>
                  </b-col>
                  <b-col sm="6" class="pr-sm-3">
                    <b-form-group label="Event Url (optional)">
                      <b-form-input
                        size="lg"
                        v-model="event.url"
                        type="url"
                        placeholder="Enter event link"
                      ></b-form-input>
                    </b-form-group>
                  </b-col>
                </b-form-row>
                <b-form-row class="mb-2">
                  <b-col sm="6" class="pr-sm-3">
                    <b-form-group label="Event resource(optional)">
                      <Upload
                        class="text-center"
                        :id="'resource'"
                        @getUpload="getUpload"
                      >
                        <b-icon
                          class="text-muted ml-3"
                          icon="files"
                          font-scale="4rem"
                        ></b-icon
                      ></Upload>
                    </b-form-group>
                  </b-col>
                  <b-col sm="6" class="pr-sm-3">
                    <b-form-group label="Upload event cover">
                      <Upload
                        class="text-left"
                        :id="'cover'"
                        @getUpload="getUpload"
                      >
                        <b-icon
                          class="text-muted ml-3"
                          icon="card-image"
                          font-scale="4rem"
                        ></b-icon>
                      </Upload>
                    </b-form-group>
                  </b-col>
                </b-form-row>
                <b-form-row class="mb-2">
                  <b-col sm="12" class="pr-sm-3">
                    <b-form-group label="Add Facilitators to event (optional)">
                      <!-- <b-button size="sm" @click="$bvModal.show('addopen')"
                        >Click to add Facilitators to event</b-button
                      > -->

                      <multi-select
                        :options="
                          facilitators.map((item) => {
                            var val = {};
                            val.value = item.id;
                            val.text = item.name;
                            return val;
                          })
                        "
                        :selected-options="event.facilitators"
                        placeholder="select facilitators"
                        @select="onSelect"
                      >
                      </multi-select>
                    </b-form-group>
                  </b-col>
                </b-form-row>

                <b-form-group class="mt-4">
                  <div class="mb-3 text-center">
                    <b-button
                      type="submit"
                      variant="dark-green"
                      size="lg"
                      :disabled="disabled"
                      class="px-5 d-none d-sm-block mx-auto"
                      >Create event</b-button
                    >
                    <b-button
                      type="submit"
                      variant="dark-green"
                      size="lg"
                      block
                      :disabled="disabled"
                      class="px-5 d-sm-none mx-auto"
                      >Create event</b-button
                    >
                  </div>
                </b-form-group>
              </div>
            </b-form>
          </b-col>
        </b-row>
        <b-row v-if="schedule_num == 2">
          <b-col>
            <b-form @submit.prevent="register">
              <b-form-row>
                <b-col sm="5" class="px-3">
                  <b-form-group label="Course">
                    <model-list-select
                      :list="courses"
                      v-model="detail.course_id"
                      option-value="id"
                      option-text="title"
                      placeholder="Select course "
                    >
                    </model-list-select>
                  </b-form-group>
                </b-col>
              </b-form-row>
              <div
                class="border rounded mb-3"
                v-for="(item, id) in detail.schedule"
                :key="id"
              >
                <div
                  class="p-2 rounded d-flex justify-content-between border"
                  v-if="id != current_schedule"
                >
                  <div>
                    <span class="mr-3"
                      >Start Date :
                      {{
                        item.start_time | moment("dddd, MMMM D YYYY, h:mm a")
                      }}</span
                    >
                    <br />
                    <span class="mr-3"
                      >End Date :
                      {{
                        item.end_time | moment("dddd, MMMM D YYYY, h:mm a")
                      }}</span
                    >
                  </div>
                  <div>
                    <b-iconstack
                      font-scale="1.1"
                      class="mr-2"
                      @click="addschedule"
                    >
                      <b-icon
                        stacked
                        icon="circle-fill"
                        variant="dark-green"
                      ></b-icon>
                      <b-icon
                        stacked
                        icon="plus-circle-fill"
                        scale="0.5"
                        variant="white"
                      ></b-icon>
                    </b-iconstack>

                    <b-iconstack
                      font-scale="1.1"
                      class="mr-2"
                      @click="current_schedule = id"
                    >
                      <b-icon
                        stacked
                        icon="circle-fill"
                        variant="warning"
                      ></b-icon>
                      <b-icon
                        icon="pencil-fill"
                        stacked
                        scale="0.5"
                        variant="white"
                      ></b-icon>
                    </b-iconstack>

                    <b-iconstack
                      font-scale="1.1"
                      v-if="detail.schedule.length > 1"
                      @click="detail.schedule.splice(id, 1)"
                    >
                      <b-icon
                        stacked
                        icon="circle-fill"
                        variant="danger"
                      ></b-icon>
                      <b-icon
                        icon="trash2-fill"
                        stacked
                        scale="0.5"
                        variant="white"
                      ></b-icon>
                    </b-iconstack>
                  </div>
                </div>
                <div v-if="id == current_schedule">
                  <div class="text-right">
                    <b-icon
                      icon="chevron-up"
                      @click="current_schedule = null"
                    ></b-icon>
                  </div>
                  <b-form-row>
                    <b-col sm="4" class="mb-3 px-3">
                      <b-form-group label="Facilitator">
                        <model-list-select
                          :list="facilitators"
                          v-model="item.facilitator_id"
                          option-value="id"
                          option-text="name"
                          placeholder="select facilitator"
                        >
                        </model-list-select>
                      </b-form-group>
                    </b-col>
                    <b-col sm="4" class="mb-3 px-3">
                      <b-form-group label="Venue">
                        <b-form-input
                          v-model="item.venue"
                          type="text"
                          placeholder="Enter Venue"
                        ></b-form-input>
                      </b-form-group>
                    </b-col>
                    <b-col sm="4" class="mb-3 px-3">
                      <b-form-group label="Link">
                        <b-form-input
                          v-model="item.url"
                          type="url"
                          placeholder="Enter url link (optional)"
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
                  <div class="px-2">
                    <b-button
                      variant="outline-dark-green"
                      class="my-2 mr-2"
                      size="sm"
                      @click="detail.schedule.splice(id, 1)"
                      v-if="detail.schedule.length > 1"
                      >Drop schedule</b-button
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
              </div>
              <div class="text-center my-3">
                <b-button
                  size="lg"
                  :disabled="disabled"
                  variant="dark-green"
                  type="submit"
                  >Create schedule</b-button
                >
              </div>
            </b-form>
          </b-col>
        </b-row>
      </b-container>
    </b-modal>

    <b-modal id="addopen" size="lg" hide-footer centered>
      <b-row>
        <b-col cols="6" class="" @click="toggleAdd('course')">
          <div class="p-4 text-center border bg-lighter-green rounded">
            <h4>Course</h4>
          </div></b-col
        >
        <b-col cols="6" class="" @click="toggleAdd('event')">
          <div class="p-4 text-center border bg-lighter-green rounded">
            <h4>Event</h4>
          </div></b-col
        >
      </b-row>
    </b-modal>
  </div>
</template>
<script>
import PopoverRow from "v-calendar/lib/components/popover-row.umd.min";
import Upload from "../fileupload";
import { MultiSelect } from "vue-search-select";
import { ModelListSelect } from "vue-search-select";
export default {
  data() {
    return {
      disabled: false,
      color: ["red", "blue", "green", "brown", "purple", "teal"],
      days: [
        "monday",
        "tuesday",
        "wednesday",
        "thursday",
        "friday",
        "saturday",
        "sunday",
      ],
      events: [],
      facilitators: [],
      schedules: [],
      courses: [],
      current_schedule: 0,
      schedule_num: 1,
      event: {
        title: "",
        duration: "",
        description: "",
        type: "",
        url: "",
        cover: "",
        start: "",
        end: "",
        resource: "",
        facilitators: [],
      },
      detail: {
        course_id: null,
        schedule: [
          {
            day: "",
            venue: "",
            url: "",
            start_time: new Date(),
            end_time: new Date(),
            facilitator_id: null,
          },
        ],
      },
      masks: {
        weekdays: "WWW",
      },
      showTable: false,
      showEvent: false,
      showschedule: false,
      options: [],
      searchText: "", // If value is falsy, reset searchText & searchItem
      items: [],
      lastSelectItem: {},
    };
  },
  components: {
    PopoverRow,
    Upload,
    MultiSelect,
    ModelListSelect,
  },
  watch: {},
  created() {
    this.getcourses().then(() => {
      this.getfacilitators().then(() => {
        this.getschedules();
        this.getevents();
      });
    });
  },
  mounted() {
    this.$root.$on("bv::modal::hide", () => {
      this.schedule_num = 1;
      this.$bvModal.hide("addopen");
    });
  },
  computed: {
    joinedSchedule() {
      return this.myschedule.concat(this.myevents);
    },
    myschedule() {
      return this.schedules.map((item, index) => {
        var res = {
          key: index,

          highlight: {
            start: { color: "teal", fillMode: "outline" },
            base: { color: "teal", fillMode: "light" },
            end: { color: "teal", fillMode: "solid" },
          },
          dot: false,
          bar: false,
          content: false,
          popover: true,
          customData: {
            title: item.course.title,
            url: item.url,
            facilitator: item.facilitator ? item.facilitator.name : "",
            color: JSON.parse(item.course.courseoutline.knowledge_areas).color,
            duration:
              this.$moment(item.start_time).diff(
                this.$moment(item.end_time),
                "weeks"
              ) + "weeks",
            type: "Course",
            class: "bg-red-600 text-white",
          },
          dates: {
            start: new Date(item.start_time),
            end: new Date(item.end_time),
          },
        };
        return res;
      });
    },
    myevents() {
      return this.events.map((item, index) => {
        var res = {
          key: index,

          highlight: {
            start: { color: "green", fillMode: "outline" },
            base: { color: "green", fillMode: "light" },
            end: { color: "green", fillMode: "solid" },
          },
          dot: false,
          bar: false,
          content: false,
          popover: true,
          customData: {
            title: item.title,
            url: item.url,
            color: "#276749",
            facilitator: item.facilitator ? item.facilitator.name : "",
            duration: item.schedule,
            type: item.type,
            class: "bg-red-600 text-white",
          },
          dates: { start: new Date(item.start), end: new Date(item.end) },
        };
        return res;
      });
    },
    attributes() {
      return this.myschedule.concat(this.myevents).map((item, index) => {
        var res = {
          key: index,
          highlight: item.highlight,
          popover: true,
          customData: item.customData,
          dates: item.dates,
        };
        return res;
      });
    },
    comingevents() {
      return this.events
        .filter((item) => item.status !== "expired")
        .slice(0, 5);
    },
  },
  methods: {
    onSelect(items, lastSelectItem) {
      this.event.facilitators = items;
      this.lastSelectItem = lastSelectItem;
    },
    toggleAdd(val) {
      if (val == "course") {
        this.schedule_num = 2;
        this.$bvModal.show("add");
      }
      if (val == "event") {
        this.schedule_num = 3;
        this.$bvModal.show("add");
      }
    },
    getUpload(val, id) {
      if (id == "cover") {
        this.event.cover = val;
      }
      if (id == "resource") {
        this.event.resource = val;
      }
    },
    daySchedule(day) {
      if (this.joinedSchedule.length) {
        return this.joinedSchedule.filter(
          (item) =>
            this.$moment(item.dates.start, "YYYY-MM-DD HH:mm:ss")
              .format("dddd")
              .toLowerCase() == day.toLowerCase() &&
            this.$moment().isBetween(
              this.$moment(item.dates.start),
              this.$moment(item.dates.end)
            )
        );
      }
      return [];
    },
    todaySchedule() {
      if (this.joinedSchedule.length) {
        return this.joinedSchedule.filter(
          (item) =>
            this.$moment().isAfter(item.dates.start) &&
            this.$moment().isBefore(item.dates.end)
        );
      }
      return [];
    },
    addschedule() {
      this.detail.schedule.push({
        day: "monday",
        url: "",
        venue: "",
        start_time: new Date(),
        end_time: new Date(),
        facilitator_id: null,
      });
      this.current_schedule = this.detail.schedule.length - 1;
    },
    duration(a, b) {
      if (this.$moment(b).diff(this.$moment(a), "weeks") > 0) {
        return `${this.$moment(b).diff(this.$moment(a), "weeks")}
         ${
           this.$moment(b).diff(this.$moment(a), "weeks") > 1 ? "weeks" : "week"
         }`;
      }
      return `${this.$moment(b).diff(this.$moment(a), "days")}
       ${this.$moment(b).diff(this.$moment(a), "days") > 1 ? "days" : "day"}`;
    },
    async getschedules() {
      return this.$http
        .get(`${this.$store.getters.url}/courseschedules`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.schedules = res.data.filter(
              (item) =>
                this.$moment().isBefore(item.start_time) ||
                this.$moment().isBefore(item.end_time)
            );
            this.rows = this.schedules.length;
            this.showschedule = true;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    async getfacilitators() {
      return this.$http
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

    async getcourses() {
      return this.$http
        .get(`${this.$store.getters.url}/courses`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.courses = res.data;
            this.showTable = true;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    async getevents() {
      return this.$http
        .get(`${this.$store.getters.url}/events`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.events = res.data.filter((item) => item.status !== "expired");
          }
          this.showEvent = true;
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    register() {
      this.disabled = true;
      this.$http
        .post(`${this.$store.getters.url}/courseschedules`, this.detail, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.disabled = false;
            this.$toast.success("Added successfully");
            this.$bvModal.hide("add");
            this.getschedules();
            this.schedule_num = 1;
            this.detail.schedule = {
              day: "",
              venue: "",
              url: "",
              start_time: new Date(),
              end_time: new Date(),
              facilitator_id: null,
            };
          }
        })
        .catch((err) => {
          this.disabled = false;
          if (err.response.data.errors.email[0]) {
            this.$toast.error(err.response.data.errors.email[0]);
          }
          if (err.response.data.errors.phone[0]) {
            this.$toast.error(err.response.data.errors.phone[0]);
          }
          if (err.response.data.errors.name[0]) {
            this.$toast.error(err.response.data.errors.name[0]);
          }
          if (err.response.data.errors.password[0]) {
            this.$toast.error(err.response.data.errors.password[0]);
          }
        });
    },
    addevent() {
      this.disabled = true;
      this.event.facilitators = this.event.facilitators.map(
        (item) => item.value
      );
      this.$http
        .post(`${this.$store.getters.url}/events`, this.event, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.disabled = false;
            this.$toast.success("Added successfully");
            this.$bvModal.hide("add");
            this.events.unshift(res.data);
            this.schedule_num = 1;
            this.event = {
              title: "",
              duration: "",
              description: "",
              type: "",
              url: "",
              cover: "",
              start: "",
              end: "",
              resource: "",
              facilitators: [],
            };
          }
        })
        .catch((err) => {
          this.disabled = false;
          if (err.response.data.errors.email[0]) {
            this.$toast.error(err.response.data.errors.email[0]);
          }
          if (err.response.data.errors.phone[0]) {
            this.$toast.error(err.response.data.errors.phone[0]);
          }
          if (err.response.data.errors.name[0]) {
            this.$toast.error(err.response.data.errors.name[0]);
          }
          if (err.response.data.errors.password[0]) {
            this.$toast.error(err.response.data.errors.password[0]);
          }
        });
    },
    edit(data) {
      this.$bvModal.show("edit");
      this.detail = data.courseschedule;
    },
    updatecourse() {
      this.$http
        .put(
          `${this.$store.getters.url}/courseschedules/${this.detail.id}`,
          this.detail,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Updated successfully");
            this.detail.schedule = {
              day: "",
              start_time: new Date(),
              end_time: new Date(),
              facilitator_id: null,
            };
            this.getschedules();
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    drop(id) {
      this.$bvModal.msgBoxConfirm("Are you sure").then((val) => {
        if (val) {
          this.$http
            .delete(`${this.$store.getters.url}/courseschedules/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.admin.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success("Removed successfully");
                this.getschedules();
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
  padding-top: 30px;
}
th {
  font-size: 14px;
  font-weight: 500;
  padding-right: 0;
  padding-left: 0;
}
td {
  color: white;
}
.bg-light {
  color: black;
}

.box {
  min-height: 130px;
  display: flex;
  align-items: flex-start;
  flex-direction: column;
  justify-content: center;
  text-align: left;
  // box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35);
  border-radius: 8px;
  background: white;
}
.top_box {
  height: 250px;
  display: flex;
  align-items: flex-start;
  text-align: left;
  overflow: hidden;
}
.new_add {
  color: rgba(0, 0, 0, 0.44);
  font-size: 14px;
}
// .box:hover {
//   background: linear-gradient(127.24deg, #388087 28.41%, #c2edce 100%);
// }
// .box:hover > div > div,
// .box:hover > div > .h6 {
//   color: white !important;
// }

// .box:hover > div > .new_add > .ic {
//   color: white !important;
// }
.shadow {
  // box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
  border-radius: 8px;
}
.search.form-control {
  width: 250px;
  border: 1px solid rgba($color: #000000, $alpha: 0.07) !important;
}
.search::placeholder {
  color: rgba($color: #000000, $alpha: 0.2);
}
.turn_over_box {
  height: 100%;
}
.tob_1 {
  min-height: 200px;
  // box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
  border-radius: 8px;
  text-align: center;
  background: white;
}
.tob_2 {
  min-height: 200px;
  // box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
  border-radius: 8px;
  padding: 0;
  background: white;
}
.facilitator_tab {
  min-height: 400px;
}
.todos {
  padding: 10px;
  height: 200px;
  overflow: auto;
}
.todo {
  background: var(--skills-grey);
  border-radius: 5px;
}
.text-sm {
  font-size: 0.7rem;
}
.schedule {
  max-height: 400px;
  overflow: auto;
}
.m_schedule {
  width: 230px;
}
// .tabl {
//   width: 600px;
//   overflow-x: auto;
// }
.event_image {
  border-radius: 10rem 0 0 0;
  overflow: hidden;
  width: 100%;
}
.upcoming {
  position: absolute;
  top: 0;
  left: 0;
  padding: 3px 15px;
  background: var(--dark-green);
  color: white;
  font-size: 12px;
  z-index: 2;
}
@media (max-width: 600px) {
  .box {
    margin-bottom: 24px;
  }
  .facilitator_tab {
    min-height: 200px;
  }
  .top_box {
    height: 400px;
  }
}
</style>

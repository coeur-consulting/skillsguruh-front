<template>
  <b-container fluid class="p-0 bg-white">
    <b-row class="m-0 h-100">
      <b-col sm="4" class="border-right text-left py-3 pl-3 pr-1">
         <div
          class="mb-4 px-2 fs11  d-flex align-items-center"


        >
        <router-link to="/member"> <span class="cursor-pointer text-dark-green">Home</span> </router-link> <span class="mx-1"> <b-icon icon="chevron-right" scale=".7"></b-icon> </span> <span class="">Profile</span>



        </div>
        <div
          class="mb-3 px-2 fs12 cursor-pointer d-flex align-items-center"
          :class="{ 'font-weight-bold': type == 'edit' }"
          @click="type = 'edit'"
        >
          <span class="flex-1">
            <b-icon
              class="mr-2"
              :icon="type == 'edit' ? 'pencil-fill' : 'pencil'"
            ></b-icon
            ><span class="">Edit Profile</span></span
          >
          <b-icon v-if="type == 'edit'" icon="chevron-right"></b-icon>
        </div>
        <div
          class="mb-3 px-2 cursor-pointer d-flex fs12"
          @click="type = 'notification'"
          :class="{ 'font-weight-bold': type == 'notification' }"
        >
          <span class="flex-1">
            <b-icon
              class="mr-2"
              :icon="type == 'notification' ? 'bell-fill' : 'bell'"
            ></b-icon>
            <span class="">Notifications</span>
          </span>
          <b-icon v-if="type == 'notification'" icon="chevron-right"></b-icon>
        </div>
        <div
          class="mb-3 px-2 cursor-pointer d-flex fs12"
          @click="type = 'request'"
          :class="{ 'font-weight-bold': type == 'request' }"
        >
          <span class="flex-1">
            <b-icon
              class="mr-2"
              :icon="type == 'request' ? 'info-circle-fill' : 'info-circle'"
            ></b-icon>
            <span class="mr-1">Requests</span>
            <b-icon
              v-if="requests.some((item) => item.response == 'pending')"
              class=""
              variant="danger"
              font-scale=".4"
              icon="circle-fill"
            ></b-icon>
          </span>
          <b-icon v-if="type == 'request'" icon="chevron-right"></b-icon>
        </div>
        <div
          class="mb-3 px-2 cursor-pointer d-flex fs12"
          @click="type = 'preference'"
          :class="{ 'font-weight-bold': type == 'preference' }"
        >
          <span class="flex-1">
            <b-icon
              class="mr-2"
              :icon="type == 'preference' ? 'nut-fill' : 'nut'"
            ></b-icon>
            <span class="">Preferences</span>
          </span>
          <b-icon v-if="type == 'preference'" icon="chevron-right"></b-icon>
        </div>

        <div
          class="px-2 mb-3 fs12 cursor-pointer d-flex"
          :class="{ 'font-weight-bold': type == 'security' }"
          @click="type = 'security'"
        >
          <span class="flex-1">
            <b-icon
              class="mr-2"
              :icon="type == 'security' ? 'shield-fill' : 'shield'"
            ></b-icon>
            <span>Password & Security </span></span
          >
          <b-icon v-if="type == 'security'" icon="chevron-right"></b-icon>
        </div>
        <div
          class="px-2 mb-3 fs12 cursor-pointer d-flex"
          :class="{ 'font-weight-bold': type == 'analytics' }"
          @click="type = 'analytics'"
        >
          <span class="flex-1">
            <b-icon
              class="mr-2"
              :icon="
                type == 'analytics' ? 'bar-chart-line-fill' : 'bar-chart-line'
              "
            ></b-icon>
            <span>Analytics</span></span
          >
          <b-icon v-if="type == 'analytics'" icon="chevron-right"></b-icon>
        </div>
        <div
          class="px-2 fs12 cursor-pointer d-flex"
          :class="{ 'font-weight-bold': type == 'additional' }"
          @click="type = 'additional'"
        >
          <span class="flex-1">
            <b-icon
              class="mr-2"
              :icon="type == 'additional' ? 'gear-fill' : 'gear'"
            ></b-icon>
            <span>Additional Information </span></span
          >
          <b-icon v-if="type == 'additional'" icon="chevron-right"></b-icon>
        </div>
      </b-col>
      <b-col sm="8" class="sideB py-3">
        <div v-if="type == 'analytics'" class="py-4">
          <b-row>
            <b-col cols="6" class="p-3">
              <b-card no-body class="bg-light">
                <b-card-body class="text-center">
                  <h6>Owned Tribes</h6>
                  <span class="display-4">{{ analytics.ownedtribes }}</span>
                  <div class="d-flex justify-content-between fs11">
                    <span>Started this week</span> <span>{{ analytics.ownedtribesthisweek }}</span>
                  </div>
                </b-card-body>
              </b-card>
            </b-col>
            <b-col cols="6" class="p-3">
              <b-card no-body class="bg-light">
                <b-card-body class="text-center">
                  <h6>Tribes You Belong Too</h6>
                  <span class="display-4">{{ analytics.belongedtribes }}</span>
                  <div class="d-flex justify-content-center fs11">
                    <span class="mr-3">Joined this week</span> <span>{{ analytics.belongedtribesthisweek }}</span>
                  </div>
                </b-card-body>
              </b-card>
            </b-col>
          </b-row>

          <b-row>
            <b-col cols="6" class="p-3">
              <b-card no-body class="bg-light">
                <b-card-body class="text-center">
                  <h6>Your Discussions</h6>
                  <span class="display-4">{{ analytics.discussions }}</span>
                  <div class="d-flex justify-content-center fs11">
                    <span class="mr-3">Started this week</span>
                    <span>{{ analytics.discussionsthisweek }}</span>
                  </div>
                </b-card-body>
              </b-card>
            </b-col>
            <b-col cols="6" class="p-3">
              <b-card no-body class="bg-light">
                <b-card-body class="text-center">
                  <h6>Unique Tribe Members</h6>
                  <span class="display-4">{{ analytics.uniquemembers }}</span>
                  <div class="d-flex justify-content-center fs11">
                    <span class="mr-3">Members this week</span> <span>0</span>
                  </div>
                </b-card-body>
              </b-card>
            </b-col>
          </b-row>
          <b-row>
            <b-col cols="4" class="p-3">
              <b-card no-body class="bg-light">
                <b-card-body class="text-center">
                  <h6>Total Connections</h6>
                  <span class="display-4">{{ analytics.connections }}</span>
                  <div class="d-flex justify-content-center fs11">
                    <span class="mr-3">Connections this week</span>
                    <span>{{ analytics.connectionsthisweek }}</span>
                  </div>
                </b-card-body>
              </b-card>
            </b-col>
            <b-col cols="4" class="p-3">
              <b-card no-body class="bg-light">
                <b-card-body class="text-center">
                  <h6>Total Posts</h6>
                  <span class="display-4">{{ analytics.posts }}</span>
                  <div class="d-flex justify-content-center fs11">
                    <span class="mr-3">Post this week</span>
                    <span>{{ analytics.poststhisweek }}</span>
                  </div>
                </b-card-body>
              </b-card>
            </b-col>
            <b-col cols="4" class="p-3">
              <b-card no-body class="bg-light">
                <b-card-body class="text-center">
                  <h6>Total Interactions</h6>
                  <div class="d-flex justify-content-between fs14">
                    <span>Total Likes</span> <span>{{ analytics.likes }}</span>
                  </div>
                  <div class="d-flex justify-content-between fs14">
                    <span>Total Comments</span>
                    <span>{{ analytics.comments }}</span>
                  </div>
                  <div class="d-flex justify-content-between fs14">
                    <span>Total Replies</span>
                    <span>{{ analytics.replies }}</span>
                  </div>
                  <div class="d-flex justify-content-between fs14">
                    <span>Total Votes</span> <span>{{ analytics.votes }}</span>
                  </div>
                </b-card-body>
              </b-card>
            </b-col>
          </b-row>
          <b-row>
            <b-col cols="12" class="p-3">
              <b-card no-body class="bg-light">
                <b-card-body class="text-left">
                  <h6>Interactions This Week</h6>

                  <div class="d-flex justify-content-between">
                    <div class="d-flex justify-content-between fs14">
                      <span class="mr-2"> Likes</span>
                      <span
                        >{{ analytics.likesthisweek }}
                        <b-icon icon="heart-fill"></b-icon
                      ></span>
                    </div>
                    <div class="d-flex justify-content-between fs14">
                      <span class="mr-2"> Comments</span>
                      <span
                        >{{ analytics.commentsthisweek }}
                        <b-icon icon="chat-dot-fill"></b-icon
                      ></span>
                    </div>
                    <div class="d-flex justify-content-between fs14">
                      <span class="mr-2"> Replies</span>
                      <span
                        >{{ analytics.repliesthisweek }}
                        <b-icon icon="reply-fill"></b-icon
                      ></span>
                    </div>
                    <div class="d-flex justify-content-between fs14">
                      <span class="mr-2"> Votes</span>
                      <span
                        >{{ analytics.votesthisweek }}
                        <b-icon icon="caret-down-fill"></b-icon
                      ></span>
                    </div>
                    <div class="d-flex justify-content-between fs14">
                      <span class="mr-2"> Posts</span>
                      <span
                        >{{ analytics.poststhisweek }}
                        <b-icon icon="pencil-fill"></b-icon
                      ></span>
                    </div>
                  </div>
                </b-card-body>
                <hr>
                <b-card-body class="text-left">
                  <h6>Interactions This Month</h6>

                  <div class="d-flex justify-content-between">
                    <div class="d-flex justify-content-between fs14">
                      <span class="mr-2"> Likes</span>
                      <span
                        >{{ analytics.likesthismonth }}
                        <b-icon icon="heart-fill"></b-icon
                      ></span>
                    </div>
                    <div class="d-flex justify-content-between fs14">
                      <span class="mr-2"> Comments</span>
                      <span
                        >{{ analytics.commentsthismonth }}
                        <b-icon icon="chat-dot-fill"></b-icon
                      ></span>
                    </div>
                    <div class="d-flex justify-content-between fs14">
                      <span class="mr-2"> Replies</span>
                      <span
                        >{{ analytics.repliesthismonth }}
                        <b-icon icon="reply-fill"></b-icon
                      ></span>
                    </div>
                    <div class="d-flex justify-content-between fs14">
                      <span class="mr-2"> Votes</span>
                      <span
                        >{{ analytics.votesthismonth }}
                        <b-icon icon="caret-down-fill"></b-icon
                      ></span>
                    </div>
                    <div class="d-flex justify-content-between fs14">
                      <span class="mr-2"> Posts</span>
                      <span
                        >{{ analytics.poststhismonth }}
                        <b-icon icon="pencil-fill"></b-icon
                      ></span>
                    </div>
                  </div>
                </b-card-body>
              </b-card>
            </b-col>
          </b-row>
          <b-row>
            <b-col cols="6" class="p-3">
              <b-card no-body class="bg-light">
                <b-card-body class="text-left">
                  <h6>Age distribution</h6>
                  <apexchart
                    type="bar"
                    :options="ageOptions"
                    :series="ageSeries"
                    :height="230"
                  ></apexchart>
                </b-card-body>
              </b-card>
            </b-col>
            <b-col cols="6" class="p-3">
              <b-card no-body class="bg-light">
                <b-card-body class="text-left">
                  <h6>Gender distribution</h6>

                  <apexchart
                    class="text-center"
                    type="pie"
                    :options="genderOptions"
                    :series="genderseries"
                    width="100%"
                    :height="250"
                  ></apexchart>
                </b-card-body>
              </b-card>
            </b-col>
          </b-row>
          <b-row>
            <b-col class="p-3">
              <b-card no-body class="bg-light">
                <b-card-body class="text-left">
                  <h6>Popular Locations</h6>
                  <apexchart
                    type="bar"
                    :options="stateOptions"
                    :series="stateSeries"
                    :height="300"
                  ></apexchart>
                </b-card-body>
              </b-card>
            </b-col>
          </b-row>
        </div>
        <div v-if="type == 'edit'">
          <div class="mb-5">
            <Upload @getUpload="getUpload" :id="'avatar'">
              <b-avatar
                badge-variant="dark-green"
                size="7rem"
                :src="user.profile"
              >
                <template #badge
                  ><b-icon icon="pencil" font-scale="1.1"></b-icon
                ></template>
              </b-avatar>
            </Upload>
          </div>
          <b-form class="text-left" @submit.prevent="updateuser">
            <b-form-row>
              <b-col sm="6">
                <b-form-group label="Name">
                  <b-form-input size="sm" v-model="user.name"></b-form-input
                ></b-form-group>
              </b-col>
              <b-col sm="6">
                <b-form-group label="Email">
                  <b-form-input
                    size="sm"
                    type="email"
                    v-model="user.email"
                  ></b-form-input></b-form-group
              ></b-col>
            </b-form-row>
            <b-form-row>
              <b-col sm="6">
                <b-form-group label="Age">
                  <b-form-input
                    size="sm"
                    v-model="user.age"
                    type="number"
                  ></b-form-input
                ></b-form-group>
              </b-col>
              <b-col sm="6">
                <b-form-group label="Gender">
                  <b-form-select size="sm" v-model="user.gender">
                    <b-form-select-option value="male"
                      >Male</b-form-select-option
                    >
                    <b-form-select-option value="female"
                      >Female</b-form-select-option
                    >
                  </b-form-select></b-form-group
                ></b-col
              >
            </b-form-row>
            <b-form-row>
              <b-col sm="12">
                <b-form-group label="Bio">
                  <b-form-textarea size="sm" maxlength="150" v-model="user.bio">
                  </b-form-textarea></b-form-group
              ></b-col>
            </b-form-row>
            <b-form-row>
              <b-col sm="6">
                <b-form-group label="State">
                  <b-form-input size="sm" v-model="user.state"></b-form-input
                ></b-form-group>
              </b-col>
              <b-col sm="6">
                <b-form-group label="Country">
                  <b-form-select size="sm" v-model="user.country">
                    <b-form-select-option value="NG"
                      >Nigeria</b-form-select-option
                    >
                  </b-form-select>
                </b-form-group></b-col
              >
            </b-form-row>
            <b-form-row>
              <b-col sm="6">
                <b-form-group label="Phone">
                  <b-form-input size="sm" v-model="user.phone"></b-form-input
                ></b-form-group>
              </b-col>
              <b-col sm="6">
                <b-form-group label="Referral Code">
                  <b-form-input
                    size="sm"
                    readonly
                    v-model="user.referral_code"
                  ></b-form-input></b-form-group
              ></b-col>
            </b-form-row>
            <b-form-row>
              <b-col sm="6">
                <b-form-group label="Username">
                  <b-form-input size="sm" v-model="user.username"></b-form-input
                ></b-form-group>
              </b-col>
              <b-col sm="6">
                <b-form-group label="Change Speech Voice">
                  <b-form-select size="sm" v-model="user.voice">
                    <b-form-select-option
                      v-for="(item, index) in voices"
                      :key="index"
                      :value="index"
                      >{{ item.name }}</b-form-select-option
                    >
                  </b-form-select></b-form-group
                >
              </b-col>
            </b-form-row>
            <hr />
            <b-form-row>
              <b-col sm="6">
                <b-form-group label="Bank Name">
                  <div class="form-group">
                    <b-form-select
                      size="sm"
                      class="form-control"
                      v-model="bank_id"
                    >
                      <b-form-select-option :value="null" disabled
                        >Select your bank</b-form-select-option
                      >
                      <b-form-select-option
                        :value="bank.id"
                        v-for="(bank, id) in banks"
                        :key="id"
                      >
                        {{ bank.name }}
                      </b-form-select-option>
                    </b-form-select>
                  </div>
                </b-form-group>
              </b-col>
              <b-col sm="6">
                <b-form-group label="Account number">
                  <b-form-input
                    size="sm"
                    type="number"
                    placeholder="Provide your account number"
                    v-model="user.account_no"
                  ></b-form-input></b-form-group
              ></b-col>
            </b-form-row>
            <div>
              <b-button variant="dark-green" type="submit" class="px-5 mt-4"
                >Save</b-button
              >
            </div>
          </b-form>
        </div>

        <div v-if="type == 'notification'" class="py-4">
          <div class="notif text-left pt-4">
            <h6 class="font-weight-bold mb-4">Notifications</h6>

            <div
              class="d-flex mb-3 border bg-light p-3 rounded fs14"
              v-for="item in notifications"
              :key="item.id"
            >
              <span class="d-flex flex-1">
                <b-icon
                  variant="dark-green"
                  icon="bell-fill"
                  class="mr-2 mt-1"
                ></b-icon>
                <span> {{ item.data.notification }}</span></span
              >
              <div class="fs10 text-muted ml-2">
                {{ item.created_at | moment("ll") }}
              </div>
            </div>
          </div>
        </div>
        <div v-if="type == 'security'">
          <div class="pt-5 text-left password">
            <b-form @submit.prevent="updatepassword">
              <b-form-group label="Old Passoword">
                <b-form-input
                  size="sm"
                  v-model="detail.old_password"
                  type="password"
                  placeholder="Enter old Password"
                  required
                ></b-form-input>
              </b-form-group>
              <b-form-group label="New Password">
                <b-form-input
                  size="sm"
                  type="password"
                  v-model="detail.new_password"
                  placeholder="Enter new Password"
                  required
                ></b-form-input>
              </b-form-group>

              <div class="my-3">
                <b-button variant="dark-green" type="submit" class="px-5"
                  >Update password</b-button
                >
              </div>
            </b-form>
          </div>
        </div>

        <div v-if="type == 'preference'">
          <div class="pt-5 text-left preference">
            <Interest :user="$store.getters.member" :type="'member'" />
          </div>
        </div>
        <div v-if="type == 'request'">
          <div class="notif text-left pt-4">
            <h6 class="font-weight-bold mb-4">Requests</h6>

            <div v-if="triberequests.length">
              <div
                class="d-flex mb-3"
                v-for="item in triberequests"
                :key="item.id"
              >
                <b-icon
                  variant="dark-green"
                  icon="bell-fill"
                  class="mr-2 mt-1"
                ></b-icon>
                <div class="d-flex justify-content-between">
                  <p class="mb-0 fs14 mr-3 flex-1">
                    <span class="text-capitalize font-weight-bold">{{
                      item.user.name
                    }}</span>
                    has requested to join your tribe
                    <span class="text-capitalize font-weight-bold">{{
                      item.tribe.name
                    }}</span>
                  </p>
                  <div>
                    <b-button
                      class="mr-2 rounded-circle"
                      variant="light"
                      size="sm"
                      v-b-tooltip.hover
                      title="Approve"
                      ><b-icon
                        @click="accept(item, 'approve')"
                        icon="check2-circle"
                      ></b-icon>
                    </b-button>

                    <b-button
                      v-b-tooltip.hover
                      title="Reject"
                      class="rounded-circle"
                      size="sm"
                      variant="light"
                      @click="accept(item, 'reject')"
                      ><b-icon icon="x-circle-fill"></b-icon
                    ></b-button>
                  </div>
                </div>
              </div>
            </div>
            <div v-else class="py-3">
              <b-alert show>
                <b-icon icon="info-circle"></b-icon> No pending requests
                available</b-alert
              >
            </div>
          </div>
        </div>
        <div v-if="type == 'additional'" class="p-4">
          <div class="notif text-left pt-4">
            <h6 class="font-weight-bold mb-4">Additional Information</h6>

            <b-form>
              <b-form-row>
                <b-col sm="6">
                  <b-form-group>
                    <b-form-checkbox
                      size="sm"
                      v-model="user.show_age"
                      name="show_age"
                      switch
                    >
                      <span class="d-flex"
                        ><span class="mr-1">Age</span>
                        <span class="form-text text-muted fs11">
                          {{ user.show_age ? "visible" : "hidden" }}
                        </span></span
                      >
                    </b-form-checkbox>
                  </b-form-group>
                </b-col>
                <b-col sm="6">
                  <b-form-group>
                    <b-form-checkbox
                      size="sm"
                      v-model="user.show_name"
                      name="show_name"
                      switch
                    >
                      <span class="d-flex">
                        <span class="mr-1"> Full name</span>
                        <span class="form-text text-muted fs11">
                          {{ user.show_name ? "visible" : "hidden" }}
                        </span></span
                      >
                    </b-form-checkbox>
                  </b-form-group>
                </b-col>
                <b-col sm="6">
                  <b-form-group>
                    <b-form-checkbox
                      size="sm"
                      v-model="user.show_email"
                      name="show_email"
                      switch
                    >
                      <span class="d-flex">
                        <span class="mr-1"> Email</span>
                        <span class="form-text text-muted fs12">
                          {{ user.show_email ? "visible" : "hidden" }}
                        </span></span
                      >
                    </b-form-checkbox>
                  </b-form-group>
                </b-col>
              </b-form-row>
              <b-form-group class="mt-5 text-center">
                <b-button variant="dark-green" @click="updateinformation"
                  >Save Information</b-button
                >
              </b-form-group>
            </b-form>
          </div>
        </div>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import Upload from "../fileupload";
import Interest from "../InterestComponent";
export default {
  data() {
    return {
      analytics: [],
     // genderseries: [33, 33, 34],
      genderOptions: {
        chart: {
          type: "pie",
        },
        colors: ["#377f87", "#3d96a5", "#6beed1"],
        labels: ["Males", "Females", "Others"],
        // responsive: [
        //   {
        //     breakpoint: 480,
        //     options: {
        //       chart: {
        //   type: "pie",
        // },
        //       legend: {
        //         position: "bottom",
        //       },
        //     },
        //   },
        // ],
      },

      stateOptions: {
        chart: {
          type: "bar",
        },
        plotOptions: {
          bar: {
            horizontal: false,
            columnWidth: "55%",
            endingShape: "rounded",
          },
        },
        dataLabels: {
          enabled: false,
        },
        colors: ["#377f87"],
        stroke: {
          show: true,
          width: 2,
          colors: ["transparent"],
        },
        xaxis: {
          categories: ["Lagos", "Ogun", "Edo", "Abuja", "Delta",'others'],
        },
        yaxis: {
          title: {
            text: "Members",
          },
        },
        fill: {
          opacity: 1,
        },
        tooltip: {
          y: {
            formatter: function (val) {
              return val;
            },
          },
        },
      },

      ageOptions: {
        chart: {
          type: "bar",
        },
        plotOptions: {
          bar: {
            horizontal: false,
            columnWidth: "55%",
            endingShape: "rounded",
          },
        },
        dataLabels: {
          enabled: false,
        },
        colors: ["#377f87", "#88b6bf", "#6beed1"],
        stroke: {
          show: true,
          width: 2,
          colors: ["transparent"],
        },
        xaxis: {
          categories: ["0-14", "15-24", "25-35", "36-above","others"],
        },
        yaxis: {
          title: {
            text: "Members",
          },
        },
        fill: {
          opacity: 1,
        },
        tooltip: {
          y: {
            formatter: function (val) {
              return val;
            },
          },
        },
      },
      triberequests: [],
      type: "edit",
      user: {
        address: null,
        age: "",
        bio: null,
        country: "NG",
        email: "",
        gender: "",
        interests: "",
        lga: null,
        name: "",
        phone: "",
        profile: "",
        state: "",
        verification: null,
        voice: null,
        role_id: null,
        show_age: false,
        show_email: false,
        show_name: false,
        bank_name: "",
        bank_code: null,
        account_no: "",
      },
      bank_id: null,
      requests: [],
      detail: {
        old_password: "",
        new_password: "",
      },
      banks: [],
    };
  },
  components: {
    Upload,
    Interest,
  },
  watch: {
    bank_id: "handleBank",
  },
  created() {
    this.getbanks();
    this.getanalytics();
    this.getuser();
    this.gettriberequests();
  },
  mounted() {
    window.document.title = `${this.$store.getters.member.name} | Nzukoor`;
  },
  computed: {
    genderseries() {
      return this.analytics.gender;
    },
    ageSeries() {
     return  [
         {
          name: "",
          data: this.analytics.ages,
        },
       ]

    },
    stateSeries() {
     return  [
         {
          name: "",
          data: this.analytics.locations,
        },
       ]
    },
    voices() {
      return this.$store.getters.voices;
    },
    notifications() {
      return this.$store.getters.notifications;
    },
  },
  methods: {
    getGender() {
      this.genderseries = ["33", "33", "34"];
      this.genderOptions = {
        chart: {
          type: "pie",
        },
        colors: ["#377f87", "#3d96a5", "#6beed1"],
        labels: ["Males", "Females", "Others"],
        responsive: [
          {
            breakpoint: 480,
            options: {
              chart: {},
              legend: {
                position: "bottom",
              },
            },
          },
        ],
      };
    },
    gettriberequests() {
      this.$http
        .get(
          `${this.$store.getters.url}/tribe/requests`,

          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then((res) => {
          this.triberequests = res.data;
        });
    },
    handleBank() {
      var bank = this.banks.find((item) => item.id == this.bank_id);
      if (!bank) {
        return;
      }
      this.user.bank_name = bank.name;
      this.user.bank_code = bank.code;
    },
    updateinformation() {
      var userinformation = {
        show_age: this.user.show_age,
        show_email: this.user.show_age,
        show_name: this.user.show_age,
      };
      this.$http
        .post(
          `${this.$store.getters.url}/update/information`,
          userinformation,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then((res) => {
          var authMember = JSON.parse(localStorage.getItem("authMember"));
          authMember.showage = res.data.showage;
          authMember.showemail = res.data.showname;
          authMember.showname = res.data.showname;
          localStorage.setItem("authMember", JSON.stringify(authMember));
          this.$toast.success("Updated successfully");
        });
    },
    getrequests() {
      this.$http
        .get(`${this.$store.getters.url}/discussion/requests`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          this.requests = res.data;
        });
    },
    getbanks() {
      this.$http.get(`${this.$store.getters.url}/get/banks`).then((res) => {
        this.banks = res.data;
      });
    },
    accept(item, response) {
      this.$http
        .put(
          `${this.$store.getters.url}/respond/tribe/request/${item.id}`,
          { response },
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then(() => {
          this.gettriberequests();
        });
    },

    getUpload(val) {
      this.user.profile = val;
      this.updateuser();
    },
    getuser() {
      this.$http
        .get(
          `${this.$store.getters.url}/users/${this.$store.getters.member.id}`,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.member.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.user = res.data;
            this.user.account_no = res.data.accountdetail.account_no;
            var bank = this.banks.find(
              (item) => item.code == res.data.accountdetail.bank_code
            );
            if (bank) {
              this.bank_id = bank.id;
            }
          }
        });
    },
    getanalytics() {
      this.$http
        .get(`${this.$store.getters.url}/get/analytics`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          this.analytics = res.data;
        });
    },
    updateuser() {
      this.$http
        .put(`${this.$store.getters.url}/users/${this.user.id}`, this.user, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.user = res.data;
            var authMember = JSON.parse(localStorage.getItem("authMember"));
            authMember.profile = res.data.profile;
            authMember.voice = res.data.voice;
            this.user.account_no = res.data.accountdetail.account_no;
            var bank = this.banks.find(
              (item) => item.code == res.data.accountdetail.bank_code
            );
            if (bank) {
              this.bank_id = bank.id;
            }
            localStorage.setItem("authMember", JSON.stringify(authMember));
            this.$toast.success("Updated successfully");
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    updatepassword() {
      this.$http
        .post(`${this.$store.getters.url}/update-password`, this.detail, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.member.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            if (res.data.message == "success") {
              this.$toast.success("Password updated");
              return;
            }
            this.$toast.error(res.data.message);
          }
        });
    },
  },
};
</script>

<style scoped>
.container-fluid {
  height: calc(100vh - 85px);
  overflow: hidden;
}
</style>

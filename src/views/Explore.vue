<template>
  <div class="main_content text-left">
    <div class="position-relative">
      <div class="stbg">
        <div class="bg_overlay">
          <h1 class="text-white font-weight-bold">Explore Interest</h1>
        </div>
      </div>
    </div>
    <b-container class="pb-5">
      <b-row class="justify-content-around p-5 my-5">
        <b-col>
          <span class="d-flex align-items-center">
            <b-img class="mr-2" size="2.5rem" src="/img/learner.png"></b-img>
            <span>
              <span class="font-weight-bold">{{ users.length }}+</span> <br />
              <span class="font-weight-bold">Happy Learner</span>
            </span>
          </span>
        </b-col>
        <b-col>
          <span class="d-flex align-items-center">
            <b-img class="mr-2" size="2.5rem" src="/img/program.png"></b-img>
            <span>
              <span class="font-weight-bold">{{ courses.length }}+</span> <br />
              <span class="font-weight-bold">Online Programs</span>
            </span>
          </span>
        </b-col>
        <b-col>
          <span class="d-flex align-items-center">
            <b-img class="mr-2" size="2.5rem" src="/img/grp.png"></b-img>
            <span>
              <span class="font-weight-bold">{{ facilitators.length }}+</span>
              <br />
              <span class="font-weight-bold">Facilitators Onboard</span>
            </span>
          </span>
        </b-col>
      </b-row>
      <section class="py-5">
        <h4 class="mb-3 font-weight-bold">Most Popular Courses</h4>
        <b-row
          class="justify-content-start pt-5 pb-1"
          v-if="mostenrolledcourse.length"
        >
          <b-col
            sm="4"
            class="mb-4 px-4"
            v-for="item in mostenrolledcourse.slice(0, 6)"
            :key="item.id"
          >
            <div
              class="course shadow"
              @click="$router.push('/learner/courses')"
            >
              <div
                class="course_img"
                :style="{ backgroundImage: `url(${item.course.cover})` }"
              ></div>
              <div class="course_text">
                <div class="d-flex justify-content-between">
                  <span
                    class="p-2 rounded-pill text-white fs11"
                    :style="{
                      backgroundColor: JSON.parse(
                        item.course.courseoutline.knowledge_areas
                      ).color,
                    }"
                  >
                    <b-icon
                      class="mr-2"
                      :icon="
                        JSON.parse(item.course.courseoutline.knowledge_areas)
                          .icon
                      "
                    ></b-icon>
                    <span>{{
                      JSON.parse(item.course.courseoutline.knowledge_areas)
                        .value
                    }}</span></span
                  >
                  <span class="text-capitalize">{{ item.course.type }}</span>
                </div>
                <div class="border-bottom pt-4">
                  <h6 class="font-weight-bold text-capitalize">
                    {{ item.course.title }}
                  </h6>
                  <p class="overview">
                    {{ item.course.courseoutline.overview }}
                  </p>
                </div>
                <div class="info fs12">
                  <div class="d-flex">
                    <div class="mr-3">
                      <b-icon icon="people" class="mr-1"></b-icon>
                      <span>{{ item.count }}+</span>
                    </div>
                    <div class="mr-3">
                      <b-icon icon="eye" class="mr-1"></b-icon>
                      <span>250+</span>
                    </div>
                    <div>
                      <b-icon icon="star-fill" class="mr-1"></b-icon>
                      <span>{{ item.course.review.length }} reviews</span>
                    </div>
                  </div>

                  <b-avatar size="sm" variant="light" :src="item.course.cover">
                  </b-avatar>
                </div>
              </div>
            </div>
          </b-col>
        </b-row>

        <div class="text-center text-dark-green">
          <span @click="$router.push('/learner/courses')" class="cursor-pointer"
            >Load more...</span
          >
        </div>
      </section>
      <section class="text-center mb-5 py-5">
        <h4 class="mb-4">Explore Interest</h4>

        <p class="px-5">
          There are several interest to be explored from health,
          entreprenuership, lifestyle , connection explore different areas of
          interest that can help improve your business skills
        </p>

        <b-row class="py-4">
          <b-col class="mb-5" sm="2"
            ><b-img src="/img/one.png" class="mb-2"></b-img>
            <h6 class="font-weight-bold">Literature</h6></b-col
          >
          <b-col class="mb-5" sm="2"
            ><b-img src="/img/two.png" class="mb-2"></b-img>
            <h6 class="font-weight-bold">Politics</h6>
          </b-col>
          <b-col class="mb-5" sm="2"
            ><b-img src="/img/three.png" class="mb-2"></b-img>
            <h6 class="font-weight-bold">Sports</h6></b-col
          >
          <b-col class="mb-5" sm="2"
            ><b-img src="/img/four.png" class="mb-2"></b-img>
            <h6 class="font-weight-bold">Marketing</h6></b-col
          >
          <b-col class="mb-5" sm="2"
            ><b-img src="/img/five.png" class="mb-2"></b-img>
            <h6 class="font-weight-bold">Health</h6></b-col
          >
          <b-col class="mb-5" sm="2"
            ><b-img src="/img/six.png" class="mb-2"></b-img>
            <h6 class="font-weight-bold">Tech</h6></b-col
          >
          <b-col class="mb-5" sm="2"
            ><b-img src="/img/seven.png" class="mb-2"></b-img>
            <h6 class="font-weight-bold">Gaming</h6></b-col
          >
          <b-col class="mb-5" sm="2"
            ><b-img src="/img/eight.png" class="mb-2"></b-img>
            <h6 class="font-weight-bold">Entrepreneurship</h6></b-col
          >
          <b-col class="mb-5" sm="2"
            ><b-img src="/img/nine.png" class="mb-2"></b-img>
            <h6 class="font-weight-bold">News</h6></b-col
          >
          <b-col class="mb-5" sm="2"
            ><b-img src="/img/ten.png" class="mb-2"></b-img>
            <h6 class="font-weight-bold">Community</h6></b-col
          >
          <b-col class="mb-5" sm="2"
            ><b-img src="/img/eleven.png" class="mb-2"></b-img>
            <h6 class="font-weight-bold">Art</h6>
          </b-col>
          <b-col class="mb-5" sm="2"
            ><b-img src="/img/twelve.png" class="mb-2"></b-img>
            <h6 class="font-weight-bold">Law</h6></b-col
          >
        </b-row>
      </section>
      <section class="py-5 mb-5">
        <b-row>
          <b-col sm="7">
            <div class="d-flex justify-content-between">
              <div>
                <h5 class="font-weight-bold">Trending Discussions</h5>
                <span
                  @click="$router.push('/learner/discussions')"
                  class="cursor-pointer"
                  >View all {{ discussions.length }} discussions</span
                >
              </div>
              <div>
                <b-button
                  size="sm"
                  @click="$router.push('/learner/discussions')"
                  variant="dark-green"
                  >Create a discussion</b-button
                >
              </div>
            </div>
            <div class="py-5" v-if="trending.length">
              <div
                class="d-flex mb-5"
                v-for="(item, id) in trending.slice(0, 4)"
                :key="id"
              >
                <div class="d-flex w-75 pr-4">
                  <b-avatar
                    v-if="item.admin"
                    :src="item.admin.profile"
                    class="mr-3"
                    size="4rem"
                  ></b-avatar>
                  <b-avatar
                    v-if="item.user"
                    :src="item.user.profile"
                    class="mr-3"
                    size="4rem"
                  ></b-avatar>
                  <b-avatar
                    v-if="item.facilitator"
                    :src="item.facilitator.profile"
                    class="mr-3"
                    size="4rem"
                  ></b-avatar>
                  <div>
                    <span
                      class="fs15 font-weight-bold cursor-pointer"
                      @click="$router.push(`/learner/discussion/${item.id}`)"
                      >{{ item.name }}</span
                    >
                    <br />
                    <span class="text-muted fs11" v-if="item.admin"
                      ><span class="mr-2">{{ item.admin.name }}</span>
                      <span class="mr-2">{{
                        $moment(item.created_at).fromNow()
                      }}</span>
                      <span
                        >{{ item.discussionmessage.length }} replies</span
                      ></span
                    >
                    <span class="text-muted fs11" v-if="item.user"
                      ><span class="mr-2">{{ item.user.name }}</span>
                      <span class="mr-2">{{
                        $moment(item.created_at).fromNow()
                      }}</span>
                      <span
                        >{{ item.discussionmessage.length }} replies</span
                      ></span
                    >
                    <span class="text-muted fs11" v-if="item.facilitator"
                      ><span class="mr-2">{{ item.facilitator.name }}</span>
                      <span class="mr-2">{{
                        $moment(item.created_at).fromNow()
                      }}</span>
                      <span
                        >{{ item.discussionmessage.length }} replies</span
                      ></span
                    >
                  </div>
                </div>
                <div class="w-25" v-if="item.discussionmessage.length">
                  <b-avatar-group size="30px">
                    <span
                      v-for="(item, idx) in item.discussionmessage.slice(0, 3)"
                      :key="idx"
                      style="
                        width: 30px;
                        margin-left: calc(-4.5px);
                        margin-right: calc(-4.5px);
                      "
                    >
                      <b-avatar
                        v-if="item.admin"
                        :src="item.admin.profile"
                      ></b-avatar>
                      <b-avatar
                        v-if="item.user"
                        :src="item.user.profile"
                      ></b-avatar>
                      <b-avatar
                        v-if="item.facilitator"
                        :src="item.facilitator.profile"
                      ></b-avatar>
                    </span>
                  </b-avatar-group>
                </div>
              </div>
            </div>
          </b-col>
          <b-col sm="5">
            <h6 class="font-weight-bold mb-4">Top Contributors</h6>
            <p class="fs15">
              See our users who have been active contibutors to discussions
            </p>
            <div v-if="filterContributors.length">
              <div
                class="d-flex w-75 pr-4 mb-3"
                v-for="(item, id) in filterContributors"
                :key="id"
              >
                <b-avatar
                  v-if="item.admin"
                  :src="item.admin.profile"
                  class="mr-3"
                  size="2.3rem"
                ></b-avatar>
                <b-avatar
                  v-if="item.user"
                  :src="item.user.profile"
                  class="mr-3"
                  size="2.3rem"
                ></b-avatar>
                <b-avatar
                  v-if="item.facilitator"
                  :src="item.facilitator.profile"
                  class="mr-3"
                  size="2.3rem"
                ></b-avatar>
                <div v-if="item.admin">
                  <span class="fs15 font-weight-bold">{{
                    item.admin.name
                  }}</span>
                  <br />
                  <span class="text-muted fs11"
                    >{{ item.count }} contributions</span
                  >
                </div>
                <div v-if="item.facilitator">
                  <span class="fs15 font-weight-bold">{{
                    item.facilitator.name
                  }}</span>
                  <br />
                  <span class="text-muted fs11"
                    >{{ item.count }} contributions</span
                  >
                </div>
                <div v-if="item.user">
                  <span class="fs15 font-weight-bold">{{
                    item.user.name
                  }}</span>
                  <br />
                  <span class="text-muted fs11"
                    >{{ item.count }} contributions</span
                  >
                </div>
              </div>
            </div>
          </b-col>
        </b-row>
      </section>
      <section class="py-5">
        <h4 class="mb-5">Upcoming Events</h4>

        <div v-if="showEvents">
          <div class="events" v-if="events.length">
            <carousel
              :perPage="1"
              :paginationEnabled="false"
              :autoplay="true"
              :speed="1000"
              :autoplayTimeout="5000"
              :loop="true"
              class="shadow bg-white"
            >
              <slide
                v-for="item in events
                  .filter((item) => item.status == 'pending')
                  .slice(0, 5)"
                :key="item.id"
              >
                <div class="border rounded text-left position-relative">
                  <div
                    class="
                      bg-lighter-green
                      px-3
                      py-3
                      text-left text-dark-green
                      d-flex
                      justify-content-between
                    "
                  >
                    <h4 class="text-capitalize text-dark-green mb-0">
                      {{ item.title }}
                    </h4>
                    <span
                      class="cursor-pointer"
                      @click="$router.push(`/learner/event/${item.id}`)"
                    >
                      <span class=""> View Event </span>
                      <b-icon icon="chevron-double-right"></b-icon>
                    </span>
                  </div>
                  <b-img fluid-grow :src="item.cover" class="event_img"></b-img>
                  <div class="px-3 py-3">
                    <p class="mb-2 fs15">
                      <b-icon icon="calendar2-check" class="mr-2"></b-icon>
                      {{ item.schedule }}
                    </p>
                    <div class="d-flex">
                      <p class="description">
                        {{ item.description }}
                      </p>
                    </div>
                  </div>
                </div>
              </slide>
            </carousel>
          </div>
          <div v-else class="text-center admin_tab p-3 p-sm-5">
            <div>
              <b-img :src="require('@/assets/images/creator.svg')"></b-img>
              <h6 class="text-muted my-3 fs14">
                It appears you have no event,
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
      </section>
    </b-container>
  </div>
</template>
<script>
import interest from "@/components/insight.js";
export default {
  data() {
    return {
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
      interest: [],
      contributors: [],
    };
  },
  mounted() {
    this.mostenrolled();
    this.getprograms();
    this.getlearners();
    this.getevents();
    this.getfacilitators();
    this.getdiscussions();
    this.getcontributors();
    this.interest = interest;
  },
  computed: {
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
  },
  methods: {
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
    getprograms() {
      this.$http.get(`${this.$store.getters.url}/guest/courses`).then((res) => {
        if (res.status == 200) {
          this.courses = res.data;
        }
      });
    },
    getlearners() {
      this.$http
        .get(`${this.$store.getters.url}/guest/learners`)
        .then((res) => {
          if (res.status == 200) {
            this.users = res.data;
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
.stbg {
  width: 100%;
  height: 250px;
  background-repeat: no-repeat;
  background-image: linear-gradient(to right, #388087 0%, #388087 100%),
    url("/img/explore_banner.jpg");
  background-blend-mode: overlay;
  background-size: cover;
  background-position: center;
}
.bg_overlay {
  height: 250px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: rgba(56, 128, 135, 0.85);
}
.main_content {
  background: #f7f7f7;
}
.course {
  height: 300px;
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
.events {
  border-radius: 8px;
  overflow: hidden;
}
.event_img {
  height: 400px;
  object-fit: cover;
}
</style>

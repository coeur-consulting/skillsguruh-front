<template>
  <div class="main_c">
    <section class="explore_banner">
      <h1>Contact Nzukoor</h1>
    </section>
    <section class="bg-white">
      <b-container class="">
        <b-row class="flex-column-reverse flex-md-row">
          <b-col sm="6" class="p-4 p-sm-5">
            <div class="d-flex align-items-center mb-3">
              <b-iconstack font-scale="2" class="mr-2">
                <b-icon
                  stacked
                  icon="circle-fill"
                  variant="lighter-green"
                ></b-icon>
                <b-icon
                  stacked
                  scale=".5"
                  icon="telephone-fill"
                  variant="dark-green"
                ></b-icon>
              </b-iconstack>
              <span class="font-weight-bold fs15"> +234 900 900 5000</span>
            </div>

            <div class="d-flex align-items-center mb-3">
              <b-iconstack font-scale="2" class="mr-2">
                <b-icon
                  stacked
                  icon="circle-fill"
                  variant="lighter-green"
                ></b-icon>
                <b-icon
                  stacked
                  scale=".5"
                  icon="envelope-fill"
                  variant="dark-green"
                ></b-icon>
              </b-iconstack>
              <span class="font-weight-bold fs15"> info@nzukoor.com</span>
            </div>
            <div>
              <div class="mapouter">
                <div class="gmap_canvas">
                  <iframe
                    width="400"
                    height="400"
                    id="gmap_canvas"
                    src="https://maps.google.com/maps?q=lekki&t=&z=13&ie=UTF8&iwloc=&output=embed"
                    frameborder="0"
                    scrolling="no"
                    marginheight="0"
                    marginwidth="0"
                  ></iframe
                  ><a href="https://123movies-to.org"></a><br />
                  <a href="https://www.embedgooglemap.net">google map insert</a>
                </div>
              </div>
            </div>
          </b-col>
          <b-col sm="6" class="p-4 p-sm-5">
            <div class="bg-white px-4 py-5 rounded text-left">
              <b-form @submit.prevent="sendmessage">
                <b-form-row>
                  <b-col>
                    <b-form-group label="Full name">
                      <b-form-input
                        v-model="contact.name"
                        placeholder="Enter your full name"
                        autocomplete="off"
                        autofocusoff="off"
                        required
                      ></b-form-input>
                    </b-form-group>
                  </b-col>
                </b-form-row>
                <b-form-row>
                  <b-col>
                    <b-form-group label="Email">
                      <b-form-input
                        type="email"
                        required
                        v-model="contact.email"
                        placeholder="Enter your email address"
                        autocomplete="off"
                      ></b-form-input>
                    </b-form-group>
                  </b-col>
                </b-form-row>
                <b-form-row>
                  <b-col>
                    <b-form-group label="Message">
                      <b-form-textarea
                        required
                        v-model="contact.message"
                        placeholder="Leave a message"
                        rows="5"
                      ></b-form-textarea>
                    </b-form-group>
                  </b-col>
                </b-form-row>

                <b-form-row>
                  <b-col>
                    <b-form-group>
                      <b-button type="submit" variant="dark-green" size="lg"
                        >Send message
                      </b-button>
                    </b-form-group>
                  </b-col>
                </b-form-row>
              </b-form>
            </div>
          </b-col>
        </b-row>
      </b-container>
    </section>
  </div>
</template>

<script>
export default {
  data() {
    return {
      contact: {
        name: "",
        email: "",
        message: "",
      },
    };
  },
  methods: {
    sendmessage() {
      this.$http
        .post(`${this.$store.getters.url}/send/message`, this.contact)
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Your message has been sent ");
            this.contact = {
              name: "",
              email: "",
              message: "",
            };
          }
        })
        .catch(() => {
          this.$toast.error("Message not sent");
        });
    },
  },
};
</script>

<style scoped lang="scss">
.main_cont {
  background: #f7f7f7;
}
.container {
  height: calc(100vh - 100px);
}
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
.mapouter {
  position: relative;
  text-align: right;
  height: 400px;
  width: 400px;
}
.gmap_canvas {
  overflow: hidden;
  background: none !important;
  height: 400px;
  width: 400px;
}
@media (max-width: 600px) {
  .container {
    height: 100%;
  }
  .mapouter {
    position: relative;
    text-align: right;
    height: 300px;
    width: 300px;
  }
  .gmap_canvas {
    overflow: hidden;
    background: none !important;
    height: 300px;
    width: 300px;
  }
}

.container {
  max-width: 1000px;
}
.main_c {
  /* The image used */
  background-image: url("../assets/images/mountain.svg");

  /* Set a specific height */
  min-height: 100vh;

  /* Create the parallax scrolling effect */
  background-attachment: fixed;
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
}
.top_bg {
  height: 400px;
  background-image: url("../assets/images/contactimg.png");
  background-position: center;
  background-repeat: no-repeat;
  background-size: contain;
}
.mywhite {
  background: #f7f8fa;
}
.trending {
  h2 span {
    position: relative;
  }
  h2 span::after {
    content: "";
    background-image: url("../assets/images/landing/mustard-brush.png");
    position: absolute;
    width: 150px;
    height: 20px;
    background-size: 150px 20px;
    background-repeat: no-repeat;
    bottom: -24px;
    right: 50%;
    margin-right: -75px;
  }
  p {
    width: 35%;
    margin: 0 auto;
  }
}

.events {
  border-radius: 8px;
  overflow: hidden;
}
.event_img {
  height: 400px;
  object-fit: cover;
}
.tpp {
  cursor: pointer;
  font-weight: 500;
}
.discussion_container {
  height: 265px;
  color: #fff;
  border-radius: 10px;

  background-image: url("/img/fac1.jpg");
}
.dicussion_overlay {
  width: 100%;
  height: 100%;
  background: rgba($color: #000000, $alpha: 0.54);
  border-radius: 10px;
}
.discussion_avatar {
  margin-bottom: 6px;
}
.discussion_badge {
  top: 15px;
  right: 15px;
  z-index: 2;
}
.discussion_name {
  font-size: 0.85rem;
  margin-bottom: 2px;
}
.discussion_title {
  text-align: center;
  font-size: 1.1rem;
  font-weight: 500;
  line-height: 1.4;
  margin-bottom: 1rem;
}
.comment_container {
  background: #fff;
  border-radius: 10px;
  max-height: 90px;
}
.comment_image {
  width: 25%;
  background: #f7f7f7;
}
.comment_image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
.comment_box {
  width: 75%;
  padding: 10px;
}
.comment_name {
  font-size: 0.7rem;
  color: rgba($color: #000000, $alpha: 0.64);
}
.comment_text {
  font-size: 0.7rem;
  color: rgba($color: #000000, $alpha: 0.64);
  max-height: 34px;
  overflow: hidden;
}
.comment_text.text-truncate p {
  display: -webkit-box !important;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  white-space: normal;
}
.comment_details {
  font-size: 0.6rem;
  color: rgba($color: #000000, $alpha: 0.54);
}
.tag_badge {
  font-size: 0.6rem;
  color: white;
}
.event_title {
  font-size: 1.05rem;
  font-weight: 500;
}
@media (max-width: 768px) {
  .trending {
    h2 {
      font-size: 1.3rem;
    }
  }
  .top_bg {
    height: 150px;
  }
  .interest {
    width: 40px;
  }
  .event_title {
    font-size: 0.85rem;
  }
  h6 {
    font-size: 14px;
  }
  .tpp span span {
    font-size: 0.7rem;
    line-height: 1.3;
  }
  .tpp span {
    line-height: 1;
  }
  .tp {
    width: 30px;
  }
  .trending {
    font-size: 0.85rem;
  }
  .discussion_container {
    min-width: 320px;
    margin-bottom: 4.1rem;
  }
  .comment_carousel {
    overflow-y: auto;
    max-height: 200px;
    -ms-overflow-style: none; /* IE and Edge */
    scrollbar-width: none; /* Firefox */
  }
  .comment_carousel::-webkit-scrollbar {
    display: none;
  }
  .event_img {
    height: 200px;
    object-fit: cover;
  }
  p.description,
  p.attending,
  p.schedule {
    font-size: 13px;
    color: rgba($color: #000000, $alpha: 0.54);
  }
  h6.interest {
    font-size: 0.74rem;
  }
}
</style>

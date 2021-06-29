<template>
  <div class="main_content">
    <div class="position-relative">
      <div class="stbg">
        <div class="bg_overlay">
          <h1 class="text-white font-weight-bold">Contact Us</h1>
        </div>
      </div>
    </div>
    <b-container class="">
      <b-row class="flex-column-reverse flex-md-row">
        <b-col sm="6" class="p-4 p-sm-5">
          <div class="d-flex align-items-center mb-3">
            <b-iconstack font-scale="2.5" class="mr-2">
              <b-icon stacked icon="circle-fill" variant="dark-green"></b-icon>
              <b-icon
                stacked
                scale=".5"
                icon="telephone-fill"
                variant="light"
              ></b-icon>
            </b-iconstack>
            <span class="font-weight-bold"> +234 900 900 5000</span>
          </div>

          <div class="d-flex align-items-center mb-3">
            <b-iconstack font-scale="2.5" class="mr-2">
              <b-icon stacked icon="circle-fill" variant="dark-green"></b-icon>
              <b-icon
                stacked
                scale=".5"
                icon="envelope-fill"
                variant="light"
              ></b-icon>
            </b-iconstack>
            <span class="font-weight-bold"> info@skillsguruh.com</span>
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
          <div class="shadow bg-white px-4 py-5 rounded text-left">
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
.main_content {
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
</style>

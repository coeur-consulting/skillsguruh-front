<template>
  <div class="pt-4">
    <b-container>
      <b-row>
        <b-col sm="8">
          <div class="shadow-sm bg-white py-4 rounded">
            <div
              class="top_header border-bottom d-flex justify-content-between position-relative"
            >
              <div class="active">Recent discussions</div>
              <div>Join Discussions</div>
              <div>Recent answers</div>
              <div>Most visit</div>
            </div>
            <div class="main_content">
              <div
                class="content border-bottom p-3 pt-4 pb-5 cursor-pointer"
                @click="$router.push('/administrator/discussion')"
              >
                <div class="top_dis d-flex align-items-center mb-2">
                  <div class="side_dis">
                    <b-avatar></b-avatar>
                  </div>
                  <div class="text-left next_dis">
                    <span class="asked"> Started 2 months ago</span> <br />
                    <span class="title"
                      >Lorem ipsum dolor sit amet consectetur adipisicing elit.
                    </span>
                  </div>
                </div>
                <div class="top_dis d-flex align-items-center">
                  <div
                    class="side_dis d-flex flex-column align-items-center justify-content-center text-center vote"
                  >
                    <b-icon
                      icon="caret-up-fill"
                      font-scale="1.2"
                      class="cursor-pointer"
                    ></b-icon>
                    <span>20</span>
                    <b-icon
                      icon="caret-down-fill"
                      font-scale="1.2"
                      class="cursor-pointer"
                    ></b-icon>
                  </div>
                  <div class="text-left next_dis">
                    <div class="main_text">
                      Lorem ipsum dolor sit amet consectetur adipisicing elit.
                      Quidem sit fuga totam repellendus ullam rerum provident
                      harum, sunt commodi. Voluptatibus! Lorem ipsum dolor sit
                      amet consectetur adipisicing elit. Quidem sit fuga totam
                      repellendus ullam rerum provident harum, sunt commodi.
                      Voluptatibus!
                    </div>
                  </div>
                </div>

                <div class="bottom_bar d-flex justify-content-between">
                  <div>
                    <span class="mr-4"
                      ><b-icon icon="chat"></b-icon> 14 answers</span
                    >
                    <span class="mr-4"
                      ><b-icon icon="eye-fill"></b-icon> 14 views</span
                    >
                  </div>
                  <div>
                    <span
                      class="text-dark-green font-weight-bold cursor-pointer"
                      >Join Discussion</span
                    >
                  </div>
                </div>
              </div>
              <div class="content border-bottom p-3 pt-4 pb-5">
                <div class="top_dis d-flex align-items-center mb-2">
                  <div class="side_dis">
                    <b-avatar></b-avatar>
                  </div>
                  <div class="text-left next_dis">
                    <span class="asked"> Started 2 months ago</span> <br />
                    <span class="title"
                      >Lorem ipsum dolor sit amet consectetur adipisicing elit.
                    </span>
                  </div>
                </div>
                <div class="top_dis d-flex align-items-center">
                  <div
                    class="side_dis d-flex flex-column align-items-center justify-content-center text-center vote"
                  >
                    <b-icon
                      icon="caret-up-fill"
                      font-scale="1.2"
                      class="cursor-pointer"
                    ></b-icon>
                    <span>20</span>
                    <b-icon
                      icon="caret-down-fill"
                      font-scale="1.2"
                      class="cursor-pointer"
                    ></b-icon>
                  </div>
                  <div class="text-left next_dis">
                    <div class="main_text">
                      Lorem ipsum dolor sit amet consectetur adipisicing elit.
                      Quidem sit fuga totam repellendus ullam rerum provident
                      harum, sunt commodi. Voluptatibus! Lorem ipsum dolor sit
                      amet consectetur adipisicing elit. Quidem sit fuga totam
                      repellendus ullam rerum provident harum, sunt commodi.
                      Voluptatibus!
                    </div>
                  </div>
                </div>

                <div class="bottom_bar d-flex justify-content-between">
                  <div>
                    <span class="mr-4"
                      ><b-icon icon="chat"></b-icon> 14 answers</span
                    >
                    <span class="mr-4"
                      ><b-icon icon="eye-fill"></b-icon> 14 views</span
                    >
                  </div>
                  <div>
                    <span
                      class="text-dark-green font-weight-bold cursor-pointer"
                      >Join Discussion</span
                    >
                  </div>
                </div>
              </div>
              <div class="content border-bottom p-3 pt-4 pb-5">
                <div class="top_dis d-flex align-items-center mb-2">
                  <div class="side_dis">
                    <b-avatar></b-avatar>
                  </div>
                  <div class="text-left next_dis">
                    <span class="asked"> Started 2 months ago</span> <br />
                    <span class="title"
                      >Lorem ipsum dolor sit amet consectetur adipisicing elit.
                    </span>
                  </div>
                </div>
                <div class="top_dis d-flex align-items-center">
                  <div
                    class="side_dis d-flex flex-column align-items-center justify-content-center text-center vote"
                  >
                    <b-icon
                      icon="caret-up-fill"
                      font-scale="1.2"
                      class="cursor-pointer"
                    ></b-icon>
                    <span>20</span>
                    <b-icon
                      icon="caret-down-fill"
                      font-scale="1.2"
                      class="cursor-pointer"
                    ></b-icon>
                  </div>
                  <div class="text-left next_dis">
                    <div class="main_text">
                      Lorem ipsum dolor sit amet consectetur adipisicing elit.
                      Quidem sit fuga totam repellendus ullam rerum provident
                      harum, sunt commodi. Voluptatibus! Lorem ipsum dolor sit
                      amet consectetur adipisicing elit. Quidem sit fuga totam
                      repellendus ullam rerum provident harum, sunt commodi.
                      Voluptatibus!
                    </div>
                  </div>
                </div>

                <div class="bottom_bar d-flex justify-content-between">
                  <div>
                    <span class="mr-4"
                      ><b-icon icon="chat"></b-icon> 14 answers</span
                    >
                    <span class="mr-4"
                      ><b-icon icon="eye"></b-icon> 14 views</span
                    >
                  </div>
                  <div>
                    <span
                      class="text-dark-green font-weight-bold cursor-pointer"
                      >Join Discussion</span
                    >
                  </div>
                </div>
              </div>
            </div>
          </div>
        </b-col>
        <b-col sm="4" class="d-none d-md-block">
          <div class="shadow-sm bg-white p-4 rounded">
            <div class="text-center mb-4">
              <b-button variant="dark-green" size="lg" class="px-3"
                >Start a discussion</b-button
              >
            </div>
            <div class="py-3 text-left related_quest border">
              <h6 class="mb-3 px-3">Related Discussions</h6>
              <div class="d-flex p-2 px-3">
                <div>
                  <span class="mr-3 related_count">2000</span>
                </div>
                <span class="related text-left"
                  >Lorem ipsum, dolor sit amet consectetur adipisicing elit.
                  Beatae.</span
                >
              </div>
              <div class="d-flex p-2 px-3">
                <div>
                  <span class="mr-3 related_count">1200</span>
                </div>
                <span class="related text-left"
                  >Lorem ipsum, dolor sit amet consectetur adipisicing elit.
                  Beatae.</span
                >
              </div>
            </div>
          </div>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<style scoped lang="scss">
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
.main_content {
  min-height: 70vh;
  max-height: 70vh;
  overflow-y: auto;
}
.content {
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
  font-size: 15px;
  font-weight: 500;
  color: rgba($color: #000000, $alpha: 0.64);
}
.main_text {
  display: -webkit-box;
  font-size: 14px;
  line-height: 1.6;
  color: rgba($color: #000000, $alpha: 0.5);
  text-overflow: ellipsis;
  overflow: hidden;
  line-clamp: 4;
  -webkit-line-clamp: 4;
  -webkit-box-orient: vertical;
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
.related_count {
  width: 50px;
  padding: 4px 5px;
  background: var(--dark-green);
  font-size: 11px;
  border-radius: 2px;
  color: white;
}
</style>

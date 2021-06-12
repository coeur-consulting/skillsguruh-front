<template>
  <div>
    <b-container>
      <b-row>
        <b-col class="mb-5 mb-sm-0">
          <div
            class="
              d-flex
              flex-column flex-sm-row
              justify-content-between
              align-items-center
              mb-4
            "
          >
            <h6 class="mb-3 mb-sm-0 text-capitalize">
              {{ $route.query.showing }} Resources
            </h6>
            <div>
              <b-form-input
                placeholder="Search"
                size="sm"
                readonly
                type="search"
                class="search"
                v-model="search"
              ></b-form-input>
            </div>
          </div>

          <div class="shadow bg-white">
            <div
              class="d-flex justify-content-between align-items-center p-3 e"
            >
              <b-icon icon="funnel"></b-icon>
              <div>
                <b-button
                  variant="dark-green"
                  size="sm"
                  @click="$bvModal.show('add')"
                >
                  <b-icon icon="plus" font-scale="1.5"></b-icon
                ></b-button>
              </div>
            </div>

            <div class="">
              <b-table-simple class="org_home_table text-left" responsive="sm">
                <b-thead>
                  <b-tr class="text-left">
                    <b-th class="text-muted">Module</b-th>
                    <b-th class="text-muted">Course</b-th>

                    <b-th class="text-muted">No of Files</b-th>
                    <b-th class="text-muted"> Added</b-th>
                    <b-th></b-th> </b-tr
                ></b-thead>
                <b-tbody class="text-left">
                  <b-tr v-for="(item, index) in filter" :key="item.id">
                    <b-td class="text-left">
                      <b-avatar
                        size="sm"
                        rounded
                        class="mr-3"
                        :src="item.cover_image"
                      ></b-avatar>
                      <span>{{ item.module }} </span>
                    </b-td>
                    <b-td>
                      <div class="d-flex">
                        <div class="text-left">
                          <span class="text-capitalize">
                            {{ item.course.title }}
                          </span>
                        </div>
                      </div>
                    </b-td>

                    <b-td class="text-center">
                      {{ JSON.parse(item.modules).length }}</b-td
                    >

                    <b-td>{{ item.created_at | moment("ll") }}</b-td>
                    <b-td
                      ><b-icon
                        icon="chevron-down"
                        class="cursor-pointer"
                        :id="item.id.toString() + item.title"
                      ></b-icon>
                      <b-popover
                        :target="item.id.toString() + item.title"
                        triggers="hover"
                        placement="bottom"
                      >
                        <div class="">
                          <small
                            class="px-0 text-left cursor-pointer"
                            @click="
                              $router.push(
                                `/facilitatoristrator/outline/${item.courseoutline.id}`
                              )
                            "
                          >
                            <b-icon class="mr-2" icon="eye"></b-icon
                            ><span>View</span>
                          </small>
                          <br />
                          <hr class="my-1" />
                          <small
                            class="px-0 text-left cursor-pointer"
                            @click="edit(item)"
                          >
                            <b-icon class="mr-2" icon="pencil"></b-icon
                            ><span>Edit</span>
                          </small>
                          <br />
                          <hr class="my-1" />
                          <small
                            class="px-0 cursor-pointer"
                            @click="drop(item.id, index)"
                          >
                            <b-icon class="mr-2" icon="trash"></b-icon
                            ><span>Drop</span>
                          </small>
                        </div>
                      </b-popover>
                    </b-td>
                  </b-tr>
                </b-tbody>
              </b-table-simple>
              <div class="p-3 d-flex justify-content-between">
                <div class="fs12 text-muted">
                  Showing 1-10 of {{ filter.length }} items
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
      title="Add Resource"
    >
      <b-form @submit.prevent="register" class="user">
        <div>
          <b-container>
            <b-form-row class="mb-4">
              <b-col sm="6" class="px-3">
                <b-form-group label="Course">
                  <b-form-select v-model="detail.course_id" readonly>
                    <b-form-select-option value="" disabled
                      >Choose Course</b-form-select-option
                    >
                    <b-form-select-option
                      :value="item.id"
                      v-for="(item, id) in courses"
                      :key="id"
                      >{{ item.title }}</b-form-select-option
                    ></b-form-select
                  >
                </b-form-group>
              </b-col>
              <b-col sm="6" class="px-3">
                <b-form-group label="Modules">
                  <b-form-select
                    v-model="detail.module"
                    class="text-capitalize"
                    required
                  >
                    <b-form-select-option disabled value=""
                      >Choose Module</b-form-select-option
                    >
                    <b-form-select-option
                      :value="item"
                      v-for="(item, id) in getmodules"
                      :key="id"
                      >{{ item }}</b-form-select-option
                    ></b-form-select
                  >
                </b-form-group>
              </b-col>
            </b-form-row>

            <div>
              <h6 class="px-2">Upload Resource</h6>
              <b-form-row>
                <b-col
                  sm="6"
                  class="p-3"
                  v-for="(item, id) in detail.modules"
                  :key="id"
                >
                  <div
                    class="p-2 rounded d-flex justify-content-between shadow"
                    v-if="id != current_module"
                  >
                    <div>
                      <b-icon icon="grid" class="mr-2"></b-icon>
                      <span class="mr-3 text-capitalize">
                        {{ item.title }}</span
                      >
                    </div>
                    <div>
                      <b-iconstack
                        font-scale="1.1"
                        class="mr-2"
                        @click="addmodule"
                      >
                        <b-icon
                          stacked
                          icon="circle-fill"
                          variant="dark-green"
                        ></b-icon>
                        <b-icon
                          stacked
                          icon="plus"
                          scale="0.9"
                          variant="white"
                        ></b-icon>
                      </b-iconstack>

                      <b-iconstack
                        font-scale="1.1"
                        class="mr-2"
                        @click="current_module = id"
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
                        v-if="detail.modules.length > 1"
                        @click="detail.modules.splice(id, 1)"
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
                  <div class="bg-light p-3 rounded" v-if="id == current_module">
                    <div class="d-flex justify-content-between">
                      <div class="py-3 text-right">
                        <b-iconstack
                          font-scale="1.5"
                          class="mr-2"
                          @click="addmodule"
                        >
                          <b-icon
                            stacked
                            icon="circle-fill"
                            variant="dark-green"
                          ></b-icon>
                          <b-icon
                            stacked
                            icon="plus"
                            scale="0.9"
                            variant="white"
                          ></b-icon>
                        </b-iconstack>

                        <b-iconstack
                          font-scale="1.5"
                          v-if="detail.modules.length > 1"
                          @click="detail.modules.splice(id, 1)"
                        >
                          <b-icon
                            stacked
                            icon="circle-fill"
                            variant="danger"
                          ></b-icon>
                          <b-icon
                            icon="trash2-fill"
                            stacked
                            scale="0.6"
                            variant="white"
                          ></b-icon>
                        </b-iconstack>
                      </div>

                      <b-icon
                        icon="chevron-up"
                        @click="current_module = null"
                      ></b-icon>
                    </div>
                    <b-form-group label=" Title">
                      <b-form-input
                        size="sm"
                        v-model="item.title"
                        placeholder="Enter Title"
                      ></b-form-input>
                    </b-form-group>
                    <b-form-group label=" Overview">
                      <b-form-textarea
                        size="sm"
                        v-model="item.overview"
                        placeholder="Enter Overview"
                      ></b-form-textarea>
                    </b-form-group>
                    <b-form-row>
                      <b-col sm="4">
                        <b-form-group label="File type">
                          <b-form-select size="sm" v-model="item.file_type">
                            <b-form-select disabled value=""
                              >Choose file type</b-form-select
                            >
                            <b-form-select-option value="video"
                              >Video</b-form-select-option
                            >
                            <b-form-select-option value="audio"
                              >Audio</b-form-select-option
                            >
                            <b-form-select-option value="document"
                              >Document</b-form-select-option
                            >
                          </b-form-select>
                        </b-form-group>
                      </b-col>
                    </b-form-row>
                    <b-form-group
                      label="Upload Resource File"
                      class="text-center"
                    >
                      <Upload
                        @getUpload="getUpload"
                        :id="'file-' + id"
                        :type="'document'"
                        :file_type="item.file_type"
                      >
                        <b-icon
                          icon="cloud-upload"
                          class="text-muted"
                          font-scale="3.5rem"
                        ></b-icon>
                      </Upload>
                    </b-form-group>
                  </div>
                </b-col>
              </b-form-row>
            </div>
            <b-form-row>
              <b-col>
                <div class="px-2 mt-3">
                  <h6>Template</h6>
                  <b-row>
                    <b-col sm="6">
                      <b-form-group label="Choose template">
                        <multi-list-select
                          :list="allquestionnaires"
                          option-value="id"
                          option-text="title"
                          :selected-items="detail.templates"
                          placeholder="Search template"
                          @select="onSelect"
                        >
                        </multi-list-select>
                      </b-form-group>
                    </b-col>

                    <b-col sm="3">
                      <b-form-group label="Choose template type">
                        <b-form-select v-model="detail.type">
                          <b-form-select-option disabled value="">
                            Choose template type</b-form-select-option
                          >
                          <b-form-select-option value="questionnaire">
                            Questionnaire</b-form-select-option
                          >
                          <b-form-select-option value="quiz">
                            Quiz</b-form-select-option
                          >
                          <b-form-select-option value="assessment">
                            Assessment</b-form-select-option
                          >
                        </b-form-select>
                      </b-form-group>
                    </b-col>
                  </b-row>
                  <div
                    v-for="(item, id) in detail.questionnaires"
                    :key="id"
                    class="d-flex justify-content-between px-2 py-2 rounded"
                  >
                    <div class="text-capitalize">
                      <span class="mr-2">{{ id + 1 }}.</span> {{ item.title }}
                    </div>
                    <b-icon
                      icon="x"
                      @click="detail.questionnaires.splice(id, 1)"
                      font-scale="1.5"
                    ></b-icon>
                  </div>
                  <b-form-group class="">
                    <b-button
                      size="sm"
                      variant="lighter-green"
                      @click="$bvModal.show('question')"
                      >Create Template</b-button
                    >
                  </b-form-group>
                </div>
              </b-col>
            </b-form-row>

            <b-form-row>
              <b-col sm="6" class="px-3">
                <div class="p-3 rounded">
                  <b-form-group label=" Cover image">
                    <Upload
                      @getUpload="getUpload"
                      :id="'cover'"
                      :type="'image'"
                      :file_type="'image'"
                    >
                      <b-icon
                        icon="image"
                        class="text-muted"
                        font-scale="6rem"
                      ></b-icon>
                    </Upload>
                  </b-form-group>
                </div>
              </b-col>
            </b-form-row>
          </b-container>
          <b-form-group>
            <div class="mb-3 text-center mt-4">
              <b-button
                type="submit"
                variant="dark-green"
                size="lg"
                class="px-5 d-none d-sm-block mx-auto"
              >
                Add Resource
              </b-button>
              <b-button
                type="submit"
                variant="dark-green"
                size="lg"
                block
                class="px-5 d-sm-none mx-auto"
              >
                Add Resource
              </b-button>
            </div>
          </b-form-group>
        </div>
      </b-form>
    </b-modal>

    <b-modal
      no-close-on-backdrop
      id="edit"
      hide-footer
      centered
      size="lg"
      title="Edit Course Module"
    >
      <b-form @submit.prevent="register" class="user" title="Edit Resource">
        <div>
          <b-container>
            <b-form-row class="mb-4">
              <b-col sm="6" class="px-3">
                <b-form-group label="Course">
                  <b-form-select v-model="detail.course_id">
                    <b-form-select-option value="" disabled
                      >Choose Course</b-form-select-option
                    >
                    <b-form-select-option
                      :value="item.id"
                      v-for="(item, id) in courses"
                      :key="id"
                      >{{ item.title }}</b-form-select-option
                    ></b-form-select
                  >
                </b-form-group>
              </b-col>
              <b-col sm="6" class="px-3">
                <b-form-group label="Modules">
                  <b-form-select
                    v-model="detail.module"
                    class="text-capitalize"
                    required
                  >
                    <b-form-select-option disabled value=""
                      >Choose Module</b-form-select-option
                    >
                    <b-form-select-option
                      :value="item"
                      v-for="(item, id) in getmodules"
                      :key="id"
                      >{{ item }}</b-form-select-option
                    ></b-form-select
                  >
                </b-form-group>
              </b-col>
            </b-form-row>

            <b-form-row>
              <b-col
                sm="6"
                class="p-3"
                v-for="(item, id) in detail.modules"
                :key="id"
              >
                <div
                  class="p-2 rounded d-flex justify-content-between shadow"
                  v-if="id != current_module"
                >
                  <div>
                    <b-icon icon="grid" class="mr-2"></b-icon>
                    <span class="mr-3 text-capitalize"> {{ item.title }}</span>
                  </div>
                  <div>
                    <b-iconstack
                      font-scale="1.1"
                      class="mr-2"
                      @click="addmodule"
                    >
                      <b-icon
                        stacked
                        icon="circle-fill"
                        variant="dark-green"
                      ></b-icon>
                      <b-icon
                        stacked
                        icon="plus"
                        scale="0.9"
                        variant="white"
                      ></b-icon>
                    </b-iconstack>

                    <b-iconstack
                      font-scale="1.1"
                      class="mr-2"
                      @click="current_module = id"
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
                      v-if="detail.modules.length > 1"
                      @click="detail.modules.splice(id, 1)"
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
                <div class="bg-light p-3 rounded" v-if="id == current_module">
                  <div class="d-flex justify-content-between">
                    <div class="py-3 text-right">
                      <b-iconstack
                        font-scale="1.5"
                        class="mr-2"
                        @click="addmodule"
                      >
                        <b-icon
                          stacked
                          icon="circle-fill"
                          variant="dark-green"
                        ></b-icon>
                        <b-icon
                          stacked
                          icon="plus"
                          scale="0.9"
                          variant="white"
                        ></b-icon>
                      </b-iconstack>

                      <b-iconstack
                        font-scale="1.5"
                        v-if="detail.modules.length > 1"
                        @click="detail.modules.splice(id, 1)"
                      >
                        <b-icon
                          stacked
                          icon="circle-fill"
                          variant="danger"
                        ></b-icon>
                        <b-icon
                          icon="trash2-fill"
                          stacked
                          scale="0.6"
                          variant="white"
                        ></b-icon>
                      </b-iconstack>
                    </div>

                    <b-icon
                      icon="chevron-up"
                      @click="current_module = null"
                    ></b-icon>
                  </div>
                  <b-form-group label=" Title">
                    <b-form-input
                      size="sm"
                      v-model="item.title"
                      placeholder="Enter Title"
                    ></b-form-input>
                  </b-form-group>
                  <b-form-group label=" Overview">
                    <b-form-textarea
                      size="sm"
                      v-model="item.overview"
                      placeholder="Enter Overview"
                    ></b-form-textarea>
                  </b-form-group>
                  <b-form-row>
                    <b-col sm="4">
                      <b-form-group label="File type">
                        <b-form-select size="sm" v-model="item.file_type">
                          <b-form-select disabled value=""
                            >Choose file type</b-form-select
                          >
                          <b-form-select-option value="video"
                            >Video</b-form-select-option
                          >
                          <b-form-select-option value="audio"
                            >Audio</b-form-select-option
                          >
                          <b-form-select-option value="document"
                            >Document</b-form-select-option
                          >
                        </b-form-select>
                      </b-form-group>
                    </b-col>
                  </b-form-row>
                  <b-form-group
                    label="Upload Resource File"
                    class="text-center"
                  >
                    <Upload
                      @getUpload="getUpload"
                      :id="'file-' + id"
                      :type="'document'"
                      :file_type="item.file_type"
                    >
                      <b-icon
                        icon="cloud-upload"
                        class="text-muted"
                        font-scale="3.5rem"
                      ></b-icon>
                    </Upload>
                  </b-form-group>
                </div>
              </b-col>
            </b-form-row>
            <b-form-row>
              <b-col>
                <div class="px-2 mt-3">
                  <h6>Questionnaires</h6>

                  <div
                    v-for="(item, id) in detail.questionnaires"
                    :key="id"
                    class="d-flex justify-content-between px-2 py-2 rounded"
                  >
                    <div class="text-capitalize">
                      <span class="mr-2">{{ id + 1 }}.</span> {{ item.title }}
                    </div>
                    <b-icon
                      icon="x"
                      @click="detail.questionnaires.splice(id, 1)"
                      font-scale="1.5"
                    ></b-icon>
                  </div>
                  <b-form-group class="">
                    <b-button
                      size="sm"
                      variant="lighter-green"
                      @click="$bvModal.show('question')"
                      >Add Questionnaire (optional)</b-button
                    >
                  </b-form-group>
                </div>
              </b-col>
            </b-form-row>
            <b-form-row>
              <b-col sm="6" class="px-3">
                <div class="p-3 rounded">
                  <b-form-group label=" Cover image">
                    <Upload
                      @getUpload="getUpload"
                      :id="'cover'"
                      :type="'image'"
                      :file_type="'image'"
                    >
                      <b-icon
                        v-if="!detail.cover_image"
                        icon="image"
                        class="text-muted"
                        font-scale="6rem"
                      ></b-icon>
                      <b-avatar
                        size="6rem"
                        v-if="detail.cover_image"
                        :src="detail.cover_image"
                        blank-color="transparent"
                      ></b-avatar>
                    </Upload>
                  </b-form-group>
                </div>
              </b-col>
            </b-form-row>
          </b-container>
          <b-form-group>
            <div class="mb-3 text-center mt-4">
              <b-button
                type="submit"
                variant="dark-green"
                size="lg"
                class="px-5 d-none d-sm-block mx-auto"
              >
                Update Resource
              </b-button>
              <b-button
                type="submit"
                variant="dark-green"
                size="lg"
                block
                class="px-5 d-sm-none mx-auto"
              >
                Update Resource
              </b-button>
            </div>
          </b-form-group>
        </div>
      </b-form>
    </b-modal>

    <b-modal no-close-on-backdrop id="question" size="xl" hide-footer centered>
      <questionnaire @getQuestionnaire="getQuestionnaire"></questionnaire>
    </b-modal>
  </div>
</template>
<script>
import Upload from "../fileupload";
import questionnaire from "./Questionnaire/resourceQuestionnaire";
import { MultiListSelect } from "vue-search-select";
export default {
  data() {
    return {
      id: null,
      search: "",
      current_module: 0,
      currentPage: 1,
      rows: null,
      perPage: 10,
      modules: [],
      courses: [],
      items: [],
      lastSelectItem: "",
      newmodule: "",
      title: "",
      facilitators: [],
      detail: {
        template: {},
        type: "",
        templates: [],
        course_id: "",
        module: "",
        modules: [
          {
            title: "",
            overview: "",
            file_type: "video",
            file: "",
          },
        ],
        cover_image: "",
        questionnaires: [],
      },
      questionnaires: [],
      allquestionnaires: [],
    };
  },
  components: {
    Upload,
    questionnaire,
    MultiListSelect,
  },
  computed: {
    filter() {
      return this.modules
        .filter((item) =>
          item.course.title.toLowerCase().includes(this.search.toLowerCase())
        )
        .slice(
          this.perPage * this.currentPage - this.perPage,
          this.perPage * this.currentPage
        );
    },
    getmodules() {
      if (!this.detail.course_id) {
        return [];
      }
      var first = this.courses.find((item) => item.id == this.detail.course_id);
      return JSON.parse(first.courseoutline.modules);
    },
  },
  mounted() {
    this.getcourses();
    this.allmodules();
    this.getfacilitators();
    this.getQuestionnairs();
    if (this.$route.query.showing) {
      this.search = this.$route.query.showing;
    }
  },
  methods: {
    onSelect(items, lastSelectItem) {
      this.detail.templates = items;
      this.lastSelectItem = lastSelectItem;
    },
    async getQuestionnairs() {
      return this.$http
        .get(`${this.$store.getters.url}/question/templates`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.allquestionnaires = res.data;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    getQuestionnaire(val) {
      this.detail.questionnaires.push(val);
      this.$bvModal.hide("question");
    },
    getUpload(val, id) {
      if (id == "cover") {
        this.detail.cover_image = val;
        return;
      }
      var index = Number(id.substr(5));
      this.detail.modules[index].file = val;
    },
    addmodule() {
      this.detail.modules.push({
        template: {},
        type: "",
        course_id: "",
        module: "",
        modules: [
          {
            title: "",
            overview: "",
            file_type: "video",
            file: "",
          },
        ],
        cover_image: "",
        questionnaires: [],
      });
      this.current_module = this.detail.modules.length - 1;
    },
    sortfacilitators(data) {
      if (!data.courseschedule) {
        return "Unavailable";
      }
      var schedule = data.courseschedule;
      var newArr = schedule.map((val) => {
        var fac = this.facilitators.find(
          (item) => item.id == val.facilitator_id
        );
        if (fac) {
          return fac.name;
        }
      });
      return [...new Set(newArr)];
    },
    async getfacilitators() {
      return this.$http
        .get(`${this.$store.getters.url}/facilitators`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
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
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.courses = res.data;
            this.rows = res.data.length;
            this.detail.course_id = this.courses.find((item) =>
              item.title
                .toLowerCase()
                .includes(this.$route.query.showing.toLowerCase())
            ).id;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },
    async allmodules() {
      return this.$http
        .get(`${this.$store.getters.url}/modules`, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 200) {
            this.modules = res.data;
            this.rows = res.data.length;
          }
        })
        .catch((err) => {
          this.$toast.error(err.response.data.message);
        });
    },

    register() {
      this.$http
        .post(`${this.$store.getters.url}/modules`, this.detail, {
          headers: {
            Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
          },
        })
        .then((res) => {
          if (res.status == 201) {
            this.$toast.success("Added successfully");
            this.allmodules();
            this.$bvModal.hide("add");
            this.detail = {
              course_id: "",
              module: "",
              modules: [
                {
                  title: "",
                  overview: "",
                  file_type: "video",
                  file: "",
                },
              ],
              cover_image: "",
            };
          }
        })
        .catch((err) => {
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
      this.detail.course_id = data.course_id;
      this.detail.module = data.module;
      this.detail.cover_image = data.cover_image;
      this.detail.modules = JSON.parse(data.modules);
      this.$bvModal.show("edit");
    },
    updatecourse() {
      this.$http
        .put(
          `${this.$store.getters.url}/modules/${this.detail.id}`,
          this.detail,
          {
            headers: {
              Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
            },
          }
        )
        .then((res) => {
          if (res.status == 200) {
            this.$toast.success("Updated successfully");
            this.detail = {
              course_id: "",
              module: "",
              modules: [
                {
                  title: "",
                  overview: "",
                  file_type: "video",
                  file: "",
                },
              ],
              cover_image: "",
            };
            this.getmodules();
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
            .delete(`${this.$store.getters.url}/modules/${id}`, {
              headers: {
                Authorization: `Bearer ${this.$store.getters.facilitator.access_token}`,
              },
            })
            .then((res) => {
              if (res.status == 200) {
                this.$toast.success("Removed successfully");
                this.allmodules();
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
.shadow {
  box-shadow: 5px 10px 20px rgba(189, 231, 201, 0.35) !important;
  border-radius: 8px;
}
.search.form-control {
  width: 250px;
  border: 1px solid rgba($color: #000000, $alpha: 0.07) !important;
}
.search::placeholder {
  color: rgba($color: #000000, $alpha: 0.2);
}
</style>

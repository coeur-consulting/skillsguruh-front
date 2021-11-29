<template>
  <div>
    <div>
      <div @click="$bvModal.show('addupload')">
        <slot>

        </slot>
      </div>
      <div class="fs12" v-if="this.images.length">
        <small  class="fs12 text-center text-dark-green">
          File(s) ready <b-icon variant="text-dark-green"  icon="check2-circle"></b-icon
        ></small>
      </div>
    </div>
    <b-modal id="addupload" centered title="Upload files" ok-only :hide-footer="!images.length" ok-variant="dark-green"  ok-title="Proceed">
      <form
        @submit.prevent="processUpload"
        class="text-center position-relative"
      >
        <div class="">
          <div class="rounded  uploader border">
            <div class="header">
              <div
                class="text-center border-right"
                @click="show = 'computer'"
                :class="show == 'computer' ? '' : 'text-muted'"
              >
                Computer
              </div>
              <div
                class="text-center border-right"
                :class="show == 'url' ? '' : 'text-muted'"
                @click="show = 'url'"
              >
                Url
              </div>
              <div
                class="text-center"
                @click="show = 'google'"
                :class="show == 'google' ? '' : 'text-muted'"
              >
                Google drive
              </div>
            </div>

            <div class="p-3" v-if="show === 'computer'">
              <div class="upload-form position-relative bg-light mb-3 p-3">
                <label class="form-group mb-0" :for="id">
                  <b-form-file
                    multiple
                    v-model="files"
                    type="file"
                    class="form-control hidden"
                    :id="id"
                    aria-describedby="helpId"
                    placeholder
                  />
                  <span
                    ><div class="mb-3 text-muted">Drag/Click to upload</div>
                    <b-icon
                      class="mb-2 text-muted text-opacity-25"
                      icon="cloud-upload"
                      font-scale="3"
                    ></b-icon
                  ></span>
                </label>
                <div v-if="start" class="spinner-start">
                  <b-spinner
                    class="text-dark-green"
                    style="width: 4rem; height: 4rem"
                    label="Spinning"
                  ></b-spinner>
                </div>
              </div>

              <div class="container-fluid">
                <b-row v-if="images.length">
                  <b-col

                    cols="3"
                    class="px-1 position-relative imgbox"
                    v-for="(item, id) in images"
                    :key="id"
                  >
                  <b-icon icon="x" class="x-img"  @click="removeimage(id)"></b-icon>
                    <b-img
                      v-if="item"
                      :src="item"
                      blank-color="transparent"
                      fluid-grow
                    ></b-img>
                  </b-col>
                </b-row>
              </div>
            </div>
            <!-- <div class="body p-3" v-show="show == 'url'">
              <span v-if="!uploadedFileUrl"
                ><span>Image Url </span><br />
                <b-form-input
                  v-model="uploadedFileUrl"
                  placeholder="Input the image url"
                  class="form_field"
                ></b-form-input
              ></span>
              <b-img
                v-if="uploadedFileUrl"
                :src="uploadedFileUrl"
                blank-color="transparent"
              ></b-img>
            </div>
            <div class="body p-3" v-show="show == 'google'">
              <span v-if="!uploadedFileUrl"
                ><span>Google Drive Link </span><br />
                <b-form-input
                  class="form_field"
                  v-model="uploadedFileUrl"
                  placeholder="Input the google drive link"
                ></b-form-input
              ></span>
              <b-img
                v-if="uploadedFileUrl"
                :src="uploadedFileUrl"
                blank-color="transparent"
              ></b-img>
            </div> -->
          </div>
        </div>
      </form>
    </b-modal>
  </div>
</template>
<style scoped>
.link_url {
  max-width: 250px;
}
.imgbox:hover .x-img{
  display: block;
}
.x-img{
  position: absolute;
  top: 5px;
  right: 5px;
}
.uploader {

  width: 100%;
  margin: 0 auto;
}
.form_field {
  width: 300px;
}
.header {
  background: white;
  border-bottom: 1px solid #ccc;
  display: flex;
  justify-content: space-between;
}
.header > div {
  width: 33.3%;
  padding: 15px 10px;
  font-size: 0.8rem;
}
.upload-form {
  height: 100px;

}
.body {
  max-height: 150px;
  overflow-y: auto;
  display: flex;
  justify-content: center;
  align-items: center;
}
.body img {
  width: 85%;
  height: 85%;
  object-fit: contain;
}
.form {
  border-radius: 8px;
}
label {
  position: relative;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;
  margin: 0;
}
.progress {
  height: 10px;
}
.hidden {
  display: none;
}
.logo {
  width: 50%;
  height: 120px;
  padding: 5px;
}
.images {
  display: flex;
  margin-top: 15px;
}
.oldimg {
  width: 50%;
  height: 120px;
  padding: 5px;
}
.oldimg img,
.logo img {
  width: 100%;
  height: 100%;
  object-fit: contain;
}
.spinner-start {
  position: absolute;
  top: 50%;
  left: 50%;
  margin-left: -2rem;
  margin-top: -2rem;
}
</style>
<script>
export default {
  name: "CloudinaryUpload",
  props:['id'],
  data() {
    return {
      show: "computer",
      img_ext: ["jpg", "png", "jpeg ", "gif"],
      vid_ext: ["mp4", "3gp", "mov", "flv"],
      filesSelectedLength: 0,
      file: [],
      filetype: "",
      uploadedFile: null,
      uploadedFileUrl: null,
      files: [],
      cloudinary: {
        uploadPreset: "skillsguruh_preset",
        cloudName: "skillsguruh",
      },
      progress: 0,
      start: false,
      images: [],
      imageProgess: [],
    };
  },

  computed: {},
  watch: {
    files: "handleUpload",
  },
  methods: {
    removeimage(id){
      this.images.splice(id,1)
    },
    getextension(fileName) {
      if (fileName) {
        var regex = new RegExp("[^.]+$");
        var extension = fileName.match(regex);

        return extension[0].toLowerCase();
      }
    },

    async handleUpload() {

      var cloudName = this.cloudinary.cloudName;
      var upload_preset = this.cloudinary.uploadPreset;
      var url = "https://api.cloudinary.com/v1_1/" + cloudName + "/upload";
      const config = {
        onUploadProgress: (e) => {
          if (e.lengthComputable) {
            this.progress = Math.round((e.loaded / e.total) * 100) + "%";
            this.start = true;
          }
        },
      };

      await this.files.forEach((file, item) => {
        const formData = new FormData();
        formData.append("file", file);
        formData.append("resource_type", "auto");
        formData.append("upload_preset", upload_preset);

        this.$http
          .post(url, formData, config)
          .then((res) => {
            var obj = {};
            obj.publiId = res.data.public_id;
            obj.url = res.data.secure_url;
            obj.file_name = res.data.original_filename;
            this.images.push(res.data.secure_url);
            this.start = false;
            if (item == this.files.length - 1) {
              this.sendImages();
            }
          })
          .catch((err) => {
            this.$toast.error(err);
            this.images = [];
            this.start = false;
          });
      });
    },
    sendImages() {
      this.$emit("getUploads", this.images);
    },


  },
};
</script>

<template>
  <div class="w-100">
    <div class="rounded uploader">
      <div class="p-3">
        <div
          class="
            upload-form
            position-relative
            bg-light
            mb-4
            p-3
            d-flex
            justify-content-center
            align-items-center
          "
        >
          <label class="form-group mb-0 text-center" :for="id">
            <b-form-file
              :multiple="isMultiple"
              v-model="files"
              type="file"
              class="form-control hidden"
              :id="id"
              aria-describedby="helpId"
              :accept="accepted"
              placeholder
            />
            <span>
              <b-icon
                class="mb-3 text-muted text-opacity-25"
                icon="cloud-upload"
                font-scale="3"
              ></b-icon>
              <div class="text-muted">Drag / Click to upload</div>
            </span>
          </label>
        </div>
        <b-row class="preview" v-if="filepreview.length && type === 'image'">
          <b-col
            cols="6"
            md="4"
            v-for="(file, id) in filepreview"
            :key="id"
            class="d-flex justify-content-between align-items-center"
          >
            <div class="d-flex align-items-center">
              <b-avatar
                class="mr-3"
                variant="transparent"
                rounded
                :src="file.preview"
                size="6rem"
              ></b-avatar>
            </div>
            <div>
              <b-icon
                v-if="!uploadedFiles.length"
                scale="1.2"
                icon="x"
                @click="removeimage(id)"
              ></b-icon>
              <b-icon
                v-if="uploadedFiles.length"
                scale="1.5"
                icon="check2-circle"
                variant="success"
              ></b-icon>
            </div>
          </b-col>
        </b-row>
        <b-row class="preview" v-if="filepreview.length && type === 'video'">
          <b-col
            cols="12"
            v-for="(file, id) in filepreview"
            :key="id"
            class="d-flex justify-content-between align-items-center"
          >
            <div class="d-flex align-items-center">
              <video :src="file.preview" controls class="video"></video>
            </div>
            <div>
              <b-icon
                v-if="!uploadedFiles.length"
                scale="1.2"
                icon="x"
                @click="removeimage(id)"
              ></b-icon>
              <b-icon
                v-if="uploadedFiles.length"
                scale="1.5"
                icon="check2-circle"
                variant="success"
              ></b-icon>
            </div>
          </b-col>
        </b-row>

        <div class="d-flex justify-content-end">
          <div v-if="!uploadedFiles.length">
            <b-button
              size="sm"
              variant="light"
              @click="handleFileUpload"
              v-if="!start"
              :disabled="!filepreview.length"
            >
              Upload</b-button
            >
            <b-button size="sm" variant="light" disabled v-if="start"
              >Uploading
              <b-icon
                icon="three-dots"
                animation="cylon"
                class="ml-3"
                font-scale="1"
              ></b-icon>
            </b-button>
          </div>

          <div v-if="uploadedFiles.length">
            <b-button size="sm" variant="light" disabled
              >Files upload successful
            </b-button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<style scoped>
.video {
  width: 90%;
  height: auto;
  margin: 0 auto 15px;
}
.link_url {
  max-width: 250px;
}
.imgbox:hover .x-img {
  display: block;
}
.x-img {
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
  border: 1px dashed rgba(0, 0, 0, 0.3);
  border-radius: 10px;
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
  name: "CloudinaryMultiUpload",
  props: {
    id: {
      type: String,
      required: true,
    },
    type: {
      type: String,
      required: true,
    },
    isMultiple: {
      type: Boolean,
      require: true,
      default: false,
    },
  },
  data() {
    return {
      show: "computer",
      img_ext: ".jpg, .png, .jpeg , .gif",
      vid_ext: ".mp4, .3gp, .mov, .flv",

      filetype: "",
      uploadedFiles: [],
      files: [],
      acceptedFiles: [],
      filepreview: [],
      cloudinary: {
        uploadPreset: "nzukoor_preset",
        cloudName: "nzukoor",
      },
      start: false,
    };
  },

  watch: {
    files: "handleAcceptedFiles",
  },
  methods: {
    getextension(fileName) {
      if (fileName && fileName.length) {
        var regex = new RegExp("[^.]+$");
        var extension = fileName.match(regex);

        return extension[0].toLowerCase();
      }
    },
    removeimage(id) {
      this.$props.isMultiple ? this.files.splice(id, 1) : (this.files = []);
    },

    handleAcceptedFiles() {
      if (this.$props.isMultiple) {
        this.files.forEach((file) => {
          if (!this.checksize(file.size)) {
            if (this.$props.type === "image") {
              this.$toast.error("One or more files too large, > 5mb");
            } else {
              this.$toast.error("One or more files too large, > 16mb");
            }

            this.files = [];
            return;
          }
        });
        this.filepreview = this.files.map((file) =>
          Object.assign(file, {
            preview: URL.createObjectURL(file),
            formattedSize: this.formatBytes(file.size),
          })
        );
      } else {
        if (!this.checksize(this.files.size)) {
          if (this.$props.type === "image") {
            this.$toast.error("One or more files too large, > 5mb");
          } else {
            this.$toast.error("One or more files too large, > 16mb");
          }

          this.files = [];
          return;
        }
        this.filepreview.push({
          preview: URL.createObjectURL(this.files),
          formattedSize: this.formatBytes(this.files.size),
        });
      }
    },
    handleFileUpload() {
      this.start = true;
      var cloudName = this.cloudinary.cloudName;
      var upload_preset = this.cloudinary.uploadPreset;
      var url = "https://api.cloudinary.com/v1_1/" + cloudName + "/upload";

      if (this.$props.isMultiple) {
        const uploads = this.files.map((file) => {
          const formData = new FormData();
          formData.append("file", file);
          formData.append("upload_preset", upload_preset); // Replace the preset name with your own
          formData.append("api_key", process.env.VUE_APP_CLOUDINARY_APIKEY); // Replace API key with your own Cloudinary API key
          formData.append("timestamp", (Date.now() / 1000) | 0);

          return this.$http
            .post(`${url}`, formData, {
              headers: { "X-Requested-With": "XMLHttpRequest" },
            })
            .then((response) =>
              this.uploadedFiles.push(response.data.secure_url)
            )
            .catch((err) => {
              this.start = false;
              this.toast.error(err);
              this.$toast.error("Upload failed");
              // this.filepreview = []
            });
        });

        this.$http.all(uploads).then(() => {
          this.$emit("getUploads", this.uploadedFiles);
          this.start = false;
        });
      } else {
        const formData = new FormData();
        formData.append("file", this.files);
        formData.append("upload_preset", upload_preset); // Replace the preset name with your own
        formData.append("api_key", process.env.VUE_APP_CLOUDINARY_APIKEY); // Replace API key with your own Cloudinary API key
        formData.append("timestamp", (Date.now() / 1000) | 0);

        this.$http
          .post(`${url}`, formData, {
            headers: { "X-Requested-With": "XMLHttpRequest" },
          })
          .then((response) => {
            this.uploadedFiles.push(response.data.secure_url);
            this.$emit("getUploads", this.uploadedFiles);
          })
          .catch((err) => {
            this.start = false;
            this.toast.error(err);
            this.$toast.error("Upload failed");
            // this.filepreview = []
          });
      }
    },

    formatBytes(bytes, decimals = 2) {
      if (bytes === 0) return "0 Bytes";
      const k = 1024;
      const dm = decimals < 0 ? 0 : decimals;
      const sizes = ["Bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];

      const i = Math.floor(Math.log(bytes) / Math.log(k));
      return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + " " + sizes[i];
    },
    checksize(bytes) {
      if (bytes === 0) return 0;
      var size = bytes / 1000;
      if (this.$props.type === "image") {
        return size < 5000 ? true : false;
      }
      return size < 16000 ? true : false;
    },
  },
  computed: {
    accepted() {
      return this.$props.type === "image" ? this.img_ext : this.vid_ext;
    },
  },
};
</script>

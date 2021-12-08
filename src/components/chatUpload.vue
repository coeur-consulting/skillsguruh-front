<template>
  <div>
    <form
      @submit.prevent="processUpload"
      class="cursor-pointer position-relative"
    >
      <div class="cursor-pointer">
        <label class="form-group mb-0" :for="id">
          <input
            type="file"
            class="form-control hidden"
            :id="id"
            aria-describedby="helpId"
            placeholder
            :accept="accepted"
            @change="handleFileChange($event)"
          />
          <div class="position-relative text-center">
            <slot></slot>
            <div v-if="start" class="spinner-start">
              <b-spinner
                class="text-dark-green"
                style="width: 2rem; height: 2rem"
                label="Spinning"
              ></b-spinner>
            </div>
            <div
              v-if="uploadedFileUrl"
              class="fs12 text-center text-dark-green"
            >
              Ready <b-icon icon="check2-circle"></b-icon>
            </div>
          </div>
        </label>
      </div>
    </form>
  </div>
</template>
<style scoped>
.form {
  border-radius: 8px;
  border: 1px dashed #ccc;
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
  margin-left: -1rem;
  margin-top: -1rem;
}
</style>
<script>
export default {
  name: "CloudinaryUpload",
  props: {
    id: {
      type: String,
      required: true,
    },
    type: {
      type: String,
      required: true,
    },
  },
  data() {
    return {
      img_ext: ".jpg, .png, .jpeg , .gif",
      vid_ext: ".mp4, .3gp, .mov, .flv",
      aud_ext: ".mp3, .aac",
      doc_ext: ".docx, .pdf, .ppt, .zip",
      filesSelectedLength: 0,
      file: [],
      filetype: "",
      uploadedFile: null,
      uploadedFileUrl: null,
      cloudinary: {
        uploadPreset: "skillsguruh_preset",
        cloudName: "skillsguruh",
      },
      progress: 0,
      start: false,
    };
  },

  mounted() {
    if (this.$props.image) {
      this.uploadedFileUrl = this.$props.image;
    }
  },
  computed: {
    accepted() {
      if (this.$props.type === "image") {
        return this.img_ext;
      }
      if (this.$props.type === "video") {
        return this.vid_ext;
      }
      if (this.$props.type === "audio") {
        return this.aud_ext;
      }
      return this.doc_ext;
    },
  },
  methods: {
    getextension(fileName) {
      if (fileName) {
        var regex = new RegExp("[^.]+$");
        var extension = fileName.match(regex);

        return extension[0].toLowerCase();
      }
    },
     checksize(bytes) {
       if (bytes === 0) return 0;
      var size = bytes / 1000;

      if (this.$props.type === "image") {
        return size < 5000 ? true : false;
      }
      return size < 16000 ? true : false;
    },
    handleFileChange(event) {
      this.file = event.target.files[0];
        if (!this.checksize(this.file.size)) {
        if (this.$props.type === "image") {
          this.$toast.error("One or more files too large, > 5mb");
        } else {
          this.$toast.error("One or more files too large, > 16mb");
        }

        this.files = [];
        return;
      }


      if (
        !this.img_ext.includes(this.getextension(this.file.name)) &&
        !this.vid_ext.includes(this.getextension(this.file.name)) &&
        !this.aud_ext.includes(this.getextension(this.file.name)) &&
        !this.doc_ext.includes(this.getextension(this.file.name))
      ) {
        this.$toast.error("Unsupported content type !");
        this.file = "";
        return;
      }

      if (this.$props.file_type) {
        if (this.$props.file_type.toLowerCase() == "video") {
          if (!this.vid_ext.includes(this.getextension(this.file.name))) {
            this.$toast.error("Unsupported content type !");
            this.file = "";
            return;
          }
        }
        if (this.$props.file_type.toLowerCase() == "audio") {
          if (!this.aud_ext.includes(this.getextension(this.file.name))) {
            this.$toast.error("Unsupported content type !");
            this.file = "";
            return;
          }
        }
        if (this.$props.file_type.toLowerCase() == "image") {
          if (!this.img_ext.includes(this.getextension(this.file.name))) {
            this.$toast.error("Unsupported content type !");
            this.file = "";
            return;
          }
        }
        if (this.$props.file_type.toLowerCase() == "document") {
          if (!this.doc_ext.includes(this.getextension(this.file.name))) {
            this.$toast.error("Unsupported content type !");
            this.file = "";
            return;
          }
        }
      }

      this.filesSelectedLength = event.target.files.length;

      this.loadFile();
      this.processUpload();
    },
    loadFile() {
      let reader = new FileReader();
      reader.onload = (event) => {
        this.uploadedFile = event.target.result;
      };
      reader.readAsDataURL(this.file);
    },
    processUpload() {
      let that = this;
      this.start = true;
      var formData = new FormData();
      var xhr = new XMLHttpRequest();
      var cloudName = this.cloudinary.cloudName;
      var upload_preset = this.cloudinary.uploadPreset;
      formData.append("file", this.file);
      formData.append("resource_type", "auto");
      formData.append("upload_preset", upload_preset); // REQUIRED
      xhr.open(
        "POST",
        "https://api.cloudinary.com/v1_1/" + cloudName + "/upload"
      );
      xhr.upload.onprogress = function (e) {
        if (e.lengthComputable) {
          that.progress = Math.round((e.loaded / e.total) * 100) + "%";
        }
      };

      xhr.upload.onloadstart = function () {
        this.progress = "Starting...";
      };
      xhr.upload.onloadend = function () {
        this.progress = "Completing..";
      };
      xhr.onload = () => {
        if (xhr.status === 200) {
          // Success! You probably want to save the URL somewhere
          this.progress = "Completed";

          var response = JSON.parse(xhr.response);
          this.start = false;
          this.file = "";
          this.uploadedFileUrl = response.secure_url; // https address of uploaded file
          this.$emit("getUpload", this.uploadedFileUrl, this.$props.id);
        } else {
          this.start = false;
          this.file = "";
          alert("Upload failed. Please try again.");
        }
      };
      xhr.send(formData);
    },
  },
};
</script>

<template>
  <div>
    <form @submit.prevent="processUpload" class="position-relative">
      <div class="cursor-pointer d-flex align-items-center">
        <b-form-file
          type="file"
          class="form-control mr-3 border-0"
          id="logo"
          aria-describedby="helpId"
          placeholder="Choose an image"
          @change="handleFileChange($event)"
        ></b-form-file>
        <div v-if="start" class="spinner-start">
          <b-spinner
            class="text-dark-green"
            style="width: 1.5rem; height: 1.5rem"
            label="Spinning"
          ></b-spinner>
        </div>
        <b-avatar
          v-if="uploadedFileUrl"
          :src="uploadedFileUrl"
          blank-color="transparent"
        ></b-avatar>
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
}
</style>
<script>
export default {
  name: "CloudinaryUpload",
  data() {
    return {
      img_ext: ["jpg", "png", "jpeg", "gif"],
      vid_ext: ["mp4", "3gp", "mov", "flv"],
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

  computed: {},
  methods: {
    getextension(fileName) {
      if (fileName) {
        var regex = new RegExp("[^.]+$");
        var extension = fileName.match(regex);

        return extension[0].toLowerCase();
      }
    },
    handleFileChange(event) {
      this.file = event.target.files[0];
      if (!this.img_ext.includes(this.getextension(this.file.name))) {
        this.$toast.error("Unsupported content type !");
        return;
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
          // Success! You probably wantto save the URL somewhere
          this.progress = "Completed";
          this.$toast.success("Upload successful");
          var response = JSON.parse(xhr.response);
          this.start = false;
          this.uploadedFileUrl = response.secure_url; // https address of uploaded file
          this.$emit("getUpload", this.uploadedFileUrl);
        } else {
          this.start = false;
          alert("Upload failed. Please try again.");
        }
      };
      xhr.send(formData);
    },
  },
};
</script>

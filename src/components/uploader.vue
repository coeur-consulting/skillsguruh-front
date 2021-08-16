<template>
  <div>
    <div>
      <b-button size="sm" @click="$bvModal.show('addupload')"
        >Click to upload</b-button
      >
      <div class="" v-if="uploadedFileUrl">
        File Upload Successful
        <small class="text-dark-green truncate text-truncate link_url"
          ><em> {{ uploadedFileUrl }}</em></small
        >
      </div>
    </div>
    <b-modal id="addupload" hide-header>
      <form
        @submit.prevent="processUpload"
        class="text-center position-relative"
      >
        <div class="mb-5">
          <div class="rounded bg-light uploader border">
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
            <label class="form-group mb-0" for="logo">
              <input
                type="file"
                class="form-control hidden"
                id="logo"
                aria-describedby="helpId"
                placeholder
                @change="handleFileChange($event)"
              />

              <div class="body p-3" v-show="show == 'computer'">
                <span v-if="!uploadedFileUrl"
                  ><div class="mb-3 text-muted">Drag/Click to upload</div>
                  <b-icon
                    class="mb-2 text-muted"
                    icon="cloud-upload"
                    font-scale="4"
                  ></b-icon
                ></span>
                <div v-if="start" class="spinner-start">
                  <b-spinner
                    class="text-dark-green"
                    style="width: 4rem; height: 4rem"
                    label="Spinning"
                  ></b-spinner>
                </div>
                <b-img
                  v-if="uploadedFileUrl"
                  :src="uploadedFileUrl"
                  blank-color="transparent"
                ></b-img>
              </div>
              <div class="body p-3" v-show="show == 'url'">
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
              </div>
            </label>
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
.uploader {
  height: 400px;
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
label {
  height: 85%;
}
.body {
  height: 100%;
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
  data() {
    return {
      show: "computer",
      img_ext: ["jpg", "png", "jpg ", "gif"],
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

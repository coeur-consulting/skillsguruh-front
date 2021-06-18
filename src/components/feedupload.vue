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
            <b-modal size="sm" hide-footer centered :id="id">
              <div class="p-4">
                <div v-if="current === 'start'" class="text-center">
                  <b-spinner
                    class="text-dark-green"
                    style="width: 4rem; height: 4rem"
                    label="Spinning"
                  ></b-spinner>
                </div>
                <div v-else-if="current === 'success'" class="text-center">
                  <b-icon
                    variant="dark-green"
                    icon="check2-circle"
                    class="mb-2"
                    font-scale="4rem"
                  ></b-icon>
                  <h6>Upload Successful</h6>
                </div>

                <div v-else class="text-center">
                  <b-icon
                    variant="danger"
                    icon="x-circle"
                    class="mb-2"
                    font-scale="4rem"
                  ></b-icon>
                  <h6>Upload Failed</h6>
                </div>
              </div>
            </b-modal>
            <div
              v-if="uploadedFileUrl"
              class="fs12 text-center text-dark-green"
            >
              Ready <b-icon icon="check2-circle"></b-icon>
            </div>
          </div>

          <!-- <b-img
            v-if="uploadedFileUrl"
            :src="uploadedFileUrl"
            blank-color="transparent"
            width="100%"
            height="100%"
          ></b-img> -->
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
  props: ["id"],
  data() {
    return {
      img_ext: ["jpg", "png", "jpeg", "gif"],
      vid_ext: ["mp4", "3gp", "mov", "flv"],
      aud_ext: ["mp3"],
      doc_ext: ["docx", "pdf", "ppt", "zip"],
      filesSelectedLength: 0,
      file: [],
      filetype: "",
      uploadedFile: null,
      uploadedFileUrl: null,
      cloudinary: {
        uploadPreset: "knkccgjv",
        apiKey: "634813511968181",
        cloudName: "bizguruh-com",
      },
      progress: 0,
      start: false,
      current: "start",
    };
  },
  mounted() {},
  computed: {},
  methods: {
    getextension(fileName) {
      if (fileName) {
        var regex = new RegExp("[^.]+$");
        var extension = fileName.match(regex);

        return extension[0];
      }
    },
    handleFileChange(event) {
      this.file = event.target.files[0];

      if (
        !this.img_ext.includes(this.getextension(this.file.name)) &&
        !this.vid_ext.includes(this.getextension(this.file.name)) &&
        !this.aud_ext.includes(this.getextension(this.file.name)) &&
        !this.doc_ext.includes(this.getextension(this.file.name))
      ) {
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
      this.current = "start";

      this.$bvModal.show(this.$props.id);
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
          this.current = "success";
          this.uploadedFileUrl = response.secure_url; // https address of uploaded file
          this.$emit("getUpload", this.uploadedFileUrl, this.$props.id);
        } else {
          this.start = false;
          this.current = "fail";
          console.log(
            "🚀 ~ file: feedupload.vue ~ line 224 ~ processUpload ~ this.current",
            this.current
          );
          alert("Upload failed. Please try again.");
        }
      };
      xhr.send(formData);
    },
  },
};
</script>

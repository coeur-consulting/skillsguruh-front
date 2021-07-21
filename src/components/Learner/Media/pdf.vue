<template>
  <div>
    <div class="py-3" v-if="getextension(src) == 'pdf'">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <div class="d-flex align-items-center">
          <b-form-checkbox type="checkbox" v-model="show" />
          <b-form-select v-model="src" style="width: 20em">
            <b-form-select-option
              v-for="(item, id) in pdfList"
              :value="item"
              v-text="item"
              :key="id"
            ></b-form-select-option>
          </b-form-select>
        </div>
        <div class="d-flex align-items-center">
          <b-form-input
            class="no-focus"
            v-model.number="page"
            type="number"
            style="width: 4em"
          />
          <span class="mx-2">/</span>{{ numPages }}
        </div>
        <b-button-group size="sm" class="ml-3">
          <b-button variant="outline-secondary" @click="rotate += 90"
            >&#x27F3;</b-button
          >
          <b-button variant="outline-secondary" @click="rotate -= 90"
            >&#x27F2;</b-button
          >
          <b-button @click="$refs.pdf.print()">Print</b-button>
        </b-button-group>
      </div>
      <div class="shadow" style="width: 100%">
        <div
          v-if="loadedRatio > 0 && loadedRatio < 1"
          style="background-color: green; color: white; text-align: center"
          :style="{ width: loadedRatio * 100 + '%' }"
        >
          {{ Math.floor(loadedRatio * 100) }}%
        </div>
        <pdf
          v-if="show"
          ref="pdf"
          style="border: 1px solid #ccc"
          :src="src"
          :page="page"
          :rotate="rotate"
          @password="password"
          @progress="loadedRatio = $event"
          @error="error"
          @num-pages="numPages = $event"
          @link-clicked="page = $event"
        ></pdf>
      </div>
    </div>
    <div v-else class="p-4 text-center">
      <a
        :href="media.file"
        download=""
        target="_blank"
        rel="noopener noreferrer"
      >
        <div class="rounded shadow p-4 bg-white d_file">
          <h5 class="mb-2">Click to download document</h5>
          <b-icon
            icon="cloud-download"
            class="text-muted"
            font-scale="3rem"
          ></b-icon></div
      ></a>
    </div>
  </div>
</template>
<script>
import pdf from "vue-pdf";

export default {
  props: ["media"],
  components: {
    pdf: pdf
  },
  data() {
    return {
      doc_ext: ["docx", "pdf", "ppt", "zip"],
      show: true,
      pdfList: [],
      src: "",
      loadedRatio: 0,
      page: 1,
      numPages: 0,
      rotate: 0
    };
  },
  mounted() {
    if (this.getextension(this.media.file) == "pdf") {
      this.pdfList.unshift(this.media.file);
      this.src = this.pdfList[0];
    }
  },
  methods: {
    getextension(fileName) {
      if (fileName) {
        var regex = new RegExp("[^.]+$");
        var extension = fileName.match(regex);

        return extension[0];
      }
    },
    password: function(updatePassword, reason) {
      console.log("🚀 ~ file: pdf.vue ~ line 70 ~ reason", reason);
      updatePassword(prompt('password is "test"'));
    },
    error: function(err) {
      console.log(err);
    }
  }
};
</script>

<style scoped>
.d_file {
  border: 1px dashed #ccc;
  cursor: pointer;
}
</style>

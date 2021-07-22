import Vue from "vue";
import Cloudinary, {
  CldImage,
  CldTransformation,
  CldVideo,
  CldContext
} from "cloudinary-vue";

Vue.use(Cloudinary, {
  configuration: { cloudName: "skillsguruh" },
  components: [CldImage, CldTransformation, CldVideo, CldContext]
});

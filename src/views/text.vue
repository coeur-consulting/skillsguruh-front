<template>
 <div class="p-5 mt-5">
    <a-mentions v-model="value" @change="onChange" @select="onSelect">
    <a-mentions-option value="afc163">
      afc163
    </a-mentions-option>
    <a-mentions-option value="zombieJ">
      zombieJ
    </a-mentions-option>
    <a-mentions-option value="yesmeck">
      yesmeck
    </a-mentions-option>
  </a-mentions>
 </div>
</template>
<script>

export default {
  data() {
    return {
      value: '@afc163',
    };
  },
  methods: {
    onSelect(option) {
      console.log('select', option);
    },
    onChange(value) {
      console.log('Change:', value);
    },
  },
};
</script>

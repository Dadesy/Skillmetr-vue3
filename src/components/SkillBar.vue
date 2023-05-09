<template>
  <div class="skill-bar flex items-center">
    <div class="label w-28 mr-3">{{ label }}</div>
    <p class="w-20 mr-4">{{ value }}/{{ max }}</p>
    <progress-bar :value="value" :max="max" @update:value="onValueChange"></progress-bar>
  </div>
</template>

<script>
import ProgressBar from './UI/ProgressBar.vue';
export default {
  components: {
    ProgressBar,
  },
  props: {
    category: String,
    skill: String,
    label: String,
    value: Number,
    max: Number,
  },
  methods: {
    onValueChange(newValue) {
      this.$emit('update:skillValue', {
        category: this.category,
        skill: this.skill,
        value: newValue,
      });
    },
  },
};
</script>
<style></style>

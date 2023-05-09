<template>
  <div class="total-progress-bar">
    <div class="progress-container">
      <input
        type="range"
        :min="0"
        :max="totalMax"
        :value="totalValue"
        :style="totalProgressBarStyle"
        class="w-auto rounded-lg overflow-hidden appearance-none bg-gray-400"
      />
    </div>
    <div class="flex justify-between">
      <h3>middle</h3>
      <p>{{ totalValue }}/{{ totalMax }}</p>
      <h3>senior</h3>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    skills: {
      type: Object,
      required: true,
    },
  },
  computed: {
    totalMax() {
      let max = 0;
      for (const category in this.skills) {
        for (const skill in this.skills[category]) {
          max += this.skills[category][skill].max;
        }
      }
      return max;
    },
    totalValue() {
      let value = 0;
      for (const category in this.skills) {
        for (const skill in this.skills[category]) {
          value += this.skills[category][skill].value;
        }
      }
      return value;
    },
    totalProgressBarStyle() {
      const ratio = this.totalValue / this.totalMax;
      const hue = ratio * 120;
      return {
        background: `linear-gradient(to right, hsl(${hue}, 100%, 50%) ${ratio * 100}%, #e5e5e5 ${
          ratio * 100
        }%)`,
      };
    },
  },
};
</script>

<style scoped>
input {
  width: 100%;
  pointer-events: none;
}
</style>

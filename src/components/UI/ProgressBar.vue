<template>
  <input
    type="range"
    :min="0"
    :max="max"
    :style="{ width: max + 'px', ...progressBarStyle }"
    :value="value"
    @input="onInput"
    class="progress-bar rounded-lg overflow-hidden appearance-none bg-gray-400"
  />
</template>

<script>
export default {
  props: {
    value: {
      type: Number,
      required: true,
    },
    max: {
      type: Number,
      required: true,
    },
  },
  computed: {
    progressBarStyle() {
      const ratio = this.value / this.max;
      const hue = ratio * 120;
      return {
        background: `linear-gradient(to right, hsl(${hue}, 100%, 50%) ${ratio * 100}%, #e5e5e5 ${
          ratio * 100
        }%)`,
      };
    },
  },
  methods: {
    onInput(event) {
      this.$emit('update:value', Number(event.target.value));
    },
  },
};
</script>

<style>
input[type='range']::-webkit-slider-thumb {
  width: 15px;
  -webkit-appearance: none;
  appearance: none;
  height: 15px;
  cursor: ew-resize;
  background: #000000;
  border-radius: 50%;
}
input[type='range']::-webkit-slider-runnable-track {
  background: none;
  height: 15px;
}
</style>

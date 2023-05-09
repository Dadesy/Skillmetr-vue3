<template>
  <div class="container mx-auto py-5" id="app">
    <h1 class="text-center text-5xl font-medium py-6">SkillMeter</h1>
    <div
      v-for="(category, categoryName) in skills"
      :key="categoryName"
      class="inline-flex items-center my-5"
    >
      <h3 class="w-16">{{ categoryName }}</h3>

      <div>
        <div v-for="(skill, skillName) in category" :key="skillName" class="my-2">
          <skill-bar
            :category="categoryName"
            :skill="skillName"
            :label="skillName"
            :value="skill.value"
            :max="skill.max"
            @update:skillValue="updateSkillValue"
          ></skill-bar>
        </div>
      </div>
    </div>
    <total-progress-bar :skills="skills" />
  </div>
</template>

<script>
// import axios from 'axios'; // Вариант с использованием библиотеки axios

import SkillBar from './components/SkillBar.vue';
import TotalProgressBar from './components/TotalProgressBar.vue';
export default {
  components: {
    SkillBar,
    TotalProgressBar,
  },
  data() {
    return {
      skills: {
        ENV: {
          Docker: {
            value: 100,
            max: 500,
          },
          Linux: {
            value: 170,
            max: 350,
          },
          Bash: {
            value: 80,
            max: 350,
          },
        },
        FRONT: {
          VueJs: {
            value: 750,
            max: 1000,
          },
          ReactJs: {
            value: 100,
            max: 1000,
          },
          CSS: {
            value: 350,
            max: 400,
          },
        },
        PHP: {
          yii2: {
            value: 350,
            max: 500,
          },
          Symphony: {
            value: 100,
            max: 500,
          },
          Legacy: {
            value: 700,
            max: 800,
          },
        },
        DB: {
          MySql: {
            value: 115,
            max: 700,
          },
          MariaDB: {
            value: 350,
            max: 500,
          },
          PostgreSql: {
            value: 50,
            max: 500,
          },
        },
      },
    };
  },
  methods: {
    async updateSkillValue({ category, skill, value }) {
      this.skills[category][skill].value = value;

      // Отправка готового value без промежутков (Защита от DDOS)
      clearTimeout(this.timeoutId);

      this.timeoutId = setTimeout(async () => {
        try {
          const response = await fetch('http://localhost:8081', {
            method: 'PUT',
            headers: {
              'Content-Type': 'application/json',
            },
            body: JSON.stringify({
              [skill]: value,
            }),
          });

          if (response.ok) {
            const responseData = await response.json();
            console.log(responseData);
          } else {
            console.error(`Ошибка: ${response.status}`);
          }
        } catch (error) {
          console.error(`Ошибка сети: ${error}`);
        }
      }, 500); // Задержка в 0.5 секунд
    },

    // Вариант с использованием библиотеки axios
    // async updateSkillValue({ category, skill, value }) {
    //   this.skills[category][skill].value = value;

    //   clearTimeout(this.timeoutId);

    //   this.timeoutId = setTimeout(async () => {
    //     try {
    //       const response = await axios.put('http://localhost:8081', {
    //         [skill]: value,
    //       });
    //       console.log(response.data);
    //     } catch (error) {
    //       console.error(error);
    //     }
    //   }, 500); // Задержка в 0.5 секунд
    // },
  },
};
</script>

<style scoped></style>

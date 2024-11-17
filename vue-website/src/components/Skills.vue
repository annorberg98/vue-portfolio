<!-- Skills.vue -->
<template>
    <section class="skills-section">
      <h3>Skills</h3>
      <ul>
        <li v-for="(skill, index) in skills" :key="index" class="skill-item">
          {{ skill }}
        </li>
      </ul>
    </section>
  </template>
  
  <script lang="ts">
  import { defineComponent } from 'vue';
  
  export default defineComponent({
    data() {
      return {
        skills: [
          "Azure Integration Services",
          "BizTalk Server",
          ".NET",
          "Automation",
        ],
      };
    },
  });
  </script>
  
  <style scoped>
.skills-section {
  background-color: #383c44;
  padding: 15px;
  color: #f9f9f9;
}
.skill-item {
  color: #ffcc00;
  font-size: 18px;
}
  </style>
  
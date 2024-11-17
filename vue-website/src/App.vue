<!-- src/App.vue -->
<template>
  <div id="app">
    <Intro />
    <WorkExperience />
    <Education />
    <Skills />
    <Certifications />
    <HobbiesProjects />
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import Intro from './components/Intro.vue';
import WorkExperience from './components/WorkExperience.vue';
import Education from './components/Education.vue';
import Skills from './components/Skills.vue';
import Certifications from './components/Certifications.vue';
import HobbiesProjects from './components/HobbiesProjects.vue';

export default defineComponent({
  components: {
    Intro,
    WorkExperience,
    Education,
    Skills,
    Certifications,
    HobbiesProjects
  }
});
</script>

<style>
#app {
  display: flex;
  flex-direction: column;
  align-items: center;
  /*padding: 20px;*/
  background-color: #f5f5f5;
}
</style>

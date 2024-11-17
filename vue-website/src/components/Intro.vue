<!-- src/components/Intro.vue -->
<template>
  <section class="intro">
    <h2>Introduction</h2>
    <p>
      Hi! I'm a consultant in software development with expertise in Azure integration services and BizTalk Server. I love solving complex problems and creating efficient, scalable solutions. Welcome to my portfolio!
    </p>
  </section>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
  name: 'Intro',
});
</script>

<style scoped>
.intro {
  padding: 20px;
  width: 100%; /* Full width */
  max-width: 900px;
  margin: auto;
  background-color: #282c34; /* Dark background */
  color: white; /* White text */
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

h2 {
  text-align: center;
  font-size: 28px;
  color: #f9f9f9; /* Lighter color for headings */
}

p {
  font-size: 18px;
  text-align: center;
  color: #f1f1f1; /* Lighter text for body */
}
</style>

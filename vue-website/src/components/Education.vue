<template>
  <section class="education">
    <h2>Education</h2>
    <div v-for="(edu, index) in education" :key="index" class="education-item">
      <div class="education-details">
        <h3>{{ edu.institution }}</h3>
        <p class="degree">{{ edu.degree }} - <span class="field-of-study">{{ edu.fieldOfStudy }}</span></p>
        <p class="dates">
          <span>{{ formatDate(edu.startDate) }} - {{ formatDate(edu.endDate) }}</span>
        </p>
      </div>
    </div>
  </section>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

interface EducationItem {
  institution: string;
  degree: string;
  fieldOfStudy: string;
  startDate: Date;
  endDate: Date;
  logo: string;
}

export default defineComponent({
  data() {
    return {
      education: [
        {
          institution: 'Malmö University',
          degree: 'Bachelor of Science - BSc, Computer and Information Science',
          fieldOfStudy: 'Information Architecture',
          startDate: new Date('2017-09-01'),
          endDate: new Date('2020-11-01'),
        }
      ] as EducationItem[]
    };
  },
  methods: {
    formatDate(date: Date): string {
      const options: Intl.DateTimeFormatOptions = { month: 'long', year: 'numeric' };
      return date.toLocaleDateString('en-US', options);
    }
  }
});
</script>

<style scoped>
.education {
  padding: 20px;
  width: 100%;
  max-width: 900px;
  margin: auto;
  background-color: #282c34;
  color: white;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

h2 {
  text-align: center;
  font-size: 28px;
  color: #f9f9f9;
  margin-bottom: 20px;
}

.education-item {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
  padding: 15px;
  background-color: #383c44;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.institution-logo {
  width: 50px;
  height: 50px;
  margin-right: 15px;
}

.education-details h3 {
  margin: 0;
  font-size: 18px;
  font-weight: bold;
  color: #f9f9f9;
}

.degree {
  font-size: 16px;
  color: #ffcc00;
}

.field-of-study {
  font-style: italic;
  color: #f1f1f1;
}

.dates {
  font-size: 14px;
  color: #f1f1f1;
}
</style>

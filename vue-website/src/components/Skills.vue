<template>
  <section class="skills-section">
    <h3>Skills</h3>
    <div class="skills-container">
      <div v-for="(skill, index) in skills" :key="index" class="skill-item">
        <div class="skill-icon">
          <!-- You can add icons here, for now, we use a simple dot icon -->
          <span class="dot"></span>
        </div>
        <span class="skill-name">{{ skill }}</span>
      </div>
    </div>
  </section>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
  data() {
    return {
      skills: [
        "Azure",
        "BizTalk Server",
        "Power Platform",
        ".NET",
        "Terraform"
      ],
    };
  },
});
</script>

<style scoped>
/* Skills Section Container */
.skills-section {
  background-color: #383c44;
  padding: 25px;
  color: #f9f9f9;
  /*border-radius: 8px;*/
  /*box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);*/
  width: 100%;
  /*max-width: 800px;*/
  margin: auto;
  text-align: center;
}

/* Section Heading */
.skills-section h3 {
  font-size: 24px;
  font-weight: 600;
  color: #ffcc00; /* Highlighted yellow */
  margin-bottom: 20px;
}

/* Container for Skills */
.skills-container {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 15px;
}

/* Individual Skill Item */
.skill-item {
  display: flex;
  align-items: center;
  gap: 10px;
  background-color: #444c56; /* Darker background for skill items */
  padding: 10px 15px;
  border-radius: 50px; /* Rounded border for each skill */
  transition: all 0.3s ease;
  cursor: pointer;
}

/* Hover Effect */
.skill-item:hover {
  background-color: #f1f1f1; /* Light background on hover */
  color: #333; /* Change text color on hover */
  transform: translateY(-5px); /* Lift effect */
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* Shadow effect */
}

/* Skill Icon */
.skill-icon .dot {
  width: 12px;
  height: 12px;
  background-color: #ffcc00;
  border-radius: 50%;
  display: inline-block;
}

/* Skill Name */
.skill-name {
  color: #ffcc00;
  font-size: 16px;
  font-weight: 500;
  text-transform: capitalize;
}

/* Responsiveness */
@media (max-width: 768px) {
  .skills-container {
    justify-content: space-around;
  }

  .skill-item {
    padding: 8px 12px;
  }
}
</style>

<!-- src/components/WorkExperience.vue -->
<template>
  <section class="work-experience">
    <h2>Work Experience</h2>

    <!-- Current Employment: Sogeti -->
    <div v-for="(job, index) in workExperience" :key="index" class="job">
      <div class="job-header">
        <div class="job-info">
          <h3>{{ job.company }}</h3>
          <p class="duration">{{ job.duration }}</p>
          <p class="location">{{ job.location }}</p>
          <p class="work-type">{{ job.workType }}</p>
        </div>
      </div>

      <!-- Main Role -->
      <div class="main-role">
        <h4>{{ job.mainRole }}</h4>
        <p class="main-role-duration">{{ job.mainRoleDuration }}</p>
        <p class="main-role-description">{{ job.mainRoleDescription }}</p>
      </div>

      <!-- Assignments (if any) -->
      <div v-if="job.assignments && job.assignments.length" class="assignments">
        <h4>Assignments:</h4>
        <div v-for="(assignment, idx) in job.assignments" :key="idx" class="assignment">
          <h5>{{ assignment.role }}</h5>
          <p class="assignment-duration">{{ assignment.duration }}</p>
          <p class="assignment-description">{{ assignment.description }}</p>
        </div>
      </div>
    </div>
  </section>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

interface Assignment {
  role: string;
  duration: string;
  description: string;
  skills: string;
}

interface Job {
  company: string;
  duration: string;
  location: string;
  workType: string;
  mainRole: string;
  mainRoleDuration: string;
  mainRoleDescription: string;
  mainRoleSkills: string;
  assignments?: Assignment[]; // Optional assignments for each job
}

export default defineComponent({
  data() {
    return {
      workExperience: [
        // Current Employment at Sogeti
        {
          company: "Sogeti",
          duration: "Nov 2022 - Present · 2 yrs 1 mo",
          location: "Malmo, Skåne County, Sweden",
          workType: "Full-time · Hybrid",
          mainRole: "Software Engineer",
          mainRoleDuration: "Nov 2022 - Present",
          mainRoleDescription: "Software Engineering Consultant with focus on Integration and Automation.",
          assignments: [
            {
              role: "Integration Specialist",
              duration: "Apr 2024 - Present · 8 mos",
              description: "Consulting assignment as an IT specialist in Integration, Automation, Data, and Development platforms, where I serve as Product Owner (PO) and Solution Architect. I oversee, develop, and maintain these platforms, ensuring seamless integration, automation, and efficient operation across all domains.",
            },
            {
              role: "Azure Integration Engineer",
              duration: "Feb 2024 - Apr 2024 · 3 mos",
              description: "Consulting Assignment as Integration Engineer. In this role, I contributed to designing and implementing integrations between the client’s HR system and Dynamics 365. My responsibilities included setting up infrastructure in Azure using Terraform, developing integrations with cloud-native resources and .NET, and configuring a CI/CD pipeline using Azure DevOps.",
            },
            {
              role: "BizTalk Developer",
              duration: "Nov 2022 - Nov 2023 · 1 yr 1 mo",
              description: "Consulting engagement as a BizTalk Developer, responsible for designing and implementing integrations between internal systems, external suppliers, and government agencies.",
            },
          ],
        },
        
        // Previous Employment at Sprinta
        {
          company: "Sprinta",
          duration: "Oct 2020 - Nov 2022 · 2 yrs 2 mos",
          location: "Malmö, Skåne, Sverige",
          workType: "Full-time",
          mainRole: "Software Developer",
          mainRoleDuration: "Oct 2020 - Nov 2022",
          mainRoleDescription: "Software Developer, contributing to development projects and integrating various systems.",
          assignments: [
            {
              role: "BizTalk Developer",
              duration: "Feb 2021 - Nov 2022 · 1 yr 10 mos",
              description: "Designed and implemented integrations with Microsoft BizTalk Server and other systems.",
            },
          ],
        },
      ] as Job[],
    };
  }
});
</script>

<style scoped>
.work-experience {
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
  margin-bottom: 20px;
}

.job {
  padding: 15px;
  background-color: #3a3f47; /* Darker background for each job entry */
  border-radius: 8px;
  margin-bottom: 20px;
}

.job-header {
  display: flex;
  align-items: center;
  gap: 15px;
}

.company-logo {
  width: 50px;
  height: 50px;
  border-radius: 50%;
}

.job-info {
  display: flex;
  flex-direction: column;
}

h3 {
  font-size: 22px;
  color: #ffcc00; /* Yellow for job title */
  margin-bottom: 5px;
}

.duration,
.location,
.work-type {
  font-size: 16px;
  color: #f1f1f1;
}

.main-role h4 {
  font-size: 20px;
  color: #ffcc00;
}

.main-role-duration,
.main-role-description,
.main-role-skills {
  font-size: 16px;
  color: #f1f1f1;
}

.assignments {
  margin-top: 20px;
  background-color: #444c56; /* Darker background for assignments section */
  padding: 15px;
  border-radius: 8px;
}

.assignments h4 {
  font-size: 20px;
  color: #ffcc00;
}

.assignment {
  margin-bottom: 15px;
}

.assignment h5 {
  font-size: 18px;
  color: #ffcc00;
}

.assignment-duration,
.assignment-description,
.assignment-skills {
  font-size: 16px;
  color: #f1f1f1;
}
</style>

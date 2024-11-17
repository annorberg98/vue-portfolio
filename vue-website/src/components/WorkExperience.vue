<!-- src/components/WorkExperience.vue -->
<template>
  <section class="work-experience">
    <h2>Work Experience</h2>

    <!-- Current Employment: Sogeti -->
    <div v-for="(job, index) in workExperience" :key="index" class="job">
      <div class="job-header">
        <div class="job-info">
          <h3>{{ job.company }}</h3>
          <p class="dates">
            {{ job.start_date.toLocaleDateString() }} -
            {{ job.end_date ? job.end_date.toLocaleDateString() : "Present" }}
          </p>
          <p class="duration">Duration: {{ calculateDuration(job.start_date, job.end_date) }}</p>
        </div>
      </div>

      <!-- Main Role -->
      <div class="main-role">
        <h4>{{ job.mainRole }}</h4>
        <p class="main-role-description">{{ job.mainRoleDescription }}</p>
      </div>

      <!-- Assignments (if any) -->
      <div v-if="job.assignments && job.assignments.length" class="assignments">
        <h4>Assignments:</h4>
        <div v-for="(assignment, idx) in job.assignments" :key="idx" class="assignment">
          <h5>{{ assignment.role }}</h5>
          <p class="dates">
            {{ assignment.start_date.toLocaleDateString() }} -
            {{ assignment.end_date ? assignment.end_date.toLocaleDateString() : "Present" }}
          </p>
          <p class="duration">Duration: {{ calculateDuration(assignment.start_date, job.end_date) }}</p>
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
  //duration: string;
  start_date: Date;
  end_date: Date | null;
  description: string;
  skills: string;
}

interface Job {
  company: string;
  //duration: string;
  start_date: Date;
  end_date: Date | null;
  mainRole: string;
  mainRoleDuration: string;
  mainRoleDescription: string;
  //mainRoleSkills: string;
  assignments?: Assignment[]; // Optional assignments for each job
}

export default defineComponent({
  methods: {
    calculateDuration(start_date: Date, end_date: Date | null): string {
      const end = end_date || new Date(); //Use current date if end_Date is null
      const diff = end.getTime() - start_date.getTime();
      
      const totalMonths = Math.floor(diff / (1000 * 60 * 60 * 24 * 30.44)); // Approximation
      const years = Math.floor(totalMonths / 12);
      const months = totalMonths % 12;

      let duration = "";
      if (years > 0) duration += `${years} year${years > 1 ? "s" : ""}`;
      if (months > 0) duration += `${years > 0 ? " and " : ""}${months} month${months > 1 ? "s" : ""}`;
      return duration;
    },
  },
  data() {
    return {
      workExperience: [
        // Current Employment at Sogeti
        {
          company: "Sogeti",
          start_date: new Date('2022-11-01'),
          mainRole: "Software Engineer",
          mainRoleDuration: "Nov 2022 - Present",
          mainRoleDescription: "Software Engineering Consultant with focus on Integration and Automation.",
          assignments: [
            {
              role: "Integration Specialist",
              start_date: new Date('2024-04-02'),
              description: "Consulting assignment as an IT specialist in Integration, Automation, Data, and Development platforms, where I serve as Product Owner (PO) and Solution Architect. I oversee, develop, and maintain these platforms, ensuring seamless integration, automation, and efficient operation across all domains.",
            },
            {
              role: "Azure Integration Engineer",
              start_date: new Date('2024-02-01'),
              end_date: new Date('2024-04-04'),
              description: "Consulting Assignment as Integration Engineer. In this role, I contributed to designing and implementing integrations between the client’s HR system and Dynamics 365. My responsibilities included setting up infrastructure in Azure using Terraform, developing integrations with cloud-native resources and .NET, and configuring a CI/CD pipeline using Azure DevOps.",
            },
            {
              role: "BizTalk Developer",
              start_date: new Date('2022-11-01'),
              end_date: new Date('2023-11-31'),
              description: "Consulting engagement as a BizTalk Developer, responsible for designing and implementing integrations between internal systems, external suppliers, and government agencies.",
            },
          ],
        },
        
        // Previous Employment at Sprinta
        {
          company: "Sprinta",
          start_date: new Date('2020-10-04'),
          end_date: new Date('2022-10-31'),
          mainRole: "Software Developer",
          mainRoleDuration: "Oct 2020 - Nov 2022",
          mainRoleDescription: "Software Developer, contributing to development projects and integrating various systems.",
          assignments: [
            {
              role: "BizTalk Developer",
              start_date: new Date('2021-02-10'),
              end_date: new Date('2022-10-31'),
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
/* Container for work experience section */
.work-experience {
  padding: 20px;
  width: 100%; /* Full width */
  max-width: 900px; /* Limit max width */
  margin: auto;
  background-color: #282c34; /* Dark background */
  color: white; /* White text */
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Subtle shadow */
  /*border-radius: 8px; */
}

/* Section heading */
h2 {
  text-align: center;
  font-size: 28px;
  color: #f9f9f9; /* Lighter color for headings */
  margin-bottom: 20px;
}

/* Individual job container */
.job {
  padding: 15px;
  background-color: #3a3f47; /* Darker background for each job entry */
  border-radius: 8px;
  margin-bottom: 20px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2); /* Slight shadow for jobs */
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.job:hover {
  transform: scale(1.02);
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
}

/* Job header section with logo and details */
.job-header {
  display: flex;
  align-items: center;
  gap: 15px;
  margin-bottom: 10px;
}

.company-logo {
  width: 50px;
  height: 50px;
  border-radius: 50%; /* Circular logo */
  object-fit: cover; /* Ensure image fits nicely */
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Subtle shadow for logo */
}

.job-info {
  display: flex;
  flex-direction: column;
}

/* Job title styling */
h3 {
  font-size: 22px;
  color: #ffcc00; /* Yellow for job title */
  margin: 0;
}

/* Additional job details */
.duration,
.location,
.work-type {
  font-size: 16px;
  color: #f1f1f1;
  margin: 3px 0; /* Small spacing between details */
}

/* Main role styling */
.main-role h4 {
  font-size: 20px;
  color: #ffcc00; /* Yellow for role title */
  margin: 10px 0;
}

.main-role-duration,
.main-role-description,
.main-role-skills {
  font-size: 16px;
  color: #f1f1f1;
  margin: 5px 0; /* Add spacing between paragraphs */
}

/* Assignments section styling */
.assignments {
  margin-top: 20px;
  background-color: #444c56; /* Darker background for assignments section */
  padding: 15px;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Subtle shadow for assignment container */
}

/* Assignment heading */
.assignments h4 {
  font-size: 20px;
  color: #ffcc00; /* Yellow for assignment heading */
  margin-bottom: 10px;
}

/* Individual assignment styling */
.assignment {
  margin-bottom: 15px;
  padding: 10px;
  background-color: #3a3f47; /* Slightly darker background for assignments */
  border-radius: 8px;
}

.assignment:hover {
  background-color: #4b535d; /* Slight hover effect for assignments */
}

/* Assignment details */
.assignment h5 {
  font-size: 18px;
  color: #ffcc00; /* Yellow for assignment title */
  margin: 5px 0;
}

.assignment-duration,
.assignment-description,
.assignment-skills {
  font-size: 16px;
  color: #f1f1f1;
  margin: 3px 0; /* Small spacing for readability */
}

/* General responsiveness */
@media (max-width: 768px) {
  .job-header {
    flex-direction: column; /* Stack items on smaller screens */
    align-items: flex-start;
  }

  .company-logo {
    margin-bottom: 10px; /* Add spacing for stacked layout */
  }
}
</style>

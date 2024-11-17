<template>
  <section class="hobbies-projects" ref="projectsSection">
    <h2>Hobbies & Projects</h2>

    <div v-if="loading" class="loading">
      <p>Loading projects...</p>
    </div>

    <div v-if="error" class="error">
      <p>Error fetching GitHub data: {{ error }}</p>
    </div>

    <div v-if="projects.length > 0" class="project-list">
      <div class="project" v-for="(project, index) in projects" :key="index">
        <h3>{{ project.name }}</h3>
        <p>{{ project.description }}</p>
        <a :href="project.html_url" target="_blank">View on GitHub</a>
      </div>
    </div>
  </section>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted, onBeforeUnmount } from 'vue';
import axios from 'axios';

interface Project {
  name: string;
  description: string;
  html_url: string;
}

export default defineComponent({
  data() {
    return {
      projects: [] as Project[],
      loading: true,
      error: null as string | null,
      selectedRepos: [
        'Selfhosting',
        'TokenBasedAuthentication',
        'vue-portfolio',
      ] as string[], // Replace with your selected GitHub repos
      observer: null as IntersectionObserver | null,
    };
  },
  methods: {
    // Function to generate a random delay
    generateRandomDelay() {
      return Math.random() * (2 - 0.5) + 0.5; // Between 0.5 and 2 seconds
    },

    async fetchProjects() {
      const githubUsername = 'annorberg98'; // Replace with your GitHub username

      // Check if the selected repositories data is in localStorage
      const storedProjects = localStorage.getItem('projects');
      const storedRepos = localStorage.getItem('selectedRepos');

      // If there's no stored data or if the selectedRepos don't match, fetch new data
      if (storedProjects && storedRepos && JSON.parse(storedRepos).toString() === this.selectedRepos.toString()) {
        this.projects = JSON.parse(storedProjects);
        this.loading = false;
        console.log('Loaded projects from localStorage.');
        return;
      }

      try {
        // Simulate a random delay before fetching the projects
        const delay = this.generateRandomDelay();
        console.log(`Waiting for ${delay} seconds before making the request...`);
        await new Promise(resolve => setTimeout(resolve, delay * 1000)); // Convert to ms

        // Fetch each repo individually using Promise.allSettled
        const projectPromises = this.selectedRepos.map((repoName) =>
          axios.get(`https://api.github.com/repos/${githubUsername}/${repoName}`)
            .then(response => ({
              name: response.data.name,
              description: response.data.description,
              html_url: response.data.html_url,
            }))
            .catch((err) => {
              console.error(`Error fetching ${repoName}:`, err);
              return null; // Return null for failed requests
            })
        );

        // Wait for all promises to settle
        const results = await Promise.allSettled(projectPromises);

        // Filter out failed requests (null values)
        this.projects = results
          .filter(result => result.status === 'fulfilled' && result.value !== null)
          .map((result: any) => result.value);

        if (this.projects.length === 0) {
          this.error = 'No projects could be fetched';
        } else {
          // Store the fetched projects and selected repos in localStorage
          localStorage.setItem('projects', JSON.stringify(this.projects));
          localStorage.setItem('selectedRepos', JSON.stringify(this.selectedRepos));
          console.log('Projects stored in localStorage.');
        }

        this.loading = false;
      } catch (err) {
        console.error("Error fetching projects:", err);
        this.error = 'Failed to fetch data from GitHub';
        this.loading = false;
      }
    },

    // Callback function for the intersection observer
    handleIntersection(entries: IntersectionObserverEntry[]) {
      const entry = entries[0];
      if (entry.isIntersecting) {
        // If the component is in view, fetch projects
        console.log("Component is in view, fetching projects...");
        this.fetchProjects();
        this.observer.disconnect(); // Disconnect observer once the request is made
      }
    },
  },
  mounted() {
    console.log("Mounted: Initializing IntersectionObserver...");

    // Check if the ref is available and create an IntersectionObserver
    const projectsSection = this.$refs.projectsSection as HTMLElement;
    if (projectsSection) {
      this.observer = new IntersectionObserver(this.handleIntersection, {
        rootMargin: '0px',
        threshold: 0.5, // Trigger when 50% of the component is in the viewport
      });

      // Start observing the component
      this.observer.observe(projectsSection);
    } else {
      console.error("Error: projectsSection ref is not available.");
    }
  },
  beforeUnmount() {
    console.log("Before unmount: Disconnecting observer...");

    // Disconnect the observer when the component is destroyed
    if (this.observer) {
      this.observer.disconnect();
    }
  },
});
</script>

<style scoped>
.hobbies-projects {
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

.loading,
.error {
  text-align: center;
  font-size: 20px;
  color: #f1f1f1;
}

.project-list {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.project {
  padding: 20px;
  background-color: #383c44;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
}

.project:hover {
  transform: scale(1.02);
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
}

.project h3 {
  font-size: 22px;
  color: #ffcc00;
  margin-bottom: 10px;
  text-align: center;
}

.project p {
  font-size: 18px;
  color: #f1f1f1;
  text-align: center;
}

.project a {
  font-size: 18px;
  color: #ffcc00;
  text-decoration: none;
  text-align: center;
  display: block;
  margin-top: 10px;
}

.project a:hover {
  text-decoration: underline;
}

.loading p {
  font-size: 20px;
  color: #007BFF;
}

.error p {
  font-size: 20px;
  color: red;
}
</style>

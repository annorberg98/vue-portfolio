<template>
  <section class="hobbies-projects" ref="projectsSection">
    <h2>Hobbies & Projects</h2>

    <div v-if="loading" class="loading">
      <p>Loading projects...</p>
    </div>

    <div v-if="error" class="error">
      <p>Error fetching GitHub data: {{ error }}</p>
    </div>

    <div v-else class="project-list">
      <div v-for="(project, index) in projects" :key="index" class="project">
        <div class="project-header">
          <h3>
            <a :href="project.html_url" target="_blank" rel="noopener noreferrer">{{ project.name }}</a>
          </h3>
          <p v-if="project.last_commit_date" class="last-commit">
            Last Commit: {{ new Date(project.last_commit_date).toLocaleDateString() }}
          </p>
        </div>
        <p>{{ project.description || 'No description available.' }}</p>
        <a :href="project.html_url" target="_blank" rel="noopener noreferrer">View Repository</a>
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
  last_commit_date: string | null;
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
        const delay = this.generateRandomDelay();
        console.log(`Waiting for ${delay} seconds before making the request...`);
        await new Promise((resolve) => setTimeout(resolve, delay * 1000));

        const projectPromises = this.selectedRepos.map(async (repoName) => {
          try {
            const repoResponse = await axios.get(`https://api.github.com/repos/${githubUsername}/${repoName}`, {
              //headers: token ? { Authorization: `Bearer ${token}` } : {},
            });

            // Fetch the latest commit for the repository
            const commitsResponse = await axios.get(
              `https://api.github.com/repos/${githubUsername}/${repoName}/commits?per_page=1`,
              //{ headers: token ? { Authorization: `Bearer ${token}` } : {} }
            );

            return {
              name: repoResponse.data.name,
              description: repoResponse.data.description,
              html_url: repoResponse.data.html_url,
              last_commit_date: commitsResponse.data[0]?.commit.committer.date || null,
            };
          } catch (err) {
            console.error(`Error fetching data for ${repoName}:`, err);
            return null;
          }
        });

        const results = await Promise.allSettled(projectPromises);

        this.projects = results
          .filter((result) => result.status === 'fulfilled' && result.value !== null)
          .map((result: any) => result.value);

        if (this.projects.length === 0) {
          this.error = 'No projects could be fetched';
        } else {
          localStorage.setItem('projects', JSON.stringify(this.projects));
          localStorage.setItem('selectedRepos', JSON.stringify(this.selectedRepos));
          console.log('Projects stored in localStorage.');
        }

        this.loading = false;
      } catch (err) {
        console.error('Error fetching projects:', err);
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
  margin: 20px auto;
  background-color: #282c34;
  color: white;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
  border-radius: 8px;
}

h2 {
  text-align: center;
  font-size: 28px;
  color: #f9f9f9;
  margin-bottom: 30px;
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
  position: relative;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.project:hover {
  transform: scale(1.02);
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
}

.project-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
  flex-wrap: wrap; /* Ensures proper layout on smaller screens */
}

.project h3 {
  font-size: 22px;
  color: #ffcc00;
  margin: 0;
}

.project h3 a {
  color: #61dafb;
  text-decoration: none;
}

.project h3 a:hover {
  text-decoration: underline;
}

.project p {
  font-size: 18px;
  color: #f1f1f1;
  text-align: center;
}

.project a {
  font-size: 18px;
  color: #61dafb;
  text-decoration: none;
  display: block;
  margin-top: 10px;
  text-align: center;
}

.project a:hover {
  text-decoration: underline;
}

.last-commit {
  font-size: 14px;
  color: #bbb;
  margin-left: auto; /* Pushes it to the right in the flex container */
  opacity: 0.5;
}

.error p {
  font-size: 20px;
  color: red;
}

.loading p {
  font-size: 20px;
  color: #007BFF;
}

</style>

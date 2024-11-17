<template>
  <section class="skills-certifications">
    <h2>Skills & Certifications</h2>

    <div class="list-container">
      <!-- Certifications Carousel Section -->
      <div class="carousel-container">
        <h3>Certifications</h3>
        <div class="carousel">
          <div
            v-for="(cert, index) in sortedCertifications"
            :key="index"
            class="certification"
          >
            <img :src="cert.image" alt="Certification Logo" class="cert-logo" />
            <p class="cert-title">{{ cert.title }}</p>
            <p class="cert-date">{{ formatIssuedDate(cert.issued) }}</p>
            <!-- Add the renewed date if it exists -->
            <p v-if="cert.renewed" class="cert-renewed">Renewed: {{ formatIssuedDate(cert.renewed) }}</p>
            <!-- Add a link to verify the certification -->
            <a v-if="cert.credentialLink" :href="cert.credentialLink" target="_blank" class="cert-link">
              Verify Online
            </a>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import az204Logo from '@/assets/images/az-204.png';
import az900Logo from '@/assets/images/az-900.png';
import sc900Logo from '@/assets/images/sc-900.png';
import pl900Logo from '@/assets/images/pl-900.png';

interface Item {
  name: string;
}

interface Certification {
  title: string;
  image: string; // Path to certification logo/image
  issued: Date; // Date object for when the certification was issued
  renewed?: Date; // Optional Date object for when the certification was renewed
  credentialLink?: string; // Optional link to verification page
}

export default defineComponent({
  data() {
    return {
      skills: [
        "Azure Integration Services",
        "BizTalk Server",
        ".NET",
        "Automation",
      ] as string[], // Changed to simple string array
      certifications: [
        {
          title: 'AZ-900: Microsoft Azure Fundamentals',
          image: az900Logo,
          issued: new Date('2023-07-24'),
          difficulty: 3,
          credentialLink: 'https://learn.microsoft.com/api/credentials/share/en-us/NorbergAnton-3184/526D81E93AA197EC?sharingId=475FA9AFD74F59E'
        },
        {
          title: 'AZ-204: Developing Solutions for Microsoft Azure',
          image: az204Logo, // Use the imported logo
          issued: new Date('2024-02-28'),
          difficulty: 2,
          credentialLink: 'https://learn.microsoft.com/api/credentials/share/en-us/NorbergAnton-3184/44C27608E2280283?sharingId=475FA9AFD74F59E'
        },
        {
          title: 'SC-900: Microsoft Security, Compliance, and Identity Fundamentals',
          image: sc900Logo,
          issued: new Date('2024-08-07'),
          difficulty: 3,
          credentialLink: 'https://learn.microsoft.com/api/credentials/share/en-us/NorbergAnton-3184/361BADA7639DAF0E?sharingId=475FA9AFD74F59E'
        },
        {
          title: 'PL-900: Microsoft Power Platform Fundamentals',
          image: pl900Logo,
          issued: new Date('2024-10-25'),
          difficulty: 3,
          credentialLink: 'https://learn.microsoft.com/api/credentials/share/en-us/NorbergAnton-3184/6226DF3F60DE3AB5?sharingId=475FA9AFD74F59E'
        },
      ] as Certification[],
    };
  },
    
  computed: {
    sortedCertifications() {
      return this.certifications
        .sort((a, b) => {
          // First, sort by difficulty (descending: 1 -> 3 -> 2)
          if (a.difficulty !== b.difficulty) {
            return a.difficulty - b.difficulty;
          }
          
          // If difficulty is the same, sort by renewal or issue date (descending)
          const aDate = a.renewed || a.issued;
          const bDate = b.renewed || b.issued;
          
          return bDate.getTime() - aDate.getTime();
        });
    }
  },
  methods: {
    formatIssuedDate(date: Date): string {
      const options: Intl.DateTimeFormatOptions = { month: 'long', year: 'numeric' };
      return date.toLocaleDateString('en-US', options);
    }
  }
});
</script>


<style scoped>
.skills-certifications {
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

.list-container {
  display: flex;
  flex-direction: column;
  gap: 40px;
}

.list {
  padding: 15px;
  background-color: #383c44;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

h3 {
  font-size: 22px;
  margin-bottom: 10px;
  text-align: center;
  color: #f9f9f9;
}

ul {
  list-style-type: none;
  padding: 0;
}

.item {
  margin-bottom: 15px;
  text-align: center;
}

.item-name {
  font-size: 18px;
  color: #ffcc00;
}

.carousel-container {
  padding: 15px;
  background-color: #383c44;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.carousel {
  display: flex;
  overflow-x: auto;
  gap: 20px;
  padding-bottom: 10px;
}

.certification {
  flex: 0 0 auto;
  text-align: center;
  min-width: 150px;
  max-width: 200px;
}

.cert-logo {
  width: 100%;
  height: auto;
  border-radius: 8px;
  margin-bottom: 10px;
}

.cert-title {
  font-size: 16px;
  color: #ffcc00;
  margin-bottom: 5px;
}

.cert-date {
  font-size: 14px;
  color: #f1f1f1;
}

.cert-renewed {
  font-size: 14px;
  color: #f1f1f1;
  font-style: italic;
}

.cert-link {
  font-size: 14px;
  color: #ffcc00;
  text-decoration: none;
  display: block;
  margin-top: 10px;
  text-align: center;
}

.cert-link:hover {
  text-decoration: underline;
}
</style>

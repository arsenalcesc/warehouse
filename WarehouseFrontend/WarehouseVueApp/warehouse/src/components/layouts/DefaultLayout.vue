<template>
  <!-- Navbar -->
  
  <nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
      <!-- Toggler for Offcanvas (visible only on small screens) -->
      <button class="navbar-toggler d-lg-none" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebarOffcanvas" aria-controls="sidebarOffcanvas">
        <span class="navbar-toggler-icon"></span>
      </button>

      <RouterLink class="nav-link" to="/">
        <a class="navbar-brand stylish-brand">Warehouse</a>
      </RouterLink>
      

      <div class="collapse navbar-collapse" id="navbarNav">
        <!-- Navbar content for larger screens -->
        <!-- ... -->
      </div>
    </div>
  </nav>

  <!-- Offcanvas Side Panel for Small Screens -->
  <div class="offcanvas offcanvas-start d-lg-none" tabindex="-1" id="sidebarOffcanvas" aria-labelledby="sidebarOffcanvasLabel">
    <div class="offcanvas-header">
      <h5 class="offcanvas-title" id="sidebarOffcanvasLabel">Menu</h5>
      <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">
      <SidebarContent />
    </div>
  </div>

  <!-- Main Layout -->
  <div class="main-layout">
    <!-- Static Side Panel for Medium and Large Screens -->
    <div class="sidebar d-none d-lg-block">
      <SidebarContent />
    </div>

    <!-- Main Content Area -->
    <div class="main-content">
      <slot></slot>
    </div>
  </div>
</template>


<script setup>

import { RouterLink, useRoute, useRouter } from 'vue-router';
import { computed } from 'vue'; // Import 'computed' from 'vue'
import SidebarContent from './SidebarContent.vue';

const router = useRouter();

const username = computed(() => {
  const userDetails = JSON.parse(localStorage.getItem('userDetails'));
  return userDetails ? userDetails.username : '';
});


</script>

<style scoped>

.stylish-brand {
  font-family: 'Arial', sans-serif;
  font-size: 1.6em;
  color: #34568B;
  /* Dark blue for a professional look */
  letter-spacing: 0.05em;
  /* Spacing out the letters slightly */
  font-weight: bold;
}

.user-display {
  font-family: 'Arial', sans-serif;
  font-size: 1.1em;
  color: #495057; /* Dark gray for contrast */
  font-weight: bold;
  border-right: 2px solid #dee2e6; /* Adding a separator */
  padding-right: 15px;
}

.offcanvas {
  color:white;
  background-color: rgb(68, 68, 68); /* Change this to your desired color */
  height: 100vh; /* Full viewport height */
  width: 250px; /* Fixed width */
}

.offcanvas-body {
  padding: 1rem 0px 0px 0px;
}

/* Ensure the static sidebar matches the offcanvas styling on larger screens */
.sidebar {
  color:white;
  background-color: rgb(68, 68, 68); /* Same as offcanvas */
  height: 100vh; /* Full viewport height */
  width: 250px; /* Fixed width */
  padding-top: 1rem;
  flex-shrink: 0; /* Prevent the sidebar from shrinking */
}

.sidebar ul {
  padding-left: 0;
  list-style: none;
}

.sidebar ul li {
  padding: 0.25rem 0;
}

.main-layout {
  display: flex;
  flex-direction: row;
}

.main-content {
  flex-grow: 1; /* Takes up remaining space */
  flex-shrink: 1; /* Allows shrinking if necessary */
  flex-basis: 0; /* Adjusts initial starting point of flex item */
}
</style>
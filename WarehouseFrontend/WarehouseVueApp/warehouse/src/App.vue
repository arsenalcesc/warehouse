<script setup>
import { RouterLink, RouterView, useRoute, useRouter } from 'vue-router';
import { computed } from 'vue'; // Import 'computed' from 'vue'

const route = useRoute();
const router = useRouter();

const isLoginPage = computed(() => {
  return route.name === 'login';
});

const username = computed(() => {
  const userDetails = JSON.parse(localStorage.getItem('userDetails'));
  console.log(userDetails.Username);
  return userDetails ? userDetails.username : '';
});

const logout = () => {
  // Remove the user details from local storage
  localStorage.removeItem('userDetails');
  // Redirect to the login page
  router.push('/login');
};
</script>


<template>
  <div class="main-app container">

    <div v-if="isLoginPage">
      <RouterView />
    </div>
    <div v-else>


      <!-- Bootstrap Navbar -->
      <nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
        <div class="container-fluid">
          <a class="navbar-brand stylish-brand" href="#">Warehouse</a>
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
              <li class="nav-item">
                <RouterLink class="nav-link" to="/inventory">Inventory</RouterLink>
              </li>
              <li class="nav-item">
                <RouterLink class="nav-link" to="/sales">Sales</RouterLink>
              </li>
            </ul>
            <span class="navbar-text mx-3 user-display">
              {{ username }}
            </span>
            <button class="btn btn-outline-danger" data-bs-toggle="modal" @click="logout">
              Logout
            </button>
          </div>
        </div>
      </nav>

      <div style="margin-top: 40px;">
        <RouterView />

      </div>
    </div>

  </div>
</template>


<style scoped>
.main-app {
  padding-top: 25px;
}

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
</style>
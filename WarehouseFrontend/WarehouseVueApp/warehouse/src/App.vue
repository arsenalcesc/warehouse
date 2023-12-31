<script setup>
import { RouterLink, RouterView } from 'vue-router'
</script>

<template>
  <div class="main-app container">
    <!-- Bootstrap Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
      <div class="container-fluid">
        <a class="navbar-brand stylish-brand" href="#">Warehouse</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav">
            <li class="nav-item">
              <RouterLink class="nav-link" to="/inventory">Inventory</RouterLink>
            </li>
            <li class="nav-item">
              <RouterLink class="nav-link" to="/sales">Sales</RouterLink>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <div style="margin-top: 40px;">

  <RouterView />
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
  color: #34568B; /* Dark blue for a professional look */
  letter-spacing: 0.05em; /* Spacing out the letters slightly */
  font-weight: bold;
}
</style>
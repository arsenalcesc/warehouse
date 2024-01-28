<template>
  <div class="container mt-5">
    <div class="row justify-content-center">
      <div class="col-md-6">     
        
        <h2 class="text-center mb-4" style="margin-top: 20px;">Stock Management System</h2>


        <div class="card mt-5">
          <div class="card-body">
            <h4 class="card-title text-center mb-4">Login</h4>
            <form @submit.prevent="handleLogin">
              <div class="mb-3">
                <label for="username" class="form-label">Username:</label>
                <input type="text" class="form-control" id="username" v-model="loginForm.username" required>
              </div>
              <div class="mb-3">
                <label for="password" class="form-label">Password:</label>
                <input type="password" class="form-control" id="password" v-model="loginForm.password" required>
              </div>
              <div class="d-grid">
                <button type="submit" class="btn btn-primary">Login</button>
              </div>
              <p class="text-danger mt-3" v-if="error">{{ error }}</p>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>


<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios'; // Ensure axios is installed and imported
import { API_ENDPOINTS } from '../../apiConfig';

const loginForm = ref({
  username: '',
  password: ''
});
const error = ref('');
const router = useRouter();

const handleLogin = async () => {
  try {
    const response = await axios.post(API_ENDPOINTS.users, loginForm.value);
    // Store the entire response object in local storage
    localStorage.setItem('userDetails', JSON.stringify(response.data));

    router.push('/');
  } catch (err) {
    if (err.response && err.response.status === 401) {
      // Handle invalid credentials
      error.value = 'Invalid username or password';
    } else {
      // Handle other HTTP errors
      error.value = 'An error occurred. Please try again later.';
    }
  }
};

</script>


<style scoped>

</style>
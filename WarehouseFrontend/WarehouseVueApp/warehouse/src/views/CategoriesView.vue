<template>
  <div class="container mt-4">
    <h2 class="mb-4">Categories</h2>
    <table v-if="!isLoading" class="table table-striped">
      <thead>
        <tr>
          <th>Id</th>
          <th>Name</th>
          <th>Description</th>
          <th>No. of Products</th>
          <th class="text-center">Edit</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="category in categories" :key="category.id">
          <td>{{ category.categoryId }}</td>
          <td>{{ category.name }}</td>
          <td>{{ category.description }}</td>
          <td>{{ category.productCount }}</td>
          <td class="text-center">
            <router-link :to="'/category/' + category.categoryId" class="icon-link">
              <i class="fa-solid fa-edit"></i>
            </router-link>
          </td>
        </tr>
      </tbody>
    </table>
    <p v-if="isLoading">Loading...</p>
  </div>
</template>

<script>
import axios from 'axios';
import { API_ENDPOINTS } from '../../apiConfig';

export default {
  data() {
    return {
      categories: [],
      isLoading: false
    };
  },
  mounted() {
    this.isLoading = true;
    axios.get(API_ENDPOINTS.categories) // Replace with your API URL
      .then(response => {
        this.categories = response.data;
      })
      .catch(error => {
        console.error("There was an error fetching the categories:", error);
      })
      .finally(() => {
        this.isLoading = false;
      });
  }
};
</script>

<style>
/* Add your styles here */
</style>

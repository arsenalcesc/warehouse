<template>
  <div class="container mt-4">
    <h2 class="mb-4">Sales</h2>

    <div class="d-flex justify-content-between align-items-center mb-4">
      <router-link to="/sale-add">
        <button class="btn btn-secondary">Add Sale</button>
      </router-link>
    </div>

    <table v-if="!isLoading" class="table table-striped">
      <thead>
        <tr>
          <th>Id</th>
          <th>Customer</th>
          <th>Date</th>
          <th>Products</th>
          <th>Stock Items</th>
          <th>Amount ($)</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="sale in sales" :key="sale.id">
          <td>{{ sale.saleId }}</td>
          <td>{{ sale.customerBusinessName }}</td>
          <td>{{ sale.saleDate }}</td>
          <td>{{ sale.productsCount }}</td>
          <td>{{ sale.stockItemsCount }}</td>
          <td>{{ sale.amount }}</td>
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
      sales: [],
      isLoading: false
    };
  },
  mounted() {
    this.isLoading = true;
    axios.get(API_ENDPOINTS.sales)
      .then(response => {
        this.sales = response.data.map(sale => {
          sale.saleDate = this.formatDate(sale.saleDate);
          return sale;
        });
      })
      .catch(error => {
        console.error("There was an error fetching the sales:", error);
      })
      .finally(() => {
        this.isLoading = false;
      });
  },
  methods: {
    formatDate(dateString) {
      const options = {
        year: 'numeric',
        month: 'numeric',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit'
      };
      return new Date(dateString).toLocaleDateString('en-GB', options);
    }

  },
};
</script>

<style>
/* Add your styles here */
</style>

<template>
  <div class="container mt-4">
    <h2 class="mb-4">Products</h2>
    <table class="table table-striped">
      <thead>
        <tr>
          <th>ID</th>
          <th>Image</th>
          <th>Name</th>
          <th>Price per Item ($)</th>
          <th>Quantity per Box</th>
          <th>CBM</th>
          <th>Description</th>
          <th>Stock</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="product in products" :key="product.productId">
          <td>{{ product.productId }}</td>
          <td>
            <img 
              :src="product.imageUrl" 
              :alt="product.name" 
              class="product-image" 
            />
          </td>
          <td>{{ product.name }}</td>
          <td>{{ product.price }}</td>
          <td>{{ product.quantityPerBox }}</td>
          <td>{{ product.cbm }}</td>
          <td>{{ product.description }}</td>
          <td>{{ product.stockCount }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios';
import { API_ENDPOINTS } from '../../apiConfig';

export default {
  data() {
    return {
      products: []
    };
  },
  mounted() {
    axios.get(API_ENDPOINTS.products)
      .then(response => {
        this.products = response.data;
      })
      .catch(error => {
        console.error("There was an error fetching the products:", error);
      });
  }
};
</script>

<style>
.product-image {
  width: 50px;
  height: 50px;
  transition: transform 0.8s ease;
}

.product-image:hover {
  transform: scale(5);
  z-index: 1000;
  position: relative;
}
</style>

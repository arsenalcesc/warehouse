<template>
  <div class="container mt-4">
    <table class="table table-striped">
      <thead>
        <tr>
          <th>ID</th>
          <th>Image</th>
          <th>Name</th>
          <th>Price per Item</th>
          <th>Quantity per Carton</th>
          <th>CBM</th>
          <th>Description</th>
          <th>Stock</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="product in products" :key="product.id">
          <td>{{ product.id }}</td>
          <td>
            <img 
              :src="product.pictureUrl" 
              :alt="product.name" 
              class="product-image" 
            />
          </td>
          <td>{{ product.name }}</td>
          <td>${{ product.pricePerItem }}</td>
          <td>{{ product.quantityPerCarton }}</td>
          <td>{{ product.cbm }}</td>
          <td>{{ product.description }}</td>
          <td>{{ product.stock }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      products: []
    };
  },
  mounted() {
    axios.get('https://localhost:7110/Products') // Replace with your API URL
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

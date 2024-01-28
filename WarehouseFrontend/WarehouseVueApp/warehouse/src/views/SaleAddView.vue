<template>
  <div class="container mt-4">
    <h2 class="mb-4">Sales</h2>

    <div class="d-flex justify-content-between align-items-center mb-4">
      <router-link to="/sales">
        <button class="btn btn-secondary">All Sales</button>
      </router-link>
    </div>

    <div v-if="successMessage" class="alert alert-success">{{ successMessage }}</div>
    <div v-if="errorMessage" class="alert alert-danger">{{ errorMessage }}</div>

    <table class="table table-striped">
      <thead>
        <tr>
          <th>Id</th>
          <th>Name</th>
          <th>Price per Item</th>
          <th>Quantity per Box</th>
          <th>CBM</th>
          <th>Description</th>
          <th>Stock</th>
          <th class="sale-quantity-input">Sale Quantity</th>
          <th>Cost</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="product in products" :key="product.id" :class="{ 'table-success': product.flash }">
          <td>{{ product.productId }}</td>
          <td>{{ product.name }}</td>
          <td>${{ product.price }}</td>
          <td>{{ product.quantityPerBox }}</td>
          <td>{{ product.cbm }}</td>
          <td>{{ product.description }}</td>
          <td>{{ product.stockCount }}</td>
          <td>
            <input type="number" min="0" v-model="product.saleQuantity" class="form-control" />
          </td>
          <td class="cost-cell">${{ calculateCost(product) }}</td>

        </tr>
      </tbody>
    </table>
    <div class="mt-3 text-end"> <!-- Bootstrap class for text alignment -->
      <p>Total Cost: ${{ totalCost }}</p>
      <button class="btn btn-primary" @click="submitSales">Submit Sales</button>
    </div>
  </div>
</template>



<script>
import axios from 'axios';
import { API_ENDPOINTS } from '../../apiConfig';

export default {
  data() {
    return {
      products: [],
      successMessage: '',
      errorMessage: ''
    };
  },
  computed: {
    totalCost() {
      return this.products.reduce((sum, product) => {
        return sum + (product.price * product.saleQuantity);
      }, 0).toFixed(2); // Fix to 2 decimal places
    }
  },
  methods: {
    calculateCost(product) {
      return (product.price * product.saleQuantity).toFixed(2); // Rounds to two decimal places
    },
    fetchProducts() {
      axios.get(API_ENDPOINTS.products)
        .then(response => {
          this.products = response.data.map(p => ({ ...p, saleQuantity: 0, flash: false }));
        })
        .catch(error => {
          console.error("Error fetching products:", error);
        });
    },
    submitSales() {

      let saleItems = this.products
        .filter(p => p.saleQuantity > 0)
        .map(p => ({
          productId: p.productId,
          quantitySold: p.saleQuantity
        }));

      let salesData = {
        SaleItems: saleItems
      };

      this.clearMessages();
      axios.post(API_ENDPOINTS.sales, salesData)
        .then(response => {
          this.products = response.data.products;
          setTimeout(() => { this.successMessage = response.data.message; }, 100);
          this.flashUpdatedStock(saleItems);
        })
        .catch(error => {
          console.error("Error submitting sales:", error);
          setTimeout(() => { this.errorMessage = error.response.data; }, 100);
        });
    },
    flashUpdatedStock(saleItems) {
      this.products = this.products.map(p => {
        let updatedProduct = saleItems.find(up => up.productId === p.productId);
        if (updatedProduct) {
          return { ...p, flash: true, saleQuantity: 0 };
        }
        return { ...p, saleQuantity: 0 };
      });

      setTimeout(() => {
        this.products = this.products.map(p => ({ ...p, flash: false }));
      }, 4000); // Flash duration
    },
    clearMessages() {
      this.successMessage = '';
      this.errorMessage = '';
    }
  },
  mounted() {
    this.fetchProducts();
  }
};
</script>

<style>
/* ... existing styles ... */

.sale-quantity-input {
  width: 100px;
  /* Adjust as needed */
}

.flash-row {
  background-color: #d1ecf1;
  /* Example color, adjust as needed */
}
</style>
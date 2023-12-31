<template>
  <div class="container mt-4">
    <table class="table table-striped">
      <thead>
        <tr>
          <th>ID</th>
          <th>Name</th>
          <th>Price per Item</th>
          <th>Quantity per Carton</th>
          <th>CBM</th>
          <th>Description</th>
          <th>Stock</th>
          <th class="sale-quantity-input">Sale Quantity</th>
          <th>Cost</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="product in products" :key="product.id" :class="{ 'table-success': product.flash }">
          <td>{{ product.id }}</td>
          <td>{{ product.name }}</td>
          <td>${{ product.pricePerItem }}</td>
          <td>{{ product.quantityPerCarton }}</td>
          <td>{{ product.cbm }}</td>
          <td>{{ product.description }}</td>
          <td>{{ product.stock }}</td>
          <td>
            <input type="number" min="0" v-model="product.saleQuantity" class="form-control"/>
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

export default {
  data() {
    return {
      products: []
    };
  },
  computed: {
    totalCost() {
      return this.products.reduce((sum, product) => {
        return sum + (product.pricePerItem * product.saleQuantity);
      }, 0).toFixed(2); // Fix to 2 decimal places
    }
  },
  methods: {   
    calculateCost(product) {
      return (product.pricePerItem * product.saleQuantity).toFixed(2); // Rounds to two decimal places
    },
    fetchProducts() {
      axios.get('https://localhost:7110/Products')
        .then(response => {
          this.products = response.data.map(p => ({ ...p, saleQuantity: 0, flash: false }));
        })
        .catch(error => {
          console.error("Error fetching products:", error);
        });
    },
    submitSales() {
      let salesData = this.products.filter(p => p.saleQuantity > 0).map(p => ({
        productId: p.id,
        quantitySold: p.saleQuantity
      }));

      axios.post('https://localhost:7110/Products/SellProducts', salesData)
        .then(response => {
          this.flashUpdatedStock(response.data);
        })
        .catch(error => {
          console.error("Error submitting sales:", error);
        });
    },
    flashUpdatedStock(updatedProducts) {
      this.products = this.products.map(p => {
        let updatedProduct = updatedProducts.find(up => up.id === p.id);
        if (updatedProduct) {
          return { ...updatedProduct, flash: true, saleQuantity: 0 };
        }
        return { ...p, saleQuantity: 0 };
      });

      setTimeout(() => {
        this.products = this.products.map(p => ({ ...p, flash: false }));
      }, 4000); // Flash duration
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
  width: 100px; /* Adjust as needed */
}

.flash-row {
  background-color: #d1ecf1; /* Example color, adjust as needed */
}
</style>
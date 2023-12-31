<script setup>
import { ref } from 'vue'

const message = ref('hello')


function increment() {
  fetch('https://localhost:7110/WeatherForecast').then(response => response.json())
    .then(data => message.value = data);
}
</script>

<template>
  <div class="container">
    <button class="btn btn-success" @click="increment">Click Me</button>
  <br>
    {{ message }}

  </div>
</template>

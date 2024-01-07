<template>
  <div class="main-app">
    <component :is="layout">
      <RouterView />
    </component>
  </div>
</template>


<script setup>
import { RouterView } from 'vue-router';
import { computed } from 'vue';
import { useRoute } from 'vue-router';

import DefaultLayout from './components/layouts/DefaultLayout.vue';
import LoginLayout from './components/layouts/LoginLayout.vue';


const layout = computed(() => {
  const layout = useRoute().meta.layout || 'default';
  return layout === 'login' ? LoginLayout : DefaultLayout;
});

</script>


<style scoped>
</style>
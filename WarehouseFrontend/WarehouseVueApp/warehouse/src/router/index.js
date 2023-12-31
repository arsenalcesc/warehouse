import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/HomeView.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView
    },
    {      path: '/inventory', name: 'inventory', component: () => import('../views/InventoryView.vue')    },
    {      path: '/sales',     name: 'sales',     component: () => import('../views/SalesView.vue')    }
  ]
})

export default router

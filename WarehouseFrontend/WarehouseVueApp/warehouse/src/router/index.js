import { createRouter, createWebHistory } from 'vue-router';
import DashboardView from '../views/DashboardView.vue';
import LoginView from '../views/LoginView.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'dashboard',
      component: DashboardView,
      meta: { requiresAuth: true }
    },
    {
      path: '/login',
      name: 'login',
      component: LoginView,
      meta: { layout: 'login' }
    },
    { 
      path: '/products', 
      name: 'products',
      component: () => import('../views/ProductsView.vue'),
      meta: { requiresAuth: true }
    },
    { 
      path: '/sales',
      name: 'sales',     
      component: () => import('../views/SalesView.vue'),
      meta: { requiresAuth: true }
    },
    { 
      path: '/sale-add',     
      name: 'sale-add',     
      component: () => import('../views/SaleAddView.vue'),
      meta: { requiresAuth: true }
    },
    { 
      path: '/categories',     
      name: 'categories',     
      component: () => import('../views/CategoriesView.vue'),
      meta: { requiresAuth: true }
    },
    {
      path: '/category/:id',
      name: 'category-edit',
      component: () => import('../views/CategoryEditView.vue'),
      meta: { requiresAuth: true }
    }
  ]
});

// Navigation Guard
router.beforeEach((to, from, next) => {
  const authToken = localStorage.getItem('userDetails');

  if (authToken && to.name === 'login') {
    next({ name: 'dashboard' });
    return;
  }

  if (to.matched.some(record => record.meta.requiresAuth)) {
    if (!authToken) {
      next({ name: 'login' });
    } else {
      next();
    }
  } else {
    next();
  }
});

export default router;
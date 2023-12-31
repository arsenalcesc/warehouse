import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '../views/HomeView.vue';
import LoginView from '../views/LoginView.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView,
      meta: { requiresAuth: true }
    },
    {
      path: '/login',
      name: 'login',
      component: LoginView
    },
    { 
      path: '/inventory', 
      name: 'inventory', 
      component: () => import('../views/InventoryView.vue'),
      meta: { requiresAuth: true }
    },
    { 
      path: '/sales',     
      name: 'sales',     
      component: () => import('../views/SalesView.vue'),
      meta: { requiresAuth: true }
    }
  ]
});

// Navigation Guard
router.beforeEach((to, from, next) => {
  // Check for the auth token in local storage
  const authToken = localStorage.getItem('userDetails');
  // If user is already logged in and tries to access the login page
  if (authToken && to.name === 'login') {
    // Redirect to the home page
    next({ name: 'home' });
    return;
  }

  // Check if the route requires authentication
  if (to.matched.some(record => record.meta.requiresAuth)) {

    if (!authToken) {
      // Redirect to the login page if there's no auth token
      next({ name: 'login' });
    } else {
      // Proceed to the route if authenticated
      next();
    }
  } else {
    // If the route does not require authentication, proceed
    next();
  }
});

export default router;
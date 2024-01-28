<template>
    <ul class="navbar-nav">
        <li class="nav-item">
            <RouterLink class="nav-link" to="/"><span class="icon"><i class="fa-solid fa-house"></i></span>Dashboard
            </RouterLink>
        </li>
        <li class="nav-item">
            <RouterLink class="nav-link" to="/categories"><span class="icon"><i
                        class="fa-solid fa-chart-line"></i></span>Categories</RouterLink>
        </li>
        <li class="nav-item">
            <RouterLink class="nav-link" to="/products"><span class="icon"><i
                        class="fa-solid fa-boxes-stacked"></i></span>Products</RouterLink>
        </li>
        <li class="nav-item">
            <RouterLink class="nav-link" to="/sales"><span class="icon"><i class="fa-solid fa-chart-line"></i></span>Sales
            </RouterLink>
        </li>
        <li class="nav-item">
            <a class="nav-link" @click.prevent="logout">
                <span class="icon"><i class="fa-solid fa-right-from-bracket"></i></span> Logout
            </a>
        </li>
    </ul>
</template>
  
<script>
import { RouterLink } from 'vue-router';

export default {
    methods: {
        logout() {
            if (confirm('Are you sure you want to log out?')) {
                localStorage.removeItem('userDetails');
                this.$router.push('/login');
            }
        }
    }
};
</script>
  
<style scoped>
.nav-link {
    display: block;
    /* Ensures the link fills the entire list item */
    padding: 0.5rem 0.7rem;
    /* Adjust padding to your preference */
    color: inherit;
    /* Keeps the text color consistent */
    text-decoration: none;
    /* Removes underline from links */
}

.nav-link:hover,
.nav-link:focus {
    background-color: #e0e0e0;
    /* Background color for hover */
    color: #000;
    /* Optional: change text color on hover */
    text-decoration: none;
    /* Keeps text from being underlined on hover */
}

/* Additional styling for list items if needed */
li {
    list-style: none;
    /* Removes bullet points */
}

.nav-link {
    display: flex;
    align-items: center;
}

.icon {
    margin-right: 10px;
    width: 30px;
    text-align: center;
}
</style>

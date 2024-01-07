<template>
    <div class="container mt-4 ms-lg-5">

        <div class="row">
            <div class="col-lg-8">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>Edit Category</h2>
                    <router-link to="/categories">
                        <button class="btn btn-secondary">All Categories</button>
                    </router-link>
                </div>
                <div v-if="successMessage" class="alert alert-success">{{ successMessage }}</div>
                <div v-if="errorMessage" class="alert alert-danger">{{ errorMessage }}</div>

                <form @submit.prevent="updateCategory">
                    <div class="mb-3">
                        <label for="categoryName" class="form-label">Name</label>
                        <input type="text" class="form-control" id="categoryName" v-model="category.name">
                    </div>
                    <div class="mb-3">
                        <label for="categoryDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="categoryDescription" v-model="category.description"
                            rows="4"></textarea>
                    </div>
                    <div class="d-flex justify-content-end">
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                        <button type="button" class="btn btn-danger" style="margin-left: 1rem;"
                            @click="deleteCategory">Delete</button>
                    </div>
                </form>
            </div>
        </div>

    </div>
</template>
  
<script>
import axios from 'axios';

export default {
    data() {
        return {
            category: {},
            isLoading: false,
            successMessage: '',
            errorMessage: ''
        };
    },
    mounted() {
        this.fetchCategory();
    },
    methods: {
        fetchCategory() {
            this.isLoading = true;
            axios.get('https://localhost:7110/Categories/' + this.$route.params.id)
                .then(response => {
                    this.category = response.data;
                })
                .catch(error => {
                    console.error("There was an error fetching the category:", error);
                })
                .finally(() => {
                    this.isLoading = false;
                });
        },
        updateCategory() {
            this.clearMessages();
            axios.put('https://localhost:7110/Categories/' + this.category.categoryId, this.category)
                .then(() => {
                    setTimeout(() => { this.successMessage = 'Category updated successfully.'; }, 100);
                })
                .catch(error => {
                    console.error("There was an error updating the category:", error);
                    setTimeout(() => { this.errorMessage = 'Failed to update the category.'; }, 100);
                });
        },
        deleteCategory() {
            if (confirm('Are you sure you want to delete this category?')) {
                this.clearMessages();
                axios.delete('https://localhost:7110/Categories/' + this.category.categoryId)
                    .then(() => {
                        setTimeout(() => { this.successMessage = 'Category deleted successfully.'; }, 100);
                    })
                    .catch(error => {
                        console.error("There was an error deleting the category:", error);
                        setTimeout(() => { this.errorMessage = 'Failed to delete the category.'; }, 100);
                    });
            }
        },
        clearMessages() {
            this.successMessage = '';
            this.errorMessage = '';
        }
    }
};
</script>
  
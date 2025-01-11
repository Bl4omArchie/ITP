<template>
    <h1>Modules</h1>
    

    <button @click="refreshTools" class="snortBox__refresh-btn">Refresh Modules</button>
    <br/>
    <input type="text" v-model="searchQuery" placeholder="Search for a module..." class="search-bar" />

      
    <div class="snortBox">
        <h2>Module store</h2>
        <div class="snorBox snortBox--store">
            <div v-for="(tool, name) in paginatedTools" :key="name" class="snortBox--store-i">
                <div class="snortBox__logo">
                    <img :src="tool.logo_url || defaultLogo" :alt="`${name} logo`" class="snortBox__logo-img"/>
                </div>
        
                <p>{{ name }}</p>
            </div>
        </div>

        <div class="pagination">
            <button @click="prevPage" :disabled="currentPage === 1" class="pagination-btn">
                <i class="fas fa-chevron-left"></i>
            </button>

            Page {{ currentPage }} of {{ totalPages }}

            <button @click="nextPage" :disabled="currentPage === totalPages" class="pagination-btn">
                <i class="fas fa-chevron-right"></i>
            </button>
        </div>
    </div>
</template>
  

<script lang="ts">
    import { defineComponent, ref, computed, onMounted } from "vue";

    import "../../styles/boxes/snort_box.css";
    import "../../styles/boxes/pagination.css";
    
    interface Tool {
        git: string;
        version: string;
        package_name: string;
        logo_url: string | null;
        installed: boolean;
    }
    
    export default defineComponent({
    name: "SnortBox",
    setup() {
        const tools = ref<Record<string, Tool>>({});
        const defaultLogo = "https://vectorified.com/images/default-icon-16.png";

        const searchQuery = ref("");
        const currentPage = ref(1);
        const itemsPerPage = 12;

        // Fonction pour charger les outils
        const loadTools = async () => {
            const response = await fetch("/tools.json");
            tools.value = await response.json();
        };

        // Fonction pour actualiser les outils (appelée par le bouton)
        const refreshTools = async () => {
            await loadTools();
        };

        onMounted(async () => {
            await loadTools();
        });

        // Filtrer les outils en fonction de la recherche
        const filteredTools = computed(() => {
            if (!searchQuery.value) return tools.value;
            const query = searchQuery.value.toLowerCase();
            return Object.fromEntries(
                Object.entries(tools.value).filter(([name]) =>
                    name.toLowerCase().includes(query)
                )
            );
        });

        // Pagination
        const totalPages = computed(() =>
            Math.ceil(Object.keys(filteredTools.value).length / itemsPerPage)
        );

        const paginatedTools = computed(() => {
            const start = (currentPage.value - 1) * itemsPerPage;
            const end = start + itemsPerPage;
            return Object.entries(filteredTools.value)
                .slice(start, end)
                .reduce((acc, [key, val]) => ({ ...acc, [key]: val }), {});
        });

        const nextPage = () => {
            if (currentPage.value < totalPages.value) currentPage.value++;
        };

        const prevPage = () => {
            if (currentPage.value > 1) currentPage.value--;
        };

        return {
            tools,
            defaultLogo,
            searchQuery,
            currentPage,
            totalPages,
            paginatedTools,
            nextPage,
            prevPage,
            refreshTools,
        };
    },
    });
</script>
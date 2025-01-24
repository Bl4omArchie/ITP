<template>
    <h1>Modules</h1>
    
    <input type="text" v-model="searchQuery" placeholder="Search for a module..." class="search-bar" />
    <button @click="refreshTools" class="snortBox__refresh-btn">Refresh Modules</button>
      
    <div class="snortBox">
        <h2>Module store</h2>
        <div class="snorBox snortBox--store">
            <div 
                v-for="(tool, name) in paginatedTools"
                :key="name"
                class="snortBox--store-i"
                @click="selectTool(tool)">
                
                <div class="snortBox__logo">
                    <img :src="tool.logo_url || defaultLogo" :alt="`${name} logo`" class="snortBox__logo-img" />
                </div>
                <p>{{ name }}</p>
            </div>

        </div>

        <div v-if="showPopup" class="snortPopup-overlay" @click.self="closePopup">
            <div class="snortPopup">
                <div class="snortPopup-close" @click="closePopup">×</div>
                <div class="snortPopup-content">
                    <h2>{{ selectedTool?.package_name}}</h2>
                    <img :src="selectedTool?.logo_url || defaultLogo" alt="Logo" width="100" />
                    <p><strong>Git:</strong> <a :href="selectedTool?.git" target="_blank">{{ selectedTool?.git }}</a></p>
                    <p><strong>Version:</strong> {{ selectedTool?.version }}</p>
                    
                </div>
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

    import "../../styles/boxes/SnortBox.css";
    import "../../styles/boxes/SnortBoxStore.css";
    import "../../styles/buttons/Pagination.css";
    import "../../styles/popups/SnortPopup.css";
    
    interface Tool {
        git: string;
        version: string;
        package_name: string;
        logo_url: string | null;
        installed: boolean;
    }
    
    export default defineComponent({
        name: "Modules",
        setup() {
            const tools = ref<Record<string, Tool>>({});
            const defaultLogo = "https://vectorified.com/images/default-icon-16.png";

            const searchQuery = ref("");
            const currentPage = ref(1);
            const itemsPerPage = 12;
            const selectedTool = ref<any | null>(null);
            
            const loadTools = async () => {
                const response = await fetch("/tools.json");
                tools.value = await response.json();
            };

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
        data() {
            return {
                showPopup: false,
            };
        },
        methods: {
            closePopup() {
                this.showPopup = false;
            },
            selectTool(tool) {
                this.selectedTool = tool;
                this.showPopup = true;
            }
        },
    });
</script>
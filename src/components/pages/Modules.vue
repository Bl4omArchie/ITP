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
                    <h2>{{ selectedTool?.package_name }}</h2>
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
    import { usePagination } from "../../services/Pagination";
    import { useModules, Module } from "../../services/Modules";

    import "../../styles/boxes/SnortBox.css";
    import "../../styles/boxes/SnortBoxStore.css";
    import "../../styles/buttons/Pagination.css";
    import "../../styles/popups/SnortPopup.css";

    export default defineComponent({
        name: "Modules",
        setup() {
            const { modules, loadModules, refreshModules } = useModules();
            const defaultLogo = "https://vectorified.com/images/default-icon-16.png";

            const searchQuery = ref("");
            const selectedModule = ref<Module | null>(null);

            onMounted(async () => {
                await loadModules();
            });

            // Filter tools based on search
            const filteredModules = computed(() => {
                if (!searchQuery.value) return modules.value;
                const query = searchQuery.value.toLowerCase();
                return Object.fromEntries(
                    Object.entries(modules.value).filter(([name]) =>
                        name.toLowerCase().includes(query)
                    )
                );
            });

            const { paginatedItems, totalPages, currentPage, nextPage, prevPage } = usePagination(modules, 12);

            return {
                modules,
                defaultLogo,
                searchQuery,
                currentPage,
                totalPages,
                paginatedItems,
                nextPage,
                prevPage,
                refreshModules,
                selectedModule,
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
            selectModule(module: Module) {
                this.selectedModule = module;
                this.showPopup = true;
            }
        },
    });
</script>
<template>
    <h1>Modules</h1>

    <input type="text" v-model="searchQuery" placeholder="Search for a module..." class="search-bar" />
    <button @click="refreshPlugins" class="snortBox__refresh-btn">Refresh Modules</button>

    <div class="snortBox">
        <h2>Module store</h2>
        <div class="snorBox snortBox--store">
            <div 
                v-for="(plugin, name) in paginatedPlugins"
                :key="name"
                class="snortBox--store-i"
                @click="selectPlugin(plugin)">
                <div class="snortBox__logo">
                    <img :src="plugin.logo_url || defaultLogo" :alt="`${name} logo`" class="snortBox__logo-img" />
                </div>
                <p>{{ name }}</p>
            </div>
        </div>

        <div v-if="showPopup" class="snortPopup-overlay" @click.self="closePopup">
            <div class="snortPopup">
                <div class="snortPopup-close" @click="closePopup">×</div>
                <div class="snortPopup-content">
                    <h2>{{ selectedPlugin?.package_name }}</h2>
                    <img :src="selectedPlugin?.logo_url || defaultLogo" alt="Logo" width="100" />
                    <p><strong>Git:</strong> <a :href="selectedPlugin?.git" target="_blank">{{ selectedPlugin?.git }}</a></p>
                    <p><strong>Version:</strong> {{ selectedPlugin?.version }}</p>
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
    import { usePluginSystem } from "../../services/Plugin";

    import "../../styles/boxes/SnortBox.css";
    import "../../styles/boxes/SnortBoxStore.css";
    import "../../styles/buttons/Pagination.css";
    import "../../styles/popups/SnortPopup.css";

    export default defineComponent({
        name: "Modules",
        setup() {
            const {
                plugins,
                defaultLogo,
                loadPlugins,
                refreshPlugins,
                filteredPlugins,
                searchQuery,
            } = usePluginSystem();

            const {
                paginatedItems: paginatedPlugins,
                currentPage,
                totalPages,
                nextPage,
                prevPage,
            } = usePagination(filteredPlugins, 12);

            const selectedPlugin = ref<any | null>(null);
            const showPopup = ref(false);

            const closePopup = () => {
                showPopup.value = false;
            };

            const selectPlugin = (plugin: any) => {
                selectedPlugin.value = plugin;
                showPopup.value = true;
            };

            onMounted(loadPlugins);

            return {
                searchQuery,
                currentPage,
                totalPages,
                paginatedPlugins,
                nextPage,
                prevPage,
                refreshPlugins,
                showPopup,
                closePopup,
                selectPlugin,
                selectedPlugin,
                defaultLogo,
            };
        },
    });
</script>
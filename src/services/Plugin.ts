import { ref, computed } from "vue";

interface Plugin {
    git: string;
    version: string;
    package_name: string;
    logo_url: string | null;
    installed: boolean;
}

export function usePluginSystem() {
    const plugins = ref<Record<string, Plugin>>({});
    const defaultLogo = "https://vectorified.com/images/default-icon-16.png";
    const searchQuery = ref("");

    const loadPlugins = async () => {
        const response = await fetch("./plugins.json");
        plugins.value = await response.json();
    };

    const refreshPlugins = async () => {
        await loadPlugins();
    };

    const filteredPlugins = computed(() => {
        if (!searchQuery.value) return plugins.value;
        const query = searchQuery.value.toLowerCase();
        return Object.fromEntries(
            Object.entries(plugins.value).filter(([name]) =>
                name.toLowerCase().includes(query)
            )
        );
    });

    return {
        plugins,
        defaultLogo,
        searchQuery,
        loadPlugins,
        refreshPlugins,
        filteredPlugins,
    };
}

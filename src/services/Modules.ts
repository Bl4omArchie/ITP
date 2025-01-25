import { ref } from "vue";

export interface Module {
    git: string;
    version: string;
    package_name: string;
    logo_url: string | null;
    installed: boolean;
}

export function useModules() {
    const modules = ref<Record<string, Module>>({});

    const loadModules = async () => {
        const response = await fetch("/tools.json");
        modules.value = await response.json();
    };

    const refreshModules = async () => {
        await loadModules();
    };

    return {
        modules,
        loadModules,
        refreshModules,
    };
}
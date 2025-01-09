<template>
    <h1>Modules</h1>
    
    <div class="snortBox">
        <h2>All Tools</h2>
        <div v-for="(tool, name) in tools" :key="name" class="snortBox--h">

            <div class="snortBox__logo">
              <img :src="tool.logo_url || defaultLogo" :alt="`${name} logo`" class="snortBox__logo-img"/>
            </div>

            <p>Name: {{ name }}</p>
            <p>Git: <a :href="tool.git" target="_blank">Lien</a></p>
            <p>Version: {{ tool.version }}</p>
        </div>
    </div>
</template>

<script lang="ts">
    import { defineComponent, ref, onMounted } from "vue";
    import "../../styles/boxes/snort_box.css";

    interface Tool {
        git: string;
        version: string;
        package_name: string;
        logo_url: string | null;
    }

    export default defineComponent({
        name: "SnortBox",
        setup() {
            const tools = ref<Record<string, Tool>>({});
            const defaultLogo = "https://vectorified.com/images/default-icon-16.png";

            onMounted(async () => {
                const response = await fetch("/tools.json");
                tools.value = await response.json();
            });

            return { tools, defaultLogo };
        },
    });

</script>
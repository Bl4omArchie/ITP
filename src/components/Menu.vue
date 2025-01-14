<template>
    <div class="menu-container">
        <!-- Sidebar -->
        <div class="sidebar">
            <img src="../assets/snort_logo.png" alt="Logo" width="200px">
            <ul>
                <li><button @click="loadPage('Home')" class="snortButton snortButton--small">Homepage</button></li>
                <li><button @click="loadPage('Rules')" class="snortButton snortButton--small">Rules</button></li>
                <li><button @click="loadPage('Modules')" class="snortButton snortButton--small">Modules</button></li>
                <li><button @click="loadPage('Instances')" class="snortButton snortButton--small">Instances</button></li>
                <li><button @click="loadPage('Tests')" class="snortButton snortButton--small">Tests</button></li>
                <li><button @click="loadPage('Settings')" class="snortButton snortButton--small">Settings</button></li>
            </ul>
        </div>

        <div class="main-container">
            <component :is="currentPage" />
        </div>
      
    </div>
</template>

  
<script lang="ts">
    import Home from './pages/Homepage.vue';
    import Rules from './pages/Rules.vue';
    import Modules from './pages/Modules.vue';
    import Instances from './pages/Instances.vue';
    import Tests from './pages/Tests.vue';
    import Settings from './pages/Settings.vue';
    
    import "../styles/Menu.css";
    import "../styles/buttons/SnortButton.css";

    export default {
    name: 'Menu',
    data() {
        return {
            currentPage: 'Home',
        };
    },
    methods: {
        loadPage(page: string) {
            this.currentPage = page.charAt(0).toUpperCase() + page.slice(1);
        }
    },
    components: {
        Home,
        Rules,
        Modules,
        Instances,
        Tests,
        Settings,
    }
};
</script>
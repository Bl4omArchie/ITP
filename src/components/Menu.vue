<template>
    <div class="menu">
        <!-- Sidebar -->
        <div :class="['sidebar', { 'sidebar--active': isSidebarOpen }]">
            <ul>
              <img src="../assets/snort_logo.png" alt="Logo" width="200px">
              <li><button class="snortButton snortButton--small">Homepage</button></li>
              <li><button class="snortButton snortButton--small">Rules</button></li>
              <li><button class="snortButton snortButton--small">Modules</button></li>
              <li><button class="snortButton snortButton--small">Configuration</button></li>
              <li><button class="snortButton snortButton--small">Tests</button></li>
              <li><button class="snortButton snortButton--small">Settings</button></li>
            </ul>
        </div>
        
        <div class="content">
            <button @click="toggleSidebar" class="toggle-button">☰</button>
        </div>
    </div>
</template>

  
<script lang="ts">
    import "../styles/Menu.css";
    import "../styles/buttons/snort_button.css";
    import "../styles/buttons/menu_toggle.css";

    export default {
      name: 'Menu',
      data() {
        return {
          isSidebarOpen: false,
        };
      },
      methods: {
        toggleSidebar() {
          this.isSidebarOpen = !this.isSidebarOpen;
        },
      },
    };
</script>
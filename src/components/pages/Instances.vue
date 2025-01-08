<template>
    <div>
      <h1>Informations Réseau</h1>
      <p>Nom d'hôte : {{ hostname }}</p>
      <p>Adresse IP : {{ localIp }}</p>
    </div>
  </template>
  
<script lang="ts">
    import { ref, onMounted } from "vue";
    
    export default {
      setup() {
        const hostname = ref("");
        const localIp = ref("");
    
        const fetchNetworkInfo = async () => {
          try {
            const result = await invoke<{ hostname: string; local_ip: string }>(
              "get_network_info"
            );
            hostname.value = result.hostname;
            localIp.value = result.local_ip;
          } catch (err) {
            console.error("Erreur lors de la récupération des informations réseau :", err);
          }
        };
    
        onMounted(() => {
          fetchNetworkInfo();
        });
    
        return { hostname, localIp };
      },
    };
</script>
  
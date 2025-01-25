<template>
    <h1>Settings</h1>
    <button @click="transferAndExecute" class="action-btn transfer-btn">
        Transférer et Exécuter
    </button>

</template>

<script lang="ts">
    import { defineComponent, ref } from "vue";
    import { invoke } from '@tauri-apps/api/core';


    import "../../styles/boxes/SnortBox.css";
    import "../../styles/boxes/SnortBoxInstances.css";
    import "../../styles/buttons/SnortIcon.css";

    export default defineComponent({
        name: "Settings",
        setup() {
            const machineIp = ref("192.168.0.22");
            const machinePort = ref(281);
            const publicKey = ref<File | null>(null);
            const scriptPath = ref("/home/");
            const remotePath = ref("/home/");

            const transferAndExecute = async () => {
            try {
                const response = await invoke("send_script_ssh", {
                    ip: machineIp.value,
                    port: machinePort.value,
                    localPath: scriptPath.value,
                    remotePath: remotePath.value,
                });
                console.log("Script transféré et exécuté :", response);
                alert("Script transféré et exécuté avec succès !");
            } catch (error) {
                console.error("Erreur lors du transfert/exécution :", error);
                alert("Échec du transfert ou de l'exécution.");
            }
            };

            return {
                machineIp,
                machinePort,
                publicKey,
                scriptPath,
                remotePath,
                transferAndExecute,
            };
        },
    });

</script>
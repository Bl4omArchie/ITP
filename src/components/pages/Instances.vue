<template>
    <h1>Instances</h1>
    <div v-for="(item, index) in paginatedItems" :key="index" class="snortBox--instances">
        <div class="snortBox snortBox--instances-data">
            <p>{{ item.name }}</p>
        </div>

        <div class="snortBox--instances-actions ">
            <button @click="selectedItem = true" class="action-btn settings-btn">
                <i class="fas fa-cog"></i>
            </button>
            <button @click="selectedItem = true" class="action-btn warning-btn">
                <i class="fas fa-exclamation-circle"></i>
            </button>
            <button @click="selectedItem = true" class="action-btn repair-btn">
                <i class="fas fa-hammer"></i>
            </button>
        </div>
    </div>

    <div class="snortBox snortBox--add" @click="showAddPopup = true">
        <div class="snortBox__logo">
            <span class="plus-icon">+</span>
        </div>
    </div>

    <!-- Popup for adding -->
    <div v-if="showAddPopup" class="snortPopup-overlay" @click.self="closePopup">
        <div class="snortPopup snortPopupSsh">
            <div class="snortPopup-close" @click="closePopup">×</div>
            <div class="snortPopup-content">
                <h2>Connect a new machine via SSH</h2>
                <input type="text" v-model="newBoxName" placeholder="Machine name" />
                <input type="text" v-model="machineIp" placeholder="IP Address" />
                <input type="number" v-model="machinePort" placeholder="Port" min="1" max="65535" />
                <div class="drag-drop">
                    <label for="publicKey">Drag and Drop Public Key</label>
                    <input type="file" id="publicKey" @change="handleFileUpload" />
                </div>
                <button @click="addBox">Valider</button>
            </div>
        </div>
    </div>

    <!-- Popup for item -->
    <div v-if="selectedItem" class="snortPopup-overlay" @click.self="closePopup">
        <div class="snortPopup">
            <div class="snortPopup-close" @click="closePopup">×</div>
            <div class="snortPopup-content">
                <h2>{{ selectedItem.name }}</h2>
                <p>Vous avez sélectionné cette boîte.</p>
                <button @click="closePopup">OK</button>
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
</template>

<script lang="ts">
    import { defineComponent, ref, computed } from "vue";
    import "../../styles/boxes/SnortBox.css";
    import "../../styles/boxes/SnortBoxInstances.css";
    import "../../styles/buttons/Pagination.css";
    import "../../styles/buttons/SnortIcon.css";
    import "../../styles/popups/SnortPopup.css";
    import "../../styles/popups/SnortPopup_ssh.css";

    interface Item {
        name: string;
    }

    export default defineComponent({
        name: "Instances",
        setup() {
            const items = ref<Item[]>([]);
            const currentPage = ref(1);
            const itemsPerPage = 3;
            const machineIp = ref("");
            const machinePort = ref(22); // Default SSH port
            const newBoxName = ref("");
            const selectedItem = ref<Item | null>(null);
            const showAddPopup = ref(false);
            const publicKey = ref<File | null>(null);

            const paginatedItems = computed(() => {
                const start = (currentPage.value - 1) * itemsPerPage;
                return items.value.slice(start, start + itemsPerPage);
            });

            const totalPages = computed(() =>
                Math.ceil(items.value.length / itemsPerPage)
            );

            const nextPage = () => {
                if (currentPage.value < totalPages.value) currentPage.value++;
            };

            const prevPage = () => {
                if (currentPage.value > 1) currentPage.value--;
            };

            const closePopup = () => {
                showAddPopup.value = false;
                selectedItem.value = null;
                newBoxName.value = "";
                machineIp.value = "";
                machinePort.value = 22;
            };

            const addBox = () => {
                if (newBoxName.value.trim() && machineIp.value.trim() && publicKey.value) {
                    items.value.push({ name: newBoxName.value.trim() });
                    closePopup();
                }
            };

            const handleFileUpload = (event: any) => {
                publicKey.value = event.target.files[0];
            };

            return {
                items,
                currentPage,
                totalPages,
                paginatedItems,
                nextPage,
                prevPage,
                showAddPopup,
                selectedItem,
                newBoxName,
                machineIp,
                machinePort,
                publicKey,
                closePopup,
                addBox,
                handleFileUpload,
            };
        },
    });
</script>

<style scoped>
.plus-icon {
    font-size: 32px;
    font-weight: bold;
}
</style>
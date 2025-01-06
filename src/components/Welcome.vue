<template>
    <div class="welcome">
        <img src="../assets/snort_logo.png" alt="Logo" class="floaty-logo" />
        <h1>Welcome to ITP</h1>
        <button @click="goToAnotherPage">Install The Pork</button>
    </div>
</template>
  
<script lang="ts">
    import "../styles/Welcome.css";
    import "../styles/button_start.css";
    import { defineComponent } from 'vue';
    import { useRouter } from 'vue-router';

    export default defineComponent({
        name: 'Welcome',
        setup() {
            const router = useRouter();

            const goToAnotherPage = () => {
                router.push({ name: 'Menu' });
            };

            return { goToAnotherPage };
        }
    });
</script>
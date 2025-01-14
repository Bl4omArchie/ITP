<template>
    <div class="welcome">
        <div class="logo">
            <img src="../assets/snort_logo.png" alt="Logo">
        </div>

        <div class="options">
            <button class="snortButton snortButton--large" @click="switchToHomepage">Install The Pork</button>
            <button class="snortButton snortButton--large" @click="switchToHomepage">Stuff #2</button>
            <button class="snortButton snortButton--large" @click="switchToHomepage">Stuff #3</button>
        </div>
    </div>
</template>
  
<script lang="ts">
    import "../styles/Welcome.css";
    import "../styles/buttons/SnortButton.css";
    import { defineComponent } from 'vue';
    import { useRouter } from 'vue-router';

    export default defineComponent({
        name: 'Welcome',
        setup() {
            const router = useRouter();

            const switchToHomepage = () => {
                router.push({ name: 'Menu' });
            };

            return { switchToHomepage };
        }
    });
</script>
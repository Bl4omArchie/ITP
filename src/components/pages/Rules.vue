<template>
    <div class="snortBox snortBox--menu">
        <button @click="loadPage('RulesMan')" class="snortButton snortButton--small">Rules</button>
        <button @click="loadPage('RuleEditor')" class="snortButton snortButton--small">Editor</button>
        <button @click="loadPage('GroupEDitor')" class="snortButton snortButton--small">Groups</button>
    </div>


    <div class="rules-container">
        <component :is="currentPage" />
    </div>
</template>

  
<script lang="ts">
    import "../../styles/boxes/SnortBox.css";
    import "../../styles/boxes/SnortBoxMenu.css";
    import "../../styles/buttons/SnortButton.css";
    import "../../styles/boxes/rules_editor.css";
    
    import { defineComponent, ref } from 'vue';
    
    import GroupEditor from "./rules/GroupEditor.vue";
    import RuleEditor from "./rules/RuleEditor.vue";
    import RulesMan from "./rules/RulesMan.vue";

    export default defineComponent({
        name: 'Rules',
        data() {
            return {
                showPopup: false,
                currentPage: 'RulesMan',
            };
        },

        methods: {
            loadPage(page: string) {
                this.currentPage = page.charAt(0).toUpperCase() + page.slice(1);
            }
        },
        components: {
            RulesMan,
            GroupEditor,
            RuleEditor,
        },

        setup() {
            const ruleContent = ref<string>('');
            const saveMessage = ref<string | null>(null);

            const saveRule = () => {
                console.log('Snort Rule:', ruleContent.value);
                saveMessage.value = 'Rule saved successfully!';
                setTimeout(() => {
                saveMessage.value = null;
                }, 3000);
            };

            const resetEditor = () => {
                ruleContent.value = '';
            };

            return {
                ruleContent,
                saveRule,
                resetEditor,
                saveMessage,
            };
        },
    });
</script>
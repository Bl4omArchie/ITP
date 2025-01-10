<template>
    <h1>Rules</h1>

    <button class="snortButton snortButton--small">Rules</button>
    <button class="snortButton snortButton--small">Editor</button>
    <button class="snortButton snortButton--small">Groups</button>

    <div class="snortBox">
        <h2>Snort Rule Editor</h2>
        <textarea
          v-model="ruleContent"
          placeholder="Edit your Snort rule here..."
          rows="10"
          style="color: black; width: 100%; font-family: monospace; padding: 10px; border-radius: 8px; border: 1px solid black;"
        ></textarea>
        
        <div style="margin-top: 10px; display: flex;">
            <button @click="saveRule" class="snortButton snortButton--save">Save</button>
            <button @click="resetEditor" class="snortButton snortButton--reset">Reset</button>   
        </div>
        
        <p v-if="saveMessage" style="color: green; margin-top: 10px;">{{ saveMessage }}</p>
    </div>
</template>

  
<script lang="ts">
    import "../../styles/boxes/snort_box.css";
    import "../../styles/buttons/snort_button.css";
    import "../../styles/boxes/rules_editor.css";
    
    import { defineComponent, ref } from 'vue';

    export default defineComponent({
      name: 'Rules',
      data() {
          return {
              showPopup: false,
          };
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
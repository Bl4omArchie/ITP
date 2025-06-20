<template>
  <h1>Snort Rule Editor</h1>

  <MonacoEditor
    v-model="ruleContent"
    lang="snort"
    theme="vs-dark"
    :options="editorOptions"
    style="height: 400px; border-radius: 8px"
  />

  <div style="margin-top: 10px; display: flex;">
    <button @click="saveRule" class="snortButton snortButton--save">Save</button>
    <button @click="resetEditor" class="snortButton snortButton--reset">Reset</button>
  </div>

  <p v-if="saveMessage" style="color: green; margin-top: 10px;">{{ saveMessage }}</p>
</template>

<script lang="ts">
import { defineComponent, ref, onMounted } from 'vue';
import { registerSnortLanguage } from '../../../utils/snortLanguage';
import MonacoEditor from 'monaco-editor-vue3';


export default defineComponent({
  name: 'RuleEditor',
  components: { MonacoEditor },
  setup() {
    onMounted(() => {
      registerSnortLanguage();
    });

    const ruleContent = ref(`alert tcp $EXTERNAL_NET 80 -> $HOME_NET any
(
    msg:"Attack attempt!";
    flow:to_client,established;
    file_data;
    content:"1337 hackz 1337",fast_pattern,nocase;
    service:http;
    sid:1;
)`);

    const editorOptions = {
      fontSize: 14,
      fontFamily: 'monospace',
      minimap: { enabled: false },
      automaticLayout: true,
    };

    const saveMessage = ref('');

    const saveRule = () => {
      saveMessage.value = 'Rule saved!';
    };

    const resetEditor = () => {
      ruleContent.value = '';
      saveMessage.value = '';
    };

    return {
      ruleContent,
      editorOptions,
      saveMessage,
      saveRule,
      resetEditor,
    };
  },
});
</script>

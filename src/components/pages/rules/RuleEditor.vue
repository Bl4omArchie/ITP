<template>
    <h1>Snort Rule Editor</h1>
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
</template>
  

<script lang="ts">  
    import "../../../styles/graphics/line_plot.css";
    import "../../../styles/boxes/SnortBox.css";
  
    export default {
      name: 'RuleEditor',
    };
</script>
<template>
    <div class="main-body">
        <h1>Modules</h1>
        <button class="snortButton snortButton--small" @click="showPopup = true">Open Popup</button>
    

        <div v-if="showPopup" class="snortPopup-overlay" @click.self="closePopup">
            <div class="snortPopup">
                <button class="snortPopup-close" @click="closePopup">&times;</button>
                
                <div class="snortPopup-content">
                    <h2>Popup Title</h2>
                    <p>Hello World!</p>
                </div>
            </div>
        </div>
    </div>
  </template>
  
<script lang="ts">
  export default {
    name: 'Modules',
    data() {
      return {
        showPopup: false,
      };
    },
    methods: {
      closePopup() {
        this.showPopup = false;
      },
    },
  };
</script>
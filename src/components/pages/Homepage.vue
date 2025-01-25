<template>
  <div>
      <h1>Homepage</h1>
      <div class="snortBox snortBox--NetworkViz"> 
          <NetworkVisualizer />
      </div>

      <div class="snortBox snortBox--v">
          <p>my second box </p>
      </div>
  </div>
</template>


<script lang="ts">
    import "../network/NetworkVisualizer.vue";
    import "../../styles/graphics/line_plot.css";
    import "../../styles/boxes/SnortBox.css";

    export default {
        name: 'Home',
    };
</script>
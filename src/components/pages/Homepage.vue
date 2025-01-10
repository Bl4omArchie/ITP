<template>
  <div>
      <h1>Homepage</h1>
      <div id="traffic-graph" class="snortBox snortBox--h"> </div>

      <div class="snortBox snortBox--v">
          <p>my second box </p>
      </div>

      <div class="snortBox snortBox--v">
          <p>my third box</p>
      </div>

      <div class="snortBox snortBox--h">
          <p>my fourth box </p>
      </div>
  </div>

</template>

<script lang="ts">
    import { onMounted } from 'vue';
    import * as d3 from 'd3';

    import "../../styles/graphics/line_plot.css";
    import "../../styles/boxes/snort_box.css";

    export default {
      name: 'Home',
      setup() {
        onMounted(() => {
          const data = [10, 20, 30, 40, 30, 50, 60, 70, 40, 50, 30, 80, 90, 70, 10, 20, 30, 25, 30, 41]; // Sample network traffic data

          const width = 600;
          const height = 400;
          
          const svg = d3.select('#traffic-graph')
                        .append('svg')
                        .attr('width', width)
                        .attr('height', height);

          const xScale = d3.scaleLinear()
                          .domain([0, data.length - 1]) // Data length range
                          .range([0, width]); // Pixel width

          const yScale = d3.scaleLinear()
                          .domain([0, d3.max(data) || 0]) // Y-axis range
                          .range([height, 0]); // Pixel height (inverted)

          const line = d3.line<number>()
                        .x((d, i) => xScale(i))
                        .y(d => yScale(d));

          svg.append('path')
            .data([data])
            .attr('class', 'line')
            .attr('d', line)
            .attr('fill', 'none')
            .attr('stroke', 'blue')
            .attr('stroke-width', 2);
        });
      }
    };
</script>
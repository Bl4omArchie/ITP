<template>
    <div id="traffic-graph" class="snortBox snortBox--NetworkViz"></div>
</template>
  
<script lang="ts">
    import { defineComponent, onMounted } from "vue";
    import * as d3 from "d3";

    import "../../styles/boxes/SnortBoxNetworkViz.css"
    
    export default defineComponent({
        name: "NetworkVisualizer",
        setup() {
        onMounted(() => {
            createNetworkVisualizer();
        });
    
        const createNetworkVisualizer = () => {
            const width = 800;
            const height = 400;
            const margin = { top: 20, right: 30, bottom: 50, left: 50 };
    
            const svg = d3
            .select("#traffic-graph")
            .append("svg")
            .attr("width", width)
            .attr("height", height);
    
            // Create scales
            const xScale = d3.scaleLinear().domain([0, 100]).range([margin.left, width - margin.right]);
            const yScale = d3.scaleLinear().domain([0, 100]).range([height - margin.bottom, margin.top]);
    
            // Add X-axis
            svg
            .append("g")
            .attr("transform", `translate(0,${height - margin.bottom})`)
            .call(d3.axisBottom(xScale));
    
            // Add Y-axis
            svg
            .append("g")
            .attr("transform", `translate(${margin.left},0)`)
            .call(d3.axisLeft(yScale));
    
            // Add grid lines
            svg
            .append("g")
            .attr("class", "grid")
            .selectAll("line.horizontal")
            .data(yScale.ticks())
            .enter()
            .append("line")
            .attr("class", "grid-line")
            .attr("x1", margin.left)
            .attr("x2", width - margin.right)
            .attr("y1", (d) => yScale(d))
            .attr("y2", (d) => yScale(d))
            .attr("stroke", "#ccc")
            .attr("stroke-width", 0.5);
    
            svg
            .append("g")
            .attr("class", "grid")
            .selectAll("line.vertical")
            .data(xScale.ticks())
            .enter()
            .append("line")
            .attr("class", "grid-line")
            .attr("y1", margin.top)
            .attr("y2", height - margin.bottom)
            .attr("x1", (d) => xScale(d))
            .attr("x2", (d) => xScale(d))
            .attr("stroke", "#ccc")
            .attr("stroke-width", 0.5);
    
            // Generate random network activity data
            const data = Array.from({ length: 100 }, (_, i) => ({
            x: i,
            y: Math.random() * 100,
            }));
    
            // Create line generator
            const line = d3
            .line<{ x: number; y: number }>()
            .x((d) => xScale(d.x))
            .y((d) => yScale(d.y))
            .curve(d3.curveBasis);
    
            // Add the line
            svg
            .append("path")
            .datum(data)
            .attr("fill", "none")
            .attr("stroke", "steelblue")
            .attr("stroke-width", 2)
            .attr("d", line);
        };
    
        return {};
        },
    });
</script>
  
looker.plugins.visualizations.add({
    id: "boxplot",
    label: "Boxplot MLB",
      options: {
          boxColors: {
              label: "Box Colors",
              type: "array",
              default: ["#45b54d", "#707878", "#2ca02c"],
              display: "colors",
          section: "Formatting"
          },
          boxFillColors: {
              label: "Box Fill Colors",
              type: "array",
              default: ["#FFFFFF", "#FFFFFF", "#FFFFFF"],
              display: "colors",
          section: "Formatting"
          },
          showLegend: {
              label: "Show Legend",
              type: "boolean",
              default: true,
          section: "Formatting",
          order: 1
          },
          yAxisMinValue: {
              label: "Min value",
              section: "Y",
              type: "number",
              placeholder: "Any number",
              display_size: "half",
          },
          yAxisMaxValue: {
              label: "Max value",
              section: "Y",
              type: "number",
              placeholder: "Any number",
              display_size: "half",
          },
          yAxisLabelFormat: {
              label: "Label Format",
              default: "",
              section: "Y",
              type: "string",
              placeholder: "$",
          }
      },

      create: function(element,config) {
        element.innerHTML = "";
      },

      update: function(data, element, config, queryResponse){
          // Invalid data structure error handling
          // if (!handleErrors(this, queryResponse, {
          //     min_pivots: 0, max_pivots: 1,
          //     min_dimensions: 1, max_dimensions: 1,
          //     min_measures: 5, max_measures: 5,
          // })) return;
          console.log("data", data);
          console.log("config", config);
          console.log("queryResponse", queryResponse);

          let x_dim = queryResponse.fields.dimensions[0];
          let min = queryResponse.fields.measures[0];
          let q25 = queryResponse.fields.measures[1];
          let med = queryResponse.fields.measures[2];
          let q75 = queryResponse.fields.measures[3];
          let max = queryResponse.fields.measures[4];


          let categories = [];
          // Get array of x axis categories
          data.forEach(function(row){
              categories.push(row[x_dim.name].value);
          });

          console.log("categories", categories);

          let series = [];
          let pivotCount = 0;
          // If there is a pivot create stacked series
          if(queryResponse.pivots) {
              //Loop through pivots to create stacks
              queryResponse.pivots.forEach(function(pivot) {
                  //loop through data to get the measures
                  dataArray = [];
                  data.forEach(function(row){
                      rowDataArray = [row[min.name][pivot.key].value,
                          row[q25.name][pivot.key].value,
                          row[med.name][pivot.key].value,
                          row[q75.name][pivot.key].value,
                          row[max.name][pivot.key].value];
                      dataArray.push(rowDataArray);
                  });
                  //Add the pivot name and associated measures to the series object
                  series.push({
                      name: pivot.key,
                      data: dataArray,
                      fillColor: config.boxFillColors[pivotCount] || '#ffffff',
                      legendColor: config.boxFillColors[pivotCount] || '#000000'
                  });
                  pivotCount++;
              });
          } else {
              dataArray = [];
              //loop through data to get the measures
              data.forEach(function(row){
                  rowDataArray = [row[min.name].value,
                      row[q25.name].value,
                      row[med.name].value,
                      row[q75.name].value,
                      row[max.name].value];
                  dataArray.push(rowDataArray);
              });
              //Add the pivot name and associated measures to the series object
              series.push({
                  name: min.field_group_label,
                  data: dataArray,
                  fillColor: config.boxFillColors[0] || '#ffffff',
                  legendColor: config.boxFillColors[0] || '#ffffff'
              });
          }

          console.log("series", series);

     let option = {
       ...this.options,
        yAxisName: {
          label: "Axis Name",
          type: "string",
          default: "",
          placeholder: min.field_label_group || y_dim.label,
          section: "Y"
        },
        xAxisName: {
          label: "Axis Name",
          type: "string",
          default: "",
          placeholder: x_dim.label_short || x_dim.label,
          section: "X"
        },
     };


    // Create options for each measure in your query
    /*series.forEach(function(serie) {

       id = typeof serie.name === "string" ? serie.name : serie.name.toString();
       offset = series.indexOf(serie) * 5;

       //set an invalid display type so only the label renders
       option[id + "_label"] = {
         label: id.toUpperCase(),
         type: "string",
         display: "label",
         section: "Series",
         order: offset + 1
       };

       option[id + "_color"] = {
        label: "Line Color",
        default: Highcharts.getOptions().colors[series.indexOf(serie)],
        section: "Series",
        type: "string",
        display: "color",
        order: offset + 2
       };

       option[id + "_marker"] = {
        // see https://jsfiddle.net/gh/get/library/pure/highcharts/highcharts/tree/master/samples/highcharts/plotoptions/series-marker-symbol/
        // and https://api.highcharts.com/highcharts/plotOptions.series.marker.symbol
        type: "string",
        label: "Line Symbol",
        values: [
          // options are 'circle', 'square','diamond', 'triangle' and 'triangle-down'
          {"Point": "circle"},
          {"Diamond": "diamond"},
          {"Square": "square"},
          {"Triangle": "triangle"},
          {"Reverse-Triangle": "triangle-down"},
        ],
        display: "select",
        default: Highcharts.getOptions().symbols[series.indexOf(serie)] || "Point",
        section: "Series",
        order: offset + 3
       };

       option[id + "_hideMarker"] = {
        type: "boolean",
        label: "Hide Symbols",
        section: "Series",
        default: false,
        order: offset + 4
      };

      option[id + "_valueLabels"] = {
        label: "Value Labels",
        type: "boolean",
        default: false,
        section: "Series",
        order: offset + 5
      };

      });*/

      this.trigger('registerOptions', option); // register options with parent page to update visConfig


          // Set Chart Options
          let options = {
              colors: config.boxColors,
              credits: {
                  enabled: false
              },
              chart: {type: "boxplot"},
              title: {text: ""},
              legend: {enabled: config.showLegend},

              xAxis: {
                  type: x_dim.is_timeframe ? "datetime" : null,
                  title: {
                      text: config.xAxisName || x_dim.label_short
                   },
                   categories: categories
              },

              yAxis: {
                  min: config.yAxisMinValue,
                  max: config.yAxisMaxValue,
                  title: {
                      text: config.yAxisName || min.field_group_label
                  },
                  labels: {
                      formatter: function() {
                          if (this.value >= 0) {
                              return config.yAxisLabelFormat + this.value;
                          } else {
                              return '-' + config.yAxisLabelFormat + (-this.value);
                          }
                      }
                  }
              },

              series: series
          };

          //Add functionality to have the legend reflect the fill color instead of the outline color
          (function(H) {
              H.wrap(H.Legend.prototype, 'colorizeItem', function(proceed, item, visible) {
                  var color = item.color;
                  item.color = item.options.legendColor;
                  proceed.apply(this, Array.prototype.slice.call(arguments, 1));
                  item.color = color;
              });
          }(Highcharts));

          // Instanciate Box Plot Highchart
          let myChart = Highcharts.chart(element, options);
      }
  });

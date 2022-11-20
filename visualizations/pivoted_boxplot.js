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
          xAxisName: {
              label: "Axis Name",
              section: "X Axis",
              type: "string",
              placeholder: "Provide an axis name ..."
          },
          yAxisName: {
              label: "Axis Name",
              section: "Y Axis",
              type: "string",
              placeholder: "Provide an axis name ..."
          },
          yAxisMinValue: {
              label: "Min value",
              default: null,
              section: "Y Axis",
              type: "number",
              placeholder: "Any number",
              display_size: "half",
          },
          yAxisMaxValue: {
              label: "Max value",
              default: null,
              section: "Y Axis",
              type: "number",
              placeholder: "Any number",
              display_size: "half",
          },
          yAxisLabelFormat: {
              label: "Label Format",
              default: "",
              section: "Y Axis",
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

          // Extract dimension data and measure names
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
          let dataArray = [];
          let pivotCount = 0;
          // If there is a pivot create stacked series
          if(queryResponse.pivots) {
              //Loop through pivots to create stacks
              queryResponse.pivots.forEach(function(pivot) {
                  //loop through data to get the measures
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
                  type: dim.is_timeframe ? "datetime" : null,
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

looker.plugins.visualizations.add({
    id: "scatter",
    label: "Custom Scatterplot",
      options: {
          showLegend: {
              label: "Show Legend",
              type: "boolean",
              default: true,
          section: "Formatting",
          order: 1
          },
          showYName:{
            label: "Show Axis Name",
            type: "boolean",
            default: true,
            section: "Y"
          },
          yAxisMinValue: {
              label: "Min value",
              section: "Y",
              type: "number",
              placeholder: "Any number",
              display_size: "half",
              order: 1,
          },
          yAxisMaxValue: {
              label: "Max value",
              section: "Y",
              type: "number",
              placeholder: "Any number",
              display_size: "half",
              order: 2,
          },
          /*yAxisLabelFormat: {
              label: "Label Format",
              default: "",
              section: "Y",
              type: "string",
              placeholder: "e.g: $",
          },*/
          showXName: {
            label: "Show Axis Name",
            type: "boolean",
            default: true,
            section: "X"
          },
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

          let x_dim = queryResponse.fields.dimensions[1];
          let y_dim = queryResponse.fields.dimensions[0];
          let seriesNames = queryResponse.fields.dimensions.slice(2);
          let series = [];
          //let categories = [];

          for(let i = 0; i < seriesNames.length; i++){
            series.push({
              name: seriesNames[i].label_short || seriesNames[i].label,
              data: data.map(row=>[row[x_dim.name].value, row[y_dim.name].value]),
              marker: {
                symbol: config[(seriesNames[i].label_short || seriesNames[i].label) + "_marker"],
                lineWidth: 1,
                lineColor: "#000000"
              },
              color: config[(seriesNames[i].label_short || seriesNames[i].label) + "_color"]
           });
          }


          // Get array of x axis categories
          /*data.forEach(row=>{
              categories.push(row[x_dim.name].value);
          });

          console.log("categories", categories);*/

          console.log("series", series);

     let option = {
       ...this.options,
        yAxisName: {
          label: "Axis Name",
          type: "string",
          default: "",
          placeholder: y_dim.label_short || y_dim.label,
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
    series.forEach(function(serie) {

       id = typeof serie.name === "string" ? serie.name : serie.name.toString();
       offset = series.indexOf(serie) * 3;

       //set an invalid display type so only the label renders
        option[id + "_label"] = {
          label: id.toUpperCase(),
          type: "string",
          display: "label",
          section: "Series",
          order: offset + 1
        };

      option[id + "_color"] = {
        label: "Point Color",
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

    });

      this.trigger('registerOptions', option); // register options with parent page to update visConfig

      Highcharts.setOptions({
          lang: {
              thousandsSep: ''
          }
      });


          // Set Chart Options
          let options = {
              //colors: config.boxColors,
              credits: {
                  enabled: false
              },
              chart: {
                type: "scatter",
                zoomType: 'xy'
              },
              title: {text: ""},
              legend: {
                  layout: 'horizontal',
                  align: 'center',
                  verticalAlign: 'bottom',
                  enabled: config.showLegend
              },

              xAxis: {
                  title: {
                      text: config.xAxisName || x_dim.label_short,
                      enabled: config.showXName,
                   },
                    startOnTick: true,
                    endOnTick: true,
                    showLastLabel: true,
                  // categories: categories
              },
              yAxis: {
                  min: config.yAxisMinValue,
                  max: config.yAxisMaxValue,
                  title: {
                      text: config.yAxisName || y_dim.label_short,
                      enabled: config.showYName,
                  },
                  /*labels: {
                    formatter: function() {
                      return this.value >= 0 ? config.yAxisLabelFormat + this.value : '-' + config.yAxisLabelFormat + (-this.value);
                    }
                  }*/
              },
              tooltip:{
                pointFormat: (config.xAxisName || x_dim.label_short) + ": {point.x} <br/>" + (config.yAxisName || y_dim.label_short) + ": {point.y}"
              },
              series
          };
          // Instanciate Box Plot Highchart
          Highcharts.chart(element, options);
      }
  });

// see https://github.com/looker/custom_visualizations_v2/blob/master/docs/api_reference.md#presenting-configuration-ui
looker.plugins.visualizations.add({
  id: "2dline",
  label: "2D Line",
  options: {
    // Formatting
    showLegend: {
      label: "Show Legend",
      type: "boolean",
      default: true,
      section: "Formatting",
      order: 1,
    },
    testDropdown:{
      label:"Accordion",
      section: "test",
      children: {
        someToggle: {
        label: "Some toggle",
        type: "boolean",
        default: true,
        order: 1,
        },
        someInput:{
          label:'some input',
          type:"string",
          default:'hi',
          order:2
        }
      }
    },
    // Y Axis options

    showYName:{
        label: "Show Axis Name",
        type: "boolean",
        default: true,
        section: "Y"
      },
    yAxisMinValue: {
      label: "Min value (%)",
        default: 0,
        section: "Y",
        type: "number",
        display_size: "half",
        order: 1
      },
      yAxisMaxValue: {
        label: "Max value (%)",
        default: 100,
        section: "Y",
        type: "number",
        display_size: "half",
        order: 2
      },
      // X Axis options

      showXName: {
        label: "Show Axis Name",
        type: "boolean",
        default: true,
        section: "X"
      },
      // Value options
      valueLabels: {
        label:"Value Labels",
        type:"boolean",
        default: false,
        section: "Values"
      },
      // Series Options
      /*colors: {
        label: "Colors",
        type: "array",
        default: Highcharts.getOptions().colors,
        display: "colors",
        section: "Series",
        order: 1,
      },*/
      /*marker: {
        // see https://jsfiddle.net/gh/get/library/pure/highcharts/highcharts/tree/master/samples/highcharts/plotoptions/series-marker-symbol/
        // and https://api.highcharts.com/highcharts/plotOptions.series.marker.symbol
        type: "string",
        label: "Point type",
        values: [
          // options are 'circle', 'square','diamond', 'triangle' and 'triangle-down'
          {"Point": "circle"},
          {"Square": "square"},
          {"Diamond": "diamond"},
          {"Triangle": "triangle"},
          {"Reverse-Triangle": "triangle-down"},
        ],
        display: "select",
        default: "Point",
        section: "Series",
        order: 2
      },*/
      //easier to hide the pointers than to make a 'none' type
      hideMarker:{
        type:"boolean",
        label: "Hide Markers",
        section: "Series",
        default: false,
        order:1
      }
  },

  create: function (element, config) {
    element.innerHTML = "";
  },

  update: function (data, element, config, queryResponse) {
    console.log("data", data);
    console.log("config", config);
    console.log("queryResponse", queryResponse);
    element.innerHTML = JSON.stringify(data);
    let dataArray = [];
    let series = [];
    let x_dim_1 = queryResponse.fields.dimensions[0];
    let x_dim_2 = queryResponse.fields.dimensions[1];
    let y_dim = queryResponse.fields.table_calculations[0];

    let minMeasureName = queryResponse.fields.measure_like[0]?.name;
    let q25MeasureName = queryResponse.fields.measure_like[1]?.name;
    let medMeasureName = queryResponse.fields.measure_like[2]?.name;
    let q75MeasureName = queryResponse.fields.measure_like[3]?.name;
    let maxMeasureName = queryResponse.fields.measure_like[4]?.name;



    //create array with required data to pivot
    //["Experiment Variant", "Last Level Completed", "churn"],
    //dataArray.push([x_dim_1.label,x_dim_2.label,y_dim.label]);
    data.map((row)=>dataArray.push([row[x_dim_1.name].value, row[x_dim_2.name].value, Math.round(row[y_dim.name].value * 100)]));

    console.log("dataArray", dataArray);

    function getPivotArray(array, rowIndex, colIndex, dataIndex) {
          //Code from https://techbrij.com
          var result = {}, ret = [];
          var newCols = [];
          for (var i = 0; i < array.length; i++) {

              if (!result[array[i][rowIndex]]) {
                  result[array[i][rowIndex]] = {};
              }
              result[array[i][rowIndex]][array[i][colIndex]] = array[i][dataIndex];

              //To get column names
              if (newCols.indexOf(array[i][colIndex]) == -1) {
                  newCols.push(array[i][colIndex]);
              }
          }

          newCols.sort();
          var item = [];

          //Add Header Row
          item.push(x_dim_2.label);
          item.push.apply(item, newCols);
          ret.push(item);

          //Add content
          for (var key in result) {
              item = [];
              item.push(key);
              for (var i = 0; i < newCols.length; i++) {
                  item.push(result[key][newCols[i]] === 0 ? 0 : result[key][newCols[i]] || "-" );
              }
              ret.push(item);
          }
          return ret;
      }

      var output = getPivotArray(dataArray, 1, 0, 2);

      console.log("output",output);


    for (let i = 1; i<output[0].length; i++) {
      series.push({
        name: output[0][i],
        data: output.slice(1).map((element) => element[i]),
        tooltip: {
          valueSuffix: '%'
        },
        dataLabels: {
          enabled: config.valueLabels,
          format: '{point.y}%'
        },
        color: config[output[0][i] + " color"] || Highcharts.getOptions().colors[i-1],
          marker: {
            symbol: config[output[0][i] + " marker"] || Highcharts.getOptions().symbols[i-1],
            enabled: !config.hideMarker,
            states: {
              hover: {
                enabled: !config.hideMarker
              }
          }
        }
      });
    }

    console.log("series", series);

    console.log("options",this.options);

    //further chart customization options that depend on queried data should go here
     let option = {
       ...this.options,
        yAxisName: {
          label: "Axis Name",
          type: "string",
          default: "",
          placeholder:y_dim.label_short || y_dim.label,
          section: "Y"
        },
        xAxisName: {
          label: "Axis Name",
          type: "string",
          default: "",
          placeholder:x_dim_2.label_short || x_dim_2.label,
          section: "X"
        },
     };


    // Create an option for each measure in your query
    series.forEach(function(serie) {

       id = serie.name;

       option[id + " color"] = {
        label: 'color',
        default: Highcharts.getOptions().colors[series.indexOf(serie)],
        section: "Series",
        type: "string",
        display: "color"
       };

       option[id + " marker"] = {
        // see https://jsfiddle.net/gh/get/library/pure/highcharts/highcharts/tree/master/samples/highcharts/plotoptions/series-marker-symbol/
        // and https://api.highcharts.com/highcharts/plotOptions.series.marker.symbol
        type: "string",
        label: "Point type",
        values: [
          // options are 'circle', 'square','diamond', 'triangle' and 'triangle-down'
          {"Point": "circle"},
          {"Square": "square"},
          {"Diamond": "diamond"},
          {"Triangle": "triangle"},
          {"Reverse-Triangle": "triangle-down"},
        ],
        display: "select",
        default: Highcharts.getOptions().symbols[series.indexOf(serie)] || "Point",
        section: "Series",
       }

     });

     this.trigger('registerOptions', option); // register options with parent page to update visConfig

    //options object to be passed to Highcharts
    const options = {
      title: "",
      legend: {
          layout: 'horizontal',
          align: 'center',
          verticalAlign: 'bottom',
          enabled: config.showLegend
      },

      yAxis: {
        title: {
          text: config.yAxisName || y_dim.label,
          enabled: config.showYName,
        },
        labels: {
         format: '{value}%'
        },
        min: config.yAxisMinValue,
        max: config.yAxisMaxValue
      },
      xAxis: {
        title: {
          text: config.xAxisName || x_dim_2.label_short,
          enabled: config.showXName,
          categories: output.slice(1).map((element) => element[0])
        },
      },
      //testing markers on line points
      /*plotOptions: {
        series: {
          marker: {
            symbol: config.marker,
            enabled: !config.hideMarker,
            states: {
              hover: {
                enabled: !config.hideMarker
              }
            }
          }
      }
    },*/

      series,
    };

    Highcharts.chart(element, options);



  },
});

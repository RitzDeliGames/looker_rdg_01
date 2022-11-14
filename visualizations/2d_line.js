// see https://github.com/looker/custom_visualizations_v2/blob/master/docs/api_reference.md#presenting-configuration-ui
looker.plugins.visualizations.add({
  id: "2dline",
  label: "2D Line",
  options: {
    // Plot
    showLegend: {
      label: "Show Legend",
      type: "boolean",
      default: true,
      section: "Plot",
      order: 1,
    },
    // Y Axis options

    showYName:{
        label: "Show Axis Name",
        type: "boolean",
        default: true,
        section: "Y"
      },
    yAxisMinValue: {
      label: "Min value",
        default: 0,
        section: "Y",
        type: "number",
        display_size: "half",
        order: 1
      },
      yAxisMaxValue: {
        label: "Max value",
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
  },

  create: function (element, config) {
    element.innerHTML = "";
  },

  update: function (data, element, config, queryResponse) {
    console.log("data", data);
    console.log("config", config);
    console.log("queryResponse", queryResponse);
    //element.innerHTML = JSON.stringify(data);
    let dataArray = [];
    let series = [];
    let x_dim_1 = queryResponse.fields.dimensions[0];
    let x_dim_2 = queryResponse.fields.dimensions[1];
    let y_dim = queryResponse.fields.table_calculations[0];
    let pivot = queryResponse.pivots[0];
    let dispVal = "";
      console.log("y_dim", y_dim);

    //create array with required data to pivot\
    //dataArray.push([x_dim_1.label,x_dim_2.label,y_dim.label]);

    data.forEach((row) => {
      let val = row[y_dim.name].rendered || row[y_dim.name].rendered === "" ? row[y_dim.name].rendered : row[y_dim.name][pivot.key].rendered ;
      if(val !== "null" && val.includes("%"))
        dispVal = "%";
      if(val !== "null" && val.includes("$"))
        dispVal = "$";
    });
    data.map((row)=>dataArray.push([row[x_dim_1.name].value, row[x_dim_2.name].value, row[y_dim.name].value || row[y_dim.name].value ===  null || row[y_dim.name].value ===  0  ? row[y_dim.name].value : row[y_dim.name][pivot.key].value]));

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
                  item.push(result[key][newCols[i]] || 0 );
              }
              ret.push(item);
          }
          return ret;
      }

      var output = getPivotArray(dataArray, 1, 0, 2);

      console.log("output", output);

    for (let i = 1; i<output[0].length; i++) {
      series.push({
        name: output[0][i] || "Null",
        data: dispVal === "%" ? output.slice(1).map((element) => Math.round(element[i] * 100))  : dispVal === "$" ? output.slice(1).map((element) => Number(element[i].toFixed(2))) : output.slice(1).map((element) => element[i]),
        tooltip: {
          valueSuffix: dispVal === "%" ? "%" : "",
          valuePrefix: dispVal === "$" ? "$" : ""
        },
        dataLabels: {
          enabled: config[output[0][i] + "_valueLabels"],
          format: dispVal === "%" ? "{point.y}%" : dispVal === "$" ? "${point.y}": "{point.y}"
        },
        color: config[output[0][i] + "_color"] || Highcharts.getOptions().colors[i-1],
          marker: {
            symbol: config[output[0][i] + "_marker"] || Highcharts.getOptions().symbols[i-1],
            enabled: !config[output[0][i] + "_hideMarker"],
            states: {
              hover: {
                enabled: !config[output[0][i] + "_hideMarker"]
              }
          }
        }
      });
    }

    console.log("series", series);

    //further chart customization options that depend on queried data should go here
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
          placeholder: x_dim_2.label_short || x_dim_2.label,
          section: "X"
        },
     };


    // Create options for each measure in your query
    series.forEach(function(serie) {

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
          text: config.yAxisName || y_dim.label_short || y_dim.label,
          enabled: config.showYName,
        },
        labels: {
         format: dispVal === "%" ? "{value}%" : dispVal === "$" ? "${value}": "{value}"
        },
        min: config.yAxisMinValue,
        max: config.yAxisMaxValue
      },
      xAxis: {
        title: {
          text: config.xAxisName || x_dim_2.label_short || x_dim_2.label,
          enabled: config.showXName,
        },
        categories: output.slice(1).map((element) => element[0]),
      },
      series,
    };
    console.log("chart options", options);

    Highcharts.chart(element, options);



  },
});

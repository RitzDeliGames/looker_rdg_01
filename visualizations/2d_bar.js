// see https://github.com/looker/custom_visualizations_v2/blob/master/docs/api_reference.md#presenting-configuration-ui
looker.plugins.visualizations.add({
    id: "2dbar",
    label: "2D Bar",
    options: {},

    create: function (element, config) {
      element.innerHTML = "";
    },

    update: function (data, element, config, queryResponse) {
      console.log("data", data);
      console.log("config", config);
      console.log("queryResponse", queryResponse);
      element.innerHTML = JSON.stringify(data);
      let categories = [];
      let series = [];
      let x_dim_1 = queryResponse.pivots;
      let x_dim_2 = queryResponse.fields.dimensions[1];
      let y_dim = queryResponse.fields.measures[0];
      console.log("x_dim_1", x_dim_1);
      console.log("x_dim_2", x_dim_2);
      console.log("y_dim", y_dim);

      //let minMeasureName = queryResponse.fields.measure_like[0]?.name;
      //let q25MeasureName = queryResponse.fields.measure_like[1]?.name;
      //let medMeasureName = queryResponse.fields.measure_like[2]?.name;
      //let q75MeasureName = queryResponse.fields.measure_like[3]?.name;
      //let maxMeasureName = queryResponse.fields.measure_like[4]?.name;

      //create array with required data to pivot\
      //dataArray.push([x_dim_1.label,x_dim_2.label,y_dim.label]);
     /* data.map((row)=>dataArray.push([row[x_dim_1.name].value, row[x_dim_2.name].value, row[y_dim.name].value]));

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
        console.log("dataArray", dataArray);

        var output = getPivotArray(dataArray, 1, 0, 2);

        console.log("output", output);*/

      for (let i = 1; i<x_dim_1.length; i++) {
        series.push({
          name: x_dim_1[i].key,
          data: data.map((row) => row[y_dim.name][x_dim_1[i].key].value)
        });
        /*series.push({
          name: output[0][i],
          data: output.slice(1).map((element) => element[i]),
          tooltip: {
            valueSuffix: '%'
          },
          dataLabels: {
            enabled: config[output[0][i] + "_valueLabels"],
            format: '{point.y}%'
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
        });*/
      }
      for(let i = 0; i < data.length; i++){
        if (categories.indexOf(data[i][x_dim_2.name].value) == -1)
        categories.push(data[i][x_dim_2.name].value);
      }


      console.log("series", series);
      console.log("categories", categories);

      //further chart customization options that depend on queried data should go here
       /*let option = {
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

         id = serie.name;
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
          type:"boolean",
          label: "Hide Symbols",
          section: "Series",
          default: false,
          order: offset + 4
        };

        option[id + "_valueLabels"] = {
          label:"Value Labels",
          type:"boolean",
          default: false,
          section: "Series",
          order: offset + 5
        };

        });

        this.trigger('registerOptions', option); // register options with parent page to update visConfig

        console.log("options",this.options);*/

      //options object to be passed to Highcharts
      const options = {
        /*title: "",
        legend: {
            layout: 'horizontal',
            align: 'center',
            verticalAlign: 'bottom',
            enabled: config.showLegend
        },*/

        chart:{
          type:"column"
        },
        /*yAxis: {
          title: {
            text: config.yAxisName || y_dim.label,
            enabled: config.showYName,
          },
          labels: {
           format: '{value}%'
          },
          min: config.yAxisMinValue,
          max: config.yAxisMaxValue
        },*/
        xAxis: {
          /*title: {
            text: config.xAxisName || x_dim_2.label_short,
            enabled: config.showXName,
          },*/
          categories: categories,
        },
        series,
      };

      Highcharts.chart(element, options);
    },
  });

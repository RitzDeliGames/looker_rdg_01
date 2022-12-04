// see https://github.com/looker/custom_visualizations_v2/blob/master/docs/api_reference.md#presenting-configuration-ui
looker.plugins.visualizations.add({
    id: "2dcolumn",
    label: "2D Column",
    options: {
      // Plot
      showLegend: {
        label: "Show Legend",
        type: "boolean",
        default: true,
        section: "Plot",
        order: 1,
      },
      seriesPositioning: {
        label: "Series Positioning",
        section: "Plot",
        type: "string",
        display: "select",
        default: "normal",
        values: [
          {"Grouped": ""},
          {"Stacked": "normal"},
          {"Stacked Percentage": "percent"},
        ],
        order: 2,
      },
      sortStacks: {
        label: "Sort Stacks",
        section:"Plot",
        type:"string",
        display: "select",
        default: "",
        hidden: false,
        values: [
          {"None":""},
          {"Ascending":"ascending"},
          {"Descending":"descending"},
        ],
        order: 3
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
          placeholder: "Min value",
          section: "Y",
          type: "number",
          display_size: "half",
          order: 1
        },
        yAxisMaxValue: {
          label: "Max value",
          placeholder: "Max value",
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
      element.innerHTML = JSON.stringify(data);
      let dataArray = [];
      let categories = [];
      let series = [];
      let x_dim_1 = queryResponse.fields.dimensions[0];
      let x_dim_2 = queryResponse.fields.dimensions[1];
      let y_dim = queryResponse.fields.measures[0];
      let pivot = queryResponse.pivots;
      /*console.log("x_dim_1", x_dim_1);
      console.log("x_dim_2", x_dim_2);
      console.log("y_dim", y_dim);
      console.log("pivot", pivot);*/

      //create array with required data to pivot
      data.map((row)=>dataArray.push([row[x_dim_1.name].value, row[x_dim_2.name].value, row[y_dim.name].value || row[y_dim.name]]));

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
                    item.push(result[key][newCols[i]] || {});
                }
                ret.push(item);
            }
            return ret;
        }
        console.log("dataArray", dataArray);

        var output = getPivotArray(dataArray, 1, 0, 2);

        console.log("output", output);

      for(let j = 0 ; j < pivot.length; j++) {
        for (let i = 1; i< output[0].length; i++) {
          series.push({
            name: pivot[j].key + " (" + output[0][i] + ")",
            data: output.slice(1).map((element) => element[i][pivot[j].key] ? element[i][pivot[j].key].value : 0),
            stack: output[0][i],
            color: config[pivot[j].key  + " (" + output[0][i] + ")" + "_color"] || Highcharts.getOptions().colors[j],
            dataLabels: {
              enabled: config[pivot[j].key  + " (" + output[0][i] + ")" + "_valueLabels"],
              format: '{point.y}'
            },
          });
        }
      }

      if (config.sortStacks !== ""){
        series.sort((a, b)=>{
          const nameA = a.name.toUpperCase();
          const nameB = b.name.toUpperCase();
          if (a.data[0] < b.data[0]) {
            return config.sortStacks === "ascending"? -1 : 1;
          }
          if (a.data[0] > b.data[0]) {
            return config.sortStacks === "ascending"? 1 : -1;
          }
          return 0;
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

       option.sortStacks.hidden = !config.seriesPositioning;


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
          label: "Column Color",
          default: serie.color,
          section: "Series",
          type: "string",
          display: "color",
          order: offset + 2
         };

         option[id + "_valueLabels"] = {
          label:"Value Labels",
          type:"boolean",
          default: false,
          section: "Series",
          order: offset + 3
        };
      });
      this.trigger('registerOptions', option); // register options with parent page to update visConfig

      console.log("options",this.options);

      Highcharts.setOptions({
          lang: {
              thousandsSep: ','
          }
      });

      //options object to be passed to Highcharts
      const options = {
        title: "",
        legend: {
            layout: 'horizontal',
            align: 'center',
            verticalAlign: 'bottom',
            enabled: config.showLegend
        },

        chart:{
          type:"column"
        },
        yAxis: {
          title: {
            text: config.yAxisName || y_dim.label_short || y_dim.label,
            enabled: config.showYName,
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

        tooltip:{
          valueSuffix: config.seriesPositioning === "percent" ? " ({point.percentage:.1f}%)" : "",
          pointFormat:"{series.name}: {point.y}"
        },
        plotOptions: {
            series: {
                stacking: config.seriesPositioning || undefined
            }
        },
        series,
      };

      Highcharts.chart(element, options);
    },
  });

looker.plugins.visualizations.add({
  id: "2dline",
  label: "2D Line",
  options: {
    showLegend: {
          label: "Show Legend",
          type: "boolean",
          default: true,
          section: "Formatting",
          order: 1,
          },
    yAxisName: {
      label: "Axis Name",
      type: "string",
      default: "Churn by level",
      section: "Y"
    },
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
      xAxisName: {
        label: "Axis Name",
        type: "string",
        default: "Level number",
        section: "X"
      },
      showXName: {
        label: "Show Axis Name",
        type: "boolean",
        default: true,
        section: "X"
      },
      valueLabels: {
        label:"Value Labels",
        type:"boolean",
        default: false,
        section: "Values"
      },
      palette: {
        label: "Palette",
        type: "array",
        default: Highcharts.getOptions().colors,
        display: "colors",
        section: "Series"
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
  let y_dim = queryResponse.fields.table_calculations[1];

  let minMeasureName = queryResponse.fields.measure_like[0]?.name;
  let q25MeasureName = queryResponse.fields.measure_like[1]?.name;
  let medMeasureName = queryResponse.fields.measure_like[2]?.name;
  let q75MeasureName = queryResponse.fields.measure_like[3]?.name;
  let maxMeasureName = queryResponse.fields.measure_like[4]?.name;



  //create array with required data to pivot
  //["Experiment Variant", "Last Level Completed", "churn"],
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
        item.push('Level');
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


  for (let i = 1; i<output[0].length; i++){
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
    color: config.palette[i]
  });
  }



  console.log("series", series);

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
        text: config.yAxisName,
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
        text: config.xAxisName,
        enabled: config.showXName,
      },
    },

    series,
  };

  Highcharts.chart(element, options);



  },
});

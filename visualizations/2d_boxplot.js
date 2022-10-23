looker.plugins.visualizations.add({
  id: "2dboxplot",
  label: "2D Boxplot",
  options: {
              boxFillColors: {
              label: "Box Fill Colors",
              type: "array",
              default: ["#FFFFFF", "#FFFFFF", "#FFFFFF"],
              display: "colors",
          section: "Formatting"
          },
          yAxisName: {
              label: "Axis Name",
              section: "Y Axis",
              type: "string",
              placeholder: "Provide an axis name ..."
          },
  },
  create: function(element,config) {
  element.innerHTML = "";
  },
  update: function(data, element, config, queryResponse){
  // console.log('data', data)
  // console.log('config', config)
  // console.log('queryResponse', queryResponse)
  // element.innerHTML = JSON.stringify(data)

  let categories = [];
  let series = [];
  let x_dim = queryResponse.fields.dimensions[1];
  let y_dim = queryResponse.fields.dimension_like[0];

  let minMeasureName = queryResponse.fields.measure_like[0]?.name;
  let q25MeasureName = queryResponse.fields.measure_like[1]?.name;
  let medMeasureName = queryResponse.fields.measure_like[2]?.name;
  let q75MeasureName = queryResponse.fields.measure_like[3]?.name;
  let maxMeasureName = queryResponse.fields.measure_like[4]?.name;

  data.forEach(function (row) {
    categories.push(row[x_dim.name].value);
  });

  dataArray = [];
  //loop through data to get the measures
  data.forEach(function (row) {
    rowDataArray = [
      row[minMeasureName].value,
      row[q25MeasureName].value,
      row[medMeasureName].value,
      row[q75MeasureName].value,
      row[maxMeasureName].value,
    ];
    dataArray.push(rowDataArray);
  });

    series.push({
    name: config.yAxisName,
    data: dataArray,
    fillColor: config.boxFillColors[0],
    legendColor: config.boxFillColors[0],
  });

  const options = {
    chart: {
      type: "boxplot",
    },

    legend: {
      enabled: false,
    },

    xAxis: {
      categories,
      title: {
        text: "Last Level Completed",
      },
    },

    yAxis: {
      title: {
        text: "Experiment Variant",
      },
    },

    series,
  };

  Highcharts.chart(element, options);

  }
})

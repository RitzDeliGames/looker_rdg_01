looker.plugins.visualizations.add({
  id: "2dline",
  label: "2D Line",
  options: {},
  create: function (element, config) {
    element.innerHTML = "";
  },
  update: function (data, element, config, queryResponse) {
    console.log("data", data);
    console.log("config", config);
    console.log("queryResponse", queryResponse);
    element.innerHTML = JSON.stringify(data);
    let series = [];
  let x_dim_1 = queryResponse.fields.dimensions[1];
  let x_dim_2 = queryResponse.fields.dimensions[0];
  let y_dim = queryResponse.fields.table_calculations[1];
  console.log(y_dim)

  let minMeasureName = queryResponse.fields.measure_like[0]?.name;
  let q25MeasureName = queryResponse.fields.measure_like[1]?.name;
  let medMeasureName = queryResponse.fields.measure_like[2]?.name;
  let q75MeasureName = queryResponse.fields.measure_like[3]?.name;
  let maxMeasureName = queryResponse.fields.measure_like[4]?.name;

  /*series.push({
    name: "Last Level Completed",
    data: data.map((row) => row[x_dim_1.name].value),
  });

  series.push({
    name: "Experiment Variant",
    data: data.map((row) => row[x_dim_2.name].value),
  });*/

  //create array with required data to pivot
  series.push(["Experiment Variant", "Last Level Completed", "churn"]);
  data.map((row)=>series.push([row[x_dim_1.name].value, row[x_dim_2.name].value, row[y_dim.name].value]));

  console.log("series", series);


  const options = {
    legend: {
      enabled: false,
    },

    yAxis: {
      title: {
        text: 'Churn per Minute',
      },
    },

    series,
  };

  Highcharts.chart(element, options);

  },
});

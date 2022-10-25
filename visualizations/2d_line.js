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
  let x_dim_1 = queryResponse.fields.dimensions[0];
  let x_dim_2 = queryResponse.fields.dimensions[1];
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
  //["Experiment Variant", "Last Level Completed", "churn"],
  data.map((row)=>series.push([row[x_dim_1.name].value, row[x_dim_2.name].value, row[y_dim.name].value]));

  console.log("series", series);

  function getPivotArray(dataArray, rowIndex, colIndex, dataIndex) {
        //Code from https://techbrij.com
        var result = {}, ret = [];
        var newCols = [];
        for (var i = 0; i < dataArray.length; i++) {

            if (!result[dataArray[i][rowIndex]]) {
                result[dataArray[i][rowIndex]] = {};
            }
            result[dataArray[i][rowIndex]][dataArray[i][colIndex]] = dataArray[i][dataIndex];

            //To get column names
            if (newCols.indexOf(dataArray[i][colIndex]) == -1) {
                newCols.push(dataArray[i][colIndex]);
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
                item.push(result[key][newCols[i]] || "-");
            }
            ret.push(item);
        }
        return ret;
    }

    var output = getPivotArray(series, 1, 0, 2);


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

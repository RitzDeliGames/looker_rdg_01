looker.plugins.visualizations.add({
  id: "2dline",
  label: "2D Line",
  options: {},
  create: function (element, config) {
    element.innerHTML = "<h1>line chart</h1>";
  },
  update: function (data, element, config, queryResponse) {
    console.log("data", data);
    console.log("config", config);
    console.log("queryResponse", queryResponse);
    element.innerHTML = JSON.stringify(data);
  },
});

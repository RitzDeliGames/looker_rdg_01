looker.plugins.visualizations.add({
  id: "2dboxplot",
  label: "2D Boxplot",
  options: {},
  create: function(element,config) {
  element.innerHTML = "<h1>demo</h1>";
  },
  update: function(data, element, config, queryResponse){
   console.log('data', data)
   console.log('config', config)
   console.log('queryResponse', queryResponse)
   element.innerHTML = JSON.stringify(data)
  }
})

var KafkaTask = function(){
  var that = {};
  
  var require = function(namespaces, properties){
    namespacesArray = namespaces.split(".");
    var parent = window;
    $.each(namespacesArray, function(i, namespace){
      if (typeof parent[namespace] === "undefined") {
        parent[namespace] = {};
      }
      parent = parent[namespace];
    });
    $.extend(parent, properties);
  };
  that.require = require;
  
  return that;
}();
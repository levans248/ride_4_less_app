(function() {
  "use strict";

  angular.module("app").controller("uberWorldDataController",[ "$scope", "$window", "$http", function($scope, $window, $http) {

  $scope.linkSelected = $window.linkSelected;
  $scope.dataCollection = false;
  $scope.surgeMultiplierTimeSeries = false;
  $scope.showButtons = false;
  $scope.dataCollection = false;
  $scope.showGraph = true;

  if($scope.linkSelected == "international_data_collection") {
    $scope.dataCollection = true;
    $scope.showGraph = false;
  } else if($scope.linkSelected == "international_data_analysis") {
    $scope.showGraph = false;
    $scope.internationalDataAnalysis = true;
  }

  $scope.fetchSaturdayNightData = function() {
    $http.get('/api/v1/uber_world_data.json?linkClicked=' + $scope.linkSelected).then(function(response){
      if($scope.linkSelected == "surge_vs_time_of_day") {
        $scope.showButtons = true;
        $scope.surgeMultiplierTimeSeries = true;
        $scope.all_data = response.data;
        $scope.internationalSurgeVsTimeOfDay(response.data);
      }  
    })
  }

  $scope.internationalSurgeVsTimeOfDay = function(json_data){
    internationalSurgeVsTimeOfDay(json_data);
  } 

  $scope.displayAppropriateInfo = function() {
    if($scope.linkSelected == "international_data_collection") {
      dataCollectionMap([[37.7929437, -122.4204894],[29.9594921, -90.0670762],[40.758895, -73.9873197],[41.8336478, -87.8722387],[34.0937458, -118.3614975],[47.6072369, -122.33271],[39.7642548, -104.995949],[42.313352, -71.1271968],[35.6735408, 139.5703023],[48.8588377, 2.27751174],[51.5285582, -0.2416805],[-31.9546516, 115.8351524],[22.2794966, 114.1644669],[13.724561, 100.4930251],[-22.9109878, -43.7285235]]);
    } else {
      $scope.fetchSaturdayNightData();
    }
  }

  window.$scope = $scope;

  }]);
})()
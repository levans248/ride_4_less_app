(function() {
  "use strict";

  angular.module("app").controller("newYearsRideDataController", function($scope, $http) {

    $scope.tabSelected = "";
    $scope.surgeVsTime = function(filter) {
      $http.get('/api/v1/new_years_data.json?filter='+ filter + '&linkClicked=' + $scope.tabSelected).then(function(response){
        $scope.all_data = response.data;
        $scope.surgeVsWaitTimeHighChart(response.data);
      });
    }

    $scope.surgeVsWaitTimeHighChart = function(json_data) {
      surgeVsWaitTime(json_data);
    }

    $scope.surgeVsTimeOfDay = function(json_data) {
      

    }

    window.$scope = $scope;


  });
})()
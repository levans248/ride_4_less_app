(function() {
  "use strict";

  angular.module("app").controller("newYearsRideDataController",[ "$scope", "$window", "$http", function($scope, $window, $http) {

    $scope.linkSelected = $window.linkSelected;
    $scope.showButtons = false;
    $scope.showChartInstructions = false;

    $scope.fetchNewYearsData = function(filter) {
      $http.get('/api/v1/new_years_data.json?filter='+ filter + '&linkClicked=' + $scope.linkSelected).then(function(response){
        if($scope.linkSelected == "surge_vs_wait_time") {
          $scope.all_data = response.data;
          $scope.surgeVsWaitTimeHighChart(response.data);
        } else if($scope.linkSelected == "surge_vs_time_of_day") {
          $scope.all_data = response.data;
          $scope.surgeVsTimeOfDayHighChart(response.data);
        } else if($scope.linkSelected == "wait_time_vs_time_of_day") {
          $scope.all_data = response.data;
          $scope.waitTimeVsTimeOfDay(response.data);
        }
      });
    }

    $scope.surgeVsWaitTimeHighChart = function(json_data) {
      $scope.showButtons = true;
      surgeVsWaitTime(json_data);
    }

    $scope.surgeVsTimeOfDayHighChart = function(json_data) {
      $scope.showChartInstructions = true;
      surgeVsTimeOfDay(json_data);
    }

    $scope.waitTimeVsTimeOfDay = function(json_data) {
      $scope.showChartInstructions = true;
      waitTimeVsTimeOfDay(json_data);
    }


    window.$scope = $scope;


  }]);
})()
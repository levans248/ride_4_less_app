(function() {
  "use strict";

  angular.module("app").controller("newYearsRideDataController",[ "$scope", "$window", "$http", function($scope, $window, $http) {

    $scope.linkSelected = $window.linkSelected;
    $scope.showGraph = true;
    $scope.showButtons = false;
    $scope.showChartInstructions = false;
    $scope.dataCollection = false;
    $scope.newYearsDataAnalysis = false;
    $scope.surgeMultiplierTimeSeries = false;
    $scope.waitTimeTimeSeries = false;
    


    if($scope.linkSelected == "nye_data_collection") {
      $scope.showGraph = false;
      $scope.dataCollection = true;
    } else if($scope.linkSelected == "nye_data_analysis") {
      $scope.showGraph = false;
      $scope.newYearsDataAnalysis = true;
    } 

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
      $scope.surgeMultiplierTimeSeries = true;
      surgeVsTimeOfDay(json_data);
    }

    $scope.waitTimeVsTimeOfDay = function(json_data) {
      $scope.waitTimeTimeSeries = true;
      $scope.showChartInstructions = true;
      waitTimeVsTimeOfDay(json_data);
    }

    $scope.displayAppropriateInfo = function() {
      if($scope.linkSelected == "nye_data_collection") {
        dataCollectionMap([[37.7929901,-122.4076399],[37.7599043,-122.4256016],[37.7808144,-122.4199277],[37.7801595,-122.4766871],[37.8019772,-122.4358579],[37.7699936,-122.4492177]]);
      } else if($scope.linkSelected == "uber_world_data_collection") {
        dataCollectionMap();
      } else if($scope.linkSelected == "nye_data_analysis") {
          
      } else {
        $scope.fetchNewYearsData('all');  
      }
    }


    window.$scope = $scope;


  }]);
})()
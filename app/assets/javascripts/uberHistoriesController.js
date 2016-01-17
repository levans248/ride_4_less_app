(function() {
  "use strict";

  angular.module("app").controller("uberHistoriesController",[ "$scope", "$window", "$http", function($scope, $window, $http) {

    $scope.linkSelected = $window.linkSelected;
    $scope.timePatterns = $window.timePatterns;
    
    if($scope.linkSelected == "time_trends"){
      $scope.timeTrends = true;
      $scope.citiesMap = false;
      $scope.profile = false;
    } else if ($scope.linkSelected == "cities_visited") {
      $scope.timeTrends = false;
      $scope.citiesMap = true;
      $scope.profile = false;
    } else if ($scope.linkSelected == "profile") {
      $scope.profile = true;
      $scope.timeTrends = false;
      $scope.citiesMap = false;
    }

    $scope.timePatternsGraph = function(json) {
      uberTimeTrends(json);
    }

    $scope.uberCitiesMap = function(json) {
      uberCitiesMap(json);
    }

    $scope.userHistoryData = function() {
      $http.get('/api/uber_histories.json?linkClicked=' + $scope.linkSelected).then(function(response){
        if($scope.linkSelected == "time_trends"){
          $scope.all_data = response.data;
          $scope.timePatternsGraph(response.data);
        }
        else if($scope.linkSelected == "cities_visited") {
          $scope.all_data = response.data;
          $scope.uberCitiesMap(response.data);
        }
        else if ($scope.linkSelected == "profile") {
          $scope.allRideData = response.data;
        }
      })
    }

    window.$scope = $scope;

  }]);
})()
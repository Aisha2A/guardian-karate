Feature: Generate token for tests

  Background: setup test
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Generate valid token for tests
    And path "/api/token"
    And request {"username" : "supervisor", "password":"tek_supervisor"}
    When method post
    Then status 200
    And print response

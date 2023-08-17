Feature: Verify Account

  Background: setup test
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def result = callonce read('GenerateToken.feature')
    And print result
    * def validToken = result.response.token

  Scenario: Verify account that is exist
    And path "/api/accounts/get-account"
    And header Authorization = "Bearer "+validToken
    * def existingId = "2785"
    And param primaryPersonId = existingId
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id == existingId

  Scenario: Verify get-account with id not exist
    And path "/api/accounts/get-account"
    And header Authorization = "Bearer "+validToken
    And param primaryPersonId = "5675672785"
    When method get
    Then status 404
    And print response
    And assert response.errorMessage == "Account with id 5675672785 not found"

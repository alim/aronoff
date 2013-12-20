# Immune Response Feature and Scenarios

Feature: Manage Immune Response Results
  In order accelerate the pace of the research project
  As a researcher
  I want to quickly search, update, edit, delete and list immune
  response results

@immune_responses
Scenario: List project immune response results w/o projects or groups
  Given a user is logged in
  And there are 10 immune responses
  When you click on immune responses link
  Then you should see 10 immune response results

@immune_responses
Scenario: Search for immune response results by experiment id
  Given a user is logged in
  And there are 15 immune responses
  When you click on immune responses link
  And enter a search by experiment ID
  Then you should see one or more immune response records

@immune_responses
Scenario: Search for immune response results by strain name
  Given a user is logged in
  And there are 9 immune responses
  When you click on immune responses link
  And enter a search by strain name
  Then you should see one or more immune response records

@immune_responses
Scenario: Show a single immune response result
  Given a user is logged in
  And there are 5 immune responses
  And you click on immune responses link
  When you click on a single immune response entry
  Then you should see an immune reponse record

@immune_responses
Scenario: Create a new immune response record
  Given a user is logged in
  And there are 5 immune responses
  And you click on immune responses link
  When you click on the New button
  Then you should see a "New Immune Response Record" form

Scenario: Edit a single immune response result

Scenario: Delete a single immune response result

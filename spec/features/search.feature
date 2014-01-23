# Global Experimental Search Feature and Scenarios

Feature: Search Experimental Results
  In order accelerate the pace of the research project
  As a researcher
  I want to quickly search all experimental data

@search_steps
Scenario: You can find the search by bacteria form
  Given a user is logged in
  When you click on the Search link
  And you click on the Bacteria link
  Then you should see "Search by Bacteria" on the page

@search_steps
Scenario: You can find both macrophages and immune responeses by bacteria
  Given a user is logged in
  And there are 20 records with matching bacteria name
  And you click on the Search link
  And you click on the Bacteria link
  And you search for records matching bacteria name
  Then you should see correct number of result records
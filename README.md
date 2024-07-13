# Automate_Test
Instructions:

1.Fork this repo.

2.Use Python with Robot or Cucumber.

3.Create a branch and name it with your "{firstname_lastname}_challenge" Make sure to update your README to show how to run your scripts Fulfill the following two scenarios Once complete push your branch up

Feature: Automate As an Engr. 

Candidate I need to automate http://www.way2automation.com/angularjs-protractor/webtables/ So I can show my automation capabilities

Scenario: Add a user and validate the user has been added to the table

Scenario: Delete user User Name: novak and validate user has been deleted


## Requirements
* Python 3.x
* Robot Framework
* Robot Framework Seleniumlibrary
* Browser driver (ChromeDriver)

You may install the prerequisites by running:

    pip3 install -r requirements.txt

## Execute basic setup test run:

    $ robot tests/web_table_check.robot
    
You also can only run one of test case by follwing command:

    $ robot --test "Add User And Validate" tests\web_table_check.robot
    $ robot --test "Delete User And Validate" tests\web_table_check.robot

## Execution Flow
Scenario1: Add a user and validate the user has been added to the table
1. Open the broswer and provide the URL.
2. Check if "Add User" button exists.
3. Click the button to add a new user.
4. Input the required information.
5. Check if the new user has been added.

Scenario2: Delete user User Name: novak and validate user has been deleted
1. Open the broswer and provide the URL.
2. Check if the user exists.
3. Click the delete button to delete a user.
4. Check if the user has been deleted.

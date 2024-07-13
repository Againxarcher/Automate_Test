*** Settings ***
Resource    ../libs/lib_common.resource
Resource    ../libs/lib_user.resource
Test Setup          Open Chrome Broswer And Check Botton Is Exist      ${web_url}      ${web_title}
Test Teardown       Close Chrome Broswer


*** Variables ***
${web_url}      https://www.way2automation.com/angularjs-protractor/webtables/
${web_title}    Protractor practice website - WebTables
&{archer_user_info}     FirstName=Archer    LastName=Wen    UserName=Archer    Password=123456    Customer=15    RoleId=Admin    Email=123456@aaa.com    Mobilephone=123456789
&{novak_user_info}     FirstName=Mark    LastName=Novak    UserName=novak    Password=123456    Customer=15    RoleId=Customer    Email=asa@asd.cz    Mobilephone=777888444


*** Test Cases ***
Add User And Validate
    [Documentation]     Add a user and validate the user has been added to the table
    [Tags]  Add_User_And_Validate
    Add User        ${archer_user_info}
    Verify User     ${archer_user_info}

Delete User And Validate
    [Documentation]     Delete a user and validate the user has been deleted from the table
    [Tags]  Delete_User_And_Validate
    Delete User     ${novak_user_info}
    Verify User     ${novak_user_info}      False
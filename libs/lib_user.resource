*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String


*** Variables ***
&{add_button}                  button=Add User     locator=.btn.btn-link.pull-right
${add_save_button}             .btn.btn-success
${add_close_button}            .btn.btn-danger
${delete_button}               body > table > tbody > tr:nth-child({}) > td:nth-child(11) > button
${delete_ok_button}            .btn.ng-scope.ng-binding.btn-primary
${delete_cancel_button}        .btn.ng-scope.ng-binding
${delete_alert_screen}         Confirmation Dialog


*** Keywords ***
Add User
    [Arguments]     ${user_info}
    Element Should Be Visible    css=${add_button["locator"]}
    Element Text Should Be    css=${add_button["locator"]}    ${add_button["button"]}
    Click Element    css=${add_button["locator"]}
    ${elements_from_input_table}       Get WebElements     css:form tbody tr td input, form tbody tr td select
    FOR    ${element}    IN    @{elements_from_input_table}
        Run Keyword If    "${element.get_attribute("name")}" == "optionsRadios"
        ...    Select Radio Button    optionsRadios    ${user_info["Customer"]}
        ...  ELSE IF      "${element.get_attribute("name")}" == "RoleId"
        ...    Select From List By Label    css:form tbody tr td select[name=${element.get_attribute("name")}]      ${user_info["${element.get_attribute("name")}"]}
        ...  ELSE
        ...    Input Text    css:form tbody tr td input[name=${element.get_attribute("name")}]    ${user_info["${element.get_attribute("name")}"]}
    END
    Click Element       css=${add_save_button}


Delete User
    [Arguments]     ${user_info}
    ${elements_from_main_table}=       Get WebElements     css:body table tbody tr
    ${input_length}=     Get Length    ${elements_from_main_table}
    FOR    ${index}    IN RANGE     ${input_length}
        ${element_text}=    Get Text    ${elements_from_main_table}[${index}]
        ${status}=     Run Keyword And Return Status    Should Contain     ${element_text}     ${user_info["UserName"]}
        IF    ${status} == True
             ${delete_botton}=      Evaluate    "${delete_button}".format(${index})
             Click Element    css=${delete_botton}
             Wait Until Element Is Visible    css=h3.ng-binding
             Element Text Should Be    css=h3.ng-binding    ${delete_alert_screen}
             Click Element    css=${delete_ok_button}
        ELSE
            Log    Cannot find the Keyword: ${user_info["UserName"]} in this row, next step not required...
        END
    END

Verify User
    [Arguments]      ${user_info}     ${exist}=True
    @{vlidate_list}=    Create List    ${user_info["FirstName"]}    ${user_info["LastName"]}    ${user_info["UserName"]}
    ${user_info_text}=     Set Variable
    FOR    ${key}   ${value}    IN    &{user_info}
        IF    "${value}" in @{vlidate_list}
              ${user_info_text}=     Set Variable    ${user_info_text} ${value}
        ELSE
              Log   "${value}" is not in the list, next step not required...
        END
    END
    ${user_info_text}=     Evaluate     "${user_info_text}".replace(' ', '', 1)
    Log    ${user_info_text}
    IF  ${exist} == True
        ${elements_from_main_table}=       Get WebElements     css:body table tbody tr
        FOR    ${element}    IN    @{elements_from_main_table}
            ${element_text}=    Get Text    ${element}
            ${status}=     Run Keyword And Return Status    Should Contain     ${element_text}     ${user_info_text}
            Exit For Loop If    ${status} == True
        END
    ELSE
        ${elements_from_main_table}=       Get WebElements     css:body table tbody tr
        FOR    ${element}    IN    @{elements_from_main_table}
            ${element_text}=    Get Text    ${element}
            ${status}=     Run Keyword And Return Status    Should Not Contain     ${element_text}     ${user_info_text}
        END
    END
*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${browser}                     chrome


*** Keywords ***
Open Chrome Broswer And Check Botton Is Exist
    [Arguments]     ${url}      ${title}
    Open Browser    ${url}      ${browser}
    Title Should Be     ${title}


Close Chrome Broswer
    Close Browser
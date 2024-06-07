*** Settings ***
Library     SeleniumLibrary
#Task Setup      Open Browser    https://konto.insert.com.pl/#/login   Chrome
#est Teardown   close browser

*** Variables ***
${ki login}  szymon.piasecki+wsb@insert.com.pl
${proper password}  Merito123!
${not proper password}  12345
${error_message}   Podany adres e-mail i/lub hasło są niepoprawne.


*** Keywords ***
Login to Konto InsERT
    [Arguments]    ${moj login}     ${moje haslo}
    Open Browser    https://konto.insert.com.pl/#/login  Chrome
    sleep    1
    wait until element is visible   id:login-email-input   timeout=5
    click element    id:login-email-input
    sleep   1
    input text    id:login-email-input   ${moj login}  False
    sleep   1
    input text    id:login-password-input    ${moje haslo}   False
    sleep    1
    click button    id:login-submit




*** Test Cases ***
Succwssful Login
#   Open Browser    https://konto.insert.com.pl/#/login  Chrome
    Login to Konto InsERT    ${ki login}    ${proper password}
    sleep    3
    wait until element is visible   id:companies-add-button   5
#   close browser


Unsuccessful login
#   Open Browser    https://konto.insert.com.pl/#/login  Chrome
    Login to Konto InsERT     ${ki login}   ${not proper password}
    sleep   3
    ${my_massage}    get text     xpath://*[@id="login-email"]/div/div[2]
    should be equal as strings    ${my_massage}    ${error_message}
#   close browser

Change color layout
#   Open Browser    https://konto.insert.com.pl/#/login  Chrome
    Login to Konto InsERT    ${ki login}    ${proper password}
    sleep    3
    wait until element is visible   id:companies-add-button   5
    click element    id:iup-btn-account
    sleep   1
    click element    id:iup-change-theme
    sleep    1
    click element    id:iup-change-theme-dark
    sleep   1
    ${kolor}    get element attribute  id:iup-change-theme-dark     color
    should not be equal    ${kolor}     rgba(255, 255, 255, 1)

#   close browser
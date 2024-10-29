*** Settings ***
Documentation    Test the login functionality of the BestPick app.
Library          AppiumLibrary

 
*** Variables ***
${URL}                        http://127.0.0.1:4723
${ANDROID_AUTOMATION_NAME}     UiAutomator2
${ANDROID_PLATFORM_NAME}       Android
${ANDROID_PLATFORM_VERSION}    15
${ANDROID_APP}                 C:\\Users\\earth\\AndroidStudioProjects\\ReviewHub_android\\app\\build\\outputs\\apk\\debug\\app-debug.apk
${APP_PACKAGE}                com.example.reviewhub
${VALID_EMAIL}                earthsrichok31@gmail.com    
${VALID_PASSWORD}             bestpick7890
${COMMENT}                    Good

*** Test Cases ***
Valid comment post
    [Documentation]    Test valid comment post
    Open Test Application
    Login
    Click Element    //*[contains(@content-desc, 'FOLLOW')]
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/recycler_view_posts    timeout=30s
    Click Element      id=${APP_PACKAGE}:id/recycler_view_posts
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/media_view_pager    timeout=30s
    Click Element      id=${APP_PACKAGE}:id/title
    FOR    ${index}    IN RANGE    10
    ${isVisible}=    Run Keyword And Return Status    Wait Until Element Is Visible    id=${APP_PACKAGE}:id/comment_input    timeout=1s
    Run Keyword If    ${isVisible}    Exit For Loop
    Swipe    500    1500    500    800    800
    END
    Input Text         id=${APP_PACKAGE}:id/comment_input       ${COMMENT}
    Click Element      id=${APP_PACKAGE}:id/send_button  
    Wait Until Comment Is Visible


invalid comment post
    [Documentation]    Test invalid comment post
    Open Test Application
    Login
    Click Element    //*[contains(@content-desc, 'FOLLOW')]
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/recycler_view_posts    timeout=30s
    Click Element      id=${APP_PACKAGE}:id/recycler_view_posts
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/media_view_pager    timeout=30s
    Click Element      id=${APP_PACKAGE}:id/title
    FOR    ${index}    IN RANGE    10
    ${isVisible}=    Run Keyword And Return Status    Wait Until Element Is Visible    id=${APP_PACKAGE}:id/comment_input    timeout=1s
    Run Keyword If    ${isVisible}    Exit For Loop
    Swipe    500    1500    500    800    800
    END
    Click Element      id=${APP_PACKAGE}:id/send_button  
    Wait Until Comment Is Visible
    Close Application

delete comment post
    [Documentation]    Test valid comment post
    Open Test Application
    Login
    Click Element    //*[contains(@content-desc, 'FOLLOW')]
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/recycler_view_posts    timeout=30s
    Click Element      id=${APP_PACKAGE}:id/recycler_view_posts
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/media_view_pager    timeout=30s
    Click Element      id=${APP_PACKAGE}:id/title
    FOR    ${index}    IN RANGE    10
    ${isVisible}=    Run Keyword And Return Status    Wait Until Element Is Visible    id=${APP_PACKAGE}:id/comment_input    timeout=1s
    Run Keyword If    ${isVisible}    Exit For Loop
    Swipe    500    1500    500    800    800
    END
    Input Text         id=${APP_PACKAGE}:id/comment_input       ${COMMENT}
    Click Element      id=${APP_PACKAGE}:id/send_button  
    Wait Until Comment Is Visible
    Click Element      id=${APP_PACKAGE}:id/comment_report
    Wait Until Element Is Visible    id=android:id/title    timeout=30s
    Click Element      id=android:id/title
    Wait Until Page Contains Element    xpath=//android.widget.TextView[contains(@text, '')]    timeout=30s


    




*** Keywords ***
Open Test Application
    Open Application    ${URL}    automationName=${ANDROID_AUTOMATION_NAME}    platformName=${ANDROID_PLATFORM_NAME}    platformVersion=${ANDROID_PLATFORM_VERSION}    app=${ANDROID_APP}
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/logintext    timeout=30s

Login 
    Input Text         id=${APP_PACKAGE}:id/Email       ${VALID_EMAIL}
    Input Text         id=${APP_PACKAGE}:id/password    ${VALID_PASSWORD}
    Click Element      id=${APP_PACKAGE}:id/loginButton
    Wait Until Element Is Visible    id=${APP_PACKAGE}:id/home   timeout=10s

Wait Until Comment Is Visible
    Wait Until Element Is Visible   xpath=//*[contains(@text, "${COMMENT}")]    timeout=30s
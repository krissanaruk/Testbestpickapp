*** Settings ***
Documentation    Test the registration functionality with OTP in the BestPick app.
Library    AppiumLibrary
Library    BuiltIn

*** Variables ***
${URL}                        http://127.0.0.1:4723
${ANDROID_AUTOMATION_NAME}     UiAutomator2
${ANDROID_PLATFORM_NAME}       Android
${ANDROID_PLATFORM_VERSION}    15
${ANDROID_APP}                  C:\\Users\\earth\\AndroidStudioProjects\\ReviewHub_android\\app\\build\\outputs\\apk\\debug\\app-debug.apk
${APP_PACKAGE}                 com.example.reviewhub

${VALID_EMAIL}                thanatornnunu@gmail.com
${INVALID_EMAIL}              1234
${password}                   terkrub2412
${confirm_password}           terkrub2412
${Valid_password}             1234
${Duplicate_email}            earthsrichok31@gmail.com
${NULL} 


*** Test Cases ***

Valid register Test
    [Documentation]    ตรวจสอบการลงทะเบียนด้วยอีเมลที่ถูกต้อง 
    Open Test Application
    Click Element    id=${APP_PACKAGE}:id/register    
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/registerusername    timeout=30s 
    Close Application



Invalid register Test1
    [Documentation]    ตรวจสอบการลงทะเบียนด้วยอีเมลที่มีอยู่แล้ว
    Open Test Application
    Click register
    Input Text    id=${APP_PACKAGE}:id/registerusername    ${Duplicate_email}    
    Click Element    id=${APP_PACKAGE}:id/btnregister
    Wait Until Page Contains    Email already registered    timeout=30s
    Close Application

Invalid register Test
    [Documentation]    ตรวจสอบการลงทะเบียนด้วยอีเมลที่ไม่ใช่อีเมล
    Open Test Application
    Click register
    Input Text    id=${APP_PACKAGE}:id/registerusername    ${INVALID_EMAIL}
    Click Element    id=${APP_PACKAGE}:id/btnregister
    Click Element    id=${APP_PACKAGE}:id/registerusername
    sleep     5s
    Close Application

Invalid register Test
    [Documentation]    ตรวจสอบการลงทะเบียนโดยไม่กรอกอีเมล
    Open Test Application
    Click register
    Input Text    id=${APP_PACKAGE}:id/registerusername    ${NULL}   
    Click Element    id=${APP_PACKAGE}:id/btnregister
    Click Element    id=${APP_PACKAGE}:id/registerusername
    sleep     5s
    Close Application

Valid password Test

    [Documentation]   ตรวจสอบการส่ง OTP ไปยังอีเมล
    Open Test Application
    Click Element    id=${APP_PACKAGE}:id/register    
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/registerusername    timeout=30s  
    Input Text    id=${APP_PACKAGE}:id/registerusername    ${VALID_EMAIL}    
    Click Element    id=${APP_PACKAGE}:id/btnregister    
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/otp1    timeout=150s  
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/otp1    timeout=150s
    Sleep    10s
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/registerpassword    timeout=30s
Valid password Test

    [Documentation]    ตรวจสอบการสร้างรหัสผ่านด้วยรหัสผ่านที่ตรงกัน
    Open Test Application
    Click Element    id=${APP_PACKAGE}:id/register    
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/registerusername    timeout=30s  
    Input Text    id=${APP_PACKAGE}:id/registerusername    ${VALID_EMAIL}    
    Click Element    id=${APP_PACKAGE}:id/btnregister    
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/otp1    timeout=150s  
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/otp1    timeout=150s
    Sleep    10s
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/registerpassword    timeout=30s
    Input Text    id=${APP_PACKAGE}:id/registerpassword    ${password}    
    Input Text    id=${APP_PACKAGE}:id/registerpasswordconfirm    ${confirm_password}    
    Click Element    id=${APP_PACKAGE}:id/registerButton    
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/main    timeout=30s    
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/main    timeout=30s
    Element Should Be Visible    id=${APP_PACKAGE}:id/main    
    Close Application

Invalid password Test1

    [Documentation]    ตรวจสอบการสร้างรหัสผ่านด้วยรหัสผ่านที่ไม่ตรงกัน
    Open Test Application
    Click Element    id=${APP_PACKAGE}:id/register    
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/registerusername    timeout=30s  
    Input Text    id=${APP_PACKAGE}:id/registerusername    ${VALID_EMAIL}    
    Click Element    id=${APP_PACKAGE}:id/btnregister    
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/otp1    timeout=150s  
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/otp1    timeout=150s
    Sleep    10s
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/registerpassword    timeout=30s
    Input Text    id=${APP_PACKAGE}:id/registerpassword    ${password}    
    Input Text    id=${APP_PACKAGE}:id/registerpasswordconfirm    ${VALID_EMAIL}   
    Click Element    id=${APP_PACKAGE}:id/registerButton  
    Click Element    id=${APP_PACKAGE}:id/registerButton      
    Wait Until Element Is Visible   "Password do not match"    timeout=30s      
    Close Application

Invalid password Test2

    [Documentation]    ตรวจสอบการสร้างรหัสผ่านโดยไม่กรอกข้อมูล
    Open Test Application
    Click Element    id=${APP_PACKAGE}:id/register    
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/registerusername    timeout=30s  
    Input Text    id=${APP_PACKAGE}:id/registerusername    ${VALID_EMAIL}    
    Click Element    id=${APP_PACKAGE}:id/btnregister    
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/otp1    timeout=150s  
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/otp1    timeout=150s
    Sleep    10s
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/registerpassword    timeout=30s
    Input Text    id=${APP_PACKAGE}:id/registerpassword   ${NULL}     
    Input Text    id=${APP_PACKAGE}:id/registerpasswordconfirm    ${NULL}  
    Click Element    id=${APP_PACKAGE}:id/registerButton    
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/main    timeout=30s    
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/main    timeout=30s
    Element Should Be Visible    id=${APP_PACKAGE}:id/main    
    Close Application

*** Keywords ***
Open Test Application
    Open Application    ${URL}    automationName=${ANDROID_AUTOMATION_NAME}    platformName=${ANDROID_PLATFORM_NAME}    platformVersion=${ANDROID_PLATFORM_VERSION}    app=${ANDROID_APP}
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/logintext    timeout=30s  

Click register
    Click Element    id=${APP_PACKAGE}:id/register    
    Wait Until Element Is Visible   id=${APP_PACKAGE}:id/registerusername    timeout=30s   
   

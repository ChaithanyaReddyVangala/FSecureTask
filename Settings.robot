*** Settings ***

Library	SeleniumLibrary
Library	Collections
Library	String
Library	OperatingSystem
Library	DateTime


*** Variables ***

${browser}  chrome
${env}   iot
${platform}   mac
${remote_url}	None
${URL}  https://youtube.com/
${title}


${search_textbox}   css:input#search
${search_button}   //*[@id="search-icon-legacy"]
${video_urls}   css:#contents.style-scope ytd-video-renderer #thumbnail
${img_srcs}   css:#contents.style-scope ytd-video-renderer #thumbnail img


*** Keywords ***


Setup Browser
	[Arguments]	${platform}	${env}
	Run Keyword If	'${platform}'=='mac'	Setup Mac
	Set Global Variable	${env}


Setup Mac
	Run keyword If	'${remote_url}'=='None' 	Launch Chrome
	...  ELSE	Sleep   3
	Run keyword If  '${remote_url}'=='None'  Maximize Browser Window
	...  ELSE    Set Window Size    1400    900

Launch Chrome 
	${options}=	Evaluate	sys.modules['selenium.webdriver'].ChromeOptions()   sys, selenium.webdriver
	${prefs}	Create Dictionary   credentials_enable_service=${false}    default_content_settings=2   managed_default_content_settings=2       #default_content_setting_values=2
	Call Method	${options}	add_experimental_option	prefs	${prefs}
	Call Method	${options}	add_argument	disable-infobars  
	Create WebDriver	Chrome	chrome_options=${options}

launch youtube home page  
	[Arguments]	 ${url}
	Go To	${url}

verify if youtube page is loaded   
    ${title}  Get Title
    Title Should Be  YouTube


input search text 
    [Arguments]     ${searchname}
    Run Keyword and continue on Failure    Wait Until Element Is Visible   ${search_textbox}   timeout=12
    input text    ${search_textbox}    ${searchname}

click search button
    Run Keyword and continue on Failure	Wait Until Element Is Visible	${search_button}	timeout=12
	Run Keyword and continue on Failure	Wait Until Keyword Succeeds	5x	500ms	Click Element	${search_button}

Retrieve all thumbnail image urls
    Run Keyword and continue on Failure    Wait Until Element Is Visible   ${img_srcs}   timeout=12
    ${imageSrcList}    Get webelements  ${img_srcs}
	Log To Console   Fetching thumbnail img urls
    :FOR    ${size}  IN  @{imageSrcList}
    \   log to console  ${size.get_attribute('src')}
    
Retrieve all video link urls
    ${videoUrlList}    Get webelements  ${video_urls}
	Log To Console   Fetching video link urls
    :FOR    ${size}  IN  @{videoUrlList}
    \   log to console  ${size.get_attribute('href')}


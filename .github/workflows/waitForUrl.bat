set url=%1
set numTries=%2
set triesSoFar=0

:loop
if %triesSoFar% gtr %numTries% goto end

set /A triesSoFar+=1
curl -s %url%
if %errorlevel% gtr 0 (
  timeout /t 1
) else (
  goto end
)
goto loop

:end

curl %url%
set curlError=%errorlevel%
echo "Curl return code: %curlError%"
exit /b %curlError%

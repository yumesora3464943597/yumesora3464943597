@echo off
title Web Update Tool - Debug

echo ========================================
echo [1/3] Checking clipboard...
echo ========================================

powershell -NoProfile -Command "$clip = Get-Clipboard -Raw; if ($clip -match 'html') { Set-Content -Path index.html -Value $clip -Encoding utf8; exit 0 } else { exit 1 }"

echo >>> 校验完成，准备进入下一步（按任意键继续）
pause >nul
if errorlevel 1 goto ERR

echo [2/3] Validation passed! Pushing to GitHub...
echo ========================================
git add .
git commit -m "Auto update"
git push

echo ========================================
echo [3/3] Done!
echo ========================================
pause
exit /b

:ERR
echo.
echo [ERROR] Clipboard does not contain HTML code!
echo Please generate code on the webpage first.
echo Operation canceled.
echo.
pause

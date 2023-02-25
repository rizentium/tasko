@echo off

set option=%1

if %option% == package (
    flutter pub get
    flutter packages pub run build_runner build --delete-conflicting-outputs
    goto :end
)

if %option% == code-coverage (
    flutter test --coverage
    perl %GENHTML% -o coverage\html coverage\lcov.info
    goto :end
)

cls
echo Windows Makefile v1.0.0
echo.
echo %option% is not available
echo Available Options
echo - package
echo - code-coverage
echo.
echo Example
echo .\Makefile.cmd package

:end

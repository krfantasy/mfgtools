@echo off

call git --version
IF ERRORLEVEL 1 (
	echo build from tarball
) ELSE (
	IF "%APPVEYOR_BUILD_VERSION%" == "" (
		echo build not from appveryor
	) ELSE (
		git tag -m "uuu %APPVEYOR_BUILD_VERSION%" uuu_%APPVEYOR_BUILD_VERSION%
	) 

	git describe --long > NUL 2>&1
	IF ERRORLEVEL 1 (
		FOR /F "tokens=*" %%a in ('call git rev-parse --short HEAD') do (
			echo #define GIT_VERSION "lib%%a" > %1/gitversion.h
		)
	) ELSE (
		FOR /F "tokens=*" %%a in ('call git describe --long') do (
			echo #define GIT_VERSION "lib%%a" > %1/gitversion.h
		)
	)
)

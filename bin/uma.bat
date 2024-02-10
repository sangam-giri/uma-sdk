@echo off
if "%1"=="start:server" (
    cd src
    dart main.dart
)
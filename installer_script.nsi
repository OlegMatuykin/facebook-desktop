!include "MUI.nsh"
; Script generated by the HM NIS Edit Script Wizard.

!define PROGRAMENAME "Facebook desktop"
!define PROGRAMEIMAGE "facebook"

; Define the name and the outfile of the installer
Name "${PROGRAMENAME}"
OutFile "${PROGRAMENAME} install.exe"

; Define the uninstaller icon
!define MUI_UNICON "Resources\${PROGRAMEIMAGE}_Icon.ico"
!define MUI_ICON "Resources\${PROGRAMEIMAGE}_Icon.ico"
!define MUI_WELCOMEFINISHPAGE_BITMAP "Resources\${PROGRAMEIMAGE}_large.bmp"
; Define the installation directory
InstallDir "$PROGRAMFILES\${PROGRAMENAME}"

; Set the installer sections
Section "${PROGRAMENAME}" SEC01
  SetOutPath "$INSTDIR"
  ; Copy the files for installation
  File /a /r "Publish\Application Files\${PROGRAMENAME}_1_0_0_0\*.*"
  File "vcredist_x64.exe"
  ;install vcredist 14
  ExecWait "$INSTDIR\vcredist_x64.exe /install /quiet"
  Delete "$INSTDIR\vcredist_x64.exe"
  ;create uninstaller
  WriteUninstaller "$INSTDIR\uninstall.exe"
  ; Create a desktop shortcut
  CreateShortCut "$DESKTOP\${PROGRAMENAME}.lnk" "$INSTDIR\${PROGRAMENAME}.exe" "" "$INSTDIR\${PROGRAMEIMAGE}_Icon.ico"
SectionEnd

; Create the MUI pages
!insertmacro MUI_PAGE_WELCOME
!define MUI_PAGE_HEADER_TEXT "Choose Destination Location"
!insertmacro MUI_PAGE_DIRECTORY
!define MUI_PAGE_CUSTOMFUNCTION_PRE "HideInst"
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE "InstToFront"
!insertmacro MUI_PAGE_INSTFILES
!define MUI_PAGE_HEADER_TEXT "Installation Complete"
!insertmacro MUI_PAGE_FINISH

; Set the MUI language
!insertmacro MUI_LANGUAGE "English"

; Define the installer attributes
ShowInstDetails show
ShowUninstDetails show
AutoCloseWindow true
AllowRootDirInstall false

;run program on sucesfull install
Function .oninstsuccess   
Exec "$INSTDIR\${PROGRAMENAME}.exe"   
FunctionEnd

Function HideInst
        HideWindow
FunctionEnd
Function InstToFront
        BringToFront
FunctionEnd

; Run the uninstaller
Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO "Are you sure you want to completely remove ${PROGRAMENAME}?" IDYES un.doUninstall
  Abort
un.doUninstall:
  RMDir /r "$INSTDIR"
  Delete "$SMPROGRAMS\${PROGRAMENAME}\*.*"
  RMDir "$SMPROGRAMS\${PROGRAMENAME}"
  Delete "$DESKTOP\${PROGRAMENAME}.lnk"
FunctionEnd
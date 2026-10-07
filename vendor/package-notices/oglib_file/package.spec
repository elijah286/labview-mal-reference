[Package]
Name="oglib_file"
Version="4.0.1.22"
Release=""
ID=a37fb043e8ea135b8276dce9fb109eb8
File Format="vip"
Format Version="2010"
Display Name="OpenG File Library"


[Description]
Description="The OpenG File Library package contains several routines for operating on files."
Summary="OpenG File Library"
License="BSD"
Copyright="2002-2010 Jim Kring, Rolf Kalbermatter; 2002-2003 Cal-Bay Systems, Inc.; 2010-2011 Jonathon Green"
Distribution=""
Vendor="OpenG.org"
URL="http://wiki.openg.org/Oglib_file"
Packager="OpenG.org"
Demo="FALSE"
Release Notes="Package build with VIPM 2013\0A[FIX] 125 - File Library Fix for QuickDrop and Shortcut Palettes: Add (OpenG) Suffix to OpenG VIs that conflict with built-ins"
System Package="FALSE"
Sub Package="FALSE"
License Agreement="TRUE"


[Platform]
Exclusive_LabVIEW_Version=">=9.0"
Exclusive_LabVIEW_System="ALL"
Exclusive_OS="ALL"


[Script VIs]
PreInstall=""
PostInstall=""
PreUninstall=""
PostUninstall=""
Verify=""
PreBuild=""
PostBuild=""


[Dependencies]
AutoReqProv=FALSE
Requires="oglib_appcontrol>=2.10,oglib_array>=3.0.0,oglib_error>=2.3,oglib_string>=2.6"
Conflicts=""


[Activation]
License File=""
Licensed Library=""


[Files]
Num File Groups="3"
Sub-Packages=""
Namespaces="5F5F6F67746B"


[File Group 0]
Target Dir="<application>"
Replace Mode="Always"
Num Files=59
File 0="user.lib/_OpenG.lib/file/file.llb/Append Path to Root if Relative - Absolute or Relative Path Array__ogtk.vi"
File 1="user.lib/_OpenG.lib/file/file.llb/Append Path to Root if Relative - Array__ogtk.vi"
File 2="user.lib/_OpenG.lib/file/file.llb/Append Path to Root if Relative - Root Path Array__ogtk.vi"
File 3="user.lib/_OpenG.lib/file/file.llb/Append Path to Root if Relative - Scalar__ogtk.vi"
File 4="user.lib/_OpenG.lib/file/file.llb/Append Path to Root if Relative__ogtk.vi"
File 5="user.lib/_OpenG.lib/file/file.llb/Application Directory__ogtk.vi"
File 6="user.lib/_OpenG.lib/file/file.llb/Build Path - File Names and Paths Arrays - path__ogtk.vi"
File 7="user.lib/_OpenG.lib/file/file.llb/Build Path - File Names and Paths Arrays__ogtk.vi"
File 8="user.lib/_OpenG.lib/file/file.llb/Build Path - File Names Array - path__ogtk.vi"
File 9="user.lib/_OpenG.lib/file/file.llb/Build Path - File Names Array__ogtk.vi"
File 10="user.lib/_OpenG.lib/file/file.llb/Build Path - Traditional - path__ogtk.vi"
File 11="user.lib/_OpenG.lib/file/file.llb/Build Path - Traditional__ogtk.vi"
File 12="user.lib/_OpenG.lib/file/file.llb/Build Path__ogtk.vi"
File 13="user.lib/_OpenG.lib/file/file.llb/Compare File Binary__ogtk.vi"
File 14="user.lib/_OpenG.lib/file/file.llb/Compare Two Paths - Array__ogtk.vi"
File 15="user.lib/_OpenG.lib/file/file.llb/Compare Two Paths - Path1 Array__ogtk.vi"
File 16="user.lib/_OpenG.lib/file/file.llb/Compare Two Paths - Path2 Array__ogtk.vi"
File 17="user.lib/_OpenG.lib/file/file.llb/Compare Two Paths - Scalar__ogtk.vi"
File 18="user.lib/_OpenG.lib/file/file.llb/Compare Two Paths__ogtk.vi"
File 19="user.lib/_OpenG.lib/file/file.llb/Convert Dirs to VI Libraries (proxy)__ogtk.vi"
File 20="user.lib/_OpenG.lib/file/file.llb/Convert File Extension (Path)__ogtk.vi"
File 21="user.lib/_OpenG.lib/file/file.llb/Convert File Extension (String)__ogtk.vi"
File 22="user.lib/_OpenG.lib/file/file.llb/Convert File Extension__ogtk.vi"
File 23="user.lib/_OpenG.lib/file/file.llb/Convert VI Libraries to Dirs (proxy)__ogtk.vi"
File 24="user.lib/_OpenG.lib/file/file.llb/Copy with Options__ogtk.vi"
File 25="user.lib/_OpenG.lib/file/file.llb/Create Dir if Non-Existant__ogtk.vi"
File 26="user.lib/_OpenG.lib/file/file.llb/Current VI's Path__ogtk.vi"
File 27="user.lib/_OpenG.lib/file/file.llb/Current VIs Parent Directory__ogtk.vi"
File 28="user.lib/_OpenG.lib/file/file.llb/Default Directory__ogtk.vi"
File 29="user.lib/_OpenG.lib/file/file.llb/Delete Recursive__ogtk.vi"
File 30="user.lib/_OpenG.lib/file/file.llb/File Exists - Array__ogtk.vi"
File 31="user.lib/_OpenG.lib/file/file.llb/File Exists - Scalar__ogtk.vi"
File 32="user.lib/_OpenG.lib/file/file.llb/File Exists__ogtk.vi"
File 33="user.lib/_OpenG.lib/file/file.llb/File Info Record__ogtk.ctl"
File 34="user.lib/_OpenG.lib/file/file.llb/File Info__ogtk.vi"
File 35="user.lib/_OpenG.lib/file/file.llb/Force File Move__ogtk.vi"
File 36="user.lib/_OpenG.lib/file/file.llb/Instrument Library__ogtk.vi"
File 37="user.lib/_OpenG.lib/file/file.llb/List Directory Recursive__ogtk.vi"
File 38="user.lib/_OpenG.lib/file/file.llb/List Directory__ogtk.vi"
File 39="user.lib/_OpenG.lib/file/file.llb/List Top Level VIs__ogtk.vi"
File 40="user.lib/_OpenG.lib/file/file.llb/Merge Directories__ogtk.vi"
File 41="user.lib/_OpenG.lib/file/file.llb/OpenG Library__ogtk.vi"
File 42="user.lib/_OpenG.lib/file/file.llb/Set VI Top Level__ogtk.vi"
File 43="user.lib/_OpenG.lib/file/file.llb/Strip Path - Arrays__ogtk.vi"
File 44="user.lib/_OpenG.lib/file/file.llb/Strip Path - Traditional__ogtk.vi"
File 45="user.lib/_OpenG.lib/file/file.llb/Strip Path Extension - 1D Array of Paths__ogtk.vi"
File 46="user.lib/_OpenG.lib/file/file.llb/Strip Path Extension - 1D Array of Strings__ogtk.vi"
File 47="user.lib/_OpenG.lib/file/file.llb/Strip Path Extension - Path__ogtk.vi"
File 48="user.lib/_OpenG.lib/file/file.llb/Strip Path Extension - String__ogtk.vi"
File 49="user.lib/_OpenG.lib/file/file.llb/Strip Path Extension__ogtk.vi"
File 50="user.lib/_OpenG.lib/file/file.llb/Strip Path__ogtk.vi"
File 51="user.lib/_OpenG.lib/file/file.llb/Temporary Directory__ogtk.vi"
File 52="user.lib/_OpenG.lib/file/file.llb/Temporary Filename__ogtk.vi"
File 53="user.lib/_OpenG.lib/file/file.llb/User Library__ogtk.vi"
File 54="user.lib/_OpenG.lib/file/file.llb/Valid Path - Array__ogtk.vi"
File 55="user.lib/_OpenG.lib/file/file.llb/Valid Path - Traditional__ogtk.vi"
File 56="user.lib/_OpenG.lib/file/file.llb/Valid Path__ogtk.vi"
File 57="user.lib/_OpenG.lib/file/file.llb/VI Library__ogtk.vi"
File 58="user.lib/_OpenG.lib/file/file.llb/VI Tree - file__ogtk.vi"


[File Group 1]
Target Dir="<menus>/Categories/OpenG"
Replace Mode="Always"
Num Files=3
File 0="_functions_oglib_file_1.mnu"
File 1="_functions_oglib_file_2.mnu"
File 2="functions_oglib_file.mnu"


[File Group 2]
Target Dir="<menus>/Categories/OpenG"
Replace Mode="If Newer"
Num Files=1
File 0="dir.mnu"

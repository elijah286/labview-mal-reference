[Package]
Name = "oglib_error"
Version = "4.2.0.23"
Release = ""
ID =6a4fba44e87163a961fce8e560c3c7c5
File Format = "vip"
Format Version = "2010"
Display Name = "OpenG Error Library"


[Description]
Description = "The OpenG Error Library package contains several routines related to error handling."
Summary = "OpenG Error Library"
License = "BSD-3-Clause"
Copyright = "Copyright (c) 2002 Jean-Pierre Drolet; Jim Kring; 2010-2011 Jonathon Green; 2011 Ed Dickens; 2011 JKI; 2011 François Normandin"
Distribution = ""
Vendor = "OpenG.org"
URL = "http://wiki.openg.org/Oglib_error"
Packager = "OpenG.org"
Demo = "FALSE"
Release Notes = "[NEW] 3426051 - Add new 'Filter Error Codes" API"
System Package = "FALSE"


[Platform]
Exclusive_LabVIEW_Version = ">=9.0"
Exclusive_LabVIEW_System = "ALL"
Exclusive_OS = "ALL"


[Script VIs]
PreInstall = ""
PostInstall = ""
PreUninstall = ""
PostUninstall = ""
Verify = ""
PreBuild = ""
PostBuild = ""


[Dependencies]
AutoReqProv = FALSE
Requires = ""
Conflicts = ""


[Activation]
License File = ""
Licensed Library = ""


[Files]
Num File Groups = "3"
Sub-Packages = ""


[File Group 0]
Target Dir = "<application>"
Replace Mode = "Always"
Num Files = 10
File 0 = "user.lib/_OpenG.lib/error/error.llb/Build Error Cluster__ogtk.vi"
File 1 = "user.lib/_OpenG.lib/error/error.llb/Case (Error IO)__ogtk.vi"
File 2 = "user.lib/_OpenG.lib/error/error.llb/Clear All Errors__ogtk.vi"
File 3 = "user.lib/_OpenG.lib/error/error.llb/Error Codes Ring Constant__ogtk.vi"
File 4 = "user.lib/_OpenG.lib/error/error.llb/Error Constant__ogtk.vi"
File 5 = "user.lib/_OpenG.lib/error/error.llb/Filter Error Codes (Array)__ogtk.vi"
File 6 = "user.lib/_OpenG.lib/error/error.llb/Filter Error Codes (Scalar)__ogtk.vi"
File 7 = "user.lib/_OpenG.lib/error/error.llb/Filter Error Codes__ogtk.vi"
File 8 = "user.lib/_OpenG.lib/error/error.llb/Filtered Error Details - Cluster__ogtk.ctl"
File 9 = "user.lib/_OpenG.lib/error/error.llb/VI Tree - error__ogtk.vi"


[File Group 1]
Target Dir = "<menus>/Categories/OpenG"
Replace Mode = "Always"
Num Files = 1
File 0 = "functions_oglib_error.mnu"


[File Group 2]
Target Dir = "<menus>/Categories/OpenG"
Replace Mode = "If Newer"
Num Files = 1
File 0 = "dir.mnu"

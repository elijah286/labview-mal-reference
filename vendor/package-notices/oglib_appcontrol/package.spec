[Package]
Name = "oglib_appcontrol"
Version = "4.1.0.7"
Release = ""
ID =f2e4630baaa6bed509695e29fff6e567
File Format = "vip"
Format Version = "2010"
Display Name = "OpenG Application Control Library"


[Description]
Description = "The OpenG Application Control Library package contains application control functions."
Summary = "OpenG Application Control Library"
License = "BSD"
Copyright = "Copyright (c) 2002 Cal-Bay Systems, Inc.; 2002 Jean-Pierre Drolet; 2002-2006 Jim Kring; 2003 Paul F. Sullivan; 2008 T. Plomp; 2010-2011 Jonathon Green"
Distribution = ""
Vendor = "OpenG.org"
URL = "http://wiki.openg.org/Oglib_appcontrol"
Packager = "OpenG.org"
Demo = "FALSE"
Release Notes = "[FIX] 3275377 - Memory Leak from "Current VIs Parents Ref.vi"\0A[FIX] 275359 - 'Set Control Value {Variant}' function returns error"
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
Requires = "oglib_error>=2.0,oglib_lvdata>=2.0"
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
Num Files = 38
File 0 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/ClassID Names Enum__ogtk.ctl"
File 1 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Close Generic Object Refnum (Array VI)__ogtk.vi"
File 2 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Close Generic Object Refnum (Array)__ogtk.vi"
File 3 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Close Generic Object Refnum (Scalar VI)__ogtk.vi"
File 4 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Close Generic Object Refnum (Scalar)__ogtk.vi"
File 5 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Close Generic Object Refnum__ogtk.vi"
File 6 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Current VIs Namespace__ogtk.vi"
File 7 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Current VIs Parents Ref__ogtk.vi"
File 8 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Current VIs Reference__ogtk.vi"
File 9 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Dist Build App from LLB (proxy)__ogtk.vi"
File 10 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Find Focus State__ogtk.ctl"
File 11 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Find VI with Focus__ogtk.vi"
File 12 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Fit VI window to Content__ogtk.vi"
File 13 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Fit VI window to Largest Dec__ogtk.vi"
File 14 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Get All Control Values {Variant}__ogtk.vi"
File 15 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Get ClassID Name__ogtk.vi"
File 16 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Get Control Value {Variant}__ogtk.vi"
File 17 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Get Frontmost VI__ogtk.vi"
File 18 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Get Text Label Decs from VI__ogtk.vi"
File 19 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Is One Frontmost__ogtk.vi"
File 20 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/is OpenG__ogtk.vi"
File 21 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Is VI-LIB__ogtk.vi"
File 22 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/List Open Front Panels__ogtk.vi"
File 23 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/List VI Hierarchy__ogtk.vi"
File 24 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Mangle VI Name (Path)__ogtk.vi"
File 25 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Mangle VI Name (String)__ogtk.vi"
File 26 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Mangle VI Name__ogtk.vi"
File 27 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Metrics-Advanced__ogtk.vi"
File 28 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Open Untitled VI__ogtk.vi"
File 29 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Open VI Clone Reference__ogtk.vi"
File 30 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Save VI ConPane Image__ogtk.vi"
File 31 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Set Control Value {Variant}__ogtk.vi"
File 32 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/UnMangle VI Name (Path)__ogtk.vi"
File 33 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/UnMangle VI Name (String)__ogtk.vi"
File 34 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/UnMangle VI Name__ogtk.vi"
File 35 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Untitled__ogtk.vit"
File 36 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/VI Tree - appcontrol__ogtk.vi"
File 37 = "user.lib/_OpenG.lib/appcontrol/appcontrol.llb/Wait on VIs Unloaded from Memory__ogtk.vi"


[File Group 1]
Target Dir = "<menus>/Categories/OpenG"
Replace Mode = "Always"
Num Files = 2
File 0 = "_functions_oglib_appcontrol_1.mnu"
File 1 = "functions_oglib_appcontrol.mnu"


[File Group 2]
Target Dir = "<menus>/Categories/OpenG"
Replace Mode = "If Newer"
Num Files = 1
File 0 = "dir.mnu"

[Package]
Name = "oglib_string"
Version = "4.1.0.12"
Release = ""
ID =3ac26478a42e80f4ade1ba16a3d35882
File Format = "vip"
Format Version = "2010"
Display Name = "OpenG String Library"


[Description]
Description = "The OpenG String Library package contains several routines for operating on strings."
Summary = "OpenG String Library"
License = "BSD-3-Clause"
Copyright = "2002-2007 Jim Kring; 2002 Cal-Bay Systems; 2004 Paul Sullivan; 2004 Michael C. Ashe; 2005-2006 MKS Instruments, Inc. (author: Doug Femec); 2010-2011 Jonathon Green; 2011 Shaun Rumbell; 2011 Darin.K; 2011 Wouter Geelen; 2011 Fabiola De la Cueva; 2011 Phillip Brooks; 2011 Jonas Mellroth; 2011 Ed Dickens"
Distribution = ""
Vendor = "OpenG.org"
URL = "http://wiki.openg.org/Oglib_string"
Packager = "OpenG.org"
Demo = "FALSE"
Release Notes = "[MOD] 3303663 - Format Variant Into String__ogtk.vi doesn't handle Timestamp\0D\0A[MOD] 3292424 - Update Trim Whitespace with Fast Trim\0D\0A[FIX] 3275381 - "Slice String__ogtk.vi" has Input or RHS of Connector Pane\0D\0A[FIX] 1958939 - "Scan Variant from String" missing description\0A[MOD] 3275249 - Update OpenG Comment\0D\0A[FIX] 3386135 - OpenG Comment not Merge VI in palette\0D\0A[MOD] 1914597 - Format Variant Into String missing DAQ, DAQmx, and VISA type\0D\0A[MOD] 921506 - "Format Variant Into String" should accept RefNums\0D\0A[NEW] 3419755 - Create new String To Character Array VI"
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
Requires = "oglib_error>=4.2.0.23,oglib_lvdata>=4.1.0.16"
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
Num Files = 28
File 0 = "user.lib/_OpenG.lib/string/string.llb/1D Array to String__ogtk.vi"
File 1 = "user.lib/_OpenG.lib/string/string.llb/Comment__ogtk.vi"
File 2 = "user.lib/_OpenG.lib/string/string.llb/Convert EOLs (String Array)__ogtk.vi"
File 3 = "user.lib/_OpenG.lib/string/string.llb/Convert EOLs (String)__ogtk.vi"
File 4 = "user.lib/_OpenG.lib/string/string.llb/Convert EOLs__ogtk.vi"
File 5 = "user.lib/_OpenG.lib/string/string.llb/Format Variant Into String__ogtk.vi"
File 6 = "user.lib/_OpenG.lib/string/string.llb/Multi-line String to Array__ogtk.vi"
File 7 = "user.lib/_OpenG.lib/string/string.llb/Number to Proper Engl Text__ogtk.vi"
File 8 = "user.lib/_OpenG.lib/string/string.llb/Place Number to Proper Engl Text__ogtk.vi"
File 9 = "user.lib/_OpenG.lib/string/string.llb/Resolve Timestamp Format__ogtk.vi"
File 10 = "user.lib/_OpenG.lib/string/string.llb/Scan Variant from String__ogtk.vi"
File 11 = "user.lib/_OpenG.lib/string/string.llb/Search or Split String__ogtk.vi"
File 12 = "user.lib/_OpenG.lib/string/string.llb/Slice String 1__ogtk.vi"
File 13 = "user.lib/_OpenG.lib/string/string.llb/Slice String__ogtk.vi"
File 14 = "user.lib/_OpenG.lib/string/string.llb/String to 1D Array__ogtk.vi"
File 15 = "user.lib/_OpenG.lib/string/string.llb/String to Character Array__ogtk.vi"
File 16 = "user.lib/_OpenG.lib/string/string.llb/To Camel Case (String Array)__ogtk.vi"
File 17 = "user.lib/_OpenG.lib/string/string.llb/To Camel Case (String)__ogtk.vi"
File 18 = "user.lib/_OpenG.lib/string/string.llb/To Camel Case__ogtk.vi"
File 19 = "user.lib/_OpenG.lib/string/string.llb/To Proper Case (String Array)__ogtk.vi"
File 20 = "user.lib/_OpenG.lib/string/string.llb/To Proper Case (String)__ogtk.vi"
File 21 = "user.lib/_OpenG.lib/string/string.llb/To Proper Case__ogtk.vi"
File 22 = "user.lib/_OpenG.lib/string/string.llb/Trim Whitespace (String Array)__ogtk.vi"
File 23 = "user.lib/_OpenG.lib/string/string.llb/Trim Whitespace (String)__ogtk.vi"
File 24 = "user.lib/_OpenG.lib/string/string.llb/Trim Whitespace Lookup Table.vi"
File 25 = "user.lib/_OpenG.lib/string/string.llb/Trim Whitespace__ogtk.vi"
File 26 = "user.lib/_OpenG.lib/string/string.llb/Variant Array to Spreadsheet__ogtk.vi"
File 27 = "user.lib/_OpenG.lib/string/string.llb/VI Tree - string__ogtk.vi"


[File Group 1]
Target Dir = "<menus>/Categories/OpenG"
Replace Mode = "Always"
Num Files = 1
File 0 = "functions_oglib_string.mnu"


[File Group 2]
Target Dir = "<menus>/Categories/OpenG"
Replace Mode = "If Newer"
Num Files = 1
File 0 = "dir.mnu"

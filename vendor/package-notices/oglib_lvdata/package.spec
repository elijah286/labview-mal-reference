[Package]
Name = "oglib_lvdata"
Version = "4.2.0.21"
Release = ""
ID =1e31926fd466afe7073c322c4ce245db
File Format = "vip"
Format Version = "2010"
Display Name = "OpenG LabVIEW Data Library"


[Description]
Description = "The OpenG LabVIEW Data Library contains several routines for operating on Variant Data, Type Descriptors and LVOOP Data."
Summary = "OpenG LabVIEW Data Library"
License = "BSD"
Copyright = "2002-2006 Jean-Pierre Drolet, Jim Kring; 2010-2012 Jonathon Green; 2012 James David Powell"
Distribution = ""
Vendor = "LAVA"
URL = "http://wiki.openg.org/Oglib_lvdata"
Packager = "OpenG.org"
Demo = "FALSE"
Release Notes = "[NEW] 3275738 - New LVOOP Data Functions"
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
Requires = "oglib_error>=4.2.0.23"
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
Num Files = 66
File 0 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Array Dim(s) from TD__ogtk.vi"
File 1 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Array of VData to VArray__ogtk.vi"
File 2 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Array of VData to VCluster__ogtk.vi"
File 3 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Array Size(s)__ogtk.vi"
File 4 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Array to Array of VData__ogtk.vi"
File 5 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Array to VCluster__ogtk.vi"
File 6 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Base Units__ogtk.ctl"
File 7 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Cluster to Array of VData__ogtk.vi"
File 8 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Cluster to VArray__ogtk.vi"
File 9 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Compute 1D Index__ogtk.vi"
File 10 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Array Element Default Data__ogtk.vi"
File 11 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Array Element TD__ogtk.vi"
File 12 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Array Element TDEnum__ogtk.vi"
File 13 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Cluster Element by Name__ogtk.vi"
File 14 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Cluster Element Names__ogtk.vi"
File 15 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Cluster Elements TDs__ogtk.vi"
File 16 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Data Name from TD__ogtk.vi"
File 17 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Data Name__ogtk.vi"
File 18 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Data TD from Datalog Ref__ogtk.vi"
File 19 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Default Data from TD__ogtk.vi"
File 20 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Default Data from Variant__ogtk.vi"
File 21 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Element TD from Array TD__ogtk.vi"
File 22 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get GOOP Object Type__ogtk.vi"
File 23 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Header from TD__ogtk.vi"
File 24 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Last PString__ogtk.vi"
File 25 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Physical Units from TD__ogtk.vi"
File 26 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Physical Units__ogtk.vi"
File 27 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get PString__ogtk.vi"
File 28 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Refnum Type Enum from Data__ogtk.vi"
File 29 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Refnum Type Enum from TD__ogtk.vi"
File 30 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Strings from Enum TD__ogtk.vi"
File 31 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Strings from Enum__ogtk.vi"
File 32 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get TDEnum from Data__ogtk.vi"
File 33 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get TDEnum from TD__ogtk.vi"
File 34 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Variant Attributes__ogtk.vi"
File 35 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Waveform Type Enum from Data__ogtk.vi"
File 36 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Get Waveform Type Enum from TD__ogtk.vi"
File 37 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Index Array__ogtk.vi"
File 38 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/LVOOP Get Default Object__ogtk.vi"
File 39 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/LVOOP Is Default Value__ogtk.vi"
File 40 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/LVOOP Is Same Or Descendant Class__ogtk.vi"
File 41 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/LVOOP Return Class Name__ogtk.vi"
File 42 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/No of Elements in Cluster__ogtk.vi"
File 43 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Parse String with TDs__ogtk.vi"
File 44 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Physical Units__ogtk.ctl"
File 45 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Refnum Code__ogtk.ctl"
File 46 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Refnum Subtype Enum__ogtk.ctl"
File 47 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Remove Typedefs from Variant__ogtk.vi"
File 48 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Replace Array Element__ogtk.vi"
File 49 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Reshape 1D Array__ogtk.vi"
File 50 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Reshape Array to 1D VArray__ogtk.vi"
File 51 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Set Cluster Element by Name__ogtk.vi"
File 52 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Set Data Name__ogtk.vi"
File 53 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Set Enum String Value__ogtk.vi"
File 54 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Size of Data from TD__ogtk.vi"
File 55 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Split Cluster TD__ogtk.vi"
File 56 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Strip Units__ogtk.vi"
File 57 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Type Descriptor Enumeration__ogtk.ctl"
File 58 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Type Descriptor Header__ogtk.ctl"
File 59 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Type Descriptor__ogtk.ctl"
File 60 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Unwrap VVariant__ogtk.vi"
File 61 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Variant Constant__ogtk.vi"
File 62 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Variant Manipulation Templ__ogtk.vit"
File 63 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Variant to Header Info__ogtk.vi"
File 64 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/VI Tree - lvdata__ogtk.vi"
File 65 = "user.lib/_OpenG.lib/lvdata/lvdata.llb/Waveform Subtype Enum__ogtk.ctl"


[File Group 1]
Target Dir = "<menus>/Categories/OpenG"
Replace Mode = "Always"
Num Files = 8
File 0 = "_functions_oglib_lvdata_1.mnu"
File 1 = "_functions_oglib_lvdata_2.mnu"
File 2 = "_functions_oglib_lvdata_3.mnu"
File 3 = "_functions_oglib_lvdata_4.mnu"
File 4 = "_functions_oglib_lvdata_5.mnu"
File 5 = "_functions_oglib_lvdata_6.mnu"
File 6 = "_functions_oglib_lvdata_7.mnu"
File 7 = "functions_oglib_lvdata.mnu"


[File Group 2]
Target Dir = "<menus>/Categories/OpenG"
Replace Mode = "If Newer"
Num Files = 1
File 0 = "dir.mnu"

[Package]
Name = "oglib_variantconfig"
Version = "4.0.0.5"
Release = ""
ID =8c916b9219d7d2704c0b43dc20522a24
File Format = "vip"
Format Version = "2010"
Display Name = "OpenG Variant Configuration File Library"


[Description]
Description = "The OpenG Variant Configuration File Library package contains tools for writing and reading variant data to and from INI files."
Summary = "OpenG Variant Configuration File Library"
License = "BSD"
Copyright = "2002-2010 Jean-Pierre Drolet, Jim Kring, Heiko Fettig, Ton Plomp; 2010-2011 Jonathon Green"
Distribution = ""
Vendor = "OpenG.org"
URL = "http://wiki.openg.org/Oglib_variantconfig"
Packager = "OpenG.org"
Demo = "FALSE"
Release Notes = "Package sources upgraded to LabVIEW 2009 (package now compatible with LV2009 or greater)\0APackage build with VIPM 2010\0A[FIX] 1960078 - Missing description in "Read/Write Panel to INI"\0A[FIX] 3004519 - Use Custom Decimal sign\0A[FIX] 3004524 - Replace deprecated methods"
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
Requires = "oglib_error>=2.3,oglib_lvdata>=2.9,oglib_string>=2.6"
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
Num Files = 11
File 0 = "user.lib/_OpenG.lib/variantconfig/variantconfig.llb/Encode Section and Key Names__ogtk.vi"
File 1 = "user.lib/_OpenG.lib/variantconfig/variantconfig.llb/Format Numeric Array__ogtk.vi"
File 2 = "user.lib/_OpenG.lib/variantconfig/variantconfig.llb/Read INI Cluster__ogtk.vi"
File 3 = "user.lib/_OpenG.lib/variantconfig/variantconfig.llb/Read Key (Variant)__ogtk.vi"
File 4 = "user.lib/_OpenG.lib/variantconfig/variantconfig.llb/Read Panel from INI__ogtk.vi"
File 5 = "user.lib/_OpenG.lib/variantconfig/variantconfig.llb/Read Section Cluster__ogtk.vi"
File 6 = "user.lib/_OpenG.lib/variantconfig/variantconfig.llb/VI Tree - variantconfig__ogtk.vi"
File 7 = "user.lib/_OpenG.lib/variantconfig/variantconfig.llb/Write INI Cluster__ogtk.vi"
File 8 = "user.lib/_OpenG.lib/variantconfig/variantconfig.llb/Write Key (Variant)__ogtk.vi"
File 9 = "user.lib/_OpenG.lib/variantconfig/variantconfig.llb/Write Panel to INI__ogtk.vi"
File 10 = "user.lib/_OpenG.lib/variantconfig/variantconfig.llb/Write Section Cluster__ogtk.vi"


[File Group 1]
Target Dir = "<menus>/Categories/OpenG"
Replace Mode = "Always"
Num Files = 2
File 0 = "_functions_oglib_variantconfig_1.mnu"
File 1 = "functions_oglib_variantconfig.mnu"


[File Group 2]
Target Dir = "<menus>/Categories/OpenG"
Replace Mode = "If Newer"
Num Files = 1
File 0 = "dir.mnu"

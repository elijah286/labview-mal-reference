[Package]
Name="national_instruments_lib_tcp___ip_functions"
Version="1.0.0.3"
Release=""
ID=028b66d9ead9dc9b8fa4089de3bf2709
File Format="vip"
Format Version="2010"
Display Name="TCP / IP Functions"


[Description]
Description="This simple library wraps some of the low-level TCP APIs to simplify sending and receiving strings"
Summary=""
License=""
Copyright="Copyright (c) 2013, National Instruments"
Distribution=""
Vendor="National Instruments"
URL=""
Packager="Elijah Kerry"
Demo="FALSE"
Release Notes="Created for the sake of reuse across multiple projects"
System Package="FALSE"
Sub Package="FALSE"
License Agreement="FALSE"


[Platform]
Exclusive_LabVIEW_Version=">=13.0"
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
Requires=""
Conflicts=""


[Activation]
License File=""
Licensed Library=""


[Files]
Num File Groups="2"
Sub-Packages=""
Namespaces=""


[File Group 0]
Target Dir="<application>"
Replace Mode="Always"
Num Files=3
File 0="vi.lib/National Instruments/TCP - IP Functions/Return Local IPs and Hostnames for all adapters.vi"
File 1="vi.lib/National Instruments/TCP - IP Functions/TCP Read String.vi"
File 2="vi.lib/National Instruments/TCP - IP Functions/TCP Write String.vi"


[File Group 1]
Target Dir="<menus>/Categories"
Replace Mode="Always"
Num Files=1
File 0="functions_national_instruments_lib_tcp___ip_functions.mnu"

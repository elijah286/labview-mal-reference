[Package]
Name="ni_lib_linked_network_actor"
Version="1.2.0.19"
Release=""
ID=0ca2045d56f07068cb10f608947c175a
File Format="vip"
Format Version="2010"
Display Name="NI Linked Network Actor"


[Description]
Description="This class uses network streams to create a peer-to-peer link between two already-launched actors. This link is a short circuit of the usual Actor communication tree.  In the intended use case, the actors reside in separate application instances, such as a host application running on a desktop computer and a target application running on a real-time system.  Linked Network Actor is suitable for both continuous and intermittent connections, such as a host which periodically connects to its RT target for monitoring.\0A\0ATo use this class, launch the two actors you wish to link and have each of them launch a nested actor of this class.  Decide which of your actors will initiate the connection, and have it send the Connect message to its Linked Network Actor. Either actor can send the Disconnect message to break the connection.  Linked Network Actor sends an Update Status Message to its caller whenever its connection status changes.  This is an abstract message; the caller is expected to provide a concrete implementation when first launching the Linked Network Actor.\0A\0AUse Transmit Network Message to send messages between the linked actors.  Create the message you wish to send, and use accessor methods to set its attributes.  Wire this message to the message input of Send Transmit Network Message.  The local Linked Network Actor will send the message to the remote Linked Network Actor, which will then forward it to its caller.  Note that sending a Transmit Network Message to a Linked Network Actor that is not connected will result in an error.\0A\0AThe package will be installed in <user.lib>\\Actors\\Linked Network Actor.  An example VI, Linked Network Actor Test.vi, will be installed in the folder <LabVIEW>\\examples\\Actors\\Linked Network Actor.\0A\0AThis version of Linked Network Actor does not cover all use cases.  Specifically:\0A1.	 Reply Messages will not work across the network.\0A2.	Self-Addressed Messages will not work across the network.\0A3.	When either nested actor receives the Stop message, it calls Destroy Stream Endpoint on both its writer and reader streams, with no opportunity to obtain any messages that might still be in the stream.  Any such messages will be lost.\0A4.  Because of 3, above, Drop Msg Core.vi will not work as expected. Drop Msg Core.vi will never be called on messages that are still in the network buffer. \0A\0AFuture versions of this actor may address these issues.\0A"
Summary="An actor that uses network streams to create a peer-to-peer link between two already-launched actors. "
License="	NI Sample Code License (NI SCL)"
Copyright="Copyright (c) 2013, National Instruments"
Distribution=""
Vendor="National Instruments"
URL="ni.com/actorframework"
Packager="Allen C. Smith"
Demo="FALSE"
Release Notes="1)  This version corrects a problem that occurs if a target running a Linked Network Actor is rebooted or otherwise disrupted while the Linked Network Actor is connected to a remote Linked Network Actor.  In this situation, the remote Linked Network Actor would persist in a connected state.  The next attempt to connect to the remote Linked Network Actor would fail, and the local Linked Network Actor would stop and return a timeout error.  The attempt would, however, reset the remote Linked Network Actor, and subsequent attempts to connect would succeed.\0A\0AThis version changes the error handling behavior of the Linked Network Actor.  The Linked Network Actor will now report timeout errors (Error -314004) without terminating.  This allows the caller to attempt to retry the connection without having to restart the Linked Network Actor.\0A\0AThe LNA will also report, without terminating, if the endpoint to which you wish to connect does not exist (Error -314100), or already exists (-314101).\0A\0A2)  At the request of users, we have also changed the name of the abstract message "Update Status Msg" to "LNA Connection Status Msg".  This should make the abstract message easier to find when building concrete implementations, and shoudl avoid name conflicts with future actors.\0A\0A3)  Certain methods in this version of the Linked Network Actor have been given community scope.  If you wish to use this version to communicate with CompactRIO and other VxWorks targets, you must install the LabVIEW 2012 Real-Time Module f1 patch, available free from National Instruments.\0A\0A4)  If you try to send a message to a remote LNA, and the transmission generates an error, the local LNA will return the transmitted message and the associated error to its caller, using the abstract message "LNA Return Message Msg."  This return message will have high priority.  This will not create an error condition locally, so the LNA will not shut down."
System Package="FALSE"
Sub Package="FALSE"
License Agreement="TRUE"


[Platform]
Exclusive_LabVIEW_Version=">=12.0"
Exclusive_LabVIEW_System="ALL"
Exclusive_OS="Windows NT"


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
Num File Groups="3"
Sub-Packages=""
Namespaces=""


[File Group 0]
Target Dir="<application>"
Replace Mode="Always"
Num Files=56
File 0="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Test - Single Actor A.vi"
File 1="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Test - Single Actor B.vi"
File 2="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor.lvlib"
File 3="vi.lib/NI/Actors/Linked Network Actor/LNA Target.lvproj"
File 4="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Write Status Msg Msg/Do.vi"
File 5="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Write Status Msg Msg/Send Write Status Msg.vi"
File 6="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Write Status Msg Msg/Write Status Msg Msg.lvclass"
File 7="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Write Reader Msg/Do.vi"
File 8="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Write Reader Msg/Send Write Reader.vi"
File 9="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Write Reader Msg/Write Reader Msg.lvclass"
File 10="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Transmit Network Message Msg/Do.vi"
File 11="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Transmit Network Message Msg/Send Transmit Network Message.vi"
File 12="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Transmit Network Message Msg/Transmit Network Message Msg.lvclass"
File 13="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/LNA Return Message Msg/LNA Return Message Msg.lvclass"
File 14="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/LNA Return Message Msg/Read Attributes.vi"
File 15="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/LNA Return Message Msg/Send LNA Return Message.vi"
File 16="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/LNA Connection Status Msg/LNA Connection Status Msg.lvclass"
File 17="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/LNA Connection Status Msg/Read Status.vi"
File 18="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/LNA Connection Status Msg/Send Update Status.vi"
File 19="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Forward Message to Caller Msg/Create Message to Forward.vi"
File 20="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Forward Message to Caller Msg/Do.vi"
File 21="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Forward Message to Caller Msg/Forward Message to Caller Msg.lvclass"
File 22="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Forward Message to Caller Msg/Read Attributes.vi"
File 23="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Forward Message to Caller Msg/Send Forward Message to Caller.vi"
File 24="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Disconnect Msg/Disconnect Msg.lvclass"
File 25="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Disconnect Msg/Do.vi"
File 26="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Disconnect Msg/Send Disconnect.vi"
File 27="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Connect Msg/Connect Msg.lvclass"
File 28="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Connect Msg/Create Connect Message.vi"
File 29="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Connect Msg/Do.vi"
File 30="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor Messages/Connect Msg/Send Connect.vi"
File 31="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Actor Core.vi"
File 32="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Connect.vi"
File 33="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Disconnect.vi"
File 34="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Forward Message to Caller.vi"
File 35="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Handle Error.vi"
File 36="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Linked Network Actor.lvclass"
File 37="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Linked Network Actor.vi"
File 38="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Post Status.vi"
File 39="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Pre Launch Init.vi"
File 40="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Read Context.vi"
File 41="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Read Name.vi"
File 42="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Read Return Msg.vi"
File 43="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Stop Core.vi"
File 44="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Transmit Network Message.vi"
File 45="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Write Buffer Size.vi"
File 46="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Write Context.vi"
File 47="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Write Name.vi"
File 48="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Write Reader.vi"
File 49="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Write Return Msg.vi"
File 50="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Write Status Msg.vi"
File 51="vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor/Write timeout.vi"
File 52="examples/NI/Actors/Linked Network Actor/Linked Network Actor Test.vi"
File 53="examples/NI/Actors/Linked Network Actor/Loopback/Add Time Stamp.vi"
File 54="examples/NI/Actors/Linked Network Actor/Loopback/Loopback.lvclass"
File 55="examples/NI/Actors/Linked Network Actor/Loopback/Read Time Stamps.vi"


[File Group 1]
Target Dir="<vi.lib>/addons/National Instruments"
Replace Mode="Always"
Num Files=1
File 0="functions_ni_lib_linked_network_actor.mnu"


[File Group 2]
Target Dir="<vi.lib>/addons/National Instruments"
Replace Mode="If Newer"
Num Files=1
File 0="dir.mnu"

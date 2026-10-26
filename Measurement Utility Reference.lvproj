<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="26008000">
	<Property Name="NI.Project.Description" Type="Str">Actively developed author-maintained LabVIEW HAL/MAL reference for LabVIEW 2026 x64. External NI dependencies and plugin configuration required; see README.md.</Property>
	<Item Name="My Computer" Type="My Computer">
		<Property Name="server.app.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.control.propertiesEnabled" Type="Bool">true</Property>
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="API" Type="Folder">
			<Item Name="Controller API.lvlib" Type="Library" URL="../source/api/controller/Controller API.lvlib"/>
		</Item>
		<Item Name="Application" Type="Folder">
			<Item Name="Client Proxy LNA.lvlib" Type="Library" URL="../source/application/Server/Client Proxy LNA/Client Proxy LNA.lvlib"/>
			<Item Name="Server Controller.lvlib" Type="Library" URL="../source/application/Server/Controller/Server Controller.lvlib"/>
			<Item Name="Server UI.lvlib" Type="Library" URL="../source/application/Server/UI/Server UI.lvlib"/>
			<Item Name="ServerListener.lvlib" Type="Library" URL="../source/application/Server/Listener/ServerListener.lvlib"/>
		</Item>
		<Item Name="Configuration" Type="Folder">
			<Item Name="Configuration.lvlib" Type="Library" URL="../source/configuration/Configuration.lvlib"/>
			<Item Name="Measurements.ini" Type="Document" URL="../source/application/Measurements.ini"/>
		</Item>
		<Item Name="Framework" Type="Folder">
			<Item Name="Buffer.lvlib" Type="Library" URL="../source/framework/Buffer/Buffer.lvlib"/>
			<Item Name="Controller Actor.lvlib" Type="Library" URL="../source/framework/Controller/Controller Actor.lvlib"/>
			<Item Name="Generic UI Actor.lvlib" Type="Library" URL="../source/framework/User Interface/Generic UI Actor.lvlib"/>
			<Item Name="Hardware.lvlib" Type="Library" URL="../source/framework/Hardware/Hardware.lvlib"/>
			<Item Name="Logger.lvlib" Type="Library" URL="../source/framework/Logger/Logger.lvlib"/>
			<Item Name="Logging.lvlib" Type="Library" URL="../source/framework/Logging/Logging.lvlib"/>
			<Item Name="Measurement Actor.lvlib" Type="Library" URL="../source/framework/Measurement Actor/Measurement Actor.lvlib"/>
			<Item Name="Measurement UI.lvlib" Type="Library" URL="../source/framework/Msmt UI/Measurement UI.lvlib"/>
			<Item Name="Msmt Configuration.lvlib" Type="Library" URL="../source/framework/Msmt Configuration/Msmt Configuration.lvlib"/>
			<Item Name="Result Actor.lvlib" Type="Library" URL="../source/framework/Results/Result Actor.lvlib"/>
		</Item>
		<Item Name="Hardware Plugins" Type="Folder">
			<Item Name="Simulated DMM.lvclass" Type="LVClass" URL="../source/plugins/hardware/Simulated DMM/Simulated DMM.lvclass"/>
			<Item Name="Simulated Function Generator.lvclass" Type="LVClass" URL="../source/plugins/hardware/Simulated FGEN/Simulated Function Generator.lvclass"/>
			<Item Name="Simulated Scope.lvclass" Type="LVClass" URL="../source/plugins/hardware/Simulated Scope/Simulated Scope.lvclass"/>
		</Item>
		<Item Name="Local Dependencies" Type="Folder">
			<Item Name="Current Value Table.lvlib" Type="Library" URL="../vendor/labview/vi.lib/NI/Current Value Table/Current Value Table.lvlib"/>
			<Item Name="Guid Generator.vi" Type="VI" URL="../source/support/guid/Guid Generator.vi"/>
			<Item Name="Linked Network Actor.lvlib" Type="Library" URL="../vendor/labview/vi.lib/NI/Actors/Linked Network Actor/Linked Network Actor.lvlib"/>
		</Item>
		<Item Name="Measurement Plugins" Type="Folder">
			<Item Name="Standard Measurement Plugin.lvlib" Type="Library" URL="../source/plugins/measurements/Standard Measurement Plugin/Standard Measurement Plugin.lvlib"/>
		</Item>
		<Item Name="Optional Integration Sources" Type="Folder">
			<Item Name="Client Source Project" Type="Document" URL="../source/application/Networked Measurement System.lvproj"/>
			<Item Name="Measurement Prototype Project" Type="Document" URL="../templates/measurement/Source/Measurement/Measurement Prototype.lvproj"/>
			<Item Name="TestStand Source Project" Type="Document" URL="../source/integrations/teststand/TestStand Custom Step Types for MAL Framework.lvproj"/>
		</Item>
		<Item Name="Dependencies" Type="Dependencies"/>
		<Item Name="Build Specifications" Type="Build">
			<Item Name="Measurement Utility EXE" Type="EXE">
				<Property Name="App_copyErrors" Type="Bool">true</Property>
				<Property Name="TgtF_enableDebugging" Type="Bool">false</Property>
				<Property Name="App_excludeLibraryItems" Type="Bool">false</Property>
				<Property Name="App_excludeLVClassItems" Type="Bool">false</Property>
				<Property Name="App_serverConfig.tcp.enabled" Type="Bool">false</Property>
				<Property Name="Bld_buildSpecName" Type="Str">Measurement Utility EXE</Property>
				<Property Name="Bld_localDestDir" Type="Path">../builds/Measurement Utility</Property>
				<Property Name="Bld_localDestDirType" Type="Str">relativeToProject</Property>
				<Property Name="Bld_version.major" Type="Int">1</Property>
				<Property Name="Destination[0].destName" Type="Str">Measurement Utility.exe</Property>
				<Property Name="Destination[0].path" Type="Path">../builds/Measurement Utility/Measurement Utility.exe</Property>
				<Property Name="Destination[0].path.type" Type="Str">relativeToProject</Property>
				<Property Name="Destination[0].preserveHierarchy" Type="Bool">true</Property>
				<Property Name="Destination[0].type" Type="Str">App</Property>
				<Property Name="Destination[1].destName" Type="Str">Support Directory</Property>
				<Property Name="Destination[1].path" Type="Path">../builds/Measurement Utility/data</Property>
				<Property Name="Destination[1].path.type" Type="Str">relativeToProject</Property>
				<Property Name="Destination[1].preserveHierarchy" Type="Bool">true</Property>
				<Property Name="Destination[2].destName" Type="Str">Application Directory</Property>
				<Property Name="Destination[2].path" Type="Path">../builds/Measurement Utility</Property>
				<Property Name="Destination[2].path.type" Type="Str">relativeToProject</Property>
				<Property Name="Destination[2].type" Type="Str">userFolder</Property>
				<Property Name="Destination[2].preserveHierarchy" Type="Bool">true</Property>
				<Property Name="DestinationCount" Type="Int">3</Property>
				<Property Name="Source[0].itemID" Type="Str">{919CE686-CA96-4D66-B217-3446EA14019C}</Property>
				<Property Name="Source[0].Container.applyProperties" Type="Bool">true</Property>
				<Property Name="Source[0].Container.applySaveSettings" Type="Bool">true</Property>
				<Property Name="Source[0].properties[0].type" Type="Str">Allow debugging</Property>
				<Property Name="Source[0].properties[0].value" Type="Bool">true</Property>
				<Property Name="Source[0].properties[1].type" Type="Str">Remove front panel</Property>
				<Property Name="Source[0].properties[1].value" Type="Bool">false</Property>
				<Property Name="Source[0].properties[2].type" Type="Str">Remove block diagram</Property>
				<Property Name="Source[0].properties[2].value" Type="Bool">false</Property>
				<Property Name="Source[0].propertiesCount" Type="Int">3</Property>
				<Property Name="Source[0].type" Type="Str">Container</Property>
				<Property Name="Source[1].destinationIndex" Type="Int">0</Property>
				<Property Name="Source[1].itemID" Type="Ref">/My Computer/Application/Server Controller.lvlib/Server Controller.lvclass/main.vi</Property>
				<Property Name="Source[1].sourceInclusion" Type="Str">TopLevel</Property>
				<Property Name="Source[1].type" Type="Str">VI</Property>
				<Property Name="Source[2].destinationIndex" Type="Int">1</Property>
				<Property Name="Source[2].itemID" Type="Ref">/My Computer/Hardware Plugins/Simulated DMM.lvclass</Property>
				<Property Name="Source[2].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[2].type" Type="Str">Library</Property>
				<Property Name="Source[3].destinationIndex" Type="Int">1</Property>
				<Property Name="Source[3].itemID" Type="Ref">/My Computer/Hardware Plugins/Simulated Function Generator.lvclass</Property>
				<Property Name="Source[3].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[3].type" Type="Str">Library</Property>
				<Property Name="Source[4].destinationIndex" Type="Int">1</Property>
				<Property Name="Source[4].itemID" Type="Ref">/My Computer/Hardware Plugins/Simulated Scope.lvclass</Property>
				<Property Name="Source[4].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[4].type" Type="Str">Library</Property>
				<Property Name="Source[5].destinationIndex" Type="Int">1</Property>
				<Property Name="Source[5].itemID" Type="Ref">/My Computer/Measurement Plugins/Standard Measurement Plugin.lvlib</Property>
				<Property Name="Source[5].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[5].type" Type="Str">Library</Property>
				<Property Name="Source[6].destinationIndex" Type="Int">2</Property>
				<Property Name="Source[6].itemID" Type="Ref">/My Computer/Configuration/Measurements.ini</Property>
				<Property Name="Source[6].sourceInclusion" Type="Str">Include</Property>
				<Property Name="Source[6].type" Type="Str">Document</Property>
				<Property Name="SourceCount" Type="Int">7</Property>
				<Property Name="TgtF_fileDescription" Type="Str">Measurement Task Manager</Property>
				<Property Name="TgtF_internalName" Type="Str">Measurement Utility</Property>
				<Property Name="TgtF_productName" Type="Str">Measurement Utility Reference</Property>
				<Property Name="TgtF_targetfileName" Type="Str">Measurement Utility.exe</Property>
			</Item>
		</Item>
	</Item>
</Project>

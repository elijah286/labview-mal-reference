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
			<Item Name="Measurements.ini" Type="Document" URL="source/application/Measurements.ini"/>
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
			<Item Name="Client Source Project" Type="Document" URL="source/application/Networked Measurement System.lvproj"/>
			<Item Name="Measurement Prototype Project" Type="Document" URL="templates/measurement/Source/Measurement/Measurement Prototype.lvproj"/>
			<Item Name="TestStand Source Project" Type="Document" URL="source/integrations/teststand/TestStand Custom Step Types for MAL Framework.lvproj"/>
		</Item>
		<Item Name="Dependencies" Type="Dependencies"/>
		<Item Name="Build Specifications" Type="Build"/>
	</Item>
</Project>

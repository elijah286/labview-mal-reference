<?xml version='1.0' encoding='UTF-8'?>
<Project Type="Project" LVVersion="26008000">
	<Property Name="NI.Project.Description" Type="Str">Hardware-free Caraya regression tests for the measurement framework.</Property>
	<Item Name="My Computer" Type="My Computer">
		<Property Name="server.tcp.enabled" Type="Bool">false</Property>
		<Property Name="specify.custom.address" Type="Bool">false</Property>
		<Item Name="Framework" Type="Folder">
			<Item Name="Hardware.lvlib" Type="Library" URL="../../source/framework/Hardware/Hardware.lvlib"/>
			<Item Name="Measurement Actor.lvlib" Type="Library" URL="../../source/framework/Measurement Actor/Measurement Actor.lvlib"/>
			<Item Name="Standard Measurement Plugin.lvlib" Type="Library" URL="../../source/plugins/measurements/Standard Measurement Plugin/Standard Measurement Plugin.lvlib"/>
		</Item>
		<Item Name="Measurement Test Harness.lvclass" Type="LVClass" URL="../fixtures/Measurement Test Harness/Measurement Test Harness.lvclass"/>
		<Item Name="Run Tests.vi" Type="VI" URL="../Run Tests.vi"/>
		<Item Name="Unit Tests" Type="Folder">
			<Item Name="Test Incoming Measurement Error.vi" Type="VI" URL="../unit/Test Incoming Measurement Error.vi"/>
			<Item Name="Test Plugin Requirements.vi" Type="VI" URL="../unit/Test Plugin Requirements.vi"/>
			<Item Name="Test Buffer Preview.vi" Type="VI" URL="../unit/Test Buffer Preview.vi"/>
			<Item Name="Test Empty Hardware Buffer.vi" Type="VI" URL="../unit/Test Empty Hardware Buffer.vi"/>
		</Item>
		<Item Name="Dependencies" Type="Dependencies"/>
		<Item Name="Build Specifications" Type="Build"/>
	</Item>
</Project>

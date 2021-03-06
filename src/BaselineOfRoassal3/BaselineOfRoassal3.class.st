"
Baseline for https://github.com/ObjectProfile/Roassal3
"
Class {
	#name : #BaselineOfRoassal3,
	#superclass : #BaselineOf,
	#category : #BaselineOfRoassal3
}

{ #category : #baselines }
BaselineOfRoassal3 >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ | dep1 dep2  |
			spec package: 'Athens-SVG' with: [
				spec repository: 'http://www.smalltalkhub.com/mc/Pharo/Athens/main' ].
			spec package: 'Geometry' with: [ 
				spec repository: 'github://TelescopeSt/Geometry:v1.1.0/src' ].
			spec baseline: 'NumericScales'with: [ 
				spec repository: 'github://ObjectProfile/NumericScales' ].
			dep1 := OrderedCollection new
				add: 'Athens-SVG';
				add: 'Geometry';
				yourself.
			Smalltalk globals at: #SpPresenter ifPresent: [
				dep2 := #('Roassal3-Spec').
			] ifAbsent: [
				dep1 add: 'Roassal3-Pharo7'.
				dep2 := #() ].
			
			spec
				package: #'Roassal3-Pharo7';
				package: #'Roassal3' with: [ spec requires: dep1 asArray ];
				package: #'Roassal3-Shapes';
				package: #'Roassal3-Animation' with: [ spec requires: #('NumericScales') ];
				package: #'Roassal3-Matplotlib';
				package: #'Roassal3-Interaction';
				package: #'Roassal3-Legend';
				package: #'Roassal3-Pie';
				package: #'Roassal3-UML';
				package: #'Roassal3-Layouts';
				package: #'Roassal3-Colors';
				package: #'Roassal3-Spec';
				package: #'Roassal3-Sunburst';
				package: #'Roassal3-Inspector' with: [spec requires: dep2 ];
				package: #'Roassal3-Menu';
				
				package: #'Roassal3-Examples';
				package: #'Roassal3-Legend-Examples';
				package: #'Roassal3-Matplotlib-Examples';
				package: #'Roassal3-Pie-Examples';
				package: #'Roassal3-Spec-Examples';
				package: #'Roassal3-Sunburst-Examples';
				package: #'Roassal3-UML-Examples';
				
				package: #'Roassal3-Global-Tests';
				package: #'Roassal3-Animation-Tests' with: [ spec requires: #('Roassal3-Animation') ];
				package: 'Roassal3-Shapes-Tests';
				package: 'Roassal3-Interaction-Tests';
				package: 'Roassal3-Layouts-Tests';
				package: 'Roassal3-Matplotlib-Tests';
				package: 'Roassal3-Spec-Tests';
				package: 'Roassal3-UML-Tests'.
				
			spec 
				group: 'Core' with: #(
					'Roassal3'
					'Roassal3-Shapes'
					'Roassal3-Interaction'
					'Roassal3-Layouts'
					'Roassal3-Colors'
					'Roassal3-Legend'
					'Roassal3-Animation'
					'Roassal3-UML'
					'Roassal3-Sunburst'
					'Roassal3-Pie'
					'Roassal3-Inspector'
					'Roassal3-Matplotlib'
					'Roassal3-Menu');
				group: 'Examples'  with: #(
					'Core' 
					'Roassal3-Examples'
					'Roassal3-Legend-Examples'
					'Roassal3-Matplotlib-Examples'
					'Roassal3-Pie-Examples'
					'Roassal3-Spec-Examples'
					'Roassal3-Sunburst-Examples'
					'Roassal3-UML-Examples');
				group: 'Tests' with: #(
					'Core' 
					'Roassal3-Global-Tests' 
					'Roassal3-Animation-Tests'
					'Roassal3-Shapes-Tests'
					'Roassal3-Interaction-Tests'
					'Roassal3-Layouts-Tests'
					'Roassal3-Matplotlib-Tests'
					'Roassal3-Spec-Tests'
					'Roassal3-UML-Tests');
				group: 'default' with: #('Core' 'Tests' 'Examples') ].

		
	







]

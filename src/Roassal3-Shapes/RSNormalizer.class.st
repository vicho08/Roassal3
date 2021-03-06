"
A Metric normalizer is made to assign a color, or a particular shape computed from a group of elements. Consider the following example:
-=-=-=-=
	classes := Collection withAllSubclasses.
	c := RSCanvas new.
	
	shapes := classes collect: [ :cls |
		b := RSBox new.
		b model: cls.
		b size: cls numberOfMethods.
		b @ RSDraggable @ RSPopup.
		b ].

	RSNormalizer color
		shapes: shapes;
		normalize: #numberOfMethods.

	c addAll: shapes.
	RSGridLayout on: shapes.

	c @ RSControlsCanvas 
-=-=-=-=

Here is another example:
-=-=-=-=
canvas := RSCanvas new.
classes := Collection withAllSubclasses.
shapes := classes collect: [ :cls |
    RSEllipse new
        size: 10;
        model: cls;
        draggable;
        yourself ].
canvas addAll: shapes.

RSNormalizer size
    from: 10;
    to: 100;
    shapes: shapes;
    normalize: #numberOfMethods.
RSNormalizer color
    from: Color green;
    to: Color red;
    shapes: shapes;
    normalize: #numberOfMethods.

RSEdgeBuilder orthoVertical
    withVerticalAttachPoint;
    markerStart: (RSPolygon arrow size: 5; color: Color blue);
    canvas: canvas;
    shapes: shapes;
    connectFrom: #superclass.
    
RSTreeLayout on: shapes.
canvas @ RSControlsCanvas.
canvas
-=-=-=-=

Another example:
-=-=-=-=
c := RSCanvas new.

(30 to: 100 by: 5) do: [ :nb |
	c add: (RSEllipse new size: nb; model: nb) ].

RSNormalizer size
	shapes: c shapes;
	normalize: #yourself.

RSNormalizer color
	shapes: c shapes;
	normalize: #yourself.
	
RSFlowLayout on: c shapes.

c shapes @ RSPopup.

c
-=-=-=-=
"
Class {
	#name : #RSNormalizer,
	#superclass : #RSObject,
	#instVars : [
		'scale',
		'executeBlock',
		'shapes'
	],
	#category : #'Roassal3-Shapes-Util'
}

{ #category : #'instance creation' }
RSNormalizer class >> color [ 
	| n |
	n := self new.
	n from: Color green.
	n to: Color red.
	n executeBlock: [ :shape :scaledValue | shape color: scaledValue ].
	^ n

]

{ #category : #'instance creation' }
RSNormalizer class >> fontSize [ 
"Here is example
-=-=-=-=-=-=-=
v := RSView new.
v @ RSControlsView.

sb := RSShapeBuilder label.
sb interactionDo: #draggable.
sb text: #asString.
elements := sb elementsOn: (Collection withAllSubclasses).

elements do: [ :e | e translateTo: (Random new nextInt: 300) @ (Random new nextInt: 300) ].
v addAll: elements.

RSNormalizer fontSize
	elements: elements;
	to: 30;
	normalize: #numberOfMethods.

v zoomToFit.
v open
-=-=-=-=-=-=-=
"

	| n |
	n := self new.
	n from: 5.
	n to: 100.
	n executeBlock: [ :shape :scaledValue | shape fontSize: scaledValue ].
	^ n

]

{ #category : #'instance creation' }
RSNormalizer class >> height [ 
	| n |
	n := self new.
	n from: 5.
	n to: 100.
	n executeBlock: [ :shape :scaledValue | shape height: scaledValue ].
	^ n

]

{ #category : #'instance creation' }
RSNormalizer class >> position [ 
	"Create a normalizer for position.
	
Here is an example:
-=-=-=
classes := Collection withAllSubclasses.

v := RSView new.
es := RSShapeBuilder circle
			color: (Color gray alpha: 0.3);
			elementsOn: classes.
es @ RSPopup.
v addAll: es.
RSNormalizer size
	elements: es;
	from: 5;
	to: 20;
	normalize: [ :cls | cls instVarNames size ].
	
RSNormalizer position
	to: 500 @ -500;
	elements: es;
	normalize: [ :cls | cls numberOfMethods @ cls linesOfCode ].
v open		
-=-=-=		

and a more elaborated example:
-=-=-=
classes := Collection withAllSubclasses.

v := RSView new.
line := RSSingleEdgeBuilder polyline 
	width: 2;
	controlPoints: { 0@ -600. 0@0. 600@0 };
	markerStartEnd: (RSShapeBuilder triangle
		size: 20;
		color: Color black;
		element);
	edge.
es := RSShapeBuilder circle
	interactionDo: [ :i | i popup; browseable ];
	border: TSBorder new;
	color: TSColorPalette sequential orrd9;
	elementsOn: classes.
v addAll: es.
v add: line.
RSNormalizer size
	from: 5;
	to: 20;
	elements: es;
	normalize: [ :cls | cls instVarNames size ].
	
RSNormalizer position
	from: 0@0;
	to: 600@ -600;
	elements: es;
	normalize: [ :cls | cls numberOfMethods @ cls linesOfCode ].
v @ RSControlsView.
v 
-=-=-=
	"
	| n |
	n := self new.
	n from: 0 @ 0.
	n to: 100 @ 100.
	n executeBlock: [ :shape :scaledValue | shape translateTo: scaledValue ].
	^ n

]

{ #category : #'instance creation' }
RSNormalizer class >> size [ 
	| n |
	n := self new.
	n from: 5.
	n to: 100.
	n executeBlock: [ :shape :scaledValue | shape size: scaledValue ].
	^ n

]

{ #category : #'instance creation' }
RSNormalizer class >> width [ 
	| n |
	n := self new.
	n from: 5.
	n to: 100.
	n executeBlock: [ :shape :scaledValue | shape width: scaledValue ].
	^ n

]

{ #category : #'private - accessing' }
RSNormalizer >> executeBlock: anOneArgBlock [
	"Set the block to be executed for the normalizer. The end user should not call this method
	Instead, it is called from methods on the class side"
	executeBlock := anOneArgBlock
]

{ #category : #accessing }
RSNormalizer >> from: aValue [
	"Set the lower limit of the normalized value. For example:
-=-=-=-=-=-=-=-=-=
v := RSView new.

classes := Collection withAllSubclasses.
es := RSShapeBuilder circle elementsOn: classes.

v addAll: es.
es @ RSPopup @ RSDraggable.


RSNormalizer size
	elements: es;
	from: 2;
	to: 50;
	normalize: #numberOfMethods.
	
RSNormalizer color
	shapes: es;
	from: Color blue;
	to: Color pink;
	normalize: #numberOfMethods.
RSGridLayout on: es.
v @ RSControlsView.
v  
-=-=-=-=-=-=-=-=-=
"
	scale from: aValue
]

{ #category : #initialization }
RSNormalizer >> initialize [
	super initialize.
	scale := NSScale linear.
	shapes := #()

]

{ #category : #'private - accessing' }
RSNormalizer >> key [
	^ #normalizerValue
]

{ #category : #'private - accessing' }
RSNormalizer >> minAndMaxFor: anOneArgBlockOrSymbol [
	| min max |
	min := SmallInteger maxVal.
	max := SmallInteger minVal.
	shapes do: [ :shape | | res |
		res := anOneArgBlockOrSymbol rsValue: shape model.
		shape attributeAt: self key put: res.
		min := min min: res.
		max := max max: res ].
	^ { min. max }.
]

{ #category : #normalizer }
RSNormalizer >> normalize: anOneArgBlockOrSymbol [
	"Trigger the normalization using a particular metric to normalize.
	The metric is computed on each model of the shapes that are considered.
	"
	| minAndMax |
	minAndMax := self minAndMaxFor: anOneArgBlockOrSymbol.
	scale domain: minAndMax.
	shapes do: [ :shape |
		| scaledValue objectValue |
		objectValue := shape attributeAt: self key.
		scaledValue := scale scale: objectValue.
		executeBlock value: shape value: scaledValue ]

]

{ #category : #accessing }
RSNormalizer >> scale [
	^ scale

]

{ #category : #accessing }
RSNormalizer >> scale: aNSScale [
	scale ifNotNil: [ aNSScale range: scale range ].
	scale := aNSScale.
	
]

{ #category : #accessing }
RSNormalizer >> shapes [
	"Return the shapes that should be normalized"
	^ shapes

]

{ #category : #accessing }
RSNormalizer >> shapes: someShapes [
	"Set to the normalizer the elements that should be normalized"
	shapes := someShapes
]

{ #category : #accessing }
RSNormalizer >> to: aValue [
	"Set the upper limit of the normalized value. For example:
-=-=-=-=-=-=-=-=-=
v := RSView new.

classes := Collection withAllSubclasses.
es := RSShapeBuilder circle elementsOn: classes.

v addAll: es.
es @ RSPopup @ RSDraggable.


RSNormalizer size
	elements: es;
	to: 20;
	normalize: #numberOfMethods.
	
RSNormalizer color
	elements: es;
	to: Color pink;
	normalize: #numberOfMethods.
RSGridLayout on: es.
v @ RSControlsView.
v  
-=-=-=-=-=-=-=-=-=
"
	scale to: aValue

]

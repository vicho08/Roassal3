"
I represent the abstract lines that have start and end points

For example:
-=-=-=-=-=-=-=-=-=-=-=-=
c := RSCanvas new.

circle := RSEllipse new color: Color green; size: 10.
box := RSBox new color: Color red; size: 10.
c add: circle; add: box.

dragMeLabel := RSLabel new text: 'Drag me'.
c add: dragMeLabel.
RSLocation new
	above; center;
	stick: dragMeLabel on: box.

c add: (RSLine new color: Color veryVeryLightGray; from: 0 @ -1000; to: 0 @ 1000).
c add: (RSLine new color: Color veryVeryLightGray; from: -1000 @ 0; to: 1000 @ 0).

box translateBy: 50 @ 50.
box @ RSDraggable.

c add: (RSLine new color: Color blue; from: box; to: circle).

c
-=-=-=-=-=-=-=-=-=-=-=-=
"
Class {
	#name : #RSAbstractLine,
	#superclass : #RSShape,
	#traits : 'TMarkeable',
	#classTraits : 'TMarkeable classTrait',
	#instVars : [
		'attachPoint',
		'from',
		'to'
	],
	#category : #'Roassal3-Shapes-Lines'
}

{ #category : #visiting }
RSAbstractLine >> accept: visitor [
	visitor visitLine: self.
]

{ #category : #'attach point' }
RSAbstractLine >> attachPoint [
	^ attachPoint
]

{ #category : #'attach point' }
RSAbstractLine >> attachPoint: ap [
	attachPoint := ap
]

{ #category : #'style-cap' }
RSAbstractLine >> capButt [
	self border capButt
]

{ #category : #'style-cap' }
RSAbstractLine >> capRound [
	self border capRound
]

{ #category : #'style-cap' }
RSAbstractLine >> capSquare [
	self border capSquare
]

{ #category : #accessing }
RSAbstractLine >> color [
	^ self strokePaint
]

{ #category : #accessing }
RSAbstractLine >> color: aColor [
	self strokePaint: aColor.
	self markersDo: [ :m | m shape borderColor: aColor ].
]

{ #category : #accessing }
RSAbstractLine >> computeEncompassingRectangle [
	| cp |
	cp := self controlPoints.
	^ cp 
			ifEmpty: [ 0@0 corner: 0@0 ]
			ifNotEmpty: [ Rectangle encompassing: cp ]
]

{ #category : #accessing }
RSAbstractLine >> controlPoints [
	^ self subclassResponsibility
]

{ #category : #'style-dashes' }
RSAbstractLine >> dashArray: arrayOfNumbers [
	self border dashArray: arrayOfNumbers
	
]

{ #category : #accessing }
RSAbstractLine >> endPoint [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractLine >> endPoint: aPoint [
	self subclassResponsibility
]

{ #category : #accessing }
RSAbstractLine >> from [
	^ from
]

{ #category : #accessing }
RSAbstractLine >> from: aShapeOrAPoint [
	"Set the end point of the line"
	from := self setAnchor: from shape: aShapeOrAPoint
]

{ #category : #testing }
RSAbstractLine >> hasMarkers [
	| m |
	m := self privateMarkers.
	^ m notNil and: [ 
		m anySatisfy: [ :mar | mar notNil ].  ]
]

{ #category : #initialization }
RSAbstractLine >> initialize [ 
	super initialize.
	self
		withBorder;
		noPaint;
		withCenteredAttachPoint.
	
]

{ #category : #testing }
RSAbstractLine >> isControlPointsLine [
	^ false
]

{ #category : #testing }
RSAbstractLine >> isEdge [
	^ true
]

{ #category : #'style-join' }
RSAbstractLine >> joinBevel [
	self border joinBevel
]

{ #category : #'style-join' }
RSAbstractLine >> joinMiter [
	self border joinMiter
]

{ #category : #'style-join' }
RSAbstractLine >> joinRound [
	self border joinRound
]

{ #category : #actions }
RSAbstractLine >> loadShape: other [
	self shouldBeImplemented 
]

{ #category : #'event handling' }
RSAbstractLine >> notifyExtentChanged [
	self announce: [ RSExtentChangedEvent new 
		shape: self;
		oldExtent: nil;
		newExtent: self controlPoints first - self controlPoints last ]
]

{ #category : #private }
RSAbstractLine >> privateMarkers [
	^ nil
]

{ #category : #adding }
RSAbstractLine >> remove [
	parent ifNil: [ ^ self ].
	parent removeEdge: self.
	self 
		removeFromParent: to;
		removeFromParent: from.
	super remove
]

{ #category : #private }
RSAbstractLine >> removeFromParent: aShape [
	aShape ifNil: [ ^ self ].
	aShape isPoint ifTrue: [ ^ self ].
	aShape connectedEdges remove: self ifAbsent: [  ].

]

{ #category : #adding }
RSAbstractLine >> renderOn: aCanvas [
	aCanvas addEdge: self.
	self update.
]

{ #category : #path }
RSAbstractLine >> resetPath [
	super resetPath.
	self resetBBox
]

{ #category : #path }
RSAbstractLine >> sessionChanged [
	self resetPath.
	self hasMarkers ifFalse: [ ^ self ].
	self markersDo: [ :mark | mark shape sessionChanged ].
	
]

{ #category : #private }
RSAbstractLine >> setAnchor: ref shape: anObject [
	ref isNotNil ifTrue: [ ref removeConnectedEdge: self ].
	anObject isPoint ifFalse: [ anObject addConnectedEdge: self ].
	^ anObject
]

{ #category : #accessing }
RSAbstractLine >> startPoint [
	^ self subclassResponsibility
]

{ #category : #accessing }
RSAbstractLine >> startPoint: aPoint [
	self subclassResponsibility
]

{ #category : #accessing }
RSAbstractLine >> strokeColor: aColor [
	self strokePaint: aColor
]

{ #category : #accessing }
RSAbstractLine >> strokePaint [
	^ self border paint
]

{ #category : #accessing }
RSAbstractLine >> strokePaint: aPaint [
	self border paint: aPaint.
]

{ #category : #accessing }
RSAbstractLine >> to [ 	
	^ to
]

{ #category : #accessing }
RSAbstractLine >> to: aShapeOrAPoint [
	"Set the end point of the line"
	to := self setAnchor: to shape: aShapeOrAPoint
]

{ #category : #update }
RSAbstractLine >> update [
	self subclassResponsibility
]

{ #category : #accessing }
RSAbstractLine >> width: aNumber [
	self border width: aNumber.
]

{ #category : #'attach point' }
RSAbstractLine >> withBorderAttachPoint [
	self attachPoint: RSBorderAttachPoint new.
]

{ #category : #'attach point' }
RSAbstractLine >> withCenteredAttachPoint [
	self attachPoint: RSCenteredAttachPoint new.
]

{ #category : #'attach point' }
RSAbstractLine >> withHorizontalAttachPoint [
	self attachPoint: RSHorizontalAttachPoint new.
]

{ #category : #'attach point' }
RSAbstractLine >> withVerticalAttachPoint [
	self attachPoint: RSVerticalAttachPoint new.
]

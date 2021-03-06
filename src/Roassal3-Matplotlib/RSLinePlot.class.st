Class {
	#name : #RSLinePlot,
	#superclass : #RSAbstractPlot,
	#category : #'Roassal3-Matplotlib-Core'
}

{ #category : #rendering }
RSLinePlot >> renderIn: canvas [
	| controlPoints |
	self checkAssertion. 
	controlPoints := OrderedCollection new.
	(1 to: xValues size) collect: [ :i |
			| xt yt |
			xt := xValues at: i.
			yt := yValues at: i.
			(self isPointWellDefined: xt @ yt)
				ifTrue: [ controlPoints add: (xScale scale: xt) @ (yScale scale: yt) ] ].
	
	canvas add: (RSPolyline new
		color: (chart colorFor: self);
		controlPoints: controlPoints;
		yourself).
]

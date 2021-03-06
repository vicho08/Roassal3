Class {
	#name : #RSVerticalTick,
	#superclass : #RSAbstractTick,
	#category : #'Roassal3-Matplotlib-Core'
}

{ #category : #rendering }
RSVerticalTick >> createNiceLabelIn: aChart [
	| nice |
	nice := super createNiceLabelIn: aChart.
	aChart 
		minValueY: nice min;
		maxValueY: nice max.
	^ nice
]

{ #category : #rendering }
RSVerticalTick >> createTickLineFor: aNumber [
	| scaledNumber |
	scaledNumber := yScale scale: aNumber.
	self assert: [ scaledNumber isInfinite not ].
	self assert: [ scaledNumber isNaN not ].
	^ RSLine new
		startPoint: 0 @ scaledNumber;
		endPoint: self tickSize negated @ scaledNumber;
		yourself
]

{ #category : #'accessing - defaults' }
RSVerticalTick >> defaultLabelLocation [
	^ RSLocation new outer; left
]

{ #category : #accessing }
RSVerticalTick >> maxValue [
	^ chart maxValueY
]

{ #category : #accessing }
RSVerticalTick >> minValue [
	^ chart minValueY
]

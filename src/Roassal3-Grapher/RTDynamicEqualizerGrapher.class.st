Class {
	#name : #RTDynamicEqualizerGrapher,
	#superclass : #RTAbstractGrapher,
	#instVars : [
		'metrics',
		'lastObject',
		'barElements'
	],
	#category : #'Roassal3-Grapher-Builder-Grapher-Core'
}

{ #category : #'public - metrics' }
RTDynamicEqualizerGrapher >> addName: aString metric: aBlockClosureOrSymbol [ 
	metrics add: (Array with: aString with: aBlockClosureOrSymbol)
]

{ #category : #examples }
RTDynamicEqualizerGrapher >> example01 [
	"
	self new example01
	"
	| b |
	b := RTDynamicEqualizerGrapher new. 
	b maxY: 20.
	b minY: -20.
	b addName: 'X1' metric: [ :anArray | anArray first ].
	b addName: 'Y1' metric: [ :anArray | anArray second ].
	b addName: 'Z1' metric: [ :anArray | anArray third ].
	b addName: 'X2' metric: [ :anArray | anArray fourth ].
	b addName: 'Y2' metric: [ :anArray | anArray fifth ].
	b addName: 'Z2' metric: [ :anArray | anArray sixth ].

	b view addMenu: 'Generate' callback: [ b object: ((1 to: 6) collect: [ :ii | 40 atRandom - 20]) ].
	^ b
]

{ #category : #initialization }
RTDynamicEqualizerGrapher >> initialize [
	super initialize.
	metrics := OrderedCollection new.
	
	self axisX noLabel; noTick
]

{ #category : #'accessing - computed' }
RTDynamicEqualizerGrapher >> numberOfMetrics [
	^ metrics size
]

{ #category : #'public - generation' }
RTDynamicEqualizerGrapher >> object: anObject [
	| values |
	values := metrics collect: [ :tupple | tupple second rsValue: anObject ].
	barElements ifNil: [ 
		barElements := self elementsOn: values.
		RSHorizontalLineLayout on: barElements.
		view addAll: barElements.
		].
	
	RSNormalizer height 
		elements: barElements;
		from: self min;
		to: self maxX;
		normalize: #yourself.
		
	view signalUpdate
]

{ #category : #hooks }
RTDynamicEqualizerGrapher >> renderIn: aView [

	self defineAxesIfNecessary.
	self renderAxis.

]

Class {
	#name : #RSAbstractChartElement,
	#superclass : #Object,
	#instVars : [
		'chart',
		'xScale',
		'yScale'
	],
	#category : #'Roassal3-Matplotlib-Core'
}

{ #category : #rendering }
RSAbstractChartElement >> beforeRenderingIn: aChart [
	"do nothing here"
]

{ #category : #accessing }
RSAbstractChartElement >> chart [
	^ chart
]

{ #category : #accessing }
RSAbstractChartElement >> chart: aChart [
	chart := aChart
]

{ #category : #rendering }
RSAbstractChartElement >> createXScale [
	xScale ifNil: [ xScale := NSScale linear ].
	xScale
		domain:
			{chart minValueX.
			chart maxValueX};
		range:
			{0.
			chart extent x}
]

{ #category : #rendering }
RSAbstractChartElement >> createYScale [
	yScale ifNil: [ yScale := NSScale linear ].
	yScale
		domain:
			{chart minValueY.
			chart maxValueY};
		range:
			{0.
			chart extent y negated}

]

{ #category : #rendering }
RSAbstractChartElement >> renderIn: canvas [
	"Need to be overridden in subclasses. This methods has to be use trachel to enrich a visualization"
	self subclassResponsibility
]

{ #category : #rendering }
RSAbstractChartElement >> spine [
	"Return the Trachel shape that describe the spine"
	^ (chart decorations
		detect: [ :d | d class == RSChartSpineDecoration ]
		ifNone: [ self error: 'No spine is added in the plt, you need to add one' ])
		shape
]

{ #category : #accessing }
RSAbstractChartElement >> xScale [
	^ xScale
]

{ #category : #accessing }
RSAbstractChartElement >> xScale: aScale [
	xScale := aScale
]

{ #category : #accessing }
RSAbstractChartElement >> yScale [
	^ yScale
]

{ #category : #accessing }
RSAbstractChartElement >> yScale: aScale [
	yScale := aScale
]

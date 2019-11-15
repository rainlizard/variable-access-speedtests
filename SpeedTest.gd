# Variable access speedtests (GDScript)
# Speedtests for all the various ways to access data. A value is increased 10000000 times in a For loop using different approaches.
# Repeated tests give very slightly different results.
#Godot version v3.2 beta1

extends ClassTest
onready var ExternalNode = $ExternalNode

# Arrays, dictionaries and enums have 10 entries each.
enum {localEnum1 = 1, localEnum2 = 1, localEnum3 = 1, localEnum4 = 1, localEnum5 = 1, localEnum6 = 1, localEnum7 = 1, localEnum8 = 1, localEnum9 = 1, localEnum10 = 1}
enum namedEnum {a = 1, b = 1, c = 1, d = 1, e = 1, f = 1, g = 1, h = 1, i = 1, j = 1}
var array = [1,1,1,1,1,1,1,1,1,1]
var dictionary = {0:1, 1:1, 2:1, 3:1, 4:1, 5:1, 6:1, 7:1, 8:1, 9:1}

const localConstant = 1
var localVariable = 1
var localTypedVariable := 1
class localClass:
	const localClassConstant = 1
var localClassInstance = localClass.new()
var preloadedScript = preload('res://PreloadedScript.gd').new()

var loops = 10000000
var CODETIME_START
var counter

func _ready():
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += 1
	result('Integer')
	
	yield(get_tree(),"idle_frame")
	argument(1)
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += localConstant
	result('Local Constant')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += localVariable
	result('Local Variable')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += localEnum10
	result('Local Enum')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += classConstant
	result('Extended Class Constant')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += array[9]
	result('Local Array')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += localClassInstance.localClassConstant
	result('Local Class Constant')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += ClassTest.classConstant
	result('External Class Constant')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += dictionary[9]
	result('Local Dictionary')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += Singleton.singletonVariable
	result('Singleton Variable')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += ExternalNode.externalVariable
	result('External Variable')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += preloadedScript.preloadedVariable
	result('Preloaded Script Variable')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += ExternalNode.externalConstant
	result('External Constant')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += ExternalNode.externalEnum10
	result('External Enum')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += ExternalNode.externalArray[9]
	result('External Array')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += ExternalNode.externalDictionary[9]
	result('External Dictionary')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += function()
	result('Local Function')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += staticFunction()
	result('Local Static Function')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += ExternalNode.externalFunction()
	result('External Function')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += namedEnum.j
	result('Local Named Enum')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += ExternalNode.externalStaticFunction()
	result('External Static Function')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += ExternalNode.externalNamedEnum.j
	result('External Named Enum')
	
	yield(get_tree(),"idle_frame")
	beginTest()
	for i in loops:
		counter += $ExternalNode.externalVariable
	result('External Variable, Repeatedly Get NodePath')

func argument(argument):
	beginTest()
	for i in loops:
		counter += argument
	result('Argument')

static func staticFunction():
	return 1

func function():
	return 1

func beginTest():
	counter = 0
	CODETIME_START = OS.get_ticks_msec()

func result(string):
	print(string+' time: '+str(OS.get_ticks_msec()-CODETIME_START)+'ms')


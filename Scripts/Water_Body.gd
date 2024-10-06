extends Node2D

@export var k = 0.015
@export var d = 0.03
@export var spread = 0.0002

#the spring array
var springs = []
var passes = 8

#distance in pixel between each spring 
@export var distance_between_springs = 32
#number of springs in the scene 
@export var spring_number = 6



@onready var water_spring = preload("res://Scenes/water_spring.tscn")

@export var depth = 1000
var target_height = global_position.y
var bottom = target_height + depth

@onready var water_polygon = $Water_Polygon

#total waterbody length



#initializes the spring array and allthe springs
func _ready():
	
	
	#loops through all the springs
	#makes an array with all the springs
	#initializes each spring
	for i in range(spring_number):
		var x_position = distance_between_springs * i
		var w = water_spring.instantiate()
		
		add_child(w)
		springs.append(w)
		w.initialize(x_position)
		
		splash (2, 3)
		
		
func _physics_process(_delta):
	for i in springs:
		i.water_update(k,d)
		
		#represents the movement of the left and right neighbor of the springs

	var left_deltas = []
	var right_deltas = []
	
	#initialize the values with an array of zeros
	for i in range(springs.size()):
		left_deltas.append(0)
		right_deltas.append(0)
		pass
		
	for j in range (passes):
		#loops through each spring of our array
		for i in range (springs.size()):
			#add velocity to a the spring to the left of the current spring
			if i > 0:
				left_deltas[i] = spread * (springs[i].height - springs[i-1].height)
				springs[i-1].velocity += left_deltas[i]
			#add velocity to a the spring to the Right of the current spring
			if i < springs.size()-1:
				right_deltas[i] = spread *(springs[i].height - springs[i+1].height)
				springs[i+1].velocity += right_deltas[i]
	draw_water_body()


func draw_water_body():
	var surface_points = []
	
	for i in range(springs.size()):
		surface_points.append(springs[i].position)
		
	var first_index = 0
	var last_index = surface_points.size()-1
	
	var water_polygon_points = surface_points
	
	water_polygon_points.append(Vector2(surface_points[last_index].x, bottom))
	water_polygon_points.append(Vector2(surface_points[first_index].x, bottom))
	
	water_polygon_points = PackedVector2Array(water_polygon_points)
	
	water_polygon.set_polygon(water_polygon_points)
	

#this function adds a speed to a spring with this index
func splash(index, speed):
	if index >= 0 and index < springs.size():
		springs[index].velocity += speed
	
	
pass

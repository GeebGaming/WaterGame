extends Node2D


#the spring's current velocity
var velocity = 0

#the force being applied to the spring
var force = 0

#the current height of the spring
var height = 0

#the natural position of the spring
var target_height = 0
#spring stiffness constant
var k = 0.015
#dampen
var d = 0.03
# the index of this spring
#we will set it on initialize
var index = 0

#how much an external object movement will affect this spring
var motion_factor = 0.015

#the last instance this spring collided with
#we check so it won't collide twice
var collided_with = null



func water_update(spring_constant, dampening):
	## This function applies the hooke's law force to the spring!!
	## This function will be called in each frame
	## hooke's law ---> F =  - K * x 
	
	#update the height value based on our current position
	height = position.y
	
	#the spring current extension
	var x = height - target_height
	
	var loss = -dampening * velocity
	
	#hookes law
	force = -spring_constant * x + loss
	
	
	#apply the force to the velocity
	#equivalent to velocity = velocity + force
	velocity += force
	
	#make the spring move!
	position.y += velocity
	

func initialize(x_position):
	height = position.y
	target_height = position.y
	velocity = 0
	position.x = x_position 
	
#we will trigger this signal to call the splash function
#to make our wave move!
signal splash

(define (domain healthcare)

  ; in this domain each supply has it's own action and in the warehouse there are infinite supplies
  ; only a person could be accompained by one robot

  (:requirements :strips :typing)

  (:types
    location unit robot box person - object
    guide_robot - robot ; robot that guides people
    box_robot - robot ; robot used for delivering supplies
    )

  (:predicates

    ; LOCATION
    (adjacent ?l1 ?l2 - location) ; used for building the topology of the hospital
    (belongs ?u - unit ?l - location) ; used for specifing that a unit belongs to a specified location            
    (is_loading_point ?l - location) ; used for indicating if the location l is the warehouse
    (has_bandages ?u - unit) ; used for specifing if the unit has the bandages 

    ; ROBOT
    (atl ?r - robot ?u - location) ; used for specifing the location of the robot      
    (has ?r - box_robot ?b - box) ; used for specifing that a robot has a box
    (free ?r - robot) ; used for specifing if the robot is free (could pick up boxes) 

    ; BOX
    (at ?b - box ?l - location) ; used for specifing the location of the box 
    (contains_bandages ?b - box) ; used for specifing if the box contains bandages
    (empty ?b - box) ; used for specifing if a box is empty (not have any supply inside)

    ;PERSON
    (in ?p - person ?u - unit) ; used for specifing if a person is in a unit 
    (inl ?p - person ?l - location) ; used for specifing the location of a person
    (accompanying ?r - guide_robot ?p - person) ; used for specifing if a robot is accompanying a person

  )

  ; action for moving a box from a location ?from to a location ?to
  (:action move_box
    :parameters (?r - box_robot ?from - location ?to - location ?b - box)
    :precondition (and (atl ?r ?from) (adjacent ?from ?to) (has ?r ?b) (at ?b ?from))
    :effect (and (not (atl ?r ?from)) (not(at ?b ?from)) (atl ?r ?to) (at ?b ?to))
  )

  ; action for moving without a box from a location ?from to a location ?to
  (:action move_empty
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and (atl ?r ?from) (adjacent ?from ?to))
    :effect (and (not (atl ?r ?from)) (atl ?r ?to))
  )

  ; action for filling the box with bandages and loading in the robot
  (:action fill_box_bandages
    :parameters (?r - box_robot ?l - location ?b - box)
    :precondition (and (atl ?r ?l) (is_loading_point ?l) (empty ?b) (at ?b ?l) (free ?r))
    :effect (and (not (empty ?b)) (contains_bandages ?b) (not (free ?r)) (has ?r ?b))
  )

  ; action for unloading the box with bandages and delivering the bendages to the unit
  (:action empty_box_bandages
    :parameters (?r - box_robot ?l - location ?b - box ?u - unit)
    :precondition (and (atl ?r ?l) (contains_bandages ?b) (belongs ?u ?l) (at ?b ?l) (has ?r ?b))
    :effect (and (not (contains_bandages ?b)) (empty ?b) (not (has ?r ?b)) (free ?r) (has_bandages ?u))
  )

  ; action for establishing the task of accompanying a person to an unit
  (:action start_accompany
    :parameters (?r - guide_robot ?l - location ?p - person)
    :precondition (and (atl ?r ?l) (inl ?p ?l) (free ?r))
    :effect (and (not (free ?r)) (accompanying ?r ?p))
  )

  ; action for guiding the person  
  (:action guide_person
    :parameters (?r - guide_robot ?from - location ?to - location ?p - person)
    :precondition (and (atl ?r ?from) (inl ?p ?from) (adjacent ?from ?to) (accompanying ?r ?p))
    :effect (and (not (atl ?r ?from)) (not (inl ?p ?from)) (atl ?r ?to) (inl ?p ?to))
  )

  ; action for accompanying a person to an unit 
  (:action accompany
    :parameters (?r - guide_robot ?l - location ?p - person ?u - unit)
    :precondition (and (atl ?r ?l) (inl ?p ?l) (belongs ?u ?l) (accompanying ?r ?p))
    :effect (and (not (accompanying ?r ?p)) (free ?r) (in ?p ?u))
  )
)
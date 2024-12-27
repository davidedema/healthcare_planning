(define (domain healthcare)

  ; Temporal version of problem 2


  (:requirements :strips :typing :durative-actions)

  (:types
    location unit robot box supply person carrier - object
    guide_robot - robot
    box_robot - robot
    earth_robot flying_robot - box_robot
    shilded_bot non_shilded_bot - earth_robot
    slot - carrier
    normal_location dangerous_location - location
  )

  (:predicates

    ; LOCATION
    (adjacent ?l1 ?l2 - location)
    (belongs ?u - unit ?l - location)

    ; ROBOT
    (atl ?r - robot ?u - location)
    (has ?r - box_robot ?c - carrier)
    (free ?r - robot)

    ; BOX
    (at ?b - box ?l - location)
    (has_supply ?b - box ?s - supply)
    (empty ?b - box)

    ; CARRIER
    (at_location_carrier ?c - carrier ?l - location) ; location of the carrier
    (contains ?c - carrier ?b - box) ; keep track of box in the carrier
    (has_slot ?c - carrier ?sl - slot) ; keep track of slots in the carrier
    (empty_slot ?sl - slot) ; if a slot is empty

    ; SUPPLY
    (has_supply_at ?s - supply ?l - location)
    (has_unit ?s - supply ?u - unit)
    
    ; PERSON
    (in ?p - person ?u - unit)
    (inl ?p - person ?l - location)
    (accompanying ?r - guide_robot ?p - person)
  )

  ; a flying_robot could go from point A to point B also 
  ; if the two are not connected
  ; (:action fly_carrier
  ;   :parameters (?r - flying_robot ?from - location ?to - normal_location ?c - carrier)
  ;   :precondition (and (atl ?r ?from) (has ?r ?c) (at_location_carrier ?c ?from))
  ;   :effect (and (not (atl ?r ?from)) (not(at_location_carrier ?c ?from)) (atl ?r ?to) (at_location_carrier ?c ?to))
  ; )
  (:durative-action action_name
      :parameters ()
      :duration (= ?duration 1)
      :condition (and 
          (at start (and 
          ))
          (over all (and 
          ))
          (at end (and 
          ))
      )
      :effect (and 
          (at start (and 
          ))
          (at end (and 
          ))
      )
  )
  

  ; ; move the robot with the carrier
  ; (:action move_carrier
  ;   :parameters (?r - box_robot ?from - location ?to - normal_location ?c - carrier)
  ;   :precondition (and (atl ?r ?from) (adjacent ?from ?to) (has ?r ?c) (at_location_carrier ?c ?from))
  ;   :effect (and (not (atl ?r ?from)) (not(at_location_carrier ?c ?from)) (atl ?r ?to) (at_location_carrier ?c ?to))
  ; )

  ; (:action move
  ;   :parameters (?r - robot ?from - location ?to - normal_location)
  ;   :precondition (and (atl ?r ?from) (adjacent ?from ?to))
  ;   :effect (and (not (atl ?r ?from)) (atl ?r ?to))
  ; )

  ; ; move with the carrier into dangerous locations if the robot is shilded 
  ; (:action move_carrier_shiled
  ;   :parameters (?r - shilded_bot ?from - location ?to - dangerous_location ?c - carrier)
  ;   :precondition (and (atl ?r ?from) (adjacent ?from ?to) (has ?r ?c) (at_location_carrier ?c ?from))
  ;   :effect (and (not (atl ?r ?from)) (not(at_location_carrier ?c ?from)) (atl ?r ?to) (at_location_carrier ?c ?to))
  ; )

  ; ; move into dangerous locations if the robot is shilded 
  ; (:action move_shield
  ;   :parameters (?r - shilded_bot ?from - location ?to - dangerous_location)
  ;   :precondition (and (atl ?r ?from) (adjacent ?from ?to))
  ;   :effect (and (not (atl ?r ?from)) (atl ?r ?to))
  ; )

  ; ; load supply into box and put in a slot of the carrier
  ; (:action load_carrier
  ;   :parameters (?b - box ?s - supply ?r - box_robot ?l - location ?c - carrier ?sl - slot)
  ;   :precondition (and (empty ?b) (at ?b ?l) (atl ?r ?l) (free ?r) (has_supply_at ?s ?l) (has ?r ?c) (at_location_carrier ?c ?l) (has_slot ?c ?sl) (empty_slot ?sl))
  ;   :effect (and (not (empty ?b)) (not (free ?r)) (not (empty_slot ?sl)) (has_supply ?b ?s) (contains ?sl ?b) (not (at ?b ?l)))
  ; )
  
  ; ; deliver supply to unit and leave box in location and empty the slot
  ; (:action unload_carrier
  ;   :parameters (?b - box ?s - supply ?r - box_robot ?l - location ?u - unit ?c - carrier ?sl - slot)
  ;   :precondition (and (has_supply ?b ?s) (atl ?r ?l) (belongs ?u ?l) (has ?r ?c) (has_slot ?c ?sl) (contains ?sl ?b) (at_location_carrier ?c ?l))
  ;   :effect (and (free ?r) (empty ?b) (has_unit ?s ?u) (not (has_supply ?b ?s)) (empty_slot ?sl) (not (contains ?sl ?b)) (at ?b ?l))
  ; )

  ; (:action start_accompany
  ;   :parameters (?r - guide_robot ?l - location ?p - person)
  ;   :precondition (and (atl ?r ?l) (inl ?p ?l))
  ;   :effect (and (accompanying ?r ?p) (not(inl ?p ?l)))
  ; )

  ; (:action accompany
  ;   :parameters (?r - guide_robot ?l - location ?p - person ?u - unit)
  ;   :precondition (and (atl ?r ?l) (belongs ?u ?l) (accompanying ?r ?p))
  ;   :effect (and (not (accompanying ?r ?p)) (in ?p ?u) (inl ?p ?l))
  ; )
)
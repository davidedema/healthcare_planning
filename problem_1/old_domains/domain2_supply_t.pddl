(define (domain healthcare)

  ; in this domain supplies now are types, they are no more infinite 
  ; only a person could be accompained by one robot

  (:requirements :strips :typing)

  (:types
    location unit robot box supply person - object ; added the supply type 
    guide_robot - robot
    box_robot - robot
  )

  (:predicates

    ; LOCATION
    (adjacent ?l1 ?l2 - location)
    (belongs ?u - unit ?l - location)
    
    ; ROBOT
    (atl ?r - robot ?u - location)
    (has ?r - box_robot ?b - box)
    (free ?r - robot)
    
    ; BOX
    (at ?b - box ?l - location)
    (has_supply ?b - box ?s - supply) ; used for specifing if a box contains a supply
    (empty ?b - box)
    
    ; SUPPLY
    (has_supply_at ?s - supply ?l - location) ; used for specifing the location of a supply
    (has_unit ?s - supply ?u - unit) ; used for specifing if a unit has a supply
    
    ; PERSON
    (in ?p - person ?u - unit)
    (inl ?p - person ?l - location)
    (accompanying ?r - guide_robot ?p - person)

  )

  (:action move_box
    :parameters (?r - box_robot ?from - location ?to - location ?b - box)
    :precondition (and (atl ?r ?from) (adjacent ?from ?to) (has ?r ?b) (at ?b ?from))
    :effect (and (not (atl ?r ?from)) (not(at ?b ?from)) (atl ?r ?to) (at ?b ?to))
  )

  (:action move_empty
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and (atl ?r ?from) (adjacent ?from ?to))
    :effect (and (not (atl ?r ?from)) (atl ?r ?to))
  )

  ; action for filling the box with the supply and loading it onto the robot
  (:action load_box
    :parameters (?b - box ?s - supply ?r - box_robot ?l - location)
    :precondition (and (empty ?b) (at ?b ?l) (atl ?r ?l) (free ?r) (has_supply_at ?s ?l))
    :effect (and (not (empty ?b)) (not (free ?r)) (has_supply ?b ?s) (has ?r ?b))
  )

  ; action for unloading the box and delivering the supply to the unit
  (:action empty_box
    :parameters (?b - box ?s - supply ?r - box_robot ?l - location ?u - unit)
    :precondition (and (has_supply ?b ?s) (at ?b ?l) (atl ?r ?l) (belongs ?u ?l) (has ?r ?b))
    :effect (and (free ?r) (empty ?b) (has_unit ?s ?u) (not (has_supply ?b ?s)))
  )

  (:action start_accompany
    :parameters (?r - guide_robot ?l - location ?p - person)
    :precondition (and (atl ?r ?l) (inl ?p ?l) (free ?r))
    :effect (and (not (free ?r)) (accompanying ?r ?p))
  )

  (:action guide_person
    :parameters (?r - guide_robot ?from - location ?to - location ?p - person)
    :precondition (and (atl ?r ?from) (inl ?p ?from) (adjacent ?from ?to) (accompanying ?r ?p))
    :effect (and (not (atl ?r ?from)) (not (inl ?p ?from)) (atl ?r ?to) (inl ?p ?to))
  )

  (:action accompany
    :parameters (?r - guide_robot ?l - location ?p - person ?u - unit)
    :precondition (and (atl ?r ?l) (inl ?p ?l) (belongs ?u ?l) (accompanying ?r ?p))
    :effect (and (not (accompanying ?r ?p)) (free ?r) (in ?p ?u))
  )
)
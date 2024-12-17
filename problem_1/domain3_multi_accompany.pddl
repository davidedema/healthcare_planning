(define (domain healthcare)

  ; in this domain supplies now are types, they are no more infinite 
  ; more person could be accompained by a single robot

  (:requirements :strips :typing)

  (:types
    location unit robot box supply person - object
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
    (has_supply ?b - box ?s - supply)
    (empty ?b - box)
    
    ; SUPPLY
    (has_supply_at ?s - supply ?l - location)
    (has_unit ?s - supply ?u - unit)
    
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

  (:action move
    :parameters (?r - robot ?from - location ?to - location)
    :precondition (and (atl ?r ?from) (adjacent ?from ?to))
    :effect (and (not (atl ?r ?from)) (atl ?r ?to))
  )

  (:action load_box
    :parameters (?b - box ?s - supply ?r - box_robot ?l - location)
    :precondition (and (empty ?b) (at ?b ?l) (atl ?r ?l) (free ?r) (has_supply_at ?s ?l))
    :effect (and (not (empty ?b)) (not (free ?r)) (has_supply ?b ?s) (has ?r ?b))
  )

  (:action empty_box
    :parameters (?b - box ?s - supply ?r - box_robot ?l - location ?u - unit)
    :precondition (and (has_supply ?b ?s) (at ?b ?l) (atl ?r ?l) (belongs ?u ?l) (has ?r ?b))
    :effect (and (free ?r) (empty ?b) (has_unit ?s ?u) (not (has_supply ?b ?s)))
  )

  (:action start_accompany
    :parameters (?r - guide_robot ?l - location ?p - person)
    :precondition (and (atl ?r ?l) (inl ?p ?l))
    :effect (and (accompanying ?r ?p) (not(inl ?p ?l)))
  )

  (:action accompany
    :parameters (?r - guide_robot ?l - location ?p - person ?u - unit)
    :precondition (and (atl ?r ?l) (belongs ?u ?l) (accompanying ?r ?p))
    :effect (and (not (accompanying ?r ?p)) (in ?p ?u) (inl ?p ?l))
  )
)
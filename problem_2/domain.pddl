(define (domain healthcare)

  (:requirements :strips :typing)

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

    (adjacent ?l1 ?l2 - location)
    (belongs ?u - unit ?l - location)
    (atl ?r - robot ?u - location)
    (at ?b - box ?l - location)
    (at_location_carrier ?c - carrier ?l - location)
    (has_supply_at ?s - supply ?l - location)
    (contains ?c - carrier ?b - box)
    (has ?r - box_robot ?c - carrier)
    (has_supply ?b - box ?s - supply)
    (has_slot ?c - carrier ?sl - slot)
    (empty_slot ?sl - slot)
    (has_unit ?s - supply ?u - unit)
    (free ?r - robot)
    (empty ?b - box)
    (in ?p - person ?u - unit)
    (inl ?p - person ?l - location)
    (accompanying ?r - guide_robot ?p - person)
  )

  (:action fly_carrier
    :parameters (?r - flying_robot ?from - location ?to - normal_location ?c - carrier)
    :precondition (and (atl ?r ?from) (has ?r ?c) (at_location_carrier ?c ?from))
    :effect (and (not (atl ?r ?from)) (not(at_location_carrier ?c ?from)) (atl ?r ?to) (at_location_carrier ?c ?to))
  )

  (:action move_carrier
    :parameters (?r - box_robot ?from - location ?to - normal_location ?c - carrier)
    :precondition (and (atl ?r ?from) (adjacent ?from ?to) (has ?r ?c) (at_location_carrier ?c ?from))
    :effect (and (not (atl ?r ?from)) (not(at_location_carrier ?c ?from)) (atl ?r ?to) (at_location_carrier ?c ?to))
  )

  (:action move
    :parameters (?r - robot ?from - location ?to - normal_location)
    :precondition (and (atl ?r ?from) (adjacent ?from ?to))
    :effect (and (not (atl ?r ?from)) (atl ?r ?to))
  )

  (:action move_carrier_shiled
    :parameters (?r - shilded_bot ?from - location ?to - dangerous_location ?c - carrier)
    :precondition (and (atl ?r ?from) (adjacent ?from ?to) (has ?r ?c) (at_location_carrier ?c ?from))
    :effect (and (not (atl ?r ?from)) (not(at_location_carrier ?c ?from)) (atl ?r ?to) (at_location_carrier ?c ?to))
  )

  (:action move_shield
    :parameters (?r - shilded_bot ?from - location ?to - dangerous_location)
    :precondition (and (atl ?r ?from) (adjacent ?from ?to))
    :effect (and (not (atl ?r ?from)) (atl ?r ?to))
  )

  (:action load_carrier
    :parameters (?b - box ?s - supply ?r - box_robot ?l - location ?c - carrier ?sl - slot)
    :precondition (and (empty ?b) (at ?b ?l) (atl ?r ?l) (free ?r) (has_supply_at ?s ?l) (has ?r ?c) (at_location_carrier ?c ?l) (has_slot ?c ?sl) (empty_slot ?sl))
    :effect (and (not (empty ?b)) (not (free ?r)) (not (empty_slot ?sl)) (has_supply ?b ?s) (contains ?sl ?b) (not (at ?b ?l)))
  )
  
  (:action unload_carrier
    :parameters (?b - box ?s - supply ?r - box_robot ?l - location ?u - unit ?c - carrier ?sl - slot)
    :precondition (and (has_supply ?b ?s) (atl ?r ?l) (belongs ?u ?l) (has ?r ?c) (has_slot ?c ?sl) (contains ?sl ?b) (at_location_carrier ?c ?l))
    :effect (and (free ?r) (empty ?b) (has_unit ?s ?u) (not (has_supply ?b ?s)) (empty_slot ?sl) (not (contains ?sl ?b)) (at ?b ?l))
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
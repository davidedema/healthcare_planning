(define (domain healthcare)

  ; Temporal version of problem 2

  (:requirements :strips :typing :durative-actions)

  (:types
    location unit robot box supply person carrier slot - object
    guide_robot box_robot - robot
    earth_robot flying_robot - box_robot
    shilded_bot non_shilded_bot - earth_robot
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
    (contains ?sl - slot ?b - box) ; keep track of box in the carrier
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
  (:durative-action fly_carrier
    :parameters (?r - flying_robot ?from - location ?to - normal_location ?c - carrier)
    :duration (= ?duration 1)
    :condition (and
      (at start (and (atl ?r ?from) (at_location_carrier ?c ?from)
        ))
      (over all (and (has ?r ?c)
        ))
      ; (at end (and 
      ; ))
    )
    :effect (and
      (at start (and (not (atl ?r ?from)) (not(at_location_carrier ?c ?from))
        ))
      (at end (and
          (atl ?r ?to) (at_location_carrier ?c ?to))
      ))
  )

  ; ; move the robot with the carrier
  ; (:action move_carrier
  ;   :parameters (?r - box_robot ?from - location ?to - normal_location ?c - carrier)
  ;   :precondition (and (atl ?r ?from) (adjacent ?from ?to) (has ?r ?c) (at_location_carrier ?c ?from))
  ;   :effect (and (not (atl ?r ?from)) (not(at_location_carrier ?c ?from)) (atl ?r ?to) (at_location_carrier ?c ?to))
  ; )
  (:durative-action move_carrier
    :parameters (?r - box_robot ?from - location ?to - normal_location ?c - carrier)
    :duration (= ?duration 1)
    :condition (and
      (at start (atl ?r ?from))
      (at start (at_location_carrier ?c ?from))
      (over all (has ?r ?c))
      (over all (adjacent ?from ?to))
    )
    ; (at end (and 
    ; ))

    :effect (and
      ; (at start (and 
      ;   ))
      (at end (atl ?r ?to))
      (at end (at_location_carrier ?c ?to))
      (at start (not (atl ?r ?from)))
      (at start (not(at_location_carrier ?c ?from)))
    )
  )

  ; (:action move
  ;   :parameters (?r - robot ?from - location ?to - normal_location)
  ;   :precondition (and (atl ?r ?from) (adjacent ?from ?to))
  ;   :effect (and (not (atl ?r ?from)) (atl ?r ?to))
  ; )
  (:durative-action move
    :parameters (?r - robot ?from - location ?to - normal_location)
    :duration (= ?duration 1)
    :condition (and
      (at start (and (atl ?r ?from)
        ))
      (over all (and (adjacent ?from ?to)
        ))
      ; (at end (and 
      ; ))
    )
    :effect (and
      (at start (and (not (atl ?r ?from))
        ))
      (at end (and
          (atl ?r ?to))
      ))
  )

  ; ; move with the carrier into dangerous locations if the robot is shilded 
  ; (:action move_carrier_shiled
  ;   :parameters (?r - shilded_bot ?from - location ?to - dangerous_location ?c - carrier)
  ;   :precondition (and (atl ?r ?from) (adjacent ?from ?to) (has ?r ?c) (at_location_carrier ?c ?from))
  ;   :effect (and (not (atl ?r ?from)) (not(at_location_carrier ?c ?from)) (atl ?r ?to) (at_location_carrier ?c ?to))
  ; )
  (:durative-action move_carrier_shiled
    :parameters (?r - shilded_bot ?from - location ?to - dangerous_location ?c - carrier)
    :duration (= ?duration 2)
    :condition (and
      (at start (and (atl ?r ?from) (at_location_carrier ?c ?from)
        ))
      (over all (and (adjacent ?from ?to) (has ?r ?c)
        ))
      ; (at end (and 
      ; ))
    )
    :effect (and
      (at start (and (not (atl ?r ?from)) (not(at_location_carrier ?c ?from))
        ))
      (at end (and
          (atl ?r ?to) (at_location_carrier ?c ?to))
      ))
  )

  ; ; move into dangerous locations if the robot is shilded 
  ; (:action move_shield
  ;   :parameters (?r - shilded_bot ?from - location ?to - dangerous_location)
  ;   :precondition (and (atl ?r ?from) (adjacent ?from ?to))
  ;   :effect (and (not (atl ?r ?from)) (atl ?r ?to))
  ; )

  (:durative-action move_shield
    :parameters (?r - shilded_bot ?from - location ?to - dangerous_location)
    :duration (= ?duration 2)
    :condition (and
      (at start (and (atl ?r ?from)
        ))
      (over all (and (adjacent ?from ?to)
        ))
      ; (at end (and 
      ; ))
    )
    :effect (and
      (at start (and (not (atl ?r ?from))
        ))
      (at end (and
          (atl ?r ?to))
      ))
  )

  ; ; load supply into box and put in a slot of the carrier
  ; (:action load_carrier
  ;   :parameters (?b - box ?s - supply ?r - box_robot ?l - location ?c - carrier ?sl - slot)
  ;   :precondition (and (empty ?b) (at ?b ?l) (atl ?r ?l) (free ?r) (has_supply_at ?s ?l) (has ?r ?c) (at_location_carrier ?c ?l) (has_slot ?c ?sl) (empty_slot ?sl))
  ;   :effect (and (not (empty ?b)) (not (free ?r)) (not (empty_slot ?sl)) (has_supply ?b ?s) (contains ?sl ?b) (not (at ?b ?l)))
  ; )

  (:durative-action load_carrier
    :parameters (?b - box ?s - supply ?r - box_robot ?l - location ?c - carrier ?sl - slot)
    :duration (= ?duration 3)
    :condition (and
      (at start (and (empty ?b) (at ?b ?l) (free ?r) (empty_slot ?sl)
        ))
      (over all (and (atl ?r ?l) (has_supply_at ?s ?l) (has ?r ?c) (at_location_carrier ?c ?l) (has_slot ?c ?sl)
        ))
      ; (at end (and 
      ; ))
    )
    :effect (and
      (at start (and (not (at ?b ?l)) (not (empty ?b)) (not (empty_slot ?sl))
        ))
      (at end (and
          (not (free ?r)) (has_supply ?b ?s) (contains ?sl ?b))
      ))
  )

  ; ; deliver supply to unit and leave box in location and empty the slot
  ; (:action unload_carrier
  ;   :parameters (?b - box ?s - supply ?r - box_robot ?l - location ?u - unit ?c - carrier ?sl - slot)
  ;   :precondition (and (has_supply ?b ?s) (atl ?r ?l) (belongs ?u ?l) (has ?r ?c) (has_slot ?c ?sl) (contains ?sl ?b) (at_location_carrier ?c ?l))
  ;   :effect (and (free ?r) (empty ?b) (has_unit ?s ?u) (not (has_supply ?b ?s)) (empty_slot ?sl) (not (contains ?sl ?b)) (at ?b ?l))
  ; )
  (:durative-action unload_carrier
    :parameters (?b - box ?s - supply ?r - box_robot ?l - location ?u - unit ?c - carrier ?sl - slot)
    :duration (= ?duration 3)
    :condition (and
      (at start (and (has_supply ?b ?s) (contains ?sl ?b)
        ))
      (over all (and (atl ?r ?l) (belongs ?u ?l) (has ?r ?c) (has_slot ?c ?sl) (at_location_carrier ?c ?l)
        ))
      ; (at end (and 
      ; ))
    )
    :effect (and
      (at start (and
          (not (has_supply ?b ?s)) (not (contains ?sl ?b))
        ))
      (at end (and
          (free ?r) (empty ?b) (has_unit ?s ?u) (empty_slot ?sl) (at ?b ?l))
      ))
  )
  ; (:action start_accompany
  ;   :parameters (?r - guide_robot ?l - location ?p - person)
  ;   :precondition (and (atl ?r ?l) (inl ?p ?l))
  ;   :effect (and (accompanying ?r ?p) (not(inl ?p ?l)))
  ; )

  (:durative-action start_accompany
    :parameters (?r - guide_robot ?l - location ?p - person)
    :duration (= ?duration 1)
    :condition (and
      (at start (and (inl ?p ?l)
        ))
      (over all (and (atl ?r ?l)
        ))
      ; (at end (and 
      ; ))
    )
    :effect (and
      (at start (and
          (not(inl ?p ?l))
        ))
      (at end (and
          (accompanying ?r ?p))
      ))
  )

  ; (:action accompany
  ;   :parameters (?r - guide_robot ?l - location ?p - person ?u - unit)
  ;   :precondition (and (atl ?r ?l) (belongs ?u ?l) (accompanying ?r ?p))
  ;   :effect (and (not (accompanying ?r ?p)) (in ?p ?u) (inl ?p ?l))
  ; ))
  (:durative-action accompany
    :parameters (?r - guide_robot ?l - location ?p - person ?u - unit)
    :duration (= ?duration 1)
    :condition (and
      (at start (and (accompanying ?r ?p)
        ))
      (over all (and (atl ?r ?l) (belongs ?u ?l)
        ))
      ; (at end (and 
      ; ))
    )
    :effect (and
      (at start (and
          (not (accompanying ?r ?p))
        ))
      (at end (and
          (in ?p ?u) (inl ?p ?l))
      ))
  )
)
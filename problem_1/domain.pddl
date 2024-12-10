(define (domain healthcare)

  (:requirements :strips :typing)

  (:types
    location unit robot box person - object
    guide_robot - robot
    box_robot - robot
  )

  (:predicates

    (adjacent ?l1 ?l2 - location)
    (belongs ?u - unit ?l - location)
    (atl ?r - robot ?u - location)
    (at ?b - box ?l - location)
    (has ?r - box_robot ?b - box)
    (contains_bandages ?b - box)
    (has_bandages ?u - unit)
    (is_loading_point ?l - location)
    (free ?r - robot)
    (empty ?b - box)
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

  (:action fill_box_bandages
    :parameters (?r - box_robot ?l - location ?b - box)
    :precondition (and (atl ?r ?l) (is_loading_point ?l) (empty ?b) (at ?b ?l) (free ?r))
    :effect (and (not (empty ?b)) (contains_bandages ?b) (not (free ?r)) (has ?r ?b))
  )

  (:action empty_box_bandages
    :parameters (?r - box_robot ?l - location ?b - box ?u - unit)
    :precondition (and (atl ?r ?l) (contains_bandages ?b) (belongs ?u ?l) (at ?b ?l) (has ?r ?b))
    :effect (and (not (contains_bandages ?b)) (empty ?b) (not (has ?r ?b)) (free ?r) (has_bandages ?u))
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
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
        (has ?r - robot ?b - box)
        ; (position ?p - person ?u - unit)
        (contains_bandages ?b - box)
        (has_bandages ?u - unit)
        (is_loading_point ?l - location)
        (free ?r - robot)
        (empty ?b - box)

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
)